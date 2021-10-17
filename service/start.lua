local service   = require("go.service")

class = require("pl.class")
local GameState = require("core.GameState")

state = GameState("mud", "./")
state:load()
