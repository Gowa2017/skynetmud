local TelnetServer = require("TelnetServer")
local skynet       = require "skynet"

local server       = {
  host       = "127.0.0.1",
  port       = 8000,
  multilogin = false, -- disallow multilogin
  name       = "login_master",
}

local server_list  = {}
local user_online  = {}
local user_login   = {}

function server.auth_handler(token)
end

function server.login_handler(fd, uid)
  print(string.format("%s is login ", uid))
  -- only one can login, because disallow multilogin
  local agent = user_online[uid]
  if agent then
    skynet.call(agent, "lua", "kick", uid)
    return uid
  end
  agent = skynet.call(".AgentManager", "lua", "get", uid)
  user_online[uid] = { agent = agent }
  skynet.send(agent, "lua", "load", fd, uid)
  return uid
end

local CMD          = {}

function CMD.logout(uid)
  local u = user_online[uid]
  if u then
    print(string.format("%s is logout", uid))
    user_online[uid] = nil
    skynet.call(".AgentManager", "lua", "del", uid)
  end
end

function server.command_handler(command, ...)
  local f = assert(CMD[command])
  return f(...)
end

TelnetServer(server)
