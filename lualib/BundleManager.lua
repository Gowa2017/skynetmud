local class            = require("pl.class")
local sfmt             = string.format

local fs               = require("pl.path")
local dir              = require("pl.dir")
local file             = require("pl.file")
local tablex           = require("pl.tablex")
local pretty           = require("pl.pretty")

local Data             = require("core.Data")
local Area             = require("core.Area")
local Command          = require("core.Command")
local CommandType      = require("core.CommandType")
local Item             = require("core.Item")
local Npc              = require("core.Npc")
local QuestGoal        = require("core.QuestGoal")
local QuestReward      = require("core.QuestReward")
local Room             = require("core.Room")
local Skill            = require("core.Skill")
local SkillType        = require("core.SkillType")
local Helpfile         = require("core.Helpfile")
local Logger           = require("core.Logger")

local AttributeFormula = require("core.Attribute").AttributeFormula

local srcPath          = "./"

---Because all settings will be used in different service, we can't share function between
---services.So, we only record the filename, every service load it independently.
---This will be a pure lua table.
---@class BundleLoader : Class
---@field state table
local M                = class()

---
---@param path string bundles path
function M:_init(path, state)
  if not path or not fs.exists(path) then
    error("Invalid bundle path")
  end
  self.bundlesPath = path
  self.state = state
  self.areas = {}
  self.loaderRegistry = self.state.EntityLoaderRegistry
end

