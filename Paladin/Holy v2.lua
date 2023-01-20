--#############################################
--##### Edited Trip Holy Paladin by Johan #####
--#############################################


local _G, setmetatable                            = _G, setmetatable
local TMW                                       = TMW
local CTT 										= _G.CTT
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local A                                         = _G.Action
local Listener                                  = Action.Listener
local Create                                    = Action.Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local AuraIsValid                               = Action.AuraIsValid
local InterruptIsValid                          = Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Utils                                     = Action.Utils
local TeamCache                                 = Action.TeamCache
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player 
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit 
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local HealingEngine                             = Action.HealingEngine
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local TeamCacheFriendly                         = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local math_random                         = math.random
local tinsert                                   = table.insert 
local select, unpack, table                     = select, unpack, table 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local select, math                              = select, math 
local huge                                      = math.huge  
local UIParent                                  = _G.UIParent 
local CreateFrame                               = _G.CreateFrame
local wipe                                      = _G.wipe
local IsUsableSpell                             = IsUsableSpell
local UnitPowerType                             = UnitPowerType 

--For Toaster
local Toaster                                    = _G.Toaster
local GetSpellTexture                             = _G.TMW.GetSpellTexture

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_PALADIN_HOLY] = {
    -- Racial
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    WillToSurvive                           = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    
    -- Spells
    Sanguine = Create({ Type = "Spell", ID = 226510, Hidden = true}),    
    Combustion = Create({ Type = "Spell", ID = 99240, Hidden = true}),    
    
    -- Paladin General
    AvengingWrath                    = Action.Create({ Type = "Spell", ID = 31884    }),    
    BlessingofFreedom                = Action.Create({ Type = "Spell", ID = 1044        }),
    BlessingofProtection            = Action.Create({ Type = "Spell", ID = 1022        }),
    BlessingofSacrifice                = Action.Create({ Type = "Spell", ID = 6940        }),
    ConcentrationAura                = Action.Create({ Type = "Spell", ID = 317920    }),
    Consecration                    = Action.Create({ Type = "Spell", ID = 26573    }),
    CrusaderAura                    = Action.Create({ Type = "Spell", ID = 32223    }),
    CrusaderStrike                    = Action.Create({ Type = "Spell", ID = 35395    }),
    DevotionAura                    = Action.Create({ Type = "Spell", ID = 465        }),    
    DivineShield                    = Action.Create({ Type = "Spell", ID = 642        }),
    DivineSteed                        = Action.Create({ Type = "Spell", ID = 190784    }),
    FlashofLight                    = Action.Create({ Type = "Spell", ID = 19750, predictName = "FlashofLight"        }),
    HammerofJustice                    = Action.Create({ Type = "Spell", ID = 853        }),
    HammerofJusticeGreen            = Action.Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", Hidden = true, Hidden = true, QueueForbidden = true }),    
    HammerofWrath                    = Action.Create({ Type = "Spell", ID = 24275    }),
    HandofReckoning                    = Action.Create({ Type = "Spell", ID = 62124    }),    
    Judgment                        = Action.Create({ Type = "Spell", ID = 275773    }),
    LayOnHands                        = Action.Create({ Type = "Spell", ID = 633, predictName = "LayOnHands"            }),    
    Redemption                        = Action.Create({ Type = "Spell", ID = 7328        }),
    RetributionAura                    = Action.Create({ Type = "Spell", ID = 183435    }),
    ShieldoftheRighteous            = Action.Create({ Type = "Spell", ID = 53600    }),
    TurnEvil                        = Action.Create({ Type = "Spell", ID = 10326    }),
    WordofGlory                        = Action.Create({ Type = "Spell", ID = 85673, predictName = "WordofGlory"        }),    
    Forbearance                        = Action.Create({ Type = "Spell", ID = 25771    }),
    
    
    -- Holy Specific
    Absolution                        = Action.Create({ Type = "Spell", ID = 212056    }),
    AuraMastery                        = Action.Create({ Type = "Spell", ID = 31821    }),
    BeaconofLight                    = Action.Create({ Type = "Spell", ID = 53563    }),
    Cleanse                            = Action.Create({ Type = "Spell", ID = 4987        }),
    DivineProtection                = Action.Create({ Type = "Spell", ID = 498        }),
    HolyLight                        = Action.Create({ Type = "Spell", ID = 82326, predictName = "HolyLight"            }),
    HolyShock                        = Action.Create({ Type = "Spell", ID = 20473, predictName = "HolyShock"            }),
    LightofDawn                        = Action.Create({ Type = "Spell", ID = 85222, predictName = "LightofDawn"        }),
    LightofMartyr                    = Action.Create({ Type = "Spell", ID = 183998, predictName = "LightofMartyr"    }),
    InfusionofLight                    = Action.Create({ Type = "Spell", ID = 53576, Hidden = true        }),    
    InfusionofLightBuff                = Action.Create({ Type = "Spell", ID = 54149, Hidden = true        }),    
    
    -- Normal Talents
    CrusadersMight                    = Action.Create({ Type = "Spell", ID = 196926, Hidden = true    }),
    BestowFaith                        = Action.Create({ Type = "Spell", ID = 223306, predictName = "BestowFaith"        }),
    LightsHammer                    = Action.Create({ Type = "Spell", ID = 114158    }),    
    SavedbytheLight                    = Action.Create({ Type = "Spell", ID = 157047, Hidden = true    }),
    JudgmentofLight                    = Action.Create({ Type = "Spell", ID = 183778, Hidden = true    }),        
    HolyPrism                        = Action.Create({ Type = "Spell", ID = 114165, predictName = "HolyPrism"        }),
    FistofJustice                    = Action.Create({ Type = "Spell", ID = 234299, Hidden = true    }),
    Repentance                        = Action.Create({ Type = "Spell", ID = 20066    }),
    BlindingLight                    = Action.Create({ Type = "Spell", ID = 115750    }),        
    UnbreakableSpirit                = Action.Create({ Type = "Spell", ID = 114154, Hidden = true    }),        
    Cavalier                        = Action.Create({ Type = "Spell", ID = 230332, Hidden = true    }),
    RuleofLaw                        = Action.Create({ Type = "Spell", ID = 214202    }),
    DivinePurpose                    = Action.Create({ Type = "Spell", ID = 223817, Hidden = true    }),    
    DivinePurposeBuff               = Action.Create({ Type = "Spell", ID = 223819, Hidden = true     }),
    HolyAvenger                        = Action.Create({ Type = "Spell", ID = 105809    }),
    Seraphim                        = Action.Create({ Type = "Spell", ID = 152262    }),
    SanctifiedWrath                    = Action.Create({ Type = "Spell", ID = 53376    }),    
    AvengingCrusader                = Action.Create({ Type = "Spell", ID = 216331    }),
    Awakening                        = Action.Create({ Type = "Spell", ID = 248033, Hidden = true    }),
    GlimmerofLight                    = Action.Create({ Type = "Spell", ID = 325966, Hidden = true    }),
    GlimmerofLightBuff                = Action.Create({ Type = "Spell", ID = 287280, Hidden = true    }),
    BeaconofFaith                    = Action.Create({ Type = "Spell", ID = 156910    }),
    BeaconofVirtue                    = Action.Create({ Type = "Spell", ID = 200025    }),        
    BreakingDawn					= Action.Create({ Type = "Spell", ID = 387879 }),
    Rebuke							= Action.Create({ Type = "Spell", ID = 96231 }),
    RebukeGreen 					= Create({ Type = "SpellSingleColor",ID = 96231,Hidden = true,Color = "GREEN",QueueForbidden = true}),
    AvengingWrathMight                    = Action.Create({ Type = "Spell", ID = 31884, Hidden = true    }),   
    UnendingLight                    = Action.Create({ Type = "Spell", ID = 387998, Hidden = true    }),  
    UnendingLightBuff                    = Action.Create({ Type = "Spell", ID = 394709, Hidden = true    }),  
    OfDuskAndDawn                    = Action.Create({ Type = "Spell", ID = 385125, Hidden = true    }), 
    BlessingofDusk                    = Action.Create({ Type = "Spell", ID = 385126, Hidden = true    }), 
    BlessingofDawn                    = Action.Create({ Type = "Spell", ID = 385127, Hidden = true    }), 
    MaraadsDyingBreath                    = Action.Create({ Type = "Spell", ID = 388018, Hidden = true    }), 
    MaraadsDyingBreathBuff                    = Action.Create({ Type = "Spell", ID = 388019, Hidden = true    }), 
    
    -- PvP
    DivineFavor                               = Action.Create({ Type = "Spell", ID = 210294 }),
    HordeFlag                                = Action.Create({ Type = "Spell", ID = 156618 }),
    AllianceFlag                           = Action.Create({ Type = "Spell", ID = 156621 }),
    OrbofPowerPurple                               = Action.Create({ Type = "Spell", ID = 121175 }), 
    OrbofPowerGreen                               = Action.Create({ Type = "Spell", ID = 121176 }), 
    OrbofPowerBlue                               = Action.Create({ Type = "Spell", ID = 121164 }), 
    OrbofPowerOrange                        = Action.Create({ Type = "Spell", ID = 121177 }), 
    FocusedAssault                           = Action.Create({ Type = "Spell", ID = 46392 }),
    NetherstormFlag                           = Action.Create({ Type = "Spell", ID = 34976 }),
    CleanseTheWeak                            = Action.Create({ Type = "Spell", ID = 199330 }),
    RecentlySavedByTheLight                    = Action.Create({ Type = "Spell", ID = 157131 }),
    HallowedGround                            = Action.Create({ Type = "Spell", ID = 216868 }),
    Mindgames                                 = Action.Create({ Type = "Spell", ID = 323673 }),
    
    --    Later
    
    DivineToll                        = Action.Create({ Type = "Spell", ID = 304971   }),    
    BlessingofSummer                = Action.Create({ Type = "Spell", ID = 388007, Texture = 328620     }),    
    BlessingofAutumn                = Action.Create({ Type = "Spell", ID = 388010, Texture = 328620     }),    
    BlessingofSpring                = Action.Create({ Type = "Spell", ID = 388013, Texture = 328620      }),    
    BlessingofWinter                = Action.Create({ Type = "Spell", ID = 388011, Texture = 328620      }),          
    
    -- Conduits

    
    
    --Anima Powers - to add later...
    
    
    -- Trinkets
    
    -- Potions
    PotionofUnbridledFury            = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),     
    SuperiorPotionofUnbridledFury    = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }),
    PotionofSpectralIntellect        = Action.Create({ Type = "Potion", ID = 171273, QueueForbidden = true }),
    PotionofSpectralStamina            = Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }),
    PotionofEmpoweredExorcisms        = Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
    PotionofHardenedShadows            = Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofPhantomFire                = Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
    PotionofDeathlyFixation            = Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }),
    SpiritualHealingPotion            = Action.Create({ Type = "Item", ID = 171267, QueueForbidden = true }),
    
    
    -- Misc
    Channeling                      = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                     = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                        = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
    PoolResource                    = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    Quake                           = Action.Create({ Type = "Spell", ID = 240447, Hidden = true     }), -- Quake (Mythic Plus Affix)
    Cyclone                         = Action.Create({ Type = "Spell", ID = 33786, Hidden = true     }), -- Cyclone     
    
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_PALADIN_HOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_HOLY], { __index = Action })


