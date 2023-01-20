local _G, select, setmetatable                            = _G, select, setmetatable

local TMW                                                 = _G.TMW

local A                                                 = _G.Action

--local Unit                                                = A.Unit
local GameLocale                                        = A.FormatGameLocale(_G.GetLocale())
local StdUi                                                = A.StdUi
local Factory                                            = StdUi.Factory
local math_random                                        = math.random

local L                                                = setmetatable(
    {
        ANY                                         = {InterruptName         = "Mythic+ and Raid - Trip",},
    }, 
    { __index = function(t) return t.ANY end })

TMW:RegisterCallback("TMW_ACTION_INTERRUPTS_UI_CREATE_CATEGORY", function(callbackEvent, Category)
        local CL = Action.GetCL()
        Category.options[#Category.options + 1] = { text = L[GameLocale].InterruptName, value = "MainPvE" }
        Category:SetOptions(Category.options)
end)

Factory[4].MainPvE = StdUi:tGenerateMinMax({
    [GameLocale] = {
        ISINTERRUPT = true,
        --Algeth'ar Academy
        [396812] = { useKick = true, useCC = true, useRacial = true,                           }, --Mystic Blast
        [388392] = { useKick = true, useCC = true, useRacial = true,                           }, --Monotonous Lecture
        [388863] = { useKick = true, useCC = true, useRacial = true,                           }, --Mana Void
        [377389] = { useKick = true, useCC = true, useRacial = true,                           }, --Call of the Flock
        [396640] = { useKick = true, useCC = true, useRacial = true,                           }, --Healing Touch
        [387843] = { useKick = true, useCC = true, useRacial = true,                           }, --Astral Bomb
        --Court of Stars
        [209413] = { useKick = true, useCC = true, useRacial = true,                           }, --Suppress
        [207980] = { useKick = true, useCC = true, useRacial = true,                           }, --Disintegration Beam
        [208165] = { useKick = true, useCC = true, useRacial = true,                           }, --Withering Soul   
        [214692] = { useKick = true, useCC = false, useRacial = false,                         }, --Shadow Bolt Volley
        [210261] = { useKick = false, useCC = true, useRacial = true,                       }, --Sound Alarm
        [211401] = { useKick = true, useCC = true, useRacial = false,                          }, --Drifting Embers
        --Halls of Valor
        [198595] = { useKick = true, useCC = true, useRacial = true,                          }, --Thunderous Bolt
        [215433] = { useKick = true, useCC = true, useRacial = true,                          }, --Holy Radiance
        [192288] = { useKick = true, useCC = true, useRacial = true,                          }, --Searing Light
        [199726] = { useKick = true, useCC = false, useRacial = false,                         }, --Unruly Yell  
        [198750] = { useKick = true, useCC = false, useRacial = false,                         }, --Surge 
        --Ruby Life Pools  
        [372749] = { useKick = true, useCC = true, useRacial = true,                          }, --Ice Shield 
        [372735] = { useKick = false, useCC = true, useRacial = true,                         }, --Tectonic Slam 
        [373803] = { useKick = true, useCC = true, useRacial = true,                         }, --Cold Claws 
        [373017] = { useKick = true, useCC = false, useRacial = false,                         }, --Roaring Blaze
        [392451] = { useKick = true, useCC = true, useRacial = true,                         }, --Flashfire
        [385310] = { useKick = true, useCC = true, useRacial = true,                         }, --Lightning Bolt
        --Shadowmoon Burial Grounds
        [152818] = { useKick = true, useCC = true, useRacial = true,                         }, --Shadow Mend
        [152814] = { useKick = true, useCC = true, useRacial = true,                         }, --Shadow Bolt
        [156776] = { useKick = true, useCC = true, useRacial = true,                         }, --Rending Voidlash
        [156722] = { useKick = true, useCC = true, useRacial = true,                         }, --Void Bolt
        [156718] = { useKick = true, useCC = true, useRacial = true,                         }, --Necrotic Burst
        [153524] = { useKick = true, useCC = true, useRacial = true,                         }, --Plague Spit
        --Temple of the Jade Serpent
        [397888] = { useKick = true, useCC = true, useRacial = true,                         }, --Hydrolance
        [397889] = { useKick = true, useCC = true, useRacial = true,                         }, --Tidal Burst
        [395859] = { useKick = true, useCC = true, useRacial = true,                         }, --Haunting Scream
        [396073] = { useKick = true, useCC = true, useRacial = true,                         }, --Cat Nap    
        [397914] = { useKick = true, useCC = true, useRacial = true,                         }, --Defiling Mist  
        --Azure Vault
        [375602] = { useKick = true, useCC = true, useRacial = true,                         }, --Erratic Growth 
        [387564] = { useKick = true, useCC = true, useRacial = true,                         }, --Mystic Vapors
        [370225] = { useKick = true, useCC = true, useRacial = true,                         }, --Shriek
        [386546] = { useKick = true, useCC = true, useRacial = true,                         }, --Waking Bane
        [389804] = { useKick = true, useCC = true, useRacial = true,                         }, --Heavy Tome
        [377488] = { useKick = true, useCC = true, useRacial = true,                         }, --Icy Bindings
        [373932] = { useKick = true, useCC = true, useRacial = true,                         }, --Illusionary Bolts
        --The Nokhud Offensive
        [383823] = { useKick = true, useCC = true, useRacial = true,                         }, --Rally the Clan
        [384365] = { useKick = true, useCC = true, useRacial = true,                         }, --Disruptive Shout
        [386024] = { useKick = true, useCC = true, useRacial = true,                         }, --Tempest
        [387411] = { useKick = true, useCC = true, useRacial = true,                         }, --Death Bolt Volley     
        [387440] = { useKick = false, useCC = true, useRacial = true,                         }, --Desecrating Roar
        [387606] = { useKick = true, useCC = true, useRacial = true,                         }, --Dominate
        [382077] = { useKick = false, useCC = true, useRacial = true,                         }, --Command: Seek
        [373395] = { useKick = true, useCC = true, useRacial = true,                         }, --Bloodcurdling Shout
        [376725] = { useKick = true, useCC = true, useRacial = true,                         }, --Storm Bolt
        
    },
}, 43, 70, math_random(87, 95), true)
