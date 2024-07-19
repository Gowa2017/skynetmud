{
  AreaBehaviors = {
  },
  AreaFactory = {
    entitys = {
      craft = {
        bundle = "simple-crafting",
        items = {
          "craft:greenplant",
          "craft:redrose"
        },
        manifest = {
          info = {
            respawnInterval = 300
          },
          title = "Crafting"
        },
        npcs = {
        },
        quests = {
        },
        rooms = {
        }
      },
      limbo = {
        bundle = "bundle-example-areas",
        items = {
          "limbo:rustysword",
          "limbo:sliceofcheese",
          "limbo:woodenchest",
          "limbo:scraps",
          "limbo:trainingsword",
          "limbo:leathervest",
          "limbo:potionhealth1",
          "limbo:potionstrength1",
          "limbo:bladeofranvier",
          "limbo:woodenshield",
          "limbo:test_key",
          "limbo:locked_chest"
        },
        manifest = {
          behaviors = {
            ["progressive-respawn"] = {
              interval = 20
            }
          },
          title = "Limbo"
        },
        npcs = {
          "limbo:rat",
          "limbo:wiseoldman",
          "limbo:puppy",
          "limbo:trainingdummy",
          "limbo:bossdummy",
          "limbo:wallythewonderful",
          "limbo:aggro-player-test",
          "limbo:aggro-npc-test"
        },
        quests = {
          "limbo:journeybegins",
          "limbo:onecheeseplease",
          "limbo:selfdefense101"
        },
        rooms = {
          "limbo:white",
          "limbo:black",
          "limbo:training1",
          "limbo:training2",
          "limbo:training3",
          "limbo:training4",
          "limbo:bosstraining",
          "limbo:ancientwayshrine",
          "limbo:wallys",
          "limbo:context",
          "limbo:locked"
        }
      },
      mapped = {
        bundle = "bundle-example-areas",
        items = {
        },
        manifest = {
          info = {
            respawnInterval = 60
          },
          instanced = "player",
          title = "Map Test"
        },
        npcs = {
          "mapped:squirrel"
        },
        quests = {
        },
        rooms = {
          "mapped:start",
          "mapped:hallway-north-1",
          "mapped:hallway-north-2",
          "mapped:basement-north",
          "mapped:hallway-south-1",
          "mapped:hallway-south-2",
          "mapped:attic-south",
          "mapped:hallway-east-1",
          "mapped:hallway-east-2",
          "mapped:hallway-east-3"
        }
      }
    },
    scripts = {
    }
  },
  AttributeFactory = {
    agility = {
      base = 0,
      formula = "./bundles/bundle-example-lib/attributes.lua"
    },
    armor = {
      base = 0,
      formula = "./bundles/bundle-example-lib/attributes.lua"
    },
    critical = {
      base = 0,
      formula = "./bundles/bundle-example-lib/attributes.lua"
    },
    energy = {
      base = 100,
      formula = "./bundles/bundle-example-lib/attributes.lua"
    },
    favor = {
      base = 10,
      formula = "./bundles/bundle-example-classes/attributes.lua"
    },
    health = {
      base = 100,
      formula = "./bundles/bundle-example-lib/attributes.lua"
    },
    intellect = {
      base = 0,
      formula = "./bundles/bundle-example-lib/attributes.lua"
    },
    mana = {
      base = 100,
      formula = "./bundles/bundle-example-classes/attributes.lua"
    },
    stamina = {
      base = 0,
      formula = "./bundles/bundle-example-lib/attributes.lua"
    },
    strength = {
      base = 0,
      formula = "./bundles/bundle-example-lib/attributes.lua"
    }
  },
  Channels = {
    "./bundles/bundle-example-channels/channels.lua"
  },
  Commands = {
    cast = "./bundles/bundle-example-classes/commands/cast.lua",
    commands = "./bundles/bundle-example-commands/commands/commands.lua",
    config = "./bundles/bundle-example-commands/commands/config.lua",
    consider = "./bundles/bundle-example-combat/commands/consider.lua",
    craft = "./bundles/simple-crafting/commands/craft.lua",
    drop = "./bundles/bundle-example-commands/commands/drop.lua",
    flee = "./bundles/bundle-example-combat/commands/flee.lua",
    gather = "./bundles/simple-crafting/commands/gather.lua",
    get = "./bundles/bundle-example-commands/commands/get.lua",
    help = "./bundles/bundle-example-commands/commands/help.lua",
    inventory = "./bundles/bundle-example-commands/commands/inventory.lua",
    kill = "./bundles/bundle-example-combat/commands/kill.lua",
    look = "./bundles/bundle-example-commands/commands/look.lua",
    map = "./bundles/bundle-example-commands/commands/map.lua",
    open = "./bundles/bundle-example-commands/commands/open.lua",
    pvp = "./bundles/bundle-example-combat/commands/pvp.lua",
    quest = "./bundles/bundle-example-quests/commands/quest.lua",
    quit = "./bundles/bundle-example-commands/commands/quit.lua",
    resources = "./bundles/simple-crafting/commands/resources.lua",
    save = "./bundles/bundle-example-commands/commands/save.lua",
    scan = "./bundles/bundle-example-commands/commands/scan.lua",
    score = "./bundles/bundle-example-commands/commands/score.lua",
    skill = "./bundles/bundle-example-classes/commands/skill.lua",
    skills = "./bundles/bundle-example-classes/commands/skills.lua",
    tnl = "./bundles/bundle-example-commands/commands/tnl.lua",
    who = "./bundles/bundle-example-commands/commands/who.lua"
  },
  EffectFactory = {
    cooldown = "./bundles/bundle-example-classes/effects/cooldown.lua",
    ["potion.buff"] = "./bundles/bundle-example-classes/effects/potion.buff.lua",
    ["skill.judge"] = "./bundles/bundle-example-classes/effects/skill.judge.lua",
    ["skill.rend"] = "./bundles/bundle-example-classes/effects/skill.rend.lua",
    ["skill.secondwind"] = "./bundles/bundle-example-classes/effects/skill.secondwind.lua",
    ["skill.shieldblock"] = "./bundles/bundle-example-classes/effects/skill.shieldblock.lua"
  },
  Helps = {
    config = {
      body = [[Modify configuration settings

Extended usage
config list               - List configured settings
config set setting value  - Change setting value

Possible Settings / Values 
autoloot    - (on / off)
brief       - (on / off)
minimap     - (on / off)

Example
config set autoloot on  - Turn on autoloot
]],
      command = "config"
    },
    consider = {
      body = [[Size up an enemy to see how difficult a fight against them would be.
]],
      command = "consider",
      keywords = {
        "combat"
      },
      related = {
        "kill"
      }
    },
    craft = {
      body = [[craft list                  View crafting recipe categories
craft list {category #}     List recipes for a given category
craft list   {cat #} {item #} View stats and ingredients for a given item
craft create {cat #} {item #} Create item viewed with list {#} {#}
]],
      command = "craft"
    },
    credits = {
      body = [[This MUD was built using the Ranvier codebase. You can find out more about Ranvier and its developers at http://ranviermud.com

Creator
---
Shawn Biddle   (github.com/shawncplus)

Developers
---
Sean O'Donohue (github.com/seanohue)
Josh Williams  (github.com/jackjwilliams)
]]
    },
    drop = {
      body = [[Drop an item from your inventory onto the ground
]],
      command = "drop",
      keywords = {
        "loot"
      },
      related = {
        "get",
        "give",
        "inventory",
        "put",
        "remove",
        "wear",
        "wield"
      }
    },
    emote = {
      body = [[Send a message to the room.
Your message may refer to specific players and items with ~<player/item name>.
]],
      command = "emote",
      keywords = {
        "emote"
      }
    },
    equipment = {
      body = [[View currently worn equipment
]],
      command = "equipment",
      keywords = {
        "loot"
      },
      related = {
        "inventory",
        "wear",
        "remove"
      }
    },
    flee = {
      body = [[Run away from a fight. You can optionally specify a direction to run, if you don't a random direction will be picked for you.
]],
      command = "flee",
      keywords = {
        "flee",
        "run"
      },
      related = {
        "kill"
      }
    },
    flush = {
      body = [[Flush currently queued commands
]],
      command = "flush",
      related = {
        "queue"
      }
    },
    get = {
      body = [[Get an item from the room or a container.

You can do '<bold>get all container' to retrieve all items from the container.
To save even more time you can do '<bold>loot container' which is the same thing.
]],
      command = "get",
      keywords = {
        "items",
        "inventory"
      },
      related = {
        "drop",
        "give",
        "inventory",
        "put",
        "wear",
        "wield"
      }
    },
    give = {
      body = [[Give an item to a target. Note: NPCs can only accept items they care about.
]],
      command = "give",
      keywords = {
        "items",
        "inventory"
      },
      related = {
        "put",
        "get",
        "drop",
        "inventory"
      }
    },
    help = {
      body = [[Type <bold><yellow>'commands' to see a list of possible commands.

Type <bold><yellow>'help [command]' to see more information about that command.

Type <bold><yellow>'help search [keyword]' to search the helpfiles by keyword.

Command usage will show arguments as either [optional] or {required}, e.g., look [thing] or get {item} [container]
]],
      related = {
        "new",
        "commands"
      }
    },
    inventory = {
      body = [[View current items in your inventory
]],
      command = "inventory",
      keywords = {
        "loot"
      },
      related = {
        "equipment",
        "get",
        "drop",
        "put"
      }
    },
    kill = {
      body = [[Initiate combat against a target
]],
      command = "kill",
      keywords = {
        "attack",
        "kill",
        "combat"
      },
      related = {
        "flee"
      }
    },
    look = {
      body = "Look at a room or a specific thing (player, item, etc...)",
      command = "look"
    },
    put = {
      body = [[Put an item in a container
]],
      command = "put",
      keywords = {
        "items",
        "inventory"
      },
      related = {
        "drop",
        "get",
        "give",
        "inventory",
        "wear",
        "wield"
      }
    },
    pvp = {
      body = [[Toggle your preference for engaging in Player versus Player combat.
]],
      command = "pvp",
      keywords = {
        "pvp",
        "player",
        "versus"
      },
      related = {
        "kill",
        "flee"
      }
    },
    quest = {
      body = [[quest log               Show current quests
quest list npc          List quests for a given NPC
quest complete number   Complete the given quest
quest start npc number  Start the given quest by the given NPC
]],
      command = "quest"
    },
    queue = {
      body = [[View current queue of commands for the player
]],
      command = "queue",
      related = {
        "flush"
      }
    },
    quit = {
      body = [[Quit the game (cannot be in combat when quitting)
]],
      command = "quit",
      related = {
        "save"
      }
    },
    recall = {
      body = [[Return to the waypoint you have saved as your home with '<b>waypoint home</b>'
]],
      command = "recall",
      keywords = {
        "travel"
      },
      related = {
        "waypoint"
      }
    },
    remove = {
      body = [[Remove equipped item
]],
      command = "remove",
      related = {
        "equipment",
        "inventory",
        "wear"
      }
    },
    save = {
      body = [[Save current player state
]],
      command = "save",
      related = {
        "quit"
      }
    },
    scan = {
      body = [[Check enemies and players in surrounding rooms
]],
      command = "scan"
    },
    tnl = {
      body = "View current experience",
      command = "tnl"
    },
    waypoint = {
      body = [[Waypoints let you travel long distances as long as you have visited the wayshrine once before. Your home waypoint is the room you return to when using '<b>recall</b>' or when you die.

waypoint list
- View your list of saved waypoints. (H) indicates your home waypoint.
waypoint save
- Save the current room to your waypoint list. Must be a wayshrine.
waypoint travel [#]
- At a wayshrine you can travel freely between all of your saved waypoints.
waypoint home
- Save the waypoint you are at as your home waypoint.
]],
      command = "waypoint",
      keywords = {
        "travel"
      },
      related = {
        "recall"
      }
    },
    wear = {
      body = [[Wear an item
]],
      command = "wear",
      keywords = {
        "loot"
      },
      related = {
        "equipment",
        "remove"
      }
    },
    who = {
      body = [[List currently logged in players
]],
      command = "who",
      keywords = {
        "online"
      }
    },
    yell = {
      body = [[Shout a message to all other players in your area
]],
      channel = "yell"
    }
  },
  InputEvents = {
    ["change-password"] = "./bundles/bundle-input-events/input-events/change-password.lua",
    ["choose-character"] = "./bundles/bundle-input-events/input-events/choose-character.lua",
    ["choose-class"] = "./bundles/bundle-input-events/input-events/choose-class.lua",
    commands = "./bundles/bundle-input-events/input-events/commands.lua",
    ["confirm-password"] = "./bundles/bundle-input-events/input-events/confirm-password.lua",
    ["create-account"] = "./bundles/bundle-input-events/input-events/create-account.lua",
    ["create-player"] = "./bundles/bundle-input-events/input-events/create-player.lua",
    ["delete-character"] = "./bundles/bundle-input-events/input-events/delete-character.lua",
    done = "./bundles/bundle-input-events/input-events/done.lua",
    ["finish-player"] = "./bundles/bundle-input-events/input-events/finish-player.lua",
    intro = "./bundles/bundle-input-events/input-events/intro.lua",
    login = "./bundles/bundle-input-events/input-events/login.lua",
    password = "./bundles/bundle-input-events/input-events/password.lua",
    ["player-name-check"] = "./bundles/bundle-input-events/input-events/player-name-check.lua"
  },
  ItemBehaviors = {
    decay = "./bundles/lootable-npcs/behaviors/item/decay.lua"
  },
  ItemFactory = {
    entitys = {
      ["craft:greenplant"] = {
        description = "An oddly bright green plant whose thorns shine as the light hits them. Perhaps you could <b><cyan>gather</cyan></b> it.",
        id = "greenplant",
        keywords = {
          "green",
          "plant",
          "resource"
        },
        metadata = {
          itemLevel = 1,
          level = 1,
          noPickup = true,
          quality = "common",
          resource = {
            depletedMessage = "withers, having been stripped of usable materials.",
            materials = {
              plant_material = {
                max = 3,
                min = 1
              }
            }
          }
        },
        name = "Green Plant",
        roomDesc = "Green Plant",
        type = "RESOURCE"
      },
      ["craft:redrose"] = {
        description = "An oddly bright red rose whose thorns shine as the light hits them. Perhaps you could <b><cyan>gather</cyan></b> it.",
        id = "redrose",
        keywords = {
          "red",
          "rose",
          "resource"
        },
        metadata = {
          itemLevel = 1,
          level = 1,
          noPickup = true,
          quality = "uncommon",
          resource = {
            depletedMessage = "withers, having been stripped of usable materials.",
            materials = {
              plant_material = {
                max = 3,
                min = 2
              },
              rose_petal = {
                max = 2,
                min = 1
              }
            }
          }
        },
        name = "Red Rose",
        roomDesc = "Red Rose",
        type = "RESOURCE"
      },
      ["limbo:bladeofranvier"] = {
        description = "The blade shines a brilliant silver. Holding it you feel as if you could take on the world.",
        id = "bladeofranvier",
        keywords = {
          "sword",
          "blade",
          "ranvier"
        },
        metadata = {
          itemLevel = 15,
          level = 10,
          maxDamage = 26,
          minDamage = 13,
          quality = "epic",
          slot = "wield",
          specialEffects = {
            "Chance on hit: Blade of Ranvier thirsts for blood and heals the wielder for 25% of damage done."
          },
          speed = 2.8,
          stats = {
            critical = 3,
            stamina = 2,
            strength = 2
          }
        },
        name = "Blade of Ranvier",
        roomDesc = "Blade of Ranvier",
        script = "ranvier-blade",
        type = "WEAPON"
      },
      ["limbo:leathervest"] = {
        description = "A plain leather vest. Better than nothing.",
        id = "leathervest",
        keywords = {
          "leather",
          "vest"
        },
        metadata = {
          itemLevel = 1,
          level = 1,
          quality = "common",
          sellable = {
            currency = "gold",
            value = 30
          },
          slot = "chest",
          stats = {
            armor = 20
          }
        },
        name = "Leather Vest",
        roomDesc = "Leather Vest",
        type = "ARMOR"
      },
      ["limbo:locked_chest"] = {
        closed = true,
        id = "locked_chest",
        items = {
          "limbo:rustysword"
        },
        keywords = {
          "locked",
          "wooden",
          "chest"
        },
        locked = true,
        lockedBy = "limbo:test_key",
        maxItems = 5,
        metadata = {
          noPickup = true
        },
        name = "Locked Chest",
        roomDesc = "A wooden chest rests open in the corner, its hinges badly rusted.",
        type = "CONTAINER"
      },
      ["limbo:potionhealth1"] = {
        id = "potionhealth1",
        keywords = {
          "potion",
          "health"
        },
        metadata = {
          level = 1,
          usable = {
            charges = 5,
            cooldown = 30,
            destroyOnDepleted = true,
            options = {
              restores = 30,
              stat = "health"
            },
            spell = "potion"
          }
        },
        name = "Potion of Health I",
        roomDesc = "Potion of Health I",
        type = "POTION"
      },
      ["limbo:potionstrength1"] = {
        id = "potionstrength1",
        keywords = {
          "potion",
          "strength"
        },
        metadata = {
          level = 1,
          usable = {
            charges = 2,
            config = {
              description = "Increases strength by <b>10</b> for <b>15</b> seconds",
              duration = 15000
            },
            destroyOnDepleted = true,
            effect = "potion.buff",
            state = {
              magnitude = 10,
              stat = "strength"
            }
          }
        },
        name = "Potion of Strength I",
        roomDesc = "Potion of Strength I",
        type = "POTION"
      },
      ["limbo:rustysword"] = {
        description = "An arm's-length, jagged metal sword discolored with red corrosion. The worn leather grip barely held on by fraying thread.",
        id = "rustysword",
        keywords = {
          "sword",
          "rusty",
          "metal",
          "rusted"
        },
        metadata = {
          itemLevel = 1,
          level = 1,
          maxDamage = 15,
          minDamage = 7,
          quality = "common",
          slot = "wield",
          speed = 2.8,
          stats = {
            critical = 1
          }
        },
        name = "Rusty Sword",
        roomDesc = "Rusted Sword",
        type = "WEAPON"
      },
      ["limbo:scraps"] = {
        description = "Splintered, shattered, and generally destroyed remains of a training dummy",
        id = "scraps",
        keywords = {
          "dummy",
          "scraps"
        },
        metadata = {
          sellable = {
            currency = "gold",
            value = 5
          }
        },
        name = "Scraps",
        quality = "poor",
        roomDesc = "Scraps from a Training Dummy"
      },
      ["limbo:sliceofcheese"] = {
        behaviors = {
          decay = {
            duration = 240
          }
        },
        description = "A yellow, slightly moldy slice of cheese. Only a rat could find this appetizing.",
        id = "sliceofcheese",
        keywords = {
          "slice",
          "cheese",
          "moldy"
        },
        name = "Slice of Cheese",
        roomDesc = "A moldy slice of cheese"
      },
      ["limbo:test_key"] = {
        description = "This key seems overly complex with numerous grooves.",
        id = "test_key",
        keywords = {
          "key",
          "odd",
          "oddly",
          "shaped"
        },
        metadata = {
          quality = "common"
        },
        name = "Oddly-shaped Key",
        roomDesc = "A strange looking key"
      },
      ["limbo:trainingsword"] = {
        description = "A hefty iron blade. Not the sharpest sword in the world but it will get the job done.",
        id = "trainingsword",
        keywords = {
          "sword",
          "training",
          "iron"
        },
        metadata = {
          itemLevel = 10,
          level = 5,
          maxDamage = 20,
          minDamage = 11,
          quality = "rare",
          sellable = {
            currency = "gold",
            value = 30
          },
          slot = "wield",
          speed = 2.8,
          stats = {
            critical = -1,
            stamina = 2,
            strength = 2
          }
        },
        name = "Training Sword",
        roomDesc = "Training Sword",
        type = "WEAPON"
      },
      ["limbo:woodenchest"] = {
        closed = true,
        description = "Time has not been kind to this chest. It seems to be held together solely by the dirt and rust.",
        id = "woodenchest",
        items = {
          "limbo:rustysword",
          "limbo:leathervest",
          "limbo:potionhealth1",
          "limbo:potionstrength1"
        },
        keywords = {
          "wooden",
          "chest"
        },
        maxItems = 5,
        metadata = {
          noPickup = true
        },
        name = "Wooden Chest",
        roomDesc = "A wooden chest rests in the corner, its hinges badly rusted.",
        type = "CONTAINER"
      },
      ["limbo:woodenshield"] = {
        description = "A rather uninteresting looking wooden shield. A rusted metal band barely hold its together and the leather arm band is nearly torn.",
        id = "woodenshield",
        keywords = {
          "shield",
          "wooden"
        },
        metadata = {
          itemLevel = 1,
          level = 1,
          quality = "common",
          sellable = {
            currency = "gold",
            value = 30
          },
          slot = "shield",
          stats = {
            armor = 10
          }
        },
        name = "Wooden Shield",
        roomDesc = "Wooden Shield",
        type = "ARMOR"
      }
    },
    scripts = {
      ["limbo:bladeofranvier"] = "./bundles//bundle-example-areas/areas/limbo/scripts"
    }
  },
  MobBehaviors = {
    combat = "./bundles/bundle-example-combat/behaviors/npc/combat.lua",
    lootable = "./bundles/lootable-npcs/behaviors/npc/lootable.lua",
    ["ranvier-aggro"] = "./bundles/bundle-example-npc-behaviors/behaviors/npc/ranvier-aggro.lua",
    ["ranvier-wander"] = "./bundles/bundle-example-npc-behaviors/behaviors/npc/ranvier-wander.lua"
  },
  MobFactory = {
    entitys = {
      ["limbo:aggro-npc-test"] = {
        attributes = {
          health = 100,
          strength = 15
        },
        behaviors = {
          combat = true,
          ["ranvier-aggro"] = {
            delay = 5,
            towards = {
              npcs = {
                "limbo:aggro-npc-test"
              },
              players = false
            }
          }
        },
        description = "This NPC is aggressive towards other NPCs but not to the player.",
        id = "aggro-npc-test",
        keywords = {
          "test",
          "aggro",
          "dummy"
        },
        level = 2,
        name = "Self-hating Training Dummy"
      },
      ["limbo:aggro-player-test"] = {
        attributes = {
          health = 120,
          strength = 12
        },
        behaviors = {
          combat = true,
          ["ranvier-aggro"] = {
            delay = 5
          }
        },
        description = "This NPC is aggressive towards players but not other NPCs. Be careful.",
        id = "aggro-player-test",
        keywords = {
          "test",
          "aggro",
          "dummy"
        },
        level = 2,
        name = "Player-aggressive Training Dummy"
      },
      ["limbo:bossdummy"] = {
        attributes = {
          health = 200,
          strength = 15
        },
        behaviors = {
          combat = true,
          lootable = {
            currencies = {
              gold = {
                max = 100,
                min = 50
              }
            },
            pools = {
              "limbo:potions",
              {
                ["limbo:trainingsword"] = 100
              },
              {
                ["limbo:bladeofranvier"] = 5
              }
            }
          }
        },
        description = "This dummy is significantly larger than the others. Bright red with a monstrous figure it lumbers around the area with a great echoing stomp. Where the other target dummies have a bullseye this dummy has a yellow exclamation mark.",
        id = "bossdummy",
        keywords = {
          "boss",
          "target",
          "dummy",
          "practice"
        },
        level = 5,
        name = "Boss Training Dummy"
      },
      ["limbo:puppy"] = {
        description = "A wide-eyed puppy stares up at you.",
        id = "puppy",
        keywords = {
          "puppy",
          "dog",
          "loyal",
          "wide",
          "eyed",
          "wide-eyed"
        },
        level = 1,
        name = "A Puppy",
        script = "puppy"
      },
      ["limbo:rat"] = {
        attributes = {
          energy = 100,
          health = 100
        },
        behaviors = {
          combat = true,
          ["ranvier-wander"] = {
            interval = 20,
            restrictTo = {
              "limbo:white",
              "limbo:black",
              "limbo:training1"
            }
          }
        },
        description = "The rat's beady red eyes dart frantically, its mouth foaming as it scampers about.",
        id = "rat",
        items = {
          "limbo:sliceofcheese"
        },
        keywords = {
          "rat"
        },
        level = 2,
        name = "A Rat",
        quests = {
          "limbo:onecheeseplease"
        },
        script = "rat"
      },
      ["limbo:trainingdummy"] = {
        attributes = {
          health = 100,
          strength = 10
        },
        behaviors = {
          combat = true,
          lootable = {
            currencies = {
              gold = {
                max = 20,
                min = 10
              }
            },
            pools = {
              "limbo:junk",
              "limbo:potions",
              {
                ["limbo:sliceofcheese"] = 25
              }
            }
          }
        },
        description = "The training dummy is almost human shaped although slightly out of proportion. The material it's made of is hard to discern; it seems to constantly change between metal, wood, cloth, and glass depending on the angle. There is a large red and white bullseye painted on its chest. The dummy has no eyes and mindlessly meanders about the area.",
        id = "trainingdummy",
        keywords = {
          "dummy",
          "target",
          "practice"
        },
        level = 2,
        name = "Training Dummy"
      },
      ["limbo:wallythewonderful"] = {
        description = "Moe's Shop has the best wares in town! Armor, weapons and potions, you name and we ... might have it!",
        id = "wallythewonderful",
        keywords = {
          "wally",
          "wonderful",
          "shop",
          "vendor"
        },
        level = 99,
        metadata = {
          vendor = {
            enterMessage = "Step right up! Get your wares at Moe's Shop!",
            items = {
              ["limbo:bladeofranvier"] = {
                cost = 99999,
                currency = "gold"
              },
              ["limbo:leathervest"] = {
                cost = 30,
                currency = "gold"
              },
              ["limbo:potionhealth1"] = {
                cost = 100,
                currency = "gold"
              },
              ["limbo:potionstrength1"] = {
                cost = 150,
                currency = "gold"
              },
              ["limbo:trainingsword"] = {
                cost = 30,
                currency = "gold"
              },
              ["limbo:woodenshield"] = {
                cost = 30,
                currency = "gold"
              }
            },
            leaveMessage = "Come back soon!"
          }
        },
        name = "Wally the Wonderful"
      },
      ["limbo:wiseoldman"] = {
        description = "A wise looking old man sits on the ground with legs crossed.",
        id = "wiseoldman",
        keywords = {
          "wise",
          "old",
          "man"
        },
        level = 99,
        name = "Wise Old Man",
        script = "old-man"
      },
      ["mapped:squirrel"] = {
        behaviors = {
          ["ranvier-wander"] = {
            areaRestricted = true,
            interval = 30
          }
        },
        description = "A furry little squirrel",
        id = "squirrel",
        keywords = {
          "squirrel"
        },
        level = 2,
        name = "A Squirrel"
      }
    },
    scripts = {
      ["limbo:puppy"] = "./bundles//bundle-example-areas/areas/limbo/scripts",
      ["limbo:rat"] = "./bundles//bundle-example-areas/areas/limbo/scripts",
      ["limbo:wiseoldman"] = "./bundles//bundle-example-areas/areas/limbo/scripts"
    }
  },
  PlayerEvents = {
    "./bundles/bundle-example-quests/player-events.lua",
    "./bundles/lootable-npcs/player-events.lua",
    "./bundles/bundle-example-commands/player-events.lua",
    "./bundles/bundle-example-combat/player-events.lua",
    "./bundles/bundle-example-classes/player-events.lua",
    "./bundles/bundle-example-player-events/player-events.lua"
  },
  QuestFactory = {
    ["limbo:journeybegins"] = {
      autoComplete = true,
      completionMessage = [[<b><cyan>Hint: You can use the '<white>tnl or '<white>level' commands to see how much experience you need to level.
<b><yellow>The rat looks like it is hungry, use '<white>quest list rat to see what aid you can offer. Use '<white>quest start rat 1 to accept their task.
<b><cyan>Hint: To move around the game type any of the exit names listed in <white>[Exits: ...] when you use the '<white>look command.]],
      description = [[A voice whispers to you: Welcome to the world, young one. This is a dangerous and deadly place, you should arm yourself.
 - Open the chest with '<white>open chest'
 - Use '<white>get sword chest and '<white>get vest chest to get some gear
 - Equip it using '<white>wield sword and '<white>wear vest']],
      goals = {
        {
          config = {
            count = 1,
            item = "limbo:rustysword",
            title = "Find a Weapon"
          },
          type = "FetchGoal"
        },
        {
          config = {
            count = 1,
            item = "limbo:leathervest",
            title = "Find Some Armor"
          },
          type = "FetchGoal"
        },
        {
          config = {
            slot = "wield",
            title = "Wield A Weapon"
          },
          type = "EquipGoal"
        },
        {
          config = {
            slot = "chest",
            title = "Equip Some Armor"
          },
          type = "EquipGoal"
        }
      },
      id = "journeybegins",
      level = 1,
      rewards = {
        {
          config = {
            amount = 5,
            leveledTo = "QUEST"
          },
          type = "ExperienceReward"
        },
        {
          config = {
            amount = 10,
            currency = "gold"
          },
          type = "CurrencyReward"
        }
      },
      title = "A Journey Begins"
    },
    ["limbo:onecheeseplease"] = {
      completionMessage = "<b><cyan>Hint: NPCs with quests available have <white>[</white><yellow>!</yellow><white>]</white> in front of their name, <white>[</white><yellow>?</yellow><white>]</white> means you have a quest ready to turn in, and <white>[</white><yellow>%</yellow><white>]</white> means you have a quest in progress.</cyan>",
      description = [[A rat's squeaks seem to indicate it wants some cheese. You check around the area, maybe someone has left some lying around.

Once you find some bring it back to the rat, use '<white>quest log</white>' to find the quest number, then complete the quest with '<white>quest complete #</white>']],
      goals = {
        {
          config = {
            count = 1,
            item = "limbo:sliceofcheese",
            removeItem = true,
            title = "Found Cheese"
          },
          type = "FetchGoal"
        }
      },
      id = "onecheeseplease",
      level = 1,
      npc = "limbo:rat",
      repeatable = true,
      rewards = {
        {
          config = {
            amount = 3,
            leveledTo = "QUEST"
          },
          type = "ExperienceReward"
        }
      },
      title = "One Cheese Please"
    },
    ["limbo:selfdefense101"] = {
      autoComplete = true,
      completionMessage = "<b><cyan>Hint: You can get the loot from enemies with '<white>get <item> corpse</white>' but be quick about it, the corpse will decay after some time.</cyan>",
      description = [[A voice whispers to you: It would be wise to practice protecting yourself. There are a number of training dummies in this area that, while not pushovers, will not be too difficult.
- Use '<white>attack dummy</white>' to start combat against the training dummy
- Once it's dead any loot it drops will be in its corpse on the ground. You can use '<white>look in corpse</white>' to check again or '<white>loot corpse</white>' to retrieve all your loot.]],
      goals = {
        {
          config = {
            count = 1,
            npc = "limbo:trainingdummy",
            title = "Kill a Training Dummy"
          },
          type = "KillGoal"
        }
      },
      id = "selfdefense101",
      level = 2,
      requires = {
        "limbo:journeybegins"
      },
      rewards = {
        {
          config = {
            amount = 5,
            leveledTo = "QUEST"
          },
          type = "ExperienceReward"
        }
      },
      title = "Self Defense 101"
    }
  },
  QuestGoals = {
    BountyGoal = "./bundles/bundle-example-quests/quest-goals/BountyGoal.lua",
    EquipGoal = "./bundles/bundle-example-quests/quest-goals/EquipGoal.lua",
    FetchGoal = "./bundles/bundle-example-quests/quest-goals/FetchGoal.lua",
    KillGoal = "./bundles/bundle-example-quests/quest-goals/KillGoal.lua"
  },
  QuestReward = {
    CurrencyReward = "./bundles/bundle-example-quests/quest-rewards/CurrencyReward.lua",
    ExperienceReward = "./bundles/bundle-example-quests/quest-rewards/ExperienceReward.lua"
  },
  RoomBehaviors = {
  },
  RoomFactory = {
    entitys = {
      ["limbo:ancientwayshrine"] = {
        description = [[A runed black obelisk towers in the center of this clearing, surrounded by a faerie ring. The runes pulse and glow with a soft blue light. The grass immediately around the obelisk is immaculate in stark contrast to the dying former meadow that makes up the clearing.
]],
        exits = {
          {
            direction = "up",
            roomId = "limbo:white"
          },
          {
            direction = "down",
            roomId = "limbo:context"
          }
        },
        id = "ancientwayshrine",
        script = "ancientwayshrine",
        title = "Ancient Wayshrine"
      },
      ["limbo:black"] = {
        description = "A completely black room. Somehow all of the light that should be coming from the room to the west does not pass through the archway. A single lightbulb hangs from the ceiling illuminating a small area. To the east you see a large white dome. There is a sign above the entrance to the dome: \"Training Area\"",
        exits = {
          {
            direction = "west",
            leaveMessage = " steps into the light and disappears.",
            roomId = "limbo:white"
          },
          {
            direction = "east",
            roomId = "limbo:training1"
          }
        },
        id = "black",
        items = {
          {
            id = "limbo:sliceofcheese",
            respawnChance = 10
          }
        },
        npcs = {
          "limbo:wiseoldman",
          "limbo:puppy"
        },
        script = "black",
        title = "Black Room"
      },
      ["limbo:bosstraining"] = {
        description = "The dome in this section is bright red, the pure green grass is replaced with a smooth white surface. The ground beneath your feet has the word \"Danger\" in bright red letters tiled across the area.",
        exits = {
          {
            direction = "south",
            roomId = "limbo:training3"
          }
        },
        id = "bosstraining",
        npcs = {
          {
            id = "limbo:bossdummy",
            respawnChance = 50
          }
        },
        title = "Boss Training Room"
      },
      ["limbo:context"] = {
        description = "This room shows off commands that are only active in a particular room. Try out the <cyan>roomtest command.",
        doors = {
          ["limbo:ancientwayshrine"] = {
            closed = true,
            locked = true
          }
        },
        exits = {
          {
            direction = "up",
            roomId = "limbo:ancientwayshrine"
          },
          {
            direction = "east",
            roomId = "limbo:locked"
          }
        },
        id = "context",
        items = {
          {
            id = "limbo:test_key"
          }
        },
        metadata = {
          commands = {
            "roomtest"
          }
        },
        script = "context",
        title = "Room Context Commands Test"
      },
      ["limbo:locked"] = {
        description = "This room requires a key to get into",
        doors = {
          ["limbo:context"] = {
            closed = true,
            locked = true,
            lockedBy = "limbo:test_key"
          }
        },
        exits = {
          {
            direction = "west",
            roomId = "limbo:context"
          }
        },
        id = "locked",
        items = {
          {
            id = "limbo:locked_chest",
            replaceOnRespawn = true,
            respawnChance = 5
          }
        },
        title = "Locked room with key"
      },
      ["limbo:training1"] = {
        description = "The entire area is covered by a large dome with a hexagonal grid surface. A beautiful blue sky reaches from horizon to horizon, punctuated by the lines of the grid. The dome shimmers as virtual birds fly into and out of its surface. The pure green grass is eerily undisturbed by you walking over it or by the simulated breeze.",
        exits = {
          {
            direction = "west",
            roomId = "limbo:black"
          },
          {
            direction = "north",
            roomId = "limbo:training2"
          },
          {
            direction = "east",
            roomId = "limbo:training4"
          }
        },
        id = "training1",
        npcs = {
          {
            id = "limbo:trainingdummy",
            maxLoad = 3,
            respawnChance = 25
          }
        },
        script = "combat-training",
        title = "Training Room"
      },
      ["limbo:training2"] = {
        description = "The entire area is covered by a large dome with a hexagonal grid surface. A beautiful blue sky reaches from horizon to horizon, punctuated by the lines of the grid. The dome shimmers as virtual birds fly into and out of its surface. The pure green grass is eerily undisturbed by you walking over it or by the simulated breeze.",
        exits = {
          {
            direction = "south",
            roomId = "limbo:training1"
          },
          {
            direction = "east",
            roomId = "limbo:training3"
          }
        },
        id = "training2",
        items = {
          {
            id = "craft:greenplant",
            respawnChance = 30
          }
        },
        npcs = {
          {
            id = "limbo:trainingdummy",
            maxLoad = 3,
            respawnChance = 25
          },
          {
            id = "limbo:aggro-player-test",
            maxLoad = 1,
            respawnChance = 25
          }
        },
        script = "combat-training",
        title = "Training Room 2"
      },
      ["limbo:training3"] = {
        description = "The entire area is covered by a large dome with a hexagonal grid surface. A beautiful blue sky reaches from horizon to horizon, punctuated by the lines of the grid. The dome shimmers as virtual birds fly into and out of its surface. The pure green grass is eerily undisturbed by you walking over it or by the simulated breeze.",
        exits = {
          {
            direction = "west",
            roomId = "limbo:training2"
          },
          {
            direction = "south",
            roomId = "limbo:training4"
          },
          {
            direction = "north",
            roomId = "limbo:bosstraining"
          }
        },
        id = "training3",
        items = {
          {
            id = "craft:redrose",
            respawnChance = 15
          }
        },
        npcs = {
          {
            id = "limbo:trainingdummy",
            maxLoad = 3,
            respawnChance = 25
          }
        },
        script = "combat-training",
        title = "Training Room 3"
      },
      ["limbo:training4"] = {
        description = "The entire area is covered by a large dome with a hexagonal grid surface. A beautiful blue sky reaches from horizon to horizon, punctuated by the lines of the grid. The dome shimmers as virtual birds fly into and out of its surface. The pure green grass is eerily undisturbed by you walking over it or by the simulated breeze.",
        exits = {
          {
            direction = "west",
            roomId = "limbo:training1"
          },
          {
            direction = "north",
            roomId = "limbo:training3"
          }
        },
        id = "training4",
        npcs = {
          {
            id = "limbo:trainingdummy",
            maxLoad = 3,
            respawnChance = 25
          },
          {
            id = "limbo:aggro-npc-test",
            maxLoad = 2,
            respawnChance = 50
          }
        },
        script = "combat-training",
        title = "Training Room 4"
      },
      ["limbo:wallys"] = {
        description = "A very brightly colored shop stall stands in the middle of an otherwise desolate clearing. The stall is covered in colorful cloth, shining gems, and battle gear of all varieties. A large sign sits next to the products: \"<yellow>Wally's Wonderful Wares has the best products in town! Armor, weapons and potions, you name and we... might have it!\"",
        exits = {
          {
            direction = "east",
            roomId = "limbo:white"
          }
        },
        id = "wallys",
        npcs = {
          {
            id = "limbo:wallythewonderful",
            respawnChance = 0
          }
        },
        title = "Wally's Wonderful Wares (Shop)"
      },
      ["limbo:white"] = {
        description = "A featureless white room. A pitch black void in the shape of archway can be seen on the east side of the room.",
        exits = {
          {
            direction = "east",
            leaveMessage = " steps into the void and disappears.",
            roomId = "limbo:black"
          },
          {
            direction = "down",
            roomId = "limbo:ancientwayshrine"
          },
          {
            direction = "west",
            roomId = "limbo:wallys"
          },
          {
            direction = "north",
            roomId = "mapped:start"
          }
        },
        id = "white",
        items = {
          {
            id = "limbo:woodenchest",
            replaceOnRespawn = true,
            respawnChance = 20
          },
          {
            id = "limbo:woodenchest",
            replaceOnRespawn = true,
            respawnChance = 20
          }
        },
        npcs = {
          "limbo:rat"
        },
        script = "white",
        title = "White Room"
      },
      ["mapped:attic-south"] = {
        coordinates = {
          0,
          -2,
          1
        },
        description = "You are in the attic.",
        exits = {
          {
            direction = "east",
            roomId = "limbo:white"
          }
        },
        id = "attic-south",
        title = "Attic"
      },
      ["mapped:basement-north"] = {
        coordinates = {
          0,
          2,
          -1
        },
        description = "You are in the basement.",
        doors = {
          ["mapped:hallway-north-2"] = {
            closed = true
          }
        },
        id = "basement-north",
        title = "Basement"
      },
      ["mapped:hallway-east-1"] = {
        coordinates = {
          1,
          0,
          0
        },
        description = "You are in the east hallway.",
        id = "hallway-east-1",
        title = "Hallway East 1"
      },
      ["mapped:hallway-east-2"] = {
        coordinates = {
          2,
          0,
          0
        },
        description = "You are in the east hallway.",
        id = "hallway-east-2",
        title = "Hallway East 2"
      },
      ["mapped:hallway-east-3"] = {
        coordinates = {
          2,
          -1,
          0
        },
        description = "You are in the east hallway.",
        id = "hallway-east-3",
        title = "Hallway East 3"
      },
      ["mapped:hallway-north-1"] = {
        coordinates = {
          0,
          1,
          0
        },
        description = "You are in the north hallway.",
        id = "hallway-north-1",
        title = "Hallway North 1"
      },
      ["mapped:hallway-north-2"] = {
        coordinates = {
          0,
          2,
          0
        },
        description = "You are in the north hallway.",
        id = "hallway-north-2",
        title = "Hallway North 2"
      },
      ["mapped:hallway-south-1"] = {
        coordinates = {
          0,
          -1,
          0
        },
        description = "You are in the south hallway.",
        id = "hallway-south-1",
        title = "Hallway South 1"
      },
      ["mapped:hallway-south-2"] = {
        coordinates = {
          0,
          -2,
          0
        },
        description = "You are in the south hallway.",
        id = "hallway-south-2",
        title = "Hallway South 2"
      },
      ["mapped:start"] = {
        coordinates = {
          0,
          0,
          0
        },
        description = "You are in the start of this area. There are hallways to the north and south.",
        id = "start",
        npcs = {
          "mapped:squirrel"
        },
        title = "Begin"
      }
    },
    scripts = {
      ["limbo:ancientwayshrine"] = "./bundles//bundle-example-areas/areas/limbo/scripts",
      ["limbo:black"] = "./bundles//bundle-example-areas/areas/limbo/scripts",
      ["limbo:context"] = "./bundles//bundle-example-areas/areas/limbo/scripts",
      ["limbo:training1"] = "./bundles//bundle-example-areas/areas/limbo/scripts",
      ["limbo:training2"] = "./bundles//bundle-example-areas/areas/limbo/scripts",
      ["limbo:training3"] = "./bundles//bundle-example-areas/areas/limbo/scripts",
      ["limbo:training4"] = "./bundles//bundle-example-areas/areas/limbo/scripts",
      ["limbo:white"] = "./bundles//bundle-example-areas/areas/limbo/scripts"
    }
  },
  SkillManager = {
    judge = "./bundles/bundle-example-classes/skills/judge.lua",
    lunge = "./bundles/bundle-example-classes/skills/lunge.lua",
    plea = "./bundles/bundle-example-classes/skills/plea.lua",
    rend = "./bundles/bundle-example-classes/skills/rend.lua",
    secondwind = "./bundles/bundle-example-classes/skills/secondwind.lua",
    shieldblock = "./bundles/bundle-example-classes/skills/shieldblock.lua",
    smite = "./bundles/bundle-example-classes/skills/smite.lua"
  },
  SpellManager = {
    fireball = "./bundles/bundle-example-classes/skills/fireball.lua",
    heal = "./bundles/bundle-example-classes/skills/heal.lua",
    potion = "./bundles/bundle-example-classes/skills/potion.lua"
  }
}