local player = "player"
local targettarget = "targettarget"
local target = "target"
local mouseover = "mouseover"
local focustarget = "focustarget"
local focus = "focus"

-- Call to avoid lua limit of 60upvalues 
-- Call RotationsVariables in each function that need these vars
local function RotationsVariables()
    combatTime = Unit(player):CombatTime()
    inCombat = Unit(player):CombatTime() > 0
    UseDBM = GetToggle(1 ,"DBM") -- Don't call it DBM else it broke all the global DBM var used by another addons
    Potion = GetToggle(1, "Potion")
    Racial = GetToggle(1, "Racial")
    HealMouseover = GetToggle(2, "HealMouseover")
    DPSMouseover = GetToggle(2, "DPSMouseover")
    -- ProfileUI vars
    BeaconWorkMode = GetToggle(2, "BeaconWorkMode")    
    TrinketMana = GetToggle(2, "TrinketMana")
    LightofDawnHP = GetToggle(2, "LightofDawnHP")
    LightofDawnUnits = GetToggle(2, "LightofDawnUnits")
    UseLightofDawn = GetToggle(2, "UseLightofDawn")
    ForceWoGHP = GetToggle(2, "ForceWoGHP")
    HolyLightHP = GetToggle(2, "HolyLightHP")
    WordofGloryHP = GetToggle(2, "WordofGloryHP")
    HolyShockHP = GetToggle(2, "HolyShockHP")
    BestowFaithHP = GetToggle(2, "BestowFaithHP")
    FlashofLightHP = GetToggle(2, "FlashofLightHP")
    HolyPrismHP = GetToggle(2, "HolyPrismHP")
    LightofMartyr = GetToggle(2, "LightofDawnHP")
    DFHolyLightHP = GetToggle(2, "DFHolyLightHP")
    if A.BreakingDawn:IsTalentLearned() then
        LightofDawnRange = 40
    elseif not A.BreakingDawn:IsTalentLearned() then
        LightofDawnRange = 15
    end

end


local Temp                               = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    useHP                                   = 3,
    customDispel                            = { --145206, --Proving Grounds Testing
                                                388392, --Monotonous Lecture
                                                391977, --Oversurge
                                                389033, --Lasher Toxin
                                                207278, --Arcane Lockdown
                                                207980, --Disintegration Beam
                                                372682, --Primal Chill
                                                114803, --Throw torch
                                                395872, --Sleepy Soliloquy
                                                106736, --Wither Will
                                                386546, --Waking Bane
                                                377488, --Icy Bindings
                                                388777, --Oppressive Miasma
                                                384686, --Energy Surge
                                                376827, --Conductive Strike
    },
    incomingAoEDamage                       = { 388537, --Arcane Fissue
                                                377004, --Deafening Screech
                                                388923, --Burst Forth
                                                212784, --Eye Storm
                                                192305, --Eye of the Storm (mini-boss)
                                                200901, --Eye of the Storm (boss)
                                                372863, --Ritual of Blazebinding
                                                153094, --Whispers of the Dark Star
                                                164974, --Dark Eclipse
                                                153804, --Inhale
                                                175988, --Omen of Death
                                                106228, --Nothingness
                                                374720, --Consuming Stomp
                                                384132, --Overwhelming Energy
                                                388008, --Absolute Zero
                                                385399, --Unleashed Destruction
                                                388817, --Shards of Stone
                                                387145, --Totemic Overload
    },
    stopCasting                             = { 377004, --Deafening Screech
                                                397892, --Scream of Pain
                                                196543, --Unnerving Howl
                                                199726, --Unruly Yell
                                                381516, --Interrupting Cloudburst
                                                384365, --Disruptive Shout
    },
    stunEnemy                               = { 197406, --Aggravated Skitterfly
                                                104295, --Blazing Imp  
                                                190174, --Hypnosis Bat  
    },
    customBoPDebuff                         = { 196838, --Scent of Blood

    },
    freedomList                             = { 377488, --Icy Bindings
                                                387615, --Grasp of the Dead
    },
    scaryCasts                              = { 396023, --Incinerating Roar
                                                376279, --Concussive Slam
                                                388290, --Cyclone
                                                375457, --Chilling Tantrum
    },
    scaryDebuffs                            = { 394917, --Leaping Flames
                                                391686, --Conductive Mark

    },
}