function M:loadBundles(distribute)
  distribute = distribute == nil and true or distribute
  Logger.verbose("LOAD: BUNDLES")

  local bundles = dir.getdirectories(self.bundlesPath)
  for _, bundlePath in ipairs(bundles) do
    local bundle = bundlePath:sub(#self.bundlesPath + 1)
    if fs.isfile(bundlePath) or bundle == "." or bundle == ".." then
      goto continue
    end

    if not tablex.find(self.state.Config.get("bundles", {}), bundle) then
      goto continue
    end

    self:loadBundle(bundle, bundlePath)
    ::continue::
  end

  -- self.state.AttributeFactory:validateAttributes()

  Logger.verbose("ENDLOAD: BUNDLES")

  if not distribute then
    return
  end
  Logger.verbose("DIST: ...............")
  for _, areaRef in ipairs(self.areas) do
    Logger.verbose("-------------------DIST AREA:%s-------------------", areaRef)
    local area = self.state.AreaFactory:create(areaRef)
    area:hydrate(self.state)
    self.state.AreaManager:addArea(area)
  end
end

function M:loadBundle(bundle, bundlePath)
  --- every bundle can have this features
  local features = {
    -- quest goals/rewards have to be loaded before areas that have quests which use those goals
    { path = "quest-goals/", fn   = "loadQuestGoals" },
    { path = "quest-rewards/", fn   = "loadQuestRewards" },
    { path = "attributes.lua", fn   = "loadAttributes" },
    -- any entity in an area, including the area itself, can have behaviors so load them first
    { path = "behaviors/", fn   = "loadBehaviors" },
    { path = "channels.lua", fn   = "loadChannels" },
    { path = "commands/", fn   = "loadCommands" },
    { path = "effects/", fn   = "loadEffects" },
    { path = "input-events/", fn   = "loadInputEvents" },
    { path = "server-events/", fn   = "loadServerEvents" },
    { path = "player-events.lua", fn   = "loadPlayerEvents" },
    { path = "skills/", fn   = "loadSkills" },
  }

  Logger.verbose("LOAD: BUNDLE [%s] START", bundle)
  for _, feature in ipairs(features) do
    local path = bundlePath .. "/" .. feature.path
    if fs.exists(path) then
      self[feature.fn](self, bundle, path)
    end
  end

  self:loadAreas(bundle)
  self:loadHelp(bundle)

  Logger.verbose("ENDLOAD: BUNDLE [%q]", bundle)
end

function M:loadQuestGoals(bundle, goalsDir)
  Logger.verbose("\tLOAD: Quest Goals...")
  local files = dir.getfiles(goalsDir)

  for _, goalPath in ipairs(files) do
    local _, goalFile = fs.splitpath(goalPath)
    if not Data.isScriptFile(goalPath, goalFile) then
      goto continue
    end
    local goalName, _ = fs.splitext(goalFile)
    local loader      = loadfile(goalPath)()
    if not QuestGoal:class_of(loader()) then
      goto continue
    end
    Logger.verbose("\t\t%s", goalName)

    self.state.defs.QuestGoals[goalName] = goalPath

    Logger.verbose("\tENDLOAD: Quest Goals...")
    ::continue::
  end
end

function M:loadQuestRewards(bundle, rewardsDir)
  Logger.verbose("\tLOAD: Quest Rewards...")

  local files = dir.getfiles(rewardsDir)

  for _, rewardPath in ipairs(files) do
    local _, rewardFile = fs.splitpath(rewardPath)
    if not Data.isScriptFile(rewardPath, rewardFile) then
      goto continue
    end

    local rewardName, _ = fs.splitext(rewardFile)
    local loader        = loadfile(rewardPath)()
    if not QuestReward:class_of(loader()) then
      goto continue
    end
    Logger.verbose("\t\t%s", rewardName)

    self.state.defs.QuestReward[rewardName] = rewardPath
  end

  Logger.verbose("\tENDLOAD: Quest Rewards...")
  ::continue::
end

function M:loadAttributes(bundle, attributesFile)
  Logger.verbose("\tLOAD: Attributes...")

  local attributes = loadfile(attributesFile, "bt")()
  local errormsg   = sfmt("\tAttributes file [%s] from bundle [%s]",
                          attributesFile, bundle)
  if type(attributes) ~= "table" then
    Logger.error("%s does not define an array of attributes", errormsg)
    return
  end

  for _, attribute in ipairs(attributes) do
    if type(attribute) ~= "table" then
      Logger.error("%s not an object", errormsg)
      goto continue
    end

    if not attribute["name"] or not attribute["base"] then
      Logger.error("%s does not include required properties name and base",
                   errormsg)
      goto continue
    end

    local formula
    if attribute.formula then
      formula = AttributeFormula(attribute.formula.requires,
                                 attribute.formula.fn)
    end

    Logger.verbose("\t\t-> %s", attribute.name)

    self.state.defs.AttributeFactory[attribute.name] = {
      base     = attribute.base,
      formula  = attributesFile,
      metadata = attribute.metadata,
    }
    ::continue::
  end

  Logger.verbose("\tENDLOAD: Attributes...")
end

function M:loadPlayerEvents(bundle, eventsFile)
  Logger.verbose("\tLOAD: Player Events... %s", eventsFile)
  self.state.defs.PlayerEvents[#self.state.defs.PlayerEvents + 1] = eventsFile
  Logger.verbose("\tENDLOAD: Player Events...")
end

function M:loadAreas(bundle)
  Logger.verbose("\tLOAD: Areas...");

  local areaLoader = self.loaderRegistry:get("areas");
  areaLoader:setBundle(bundle);
  local areas      = {};

  if not areaLoader:hasData() then
    return areas
  end

  areas = areaLoader:fetchAll();

  for name, manifest in pairs(areas) do
    self.areas[#self.areas + 1] = name
    self:loadArea(bundle, name, manifest)

  end
  Logger.verbose("\tENDLOAD: Areas");
end

function M:loadArea(bundle, areaName, manifest)
  local definition = {
    bundle   = bundle,
    manifest = manifest,
    quests   = {},
    items    = {},
    npcs     = {},
    rooms    = {},
  }

  local scriptPath = self:_getAreaScriptPath(bundle, areaName)

  if manifest.script then
    local areaScriptPath = sfmt("%s/%s.lua", scriptPath, manifest.script) -- '${scriptPath}/${manifest.script}.js'
    if not fs.exists(areaScriptPath) then
      Logger.warn("\t\t\t[%s] has non-existent script \"%s\"", areaName,
                  manifest.script)
    end

    Logger.verbose("\t\t\tLoading Area Script for [%s]: %s", areaName,
                   manifest.script)
    self.state.defs.AreaFactory.scripts[areaName] = areaScriptPath
  end

  Logger.verbose("\t\tLOAD: Quests...")
  definition.quests = self:loadQuests(bundle, areaName)
  Logger.verbose("\t\tLOAD: Items...")
  definition.items = self:loadEntities(bundle, areaName, "items",
                                       self.state.defs.ItemFactory)
  Logger.verbose("\t\tLOAD: NPCs...")
  definition.npcs = self:loadEntities(bundle, areaName, "npcs",
                                      self.state.defs.MobFactory)
  Logger.verbose("\t\tLOAD: Rooms...")
  definition.rooms = self:loadEntities(bundle, areaName, "rooms",
                                       self.state.defs.RoomFactory)
  Logger.verbose("\t\tDone.")

  for _, npcRef in pairs(definition.npcs) do
    local npc = self.state.defs.MobFactory.entitys[npcRef]
    if not npc.quests then
      goto continue
    end
    for _, qid in ipairs(npc.quests) do
      local quest = self.state.defs.QuestFactory[qid]
      if not quest then
        Logger.error("\t\t\tError: NPC is questor for non-existent quest [%q]",
                     qid)
        goto continue2
      end
      quest.npc = npcRef
      self.state.defs.QuestFactory[qid] = quest
      ::continue2::
    end
    ::continue::
  end
  self.state.defs.AreaFactory.entitys[areaName] = definition
end

function M:loadEntities(bundle, areaName, type, factory)
  local loader     = self.loaderRegistry:get(type)
  loader:setBundle(bundle)
  loader:setArea(areaName)

  if not loader:hasData() then
    return {}
  end

  local entities   = loader:fetchAll()
  if not entities then
    Logger.warn("\t\t\t%q has an invalid value [%q]", type, entities)
    return {}
  end

  local scriptPath = self:_getAreaScriptPath(bundle, areaName)
  local res        = {}
  for _, entity in ipairs(entities) do
    local entityRef = areaName .. ":" .. entity.id
    factory.entitys[entityRef] = entity
    if entity.script then
      local entityScript = sfmt("%s/%s/%s.lua", scriptPath, type, entity.script)
      if not fs.exists(entityScript) then
        Logger.warn("\t\t\t[%s] has non-existent script \"%s\"", entityRef,
                    entity.script)
      else
        Logger.verbose("\t\t\tLoading Script [%s] %s", entityRef, entity.script)
        factory.scripts[entityRef] = scriptPath
      end
    end
    res[#res + 1] = entityRef
  end

  return res
end

function M:loadQuests(bundle, areaName)
  local loader     = self.loaderRegistry:get("quests")
  loader:setBundle(bundle)
  loader:setArea(areaName)
  local ok, quests = pcall(loader.fetchAll, loader)
  if not ok then
    Logger.warn(quests)
    quests = {}
  end
  local res        = {}
  for _, quest in pairs(quests) do
    Logger.verbose("\t\t\tLoading Quest [%s:%s]", areaName, quest.id)
    self.state.defs.QuestFactory[areaName .. ":" .. quest.id] = quest
    res[#res + 1] = areaName .. ":" .. quest.id
  end

  return res
end

function M:loadCommands(bundle, commandsDir)
  Logger.verbose("\tLOAD: Commands...")
  local files = dir.getallfiles(commandsDir)

  for _, commandPath in ipairs(files) do
    local _, commandFile = fs.splitpath(commandPath)
    if not Data.isScriptFile(commandPath, commandFile) then
      goto continue
    end
    local commandName    = fs.splitext(commandFile)
    Logger.verbose("\t\tCommand: %q", commandName)
    -- local command        = self:createCommand(commandPath, commandName, bundle)
    self.state.defs.Commands[commandName] = commandPath
    ::continue::
  end

  Logger.verbose("\tENDLOAD: Commands...")
end

function M:createCommand(commandPath, commandName, bundle)
  local loader    = loadfile(commandPath)()
  local cmdImport = self:_getLoader(loader, srcPath, self.bundlesPath)
  cmdImport.command = cmdImport.command(self.state)

  return Command(bundle, commandName, cmdImport, commandPath)
end

function M:loadChannels(bundle, channelsFile)
  Logger.verbose("\tLOAD: Channels...")
  self.state.defs.Channels[#self.state.defs.Channels + 1] = channelsFile

  Logger.verbose("\tENDLOAD: Channels...")
end

function M:loadHelp(bundle)
  Logger.verbose("\tLOAD: Help...")
  local loader  = self.loaderRegistry:get("help")
  loader:setBundle(bundle)

  if not loader:hasData() then
    return
  end

  local records = loader:fetchAll()
  for helpName, body in pairs(records) do
    self.state.defs.Helps[helpName] = body
  end
  Logger.verbose("\tENDLOAD: Help...")
end

function M:loadInputEvents(bundle, inputEventsDir)
  Logger.verbose("\tLOAD: Events...")
  local files = dir.getallfiles(inputEventsDir)

  for _, eventPath in ipairs(files) do
    local _, eventFile = fs.splitpath(eventPath)
    if not Data.isScriptFile(eventPath, eventFile) then
      goto continue
    end

    local eventName    = fs.splitext(eventFile)
    local loader       = loadfile(eventPath)()
    local eventImport  = self:_getLoader(loader, srcPath)
    if type(eventImport.event) ~= "function" then
      error(sfmt(
              "Bundle %s has an invalid input event %s. Expected a function, got: %q",
              bundle, eventName, eventImport.event))
    end

    self.state.defs.InputEvents[eventName] = eventPath
    ::continue::
  end
  Logger.verbose("\tENDLOAD: Events...")
end

function M:loadBehaviors(bundle, behaviorsDir)
  Logger.verbose("\tLOAD: Behaviors...")

  local loadEntityBehaviors = function(type, manager, state)
    local typeDir = behaviorsDir .. type .. "/"

    if not fs.exists(typeDir) then
      return
    end

    Logger.verbose("\t\tLOAD: BEHAVIORS [%s]...", type)
    local files   = dir.getallfiles(typeDir)

    for _, behaviorPath in ipairs(files) do
      local _, behaviorFile = fs.splitpath(behaviorPath)
      -- local behaviorPath      = typeDir .. behaviorFile
      if not Data.isScriptFile(behaviorPath, behaviorFile) then
        goto continue
      end

      local behaviorName    = fs.splitext(behaviorFile)
      Logger.verbose("\t\t\tLOAD: BEHAVIORS [%s] %s...", type, behaviorName)
      manager[behaviorName] = behaviorPath

      ::continue::

    end
  end

  loadEntityBehaviors("area", self.state.defs.AreaBehaviors, self.state)
  loadEntityBehaviors("npc", self.state.defs.MobBehaviors, self.state)
  loadEntityBehaviors("item", self.state.defs.ItemBehaviors, self.state)
  loadEntityBehaviors("room", self.state.defs.RoomBehaviors, self.state)

  Logger.verbose("\tENDLOAD: Behaviors...")
end

function M:loadEffects(bundle, effectsDir)
  Logger.verbose("\tLOAD: Effects...")
  local files = dir.getallfiles(effectsDir)

  for _, effectPath in ipairs(files) do
    local _, effectFile = fs.splitpath(effectPath)
    if not Data.isScriptFile(effectPath, effectFile) then
      goto continue
    end

    local effectName    = fs.splitext(effectFile)
    local loader        = loadfile(effectPath)()

    Logger.verbose("\t\t%s", effectName)
    self.state.defs.EffectFactory[effectName] = effectPath
    ::continue::
  end

  Logger.verbose("\tENDLOAD: Effects...")
end

function M:loadSkills(bundle, skillsDir)
  Logger.verbose("\tLOAD: Skills...")
  local files = dir.getfiles(skillsDir)

  for _, skillPath in ipairs(files) do
    local _, skillFile = fs.splitpath(skillPath)
    if not Data.isScriptFile(skillPath, skillFile) then
      goto continue
    end
    local skillName    = fs.splitext(skillFile)
    local loader       = loadfile(skillPath)()
    local skillImport  = self:_getLoader(loader, srcPath)
    if skillImport.run then
      skillImport.run = skillImport.run(self.state)
    end

    Logger.verbose("\t\t%s", skillName)
    local skill        = Skill(skillName, skillImport, self.state)

    if skill.type == SkillType.SKILL then
      self.state.defs.SkillManager[skillName] = skillPath
    else
      self.state.defs.SpellManager[skillName] = skillPath
    end

    ::continue::
  end
  Logger.verbose("\tENDLOAD: Skills...")
end

function M:loadServerEvents(bundle, serverEventsDir)
  Logger.verbose("\tLOAD: Server Events...")
  local files = dir.getallfiles(serverEventsDir)

  for _, eventsPath in ipairs(files) do
    local _, eventsFile   = fs.splitpath(eventsPath)
    if not Data.isScriptFile(eventsPath, eventsFile) then
      goto continue
    end
    local eventsName      = fs.splitext(eventsFile)
    Logger.verbose("\t\t\tLOAD: SERVER-EVENTS %s...", eventsName)
    local loader          = loadfile(eventsPath)()
    local eventsListeners = self:_getLoader(loader, srcPath).listeners

    for eventName, listener in pairs(eventsListeners) do
      self.state.ServerEventManager:add(eventName, listener(self.state))
    end
    ::continue::
  end
  Logger.verbose("\tENDLOAD: Server Events...")
end

function M:_getLoader(loader, ...)
  if type(loader) == "function" then
    return loader(...)
  end
  return loader
end

function M:_getAreaScriptPath(bundle, areaName)
  return sfmt("%s/%s/areas/%s/scripts", self.bundlesPath, bundle, areaName)
end

return M
