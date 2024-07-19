local skynet = require("skynet")
local socket = require("skynet.socket")

require "skynet.manager"

local CMD = {}

function CMD.load(fd, uid)
  socket.start(fd)
  socket.write(fd, "hello")
  while true do
    local data = socket.readline(fd, "\r\n")
    socket.write(fd, data .. "\r\n")
  end
end

skynet.start(function()
  skynet.dispatch("lua", function(_, _, cmd, ...)
    skynet.retpack(CMD[cmd](...))
  end)
end)