A[1] = nil
A[2] = nil

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local incomingBigHit = MultiUnits:GetByRangeCasting(40, nil, nil, Temp.scaryCasts) > 0
    if A.AuraMastery:IsReady(player) and Unit(player):HasBuffs(A.DevotionAura.ID, true) > 0 and incomingBigHit then
        return A.AuraMastery
    end

    -- DivineShield
    if A.DivineShield:IsReady(player) and GetToggle(2, "UseDivineShield") and Unit(player):HasDeBuffs(A.Forbearance.ID, true) == 0 and Unit(player):HealthPercent() < 20 and Unit(player):TimeToDieX(20) < 3
    then 
        return A.DivineShield
    end
    
    -- DivineProtection
    if A.DivineProtection:IsReady(player) and Unit(player):HealthPercent() < 60 and Unit(player):TimeToDieX(20) < 10 then
        return A.DivineProtection
    end
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
    
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function BlessingofSeasons(unitID)
    local getmembersAll = HealingEngine.GetMembersAll()
    for i = 1, #getmembersAll do 
        if Unit(getmembersAll[i].Unit):GetRange() <= 40 then
            --BlessingofAutumn
            if A.BlessingofAutumn:IsReady(getmembersAll[i].Unit) then 
                if Unit(getmembersAll[i].Unit):IsDamager() and (Unit(getmembersAll[i].Unit):Class() == "MONK" or Unit(getmembersAll[i].Unit):Class() == "WARLOCK" or Unit(getmembersAll[i].Unit):Class() == "EVOKER") then
                    HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)    -- Add 1sec delay in case of emergency switch     
                    return A.BlessingofAutumn                --Keep same icon for all four spells.  
                else return A.BlessingofAutumn              --If no monk, warlock, or evoker, just dump Autumn on whoever is current target.     
                end  
            --Blessing of Winter                  
            elseif A.BlessingofWinter:IsReady(getmembersAll[i].Unit) then 
                if Unit(getmembersAll[i].Unit):IsMelee() then
                    HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)    -- Add 1sec delay in case of emergency switch     
                    return A.BlessingofWinter                --Keep same icon for all four spells.       
                end
            elseif A.BlessingofSummer:IsReady(getmembersAll[i].Unit) and not (A.BlessingofAutumn:IsReady(getmembersAll[i].Unit) or A.BlessingofWinter:IsReady(getmembersAll[i].Unit) or A.BlessingofSpring:IsReady(getmembersAll[i].Unit)) then
                if Unit(getmembersAll[i].Unit):Class() == "ROGUE" then
                    HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)    -- Add 1sec delay in case of emergency switch  
                    return A.BlessingofSummer 
                elseif Unit(getmembersAll[i].Unit):IsDamager() and not Unit(getmembersAll[i].Unit):HasSpec({253, 255, 270, 266}) then --no pet/clone specs 
                    HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)    -- Add 1sec delay in case of emergency switch     
                    return A.BlessingofSummer                --Keep same icon for all four spells.       
                end
            end
        end                  

    end    

    if A.BlessingofSpring:IsReady(player) then
        HealingEngine.SetTarget(player, 0.5)    -- Add 1sec delay in case of emergency switch     
        return A.BlessingofSpring  
    end

end

local function UseTrinkets(unitID)
    local TrinketType1 = A.GetToggle(2, "TrinketType1")
    local TrinketType2 = A.GetToggle(2, "TrinketType2")
    local TrinketValue1 = A.GetToggle(2, "TrinketValue1")
    local TrinketValue2 = A.GetToggle(2, "TrinketValue2")	

    if A.Trinket1:IsReady(unitID) then
        if TrinketType1 == "Damage" then
            if A.BurstIsON(unitID) and A.IsUnitEnemy(unitID) then
                return A.Trinket1
            end
        elseif TrinketType1 == "Friendly" and A.IsUnitFriendly(unitID) then
            if Unit(unitID):HealthPercent() <= TrinketValue1 then
                return A.Trinket1
            end	
        elseif TrinketType1 == "SelfDefensive" then
            if Unit(player):HealthPercent() <= TrinketValue1 then
                return A.Trinket1
            end	
        elseif TrinketType1 == "ManaGain" then
            if Unit(player):PowerPercent() <= TrinketValue1 then
                return A.Trinket1
            end
        end	
    end

    if A.Trinket2:IsReady(unitID) then
        if TrinketType2 == "Damage" then
            if A.BurstIsON(unitID) and A.IsUnitEnemy(unitID) then
                return A.Trinket2
            end
        elseif TrinketType2 == "Friendly" and A.IsUnitFriendly(unitID) then
            if Unit(unitID):HealthPercent() <= TrinketValue2 then
                return A.Trinket2
            end	
        elseif TrinketType2 == "SelfDefensive" then
            if Unit(player):HealthPercent() <= TrinketValue2 then
                return A.Trinket2
            end	
        elseif TrinketType2 == "ManaGain" then
            if Unit(player):PowerPercent() <= TrinketValue2 then
                return A.Trinket2
            end
        end	
    end

end

local function Cleanse(unitID)
    
    local customDispel = A.GetToggle(2, "CustomDispel")
    local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
    local unitGUID = UnitGUID(unitID)  

    dispelList = AuraIsValid(unitID, "UseDispel", "Dispel")
    freedomList = AuraIsValid(unitID, true, "BlessingofFreedom")

    if A.Cleanse:IsReady(unitID) and useDispel and dispelList then
        return A.Cleanse
    end 
    
    if A.BlessingofFreedom:IsReady(unitID) and useUtils and freedomList then
        return A.BlessingofFreedom
    end

end

local function Interrupts(unitID)

    local customKicks = A.GetToggle(2, "CustomKicks")

    if customKicks then
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, "MainPvE", true, true)
    else useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true) 
    end
    
    if castRemainsTime >= A.GetLatency() then
        -- Quell
        if useKick and not notInterruptable and A.Rebuke:IsReady(unitID) then 
            return A.Rebuke
        end
            
        if useCC and A.HammerofJustice:IsReady(unitID) then
            return A.HammerofJustice
        end

        if useCC and A.BlindingLight:IsReady(player) and A.HammerofJustice:IsInRange(unitID) then
            return A.BlindingLight
        end

    end

end

-----------------------------------------
--        ROTATION FUNCTIONS           --
-----------------------------------------

