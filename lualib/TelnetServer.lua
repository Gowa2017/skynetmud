local skynet       = require "skynet"
require "skynet.manager"
local socket       = require "skynet.socket"
local crypt        = require "skynet.crypt"
local table        = table
local string       = string
local assert       = assert

local socket_error = {}
---Assert action
---@param service string used for error tips
---@param v string binary
---@param fd number socket index, for error tips
---@return string binary
local function assert_socket(service, v, fd)
  if v then
    return v
  else
    skynet.error(
      string.format("%s failed: socket (fd = %d) closed", service, fd))
    error(socket_error)
  end
end

---Write to socket
---@param service string used for error tips
---@param fd number socket index
---@param text string binary
local function write(service, fd, text)
  assert_socket(service, socket.write(fd, text), fd)
end

local function read(fd, service)
  service = service or "read"
  return assert_socket(service, socket.readline(fd, "\r\n"), fd)
end
local function launch_slave(auth_handler)
  local function auth(fd, addr)
    -- set socket buffer limit (8K)
    -- If the attacker send large package, close the socket
    socket.limit(fd, 8192)

    write("auth", fd, "What's you name?\n")
    local username    = read(fd)
    local password   
    local ok, account = skynet.call(".AccountManager", "lua", "loadAccount",
                                    username)
    if account and type(account) == "table" then
      write("auth", fd, "What's you password?\n")
      password = read(fd)
      if password ~= account.password then
        error("Password Error")
      end
      return true, username
    else
      write("auth", fd, string.format("Use %s as you account?[y/n]\n", username))
      local sel = read(fd)
      if sel:lower() == "n" then
        error("reject to create account")
      end
      write("auth", fd, "What's you password?\n")
      password = read(fd)
      skynet.call(".AccountManager", "lua", "new", username, password)
    end
    return true, username
  end

  local function ret_pack(ok, err, ...)
    --- 认证成功
    if ok then
      return skynet.pack(err, ...)
    else
      --- 套接字错误
      if err == socket_error then
        return skynet.pack(nil, "socket error")
        --- 其他错误
      else
        return skynet.pack(false, err)
      end
    end
  end

  local function auth_fd(fd, addr)
    skynet.error(string.format("connect from %s (fd = %d)", addr, fd))
    socket.start(fd) -- may raise error here
    local msg, len = ret_pack(pcall(auth, fd, addr))
    socket.abandon(fd) -- never raise error here
    return msg, len
  end

  skynet.dispatch("lua", function(_, _, ...)
    local ok, msg, len = pcall(auth_fd, ...)
    if ok then
      skynet.ret(msg, len)
    else
      skynet.ret(skynet.pack(false, msg))
    end
  end)
end

local user_login   = {}

local function accept(conf, s, fd, addr)
  -- call slave auth
  local ok, uid = skynet.call(s, "lua", fd, addr)
  -- slave will accept(start) fd, so we can write to fd later

  if not ok then
    -- nil 表示套接字错误
    if ok ~= nil then
      write("response 401", fd, "401 Unauthorized\n")
    end
    error(uid)
  end

  if not conf.multilogin then
    if user_login[uid] then
      write("response 406", fd, "406 Not Acceptable\n")
      error(string.format("User %s is already login", uid))
    end

    user_login[uid] = true
  end

  local ok, err = pcall(conf.login_handler, fd, uid)
  -- unlock login
  user_login[uid] = nil

  if ok then
    err = err or ""
    write("response 200", fd, "200 " .. err .. "\n")
  else
    write("response 403", fd, "403 Forbidden\n")
    error(err)
  end
end

local function launch_master(conf)
  local instance = conf.instance or 8
  assert(instance > 0)
  local host     = conf.host or "0.0.0.0"
  local port     = assert(tonumber(conf.port))
  local slave    = {}
  local balance  = 1

  skynet.dispatch("lua", function(_, source, command, ...)
    skynet.ret(skynet.pack(conf.command_handler(command, ...)))
  end)

  for i = 1, instance do
    table.insert(slave, skynet.newservice(SERVICE_NAME))
  end

  skynet.error(string.format("telnet server listen at : %s %d", host, port))
  local id       = socket.listen(host, port)
  socket.start(id, function(fd, addr)
    local s       = slave[balance]
    balance = balance + 1
    if balance > #slave then
      balance = 1
    end
    local ok, err = pcall(accept, conf, s, fd, addr)
    if not ok then
      if err ~= socket_error then
        skynet.error(string.format("invalid client (fd = %d) error = %s", fd,
                                   err))
      end
      socket.close_fd(fd) -- We haven't call socket.start, so use socket.close_fd rather than socket.close.
    end
    -- socket.close_fd(fd) -- We haven't call socket.start, so use socket.close_fd rather than socket.close.
  end)
end

local function login(conf)
  local name = "." .. (conf.name or "login")
  skynet.start(function()
    local loginmaster = skynet.localname(name)
    if loginmaster then
      local auth_handler = assert(conf.auth_handler)
      launch_master = nil
      conf = nil
      launch_slave(auth_handler)
    else
      launch_slave = nil
      conf.auth_handler = nil
      assert(conf.login_handler)
      assert(conf.command_handler)
      skynet.register(name)
      launch_master(conf)
    end
  end)
end

return login
