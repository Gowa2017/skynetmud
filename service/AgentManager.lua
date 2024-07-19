local timer  = require("go.timer")
local skynet = require("skynet")
require "skynet.manager"

local pool   = {}
local min    = 5
local uids   = {}

local cb     = function()
  if #pool < min then
    for i = 1, min do
      pool[#pool + 1] = skynet.newservice("Agent")
    end
  end
end

local CMD    = {}

function CMD.get(uid)
  if not uids[uid] then
    uids[uid] = table.remove(pool)
  end
  return uids[uid]
end

function CMD.del(uid)
  uids[uid] = nil
end

skynet.start(function()
  skynet.dispatch("lua", function(_, _, cmd, ...)
    skynet.retpack(CMD[cmd](...))
  end)
  timer.start()
  timer.period(1 * 100, cb)
  skynet.register(".AgentManager")
end)