local ipairs, pairs = ipairs, pairs
local FriendlyGUIDs = TeamCache.Friendly.GUIDs

-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local CurrentTanks = HealingEngine.GetMembersByMode("TANK")
    local getmembersAll = HealingEngine.GetMembersAll()
    local inCombat = Unit(player):CombatTime() > 0
    local isMoving = Player:IsMoving()
    local isMovingFor = A.Player:IsMovingTime()
    local combatTime = Unit(player):CombatTime()    
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local AoEON = GetToggle(2, "AoE")
    
    -- Healing Engine vars
    local AVG_DMG = HealingEngine.GetIncomingDMGAVG()
    local AVG_HPS = HealingEngine.GetIncomingHPSAVG()
    local TeamCacheEnemySize = TeamCache.Enemy.Size
    local DungeonGroup = TeamCache.Friendly.Size >= 2 and TeamCache.Friendly.Size <= 5
    local RaidGroup = TeamCache.Friendly.Size >= 5
    local TeamCacheFriendlySize = TeamCache.Friendly.Size
    local TeamCacheFriendlyType = TeamCache.Friendly.Type or "none"     
    
    
    RotationsVariables()    
    
    
    ---------------------
    --- HEAL ROTATION ---
    ---------------------
    local function HealingRotation(unitID) 

        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
        local unitGUID = UnitGUID(unitID)   
        
        if A.OfDuskAndDawn:IsTalentLearned() and (Unit(player):HasBuffs(A.BlessingofDawn.ID) == 0 or Unit(player):HasBuffs(A.BlessingofDawn.ID) < Unit(player):HasBuffs(A.BlessingofDusk.ID)) then
            Temp.useHP = 5
            else Temp.useHP = 3
        end

        --Auras
        if (A.Zone == "pvp" or A.Zone == "arena" or A.InstanceInfo.isRated) and A.ConcentrationAura:IsReady() and Unit(player):HasBuffs(A.ConcentrationAura.ID) == 0 and Unit(player):HasBuffs(A.CrusaderAura.ID) == 0 and Unit(player):HasBuffs(A.RetributionAura.ID) == 0 
        and Unit(player):HasBuffs(A.DevotionAura.ID) == 0 then
            return A.ConcentrationAura:Show(icon)
        end
        
        if (A.Zone ~= "pvp" or A.Zone ~= "arena" or not A.InstanceInfo.isRated) and A.DevotionAura:IsReady() and Unit(player):HasBuffs(A.DevotionAura.ID) == 0 and Unit(player):HasBuffs(A.CrusaderAura.ID) == 0 and Unit(player):HasBuffs(A.RetributionAura.ID) == 0 
        and Unit(player):HasBuffs(A.ConcentrationAura.ID) == 0 then
            return A.DevotionAura:Show(icon)
        end
        
        --Lay on hands
        if Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and combatTime > 0 and Action.Zone ~= "arena" and not Action.InstanceInfo.isRated   -- Forbearance
        then
            for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 then 
                    if not Unit(getmembersAll[i].Unit):IsPet() and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(getmembersAll[i].Unit):IsDead() and A.LayOnHands:IsReadyByPassCastGCD(getmembersAll[i].Unit) and (Unit(getmembersAll[i].Unit):HealthDeficit() >= Unit(player):HealthMax() or Unit(getmembersAll[i].Unit):HealthPercent() <= 30 
                        and Unit(getmembersAll[i].Unit):TimeToDie() <= 3) and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Forbearance.ID, true) == 0 then
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)    -- Add 1sec delay in case of emergency switch     
                        return A.LayOnHands:Show(icon)                        
                    end                    
                end                
            end    
        end 
        
        if GetToggle(1, "StopCast") then
            
            if Unit(player):HasDeBuffs(A.Quake.ID) > 0 and (Unit(player):IsCastingRemains(A.HolyLight.ID) > Unit(player):HasDeBuffs(A.Quake.ID) or Unit(player):IsCastingRemains(A.FlashofLight.ID) > Unit(player):HasDeBuffs(A.Quake.ID)) then
                return A:Show(icon, ACTION_CONST_STOPCAST)
            end
            
            if inCombat and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and (((Unit(player):IsCastingRemains(A.HolyLight.ID) > Player:Execute_Time(A.HolyLight.ID)/2 or Unit(player):IsCastingRemains(A.FlashofLight.ID) > Player:Execute_Time(A.FlashofLight.ID)/2) and A.HolyShock:IsReady(unitID) and Unit(unitID):HealthPercent() < HolyShockHP)
                or ((Unit(player):IsCastingRemains(A.HolyLight.ID) > 0.5 or Unit(player):IsCastingRemains(A.FlashofLight.ID) > 0.5) and A.WordofGlory:IsReady(unitID) and Unit(unitID):HealthPercent() < WordofGloryHP) or (Unit(player):IsCastingRemains(A.HolyLight.ID) > 0 and Unit(unitID):HealthPercent() >= HolyLightHP) 
                or (Unit(player):IsCastingRemains(A.FlashofLight.ID) > 0 and Unit(unitID):HealthPercent() >= FlashofLightHP)) then
                return A:Show(icon, ACTION_CONST_STOPCAST)
            end
            
        end
        
        --Blessing of Sacrifice
        if A.BlessingofSacrifice:IsReadyByPassCastGCD(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and combatTime > 0 and not UnitIsUnit(unitID, player) and not Unit(unitID):IsPet() and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 40 
        and Unit(unitID):TimeToDieX(20) <= 4 and (Unit(unitID):HasBuffs("TotalImun") == 0 or Unit(unitID):HasBuffs("DamagePhysImun") > 0 and Unit(unitID):TimeToDieMagicX(20) <= 4 or Unit(unitID):HasBuffs("DamageMagicImun") > 0 and Unit(unitID):TimeToDieX(20) - Unit(unitID):TimeToDieMagicX(20) < -1) then
            return A.BlessingofSacrifice:Show(icon)
        end    
        
        --Blessing of Protection (Keystone Combustion Aggro)
        for i = 1, #getmembersAll do 
            if combatTime > 0 and useShields and Unit(getmembersAll[i].Unit):GetRange() <= 40 and A.InstanceInfo.KeyStone >= 15 then 
                if not Unit(getmembersAll[i].Unit):IsPet() and not Unit(getmembersAll[i].Unit):IsDead() and A.BlessingofProtection:IsReady(getmembersAll[i].Unit) 
                and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Forbearance.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.Combustion.ID) > 0
                and Unit(getmembersAll[i].Unit):IsTanking() and not Unit(getmembersAll[i].Unit):Role("TANK") and not UnitIsUnit(getmembersAll[i].Unit, player) and (Unit(getmembersAll[i].Unit):HasBuffs("TotalImun") == 0 or Unit(getmembersAll[i].Unit):HasBuffs("DamagePhysImun") == 0) then
                    HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)       
                    return A.BlessingofProtection:Show(icon)                        
                end                    
            end                
        end    
        
        local _,_,_,_,_,NPCID1 = Unit(unitID):InfoGUID()
        
        --Blessing of Protection
        
        if A.BlessingofProtection:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and useShields and combatTime > 0 and not Unit(unitID):IsPet() and not Unit(unitID):IsTank() and not UnitIsUnit(unitID, player) and not Unit(unitID):IsDead() 
        and Unit(unitID):HealthPercent() <= 30 and Unit(unitID):TimeToDieX(20) <= 4 and Unit(unitID):HasDeBuffs(A.OrbofPowerBlue.ID) == 0 and Unit(unitID):HasDeBuffs(A.OrbofPowerGreen.ID) == 0 
        and Unit(unitID):HasDeBuffs(A.OrbofPowerPurple.ID) == 0 and Unit(unitID):HasDeBuffs(A.OrbofPowerOrange.ID) == 0 and Unit(unitID):HasDeBuffs(A.Forbearance.ID, true) == 0
        and not Unit(unitID):HasFlags() and (Unit(unitID):HasBuffs("TotalImun") == 0 or Unit(unitID):HasBuffs("DamagePhysImun") == 0 and Unit(unitID):TimeToDieX(20) - Unit(unitID):TimeToDieMagicX(20) < -1) then
            return A.BlessingofProtection:Show(icon)
        end    
        
        if A.WillToSurvive:IsReady() and Unit(player):HasDeBuffs("Stuned") > 2 then
            return A.WillToSurvive:Show(icon)
        end
        
        --Holy Light Divine Favor w/o Infusion
        if A.HolyLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < 0.8 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and Unit(player):HasBuffs(A.DivineFavor.ID, true) > 0 and Unit(unitID):TimeToDie() <= 5 and Unit(unitID):HealthPercent() <= DFHolyLightHP and not Unit(unitID):IsDead() and Unit(player):GetCurrentSpeed() == 0 then
            return A.HolyLight:Show(icon)
        end    
        
        -- Beacon of Light - Self
        if not A.BeaconofVirtue:IsTalentLearned() and A.BeaconofLight:IsReady() and BeaconWorkMode == "Self" then
            if UnitIsUnit(unitID, player) and Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0  then    
                return A.BeaconofLight:Show(icon)                        
            end                    
        end
        
        -- Beacon of Light - Tank
        if not A.BeaconofVirtue:IsTalentLearned() and A.BeaconofLight:IsReady(unitID) and BeaconWorkMode == "Tanking Units" then
            if Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofLight.ID, 0, true) == 0 then
                return A.BeaconofLight:Show(icon)
            end
        end
        
        -- Beacon of Faith PVE - 2x Tank
        if not A.BeaconofVirtue:IsTalentLearned() and BeaconWorkMode == "Beacon of Faith 2" then
            if A.BeaconofLight:IsReady(unitID) and Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofLight.ID, 0, true) == 0 then
                return A.BeaconofLight:Show(icon)
            end
            if A.BeaconofFaith:IsReady(unitID) and Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofFaith.ID, 0, true) == 0 then
                return A.BeaconofFaith:Show(icon)
            end
        end
        
        -- Beacon of Faith PVE
        if not A.BeaconofVirtue:IsTalentLearned() and A.BeaconofFaith:IsTalentLearned() and BeaconWorkMode == "Beacon of Faith" then
            if UnitIsUnit(unitID, player) and A.BeaconofFaith:IsReady(unitID) and Unit(player):HasBuffs(A.BeaconofFaith.ID, true) == 0 then
                return A.BeaconofFaith:Show(icon)
            end
            if Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofLight.ID, 0, true) == 0 then
                return A.BeaconofLight:Show(icon)
            end
        end
        
        -- Beacon of Light - Beacon of Faith + Saved By the Light
        if A.SavedbytheLight:IsTalentLearned() and A.BeaconofFaith:IsTalentLearned() and BeaconWorkMode == "Beacon of Faith + Saved By the Light" then
            if UnitIsUnit(unitID, player) and not Unit(unitID):IsDead() and Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0 
            or not UnitIsUnit(unitID, player) and HealingEngine.GetBuffsCount(A.BeaconofFaith.ID) > 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and IsUnitFriendly(unitID) and Unit(unitID):IsPlayer() and Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and Unit(unitID):HealthPercent() <= 45 and combatTime > 0 then
                return A.BeaconofLight:Show(icon)                        
            end           
            if IsUnitFriendly(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not UnitIsUnit(unitID, player) and not Unit(unitID):IsDead() and Unit(unitID):IsPlayer() and Unit(unitID):HasBuffs(A.RecentlySavedByTheLight.ID, true) == 0 and (Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0 or Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0) and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and Unit(unitID):HealthPercent() <= 45 and combatTime > 0 then
                return A.BeaconofFaith:Show(icon)
            end
        end
        
        --Beacon of Virtue
        if A.BeaconofVirtue:IsReady(unitID) and A.BeaconofVirtue:IsTalentLearned() and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and HealingEngine.GetBelowHealthPercentUnits(90, 30) >= 2 then
            return A.BeaconofVirtue:Show(icon)
        end
        
        -- Toll + Wrath Amplifier
        if combatTime > 0 and A.DivineToll:IsReady(unitID) and HealingEngine.GetBelowHealthPercentUnits(70, 30) >= 5 and Unit(player):HasBuffs(A.AvengingWrath.ID) == 0 and A.AvengingWrath:IsReady() and TeamCacheFriendlyType == "raid" then
            return A.AvengingWrath:Show(icon)
        end

        local UseTrinket = UseTrinkets(unitID)
        if UseTrinket then
            return UseTrinket:Show(icon)
        end 

        -- #17 HPvE DivineToll
        if A.DivineToll:IsReady(unitID) and combatTime > 0 and Unit(unitID):IsPlayer() and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() 
        and not IsUnitEnemy(unitID) and Unit(unitID):GetRange() <= 30 and Unit(unitID):HealthPercent() < HolyShockHP and
        ((Player:HolyPower() <= 1 and
                        (    (Action.Zone == "arena" and (TeamCache.Friendly.Size >= 2 and HealingEngine.GetBelowHealthPercentUnits(80, 30) >= 2))
                            or
                            (TeamCacheFriendlyType == "none" and MultiUnits:GetByRange(10) > 2 and Unit(player):HealthPercent() <= 80) 
                            or
                            (TeamCacheFriendlyType == "party" and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "DivineTollHPParty"), 30) >= GetToggle(2, "DivineTollUnitsParty")) 
                            or
                            (TeamCacheFriendlyType == "raid" and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "DivineTollHPRaid"), 30) >= GetToggle(2, "DivineTollUnitsRaid"))
                        )
                    ) 
                    or
                    TeamCacheFriendly ~= "raid" and HealingEngine.GetBelowHealthPercentUnits(50, 30) >= 4 and Player:HolyPower() <= 3 or (TeamCacheFriendlyType == "raid" and HealingEngine.GetBelowHealthPercentUnits(80, 30) >= 5))
                then
                    return A.DivineToll:Show(icon)
        end
            
        
        if not Action.InstanceInfo.isRated or Action.InstanceInfo.isRated and (Unit(unitID):HealthPercent() >= 30 or Unit(unitID):HealthPercent() < 30 and not A.HolyShock:IsReady() and not A.WordofGlory:IsReady()) then
            
            if (A.Zone == "arena" or A.InstanceInfo.isRated) and A.BlessingofFreedom:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.BlessingofFreedom.ID) == 0 
                    and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofFreedom") and Unit(getmembersAll[i].Unit):HasSpec(PVPMELEE) and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end
            
            if A.Cleanse:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if GetToggle(2, "CustomDispel") then
                        dispelList = Unit(getmembersAll[i].Unit):HasDeBuffs(Temp.customDispel) > 0
                    else dispelList = AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Dispel")
                    end
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and dispelList
                    and Unit(getmembersAll[i].Unit):HasDeBuffs(342938) == 0 and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end
            
            if A.BlessingofFreedom:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if GetToggle(2, "CustomDispel") then
                        freedomList = Unit(getmembersAll[i].Unit):HasDeBuffs(Temp.freedomList) > 0 or AuraIsValid(getmembersAll[i].Unit, true, "BlessingofProtection")
                    end
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):GetCurrentSpeed() <= 70 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.BlessingofFreedom.ID) == 0 
                    and freedomList and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end
            
            if A.BlessingofProtection:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.BlessingofProtection.ID) == 0 and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Forbearance.ID) == 0
                    and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofProtection") and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end 

            local useCleanse = Cleanse(unitID)
            if useCleanse then
                return useCleanse:Show(icon)
            end
            
            -- #2 HPvE BoF
            if A.BlessingofFreedom:IsReady(unitID) and (((A.Zone == "arena" or A.InstanceInfo.isRated)) or ((A.Zone ~= "arena" or not A.InstanceInfo.isRated) and Unit(unitID):GetCurrentSpeed() <= 70)) and Unit(unitID):HasBuffs(A.BlessingofFreedom.ID) == 0 and
            useUtils and
            (
                -- MouseOver
                (
                    Unit("mouseover"):IsExists() and 
                    MouseHasFrame() and                      
                    not IsUnitEnemy("mouseover") and        
                    AuraIsValid(mouseover, true, "BlessingofFreedom")
                ) or 
                (
                    (
                        not A.GetToggle(2, "mouseover") or 
                        not Unit("mouseover"):IsExists() or 
                        IsUnitEnemy("mouseover")
                    ) and        
                    not IsUnitEnemy(unitID) and A.GetToggle(2, "DispelSniper") and
                    AuraIsValid(unitID, true, "BlessingofFreedom")
                )
            )
            then
                return A.BlessingofFreedom:Show(icon)
            end        
            
            -- #3 HPvE BoP
            if A.BlessingofProtection:IsReady(unitID) and Unit(unitID):HasBuffs(A.BlessingofProtection.ID) == 0 and Unit(unitID):HasDeBuffs(A.Forbearance.ID) == 0 and not Unit(unitID):IsPet() and not Unit(unitID):IsTank() and
            useShields and not Unit(unitID):IsDead() and
            (
                -- MouseOver
                (
                    Unit("mouseover"):IsExists() and 
                    MouseHasFrame() and                      
                    not IsUnitEnemy("mouseover") and        
                    AuraIsValid(mouseover, true, "BlessingofProtection")
                ) or 
                (
                    (
                        not A.GetToggle(2, "mouseover") or 
                        not Unit("mouseover"):IsExists() or 
                        IsUnitEnemy("mouseover")
                    ) and        
                    not IsUnitEnemy(unitID) and A.GetToggle(2, "DispelSniper") and
                    AuraIsValid(unitID, true, "BlessingofProtection")
                )
            )
            then
                return A.BlessingofProtection:Show(icon)
            end     
            
        end

        if inCombat then
            local SeasonBlessings = BlessingofSeasons()
            if SeasonBlessings and A.BlessingofSummer:IsTalentLearned() then
                return SeasonBlessings:Show(icon)
            end
        end

        if A.LightsHammer:IsReady(player) and not isMoving and HealingEngine.GetBelowHealthPercentUnits(85, 15) >= 2 then
            return A.LightsHammer:Show(icon)
        end

        if A.LightofDawn:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and not Unit(unitID):IsDead() and TeamCacheFriendlyType == "raid" and UseLightofDawn and HealingEngine.GetBelowHealthPercentUnits(LightofDawnHP, 15) >= LightofDawnUnits and HealingEngine.GetBelowHealthPercentUnits(ForceWoGHP, 40) == 0 and Player:HolyPower() >= Temp.useHP then
            return A.LightofDawn:Show(icon)
        end
        
        if A.MaraadsDyingBreath:IsTalentLearned() and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() then
            if A.LightofDawn:IsReady(player) and Player:HolyPower() >= Temp.useHP then
                return A.LightofDawn:Show(icon)
            end

            if A.HolyShock:IsReady(unitID) and IsUnitFriendly(unitID) and Unit(unitID):HealthPercent() < HolyShockHP then
                return A.HolyShock:Show(icon)
            end

            if A.LightofMartyr:IsReady(unitID) and Unit(unitID):HealthPercent() <= 90 and not UnitIsUnit(player, unitID) and Unit(player):HasBuffs(A.MaraadsDyingBreathBuff.ID) > 0 then
                return A.LightofMartyr:Show(icon)
            end

            if A.BestowFaith:IsReady(unitID) and Unit(player):HealthPercent() <= 95 then
                HealingEngine.SetTarget(player, 0.5)
                return A.BestowFaith:Show(icon)
            end
        end

        --Word of Glory at 5 HP
        if A.WordofGlory:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() < WordofGloryHP and Player:HolyPower() >= Temp.useHP then
            return A.WordofGlory:Show(icon)
        end
        
        if A.HolyPrism:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() < HolyPrismHP then
            return A.HolyPrism:Show(icon)
        end       
        
        --Holy Shock target
        if A.HolyShock:IsReady(unitID) and IsUnitFriendly(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() < HolyShockHP then
            return A.HolyShock:Show(icon)
        end
        
        --Word of Glory 3 HP
        if A.WordofGlory:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() < WordofGloryHP and not A.MaraadsDyingBreath:IsTalentLearned() and Player:HolyPower() >= Temp.useHP then
            return A.WordofGlory:Show(icon)
        end
        
        if Unit(target):HasDeBuffs("BreakAble") == 0 and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 then
                
                if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.CrusaderStrike:IsReady(target) and A.CrusaderStrike:IsInRange(target) and IsUnitEnemy(target) and Unit(target):HasDeBuffs(A.Cyclone.ID) == 0 
                and not Unit(target):IsDead() and (A.CrusadersMight:IsTalentLearned() and ((Player:HolyPower() < 5 and A.HolyShock:GetCooldown() >= 1.0)) or (not A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and Player:ManaPercentage() > GetToggle(2, "ManaConservation"))) then
                    return A.CrusaderStrike:Show(icon)        
                end
                
                if A.Judgment:IsReady(target) and (Unit(target):GetRange() <= 10 or A.Zone == "arena" or A.InstanceInfo.isRated or A.Zone == "pvp") and IsUnitEnemy(target) and Unit(target):HasDeBuffs(A.Cyclone.ID) == 0 and Unit(target):HasDeBuffs(196941, true) == 0 
                and A.JudgmentofLight:IsTalentLearned() and not Unit(target):IsDead() then
                    return A.Judgment:Show(icon)
                end
        
        end
        
        if A.ArcaneTorrent:IsReady(player) and not Unit(player):IsDead() and Player:HolyPower() == 2 and combatTime > 0 then
            return A.ArcaneTorrent:Show(icon)
        end
        
        if TeamCacheFriendlyType ~= "raid" and A.HolyShock:IsReady(unitID) and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 90 and (HealingEngine.GetBelowHealthPercentUnits(90, 40) == 1 and Player:ManaPercentage() >= 50 and Player:HolyPower() < 5) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 then
            return A.HolyShock:Show(icon)
        end
        
        if A.WordofGlory:IsReady(unitID) and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 90 and combatTime == 0 then
            return A.WordofGlory:Show(icon)
        end
        
        --Rule of Law
        if A.RuleofLaw:IsReady(player) and not Unit(unitID):IsDead() and IsUnitFriendly(unitID) and combatTime > 0 and A.RuleofLaw:IsTalentLearned() and Unit(player):HasBuffs(A.RuleofLaw.ID, true) == 0 and inCombat and 
        ((Unit(unitID):CanInterract(40) and (A.RuleofLaw:GetSpellCharges() == 2 and (Unit(unitID):Health() <= Unit(unitID):HealthMax()*0.6 or HealingEngine.GetBelowHealthPercentUnits(LightofDawnHP, 15) >= LightofDawnUnits)) or (Unit(unitID):TimeToDie() <= 6 or Unit(unitID):Health() <= Unit(unitID):HealthMax()*0.35) or (not Unit(unitID):CanInterract(40)))) then
            return A.RuleofLaw:Show(icon)
        end
        
        --Bestow Faith
        if A.BestowFaith:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() < BestowFaithHP then
            return A.BestowFaith:Show(icon)
        end    
        
        if A.DivineFavor:IsTalentLearned() and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and IsUnitFriendly("target") and Unit("target"):HasDeBuffs(A.Cyclone.ID) == 0 and Unit("target"):GetRange() <= 40 and Unit("target"):HealthPercent() < DFHolyLightHP and Unit("target"):TimeToDie() < 5 and A.DivineFavor:IsReady(player) then
            return A.DivineFavor:Show(icon)
        end
        
        if A.Zone == "arena" or A.InstanceInfo.isRated or A.Zone == "pvp" or inCombat then
            
            if A.Awakening:IsTalentLearned() and A.LightofDawn:IsReady(unitID) and A.GetToggle(2, "LightofDawnDump") and Player:HolyPower() >= Temp.useHP and Unit(player):HasBuffs(A.AvengingWrath.ID) == 0 then
                return A.LightofDawn:Show(icon)
            end
            
            if (A.Awakening:IsTalentLearned() and A.GetToggle(2, "LightofDawnDump") and Unit(player):HasBuffs(A.AvengingWrath) > 0 or A.Awakening:IsTalentLearned() and not A.GetToggle(2, "LightofDawnDump") or not A.Awakening:IsTalentLearned()) and A.ShieldoftheRighteous:IsReady(player) and Player:HolyPower() >= A.GetToggle(2, "DumpHP") and A.CrusaderStrike:IsInRange(target) and IsUnitEnemy(target) and Unit(target):HasDeBuffs(A.Cyclone.ID) == 0 
            and (HealingEngine.GetBelowHealthPercentUnits(80, 40) < 1 or (HealingEngine.GetBelowHealthPercentUnits(50, 40) < 1 and TeamCache.Friendly.Size <= 2)) then
                return A.ShieldoftheRighteous:Show(icon)
            end
            
        end
    end    
    HealingRotation = Action.MakeFunctionCachedDynamic(HealingRotation)
    
    ---------------------
    --- FILLER ROTATION ---
    ---------------------
    local function FillerRotation(unitID) 
        
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
        local unitGUID = UnitGUID(unitID)    
        
        -- Light of the Martyr
        if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.LightofMartyr:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and (Unit(player):HealthPercent() >= 50 or Unit(player):HasBuffs(A.DivineShield.ID) > 0) and Unit(unitID):HealthPercent() < A.GetToggle(2, "LightofMartyrHP") and Unit(player):GetCurrentSpeed() ~= 0 and not UnitIsUnit(unitID, player) then
            return A.LightofMartyr:Show(icon)
        end    
        
        if Unit(player):HasDeBuffs(A.Quake.ID) == 0 then
            
            if not inCombat or inCombat and not A.HolyShock:IsReady() and not A.WordofGlory:IsReady() then 
                
                --[[Flash of Light Infusion proc
                if A.FlashofLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.FlashofLight.ID) and not A.WordofGlory:IsReady(unitID) 
                and Player:Execute_Time(A.FlashofLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.FlashofLight.ID)/2 and Unit(unitID):HealthPercent() <= A.GetToggle(2, "FlashofLightHP") 
                and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() and Unit(player):HasBuffs(A.InfusionofLightBuff.ID, true) > Player:Execute_Time(A.FlashofLight.ID) 
                and Unit(unitID):HealthPercent() < FlashofLightHP 
                and Unit(unitID):TimeToDie() > Player:Execute_Time(A.FlashofLight.ID) and Unit(unitID):TimeToDie() < 8 and Unit(player):GetCurrentSpeed() == 0 then
                    if A.DivineFavor:IsReady(player) then
                        return A.DivineFavor:Show(icon)
                    end
                    return A.FlashofLight:Show(icon)
                end]]
                
                --Holy Light Infusion proc
                if A.HolyLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.HolyLight.ID) and not A.WordofGlory:IsReady(unitID) 
                and Player:Execute_Time(A.HolyLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.HolyLight.ID)/2 and not Unit(unitID):IsDead() 
                and Unit(player):HasBuffs(A.InfusionofLightBuff.ID, true) > Player:Execute_Time(A.HolyLight.ID) and Unit(unitID):HealthPercent() < HolyLightHP 
                and Unit(player):GetCurrentSpeed() == 0 then
                    if A.DivineFavor:IsReady(player) then
                        return A.DivineFavor:Show(icon)
                    end
                    return A.HolyLight:Show(icon)
                end    
                
                --[[Flash of Light no infusion
                if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.FlashofLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.FlashofLight.ID) 
                and not A.WordofGlory:IsReady(unitID) and Player:Execute_Time(A.FlashofLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.FlashofLight.ID)/2 
                and Unit(unitID):HealthPercent() <= A.GetToggle(2, "FlashofLightHP") and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() 
                and Unit(unitID):TimeToDie() > Player:Execute_Time(A.FlashofLight.ID) and Unit(unitID):TimeToDie() < 8 and Unit(player):GetCurrentSpeed() == 0 then
                    if A.DivineFavor:IsReady(player) then
                        return A.DivineFavor:Show(icon)
                    end
                    return A.FlashofLight:Show(icon)
                end]]
                
                --Holy Light no infusion
                if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.HolyLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.HolyLight.ID) and not A.WordofGlory:IsReady(unitID) 
                and Player:Execute_Time(A.HolyLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.HolyLight.ID)/2 and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() 
                and Unit(unitID):HealthPercent() < HolyLightHP and Unit(player):GetCurrentSpeed() == 0 then
                    if A.DivineFavor:IsReady(player) then
                        return A.DivineFavor:Show(icon)
                    end
                    return A.HolyLight:Show(icon)
                end    
                
            end
            
        end
        
    end
    FillerRotation = Action.MakeFunctionCachedDynamic(FillerRotation)
    
    
    --------------------
    --- DPS ROTATION ---
    --------------------
    local function DamageRotation(unitID)
        
        local useInterrupt = Interrupts(unitID)
        if useInterrupt then
            return useInterrupt:Show(icon)
        end

        if A.LightofDawn:IsReady(player) and A.OfDuskAndDawn:IsTalentLearned() and Unit(player):HasBuffs(A.BlessingofDusk.ID) < Unit(player):HasBuffs(A.BlessingofDawn.ID) and Unit(player):HasBuffs(A.BlessingofDusk.ID) < 3 then
            return A.LightofDawn:Show(icon)
        end

        if A.Zone == "arena" or A.InstanceInfo.isRated or A.Zone == "pvp" or inCombat then
            
            local _,_,_,_,_,NPCID1 = Unit(unitID):InfoGUID()       
            
            if Unit(mouseover):Name() == "Spiteful Shade" and Unit(mouseover):HasBuffs(A.Sanguine.ID) == 0 and A.HammerofJustice:IsReady(mouseover) and Unit(mouseover):HasDeBuffs({"Stuned", "Disoriented", "PhysStuned"}) == 0 and Unit("targettarget"):Name() == Unit(player):Name() and A.HammerofJustice:AbsentImun(mouseover, Temp.TotalAndPhysAndCC) and Unit(mouseover):GetDR("stun") >= 50 then
                return A.HammerofJustice:Show(icon) 
            end
            
            if Unit(unitID):IsExplosives() then
                if A.HammerofWrath:IsReady(unitID) then
                    return A.HammerofWrath:Show(icon)
                elseif A.Judgment:IsReady(unitID) then
                    return A.Judgment:Show(icon)
                elseif A.CrusaderStrike:IsReady(unitID) then
                    return A.CrusaderStrike:Show(icon)
                elseif A.HolyShock:IsReady(unitID) and HealingEngine.GetBelowHealthPercentUnits(80, 40) == 0 then
                    return A.Fireblood:Show(icon)
                end
            end
            
            if Unit(unitID):HasDeBuffs("BreakAble") == 0 and A.Zone == "arena" or A.InstanceInfo.isRated or (Unit(unitID):GetRange() <= 15 or TeamCache.Friendly.Size == 1) then
                
                if MultiUnits:GetByRangeInCombat(30) >= 4 and A.GetToggle(2, "OffensiveDT") and A.DivineToll:IsReady(unitID) and HealingEngine.GetBelowHealthPercentUnits(80, 40) <= 1 then
                    return A.HandofReckoning:Show(icon)
                end
                
                if A.HammerofWrath:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
                and IsUnitEnemy(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() then
                    return A.HammerofWrath:Show(icon)
                end     
                
                if A.Consecration:IsReady(player) and MultiUnits:GetByRange(5) >= 2 and Unit(unitID):HasDeBuffs(204242, true) <= 1 and A.CrusaderStrike:IsInRange(unitID) then
                    return A.Consecration:Show(icon)
                end
                
                if A.Awakening:IsTalentLearned() and A.LightofDawn:IsReady(unitID) and A.GetToggle(2, "LightofDawnDump") and Player:HolyPower() >= Temp.useHP and Unit(player):HasBuffs(A.AvengingWrath.ID) == 0 then
                    return A.LightofDawn:Show(icon)
                end
                
                if (A.Awakening:IsTalentLearned() and A.GetToggle(2, "LightofDawnDump") and Unit(player):HasBuffs(A.AvengingWrath.ID) > 0 or A.Awakening:IsTalentLearned() and not A.GetToggle(2, "LightofDawnDump") or not A.Awakening:IsTalentLearned()) and A.ShieldoftheRighteous:IsReady(player) and Player:HolyPower() >= A.GetToggle(2, "DumpHP") and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.CrusaderStrike:IsInRange(unitID) and IsUnitEnemy(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 
                and (HealingEngine.GetBelowHealthPercentUnits(80, 40) < 1 or (HealingEngine.GetBelowHealthPercentUnits(50, 40) < 1 and TeamCache.Friendly.Size <= 2)) then
                    return A.ShieldoftheRighteous:Show(icon)
                end
                
                if A.HammerofWrath:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):GetRange() <= 30 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 then
                    return A.HammerofWrath:Show(icon)
                end
                
                if A.Judgment:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):GetRange() <= 30 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 then
                    return A.Judgment:Show(icon)
                end
                
                if ((A.Zone == "pvp" or A.Zone == "arena" or A.InstanceInfo.isRated) or (Player:ManaPercentage() > GetToggle(2, "ManaConservation") * 2)) and A.HolyShock:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and GetToggle(2, "HolyShockDPS") and Unit(unitID):GetRange() <= 40 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 then
                    return A.Fireblood:Show(icon)
                end
                
                if A.CrusaderStrike:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.CrusaderStrike:IsInRange(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and
                ((A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and A.HolyShock:GetCooldown() >= 1.0 and Player:ManaPercentage() > GetToggle(2, "ManaConservation")) 
                    or (not A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and ((A.Zone == "pvp" or A.Zone == "arena" or A.InstanceInfo.isRated) or (Player:ManaPercentage() > GetToggle(2, "ManaConservation")))))
                    or TeamCache.Friendly.Size == 1
                then
                    return A.CrusaderStrike:Show(icon)
                end
                
                if A.Consecration:IsReady(player) and Unit(unitID):HasDeBuffs(204242, true) <= 1 and A.CrusaderStrike:IsInRange(unitID) then
                    return A.Consecration:Show(icon)
                end
            end    
        end
        
    end
    DamageRotation = Action.MakeFunctionCachedDynamic(DamageRotation)
    
    
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Cleanse Mouseover 
    if A.Cleanse:IsReady(mouseover) then 
        unitID = mouseover 
        
        if HealingRotation(unitID) then 
            return true 
        end 
    end  
    
    -- Heal Mouseover 
    if IsUnitFriendly(mouseover) and A.GetToggle(2, "HealMouseover") then 
        unitID = mouseover 
        
        if HealingRotation(unitID) then 
            return true 
        end 
    end      
    
    -- Heal Target 
    if IsUnitFriendly(target) then 
        unitID = target 
        
        if HealingRotation(unitID) then 
            return true 
        end 
    elseif IsUnitFriendly(focus) then	
        unitID = focus
        
        if HealingRotation(unitID) then
            return true
        end
    end  
    
    -- DPS Mouseover 
    if IsUnitEnemy(mouseover) then 
        unitID = mouseover    
        
        if DamageRotation(unitID) and A.GetToggle(2, "DPSMouseover") then 
            return true 
        end 
    end  
        
    -- Filler Mouseover 
    if IsUnitFriendly(mouseover) and A.GetToggle(2, "HealMouseover") then 
        unitID = mouseover 
        
        if FillerRotation(unitID) then 
            return true 
        end 
    end      
    
    -- Filler Target 
    if IsUnitFriendly(target) then 
        unitID = target 
        
        if FillerRotation(unitID) then 
            return true 
        end 
    elseif IsUnitFriendly(focus) then
        unitID = focus
        
        if FillerRotation(unitID) then
            return true
        end
    end  
    
    -- DPS Target     
    if IsUnitEnemy(target) then 
        unitID = target
        
        if DamageRotation(unitID) then 
            return true 
        end 
    end         
end 

A[4] = nil
A[5] = nil 
A[6] = function(icon)    
    
    if IsUnitEnemy("mouseover") and Unit("mouseover"):IsExplosives() or IsUnitEnemy("mouseover") and Unit("mouseover"):IsTotem() then 
        return A:Show(icon, ACTION_CONST_LEFT)
    end
end 
A[7] = nil 
A[8] = nil 
