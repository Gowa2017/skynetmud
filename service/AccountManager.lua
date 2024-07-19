local skynet = require("skynet")
require "skynet.manager"
local sharetable = require("skynet.sharetable")
local mongo      = require("skynet.db.mongo")

local CMD    = {}
local dbconf = {
  username = "root",
  password = "wouinibaba",
  host     = "localhost",
  port     = 27017,
}
---@type mongo_collection
local col

function CMD.loadAccount(account)
  return col:findOne({ username = account }, {
    username = true,
    password = true,
    banned = true,
    deleted = true,
  })
end

function CMD.new(username, password)
  return col:insert({ username = username, password = password })

end

function CMD.ban(username)
  return col:update({ username = username }, { ["$set"] = { banned = true } })

end

function CMD.delete(username)
  return col:update({ username = username }, { ["$set"] = { deleted = true } })
end

skynet.start(function()
  col = mongo.client(dbconf):getDB("mud"):getCollection("account")
  skynet.dispatch("lua", function(_, _, cmd, ...)
    local f     = assert(CMD[cmd], string.format("cmd %s not found", cmd))
    local ok, r = pcall(f, ...)
    skynet.retpack(ok, r)
  end)
  skynet.register(".AccountManager")
end)
