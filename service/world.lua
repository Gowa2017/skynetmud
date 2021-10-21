local skynet    = require("skynet")
require "skynet.manager"
local service   = require("go.service")
local GameState = require("core.GameState")
local Config    = require("core.Config")
local Logger    = require("core.Logger")

Logger.setLevel(tonumber(skynet.getenv("logLevel")))
service.enableMessage("logic")
service.start(function()
  ---@type GameState
  local state = GameState(skynet.getenv("gameConfig"),
                          skynet.getenv("bundleDir"))
  state:load()
  state:start({ port = Config.get("port") })
end)
