local skynet     = require("skynet")
local sharetable = require("skynet.sharetable")

require "skynet.manager"

local mode       = ...

if mode == "slave" then
  skynet.start(function()
    local box = sharetable.query("test")
    local t   = setmetatable({ box     = box, version = box.version }, {
      __index = function(self, key)
        if self.version > self.box.version then
          self.box = sharetable.query("test")
        end
        return self.box[key]
      end,
    })
    print("slave", t.a)
    skynet.dispatch("lua", function(_, _, version)
      t.version = version
      print("slave", t.a)
    end)
  end)
else
  skynet.start(function()
    sharetable.loadtable("test", { a       = 1, version = 0 })
    local slave = skynet.newservice("sharetableupdate", "slave")
    sharetable.loadtable("test", { a       = 2, version = 1 })
    skynet.send(slave, "lua", 1)
  end)
end
