local skynet = require("skynet")
require "skynet.manager"

skynet.start(function()
  -- local gate = skynet.newservice("logind")
  -- skynet.call(gate, "lua", "cmd.start", { port = 8888 })
  skynet.newservice("world")
  -- skynet.newservice("telnet")
end)
