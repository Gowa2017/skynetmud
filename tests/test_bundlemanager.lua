local BundleManager = require("BundleManager")
local GameConfig    = require("GameConfig")
local pretty        = require("pl.pretty")
local Logger        = require("core.Logger")
local utils         = require("pl.utils")

Logger.setLevel(0)
local game          = GameConfig("game.lua", ".")

game:load(false)

local pretty        = require("pl.pretty")
utils.writefile("config.lua", "return " .. pretty.write(game.defs))
