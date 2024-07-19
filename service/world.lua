local skynet    = require("skynet")
require "skynet.manager"
local GameState = require("core.GameState")
local Config    = require("core.Config")
local message   = require("conf.message")

skynet.register_protocol(message.logic)
skynet.start(function()
  ---@type GameState
  local state = GameState(skynet.getenv("gameConfig"),
                          skynet.getenv("bundleDir"))
  state:load(false)
  skynet.newservice("telnetserver")
  skynet.register(".world")
end)
