local TransportStream = require("core.TransportStream")
local class           = require("pl.class")

---@class TelnetStream : TransportStream
---@field socket TelnetSocket
local M               = class(TransportStream)

function M:attach(socket)
  TransportStream.attach(self, socket)
  socket:on("data", function(message) self:emit("data", message) end)
  socket:on("error", function(error) self:emit("error", error) end)
  socket:on("DO", function(opt) self.socket:telnetCommand("WONT", opt) end)
end
function M:writable() return self.socket:writable() end

function M:write(message)
  if not self:writable() then return end
  self.socket:write(message)
end

function M:pause() self.socket:pause() end

function M:resume() self.socket:resume() end

function M:stop() self.socket:stop() end

function M:executeToggleEcho() self.socket:toggleEcho() end

return M
