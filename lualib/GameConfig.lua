local class                = require("pl.class")
local Logger               = require("core.Logger")
local Config               = require("core.Config")
local Data                 = require("core.Data")
local BundleManager        = require("BundleManager")
local EntityLoaderRegistry = require("core.EntityLoaderRegistry")
local DataSourceRegistry   = require("core.DataSourceRegistry")

---@class Game : Class
local M                    = class()
---@param config string|table #config module or file
---@param dirname? string work dir default .
function M:_init(config, dirname)
  assert(config, "Need config module")
  if type(config) == "string" then
    config = loadfile(config)()
  else
    assert(type(config) == "table", "config must a string or a table")
  end
  Logger.verbose("INIT - GameState")
  dirname = dirname or "."
  Config.load(config)
  Data.setDataPath(dirname .. "/data/")
  restartServer = restartServer or true
  self.dirname = dirname or "."
  self.Config = Config
  self.EntityLoaderRegistry = EntityLoaderRegistry()
  self.DataSourceRegistry = DataSourceRegistry()

  self.defs = {
    Config           = config,
    QuestGoals       = {},
    QuestReward      = {},
    Commands         = {},
    PlayerEvents     = {},
    Helps            = {},
    AreaBehaviors    = {},
    ItemBehaviors    = {},
    MobBehaviors     = {},
    RoomBehaviors    = {},
    Channels         = {},
    QuestFactory     = {},
    ItemFactory      = { entitys = {}, scripts = {} },
    MobFactory       = { entitys = {}, scripts = {} },
    RoomFactory      = { entitys = {}, scripts = {} },
    AreaFactory      = { entitys = {}, scripts = {} },
    AttributeFactory = {},
    EffectFactory    = {},
    SkillManager     = {},
    SpellManager     = {},
    InputEvents      = {},
  }
  self.BundleManager = BundleManager(self.dirname .. "/bundles/", self);
end
---now only need is { port = 8000}
---@param config table
function M:start(config)
  Logger.verbose("START - Starting server");
  self.GameServer:startup(config);
end

function M:updateTick()
  self.AreaManager:tickAll(self);
  self.ItemManager:tickAll();
  self.PlayerManager:emit("updateTick");
end
function M:load(distribute)
  Logger.verbose("LOAD")
  self.DataSourceRegistry:load(require, self.dirname, Config.get("dataSources"))
  self.EntityLoaderRegistry:load(self.DataSourceRegistry,
                                 Config.get("entityLoaders"))
  -- self.AccountManager:setLoader(self.EntityLoaderRegistry:get("accounts"));
  -- self.PlayerManager:setLoader(self.EntityLoaderRegistry:get("players"));

  self.BundleManager:loadBundles(distribute);
  -- self.ServerEventManager:attach(self.GameServer);
end

return M
