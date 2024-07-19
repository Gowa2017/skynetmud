local skynet     = require("skynet")
require "skynet.manager"
local GameConfig = require("GameCOnfig")
local sharetable = require("skynet.sharetable")
local pretty     = require("pl.pretty")
local utils      = require("pl.utils")

skynet.start(function()
  -- local state = GameConfig(skynet.getenv("gameConfig"),
  --                          skynet.getenv("bundleDir"))
  -- state:load(false)
  -- sharetable.loadtable("cfg", state.defs)

  -- skynet.newservice("AccountManager")
  -- skynet.newservice("AgentManager")
  -- skynet.newservice("telnet")
  -- local telnet = skynet.newservice("test")
  -- skynet.call(telnet, "lua", "open", { port = 8000 })
  skynet.newservice("sharetableupdate")
end)
