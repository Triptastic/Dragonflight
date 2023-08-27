--############################
--##### TRIP'S FIRE MAGE #####
--############################

local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
local TMW										= _G.TMW
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local AuraIsValid								= Action.AuraIsValid
local HealingEngine                           	= Action.HealingEngine
local InterruptIsValid							= Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player
local Pet                                       = LibStub("PetLibrary") 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local pairs                                     = pairs

--For Toaster
local Toaster									= _G.Toaster
local GetSpellTexture 							= _G.TMW.GetSpellTexture

Action[ACTION_CONST_MAGE_FIRE] = {
	--Racial 
    ArcaneTorrent				= Action.Create({ Type = "Spell", ID = 50613	}),
    BloodFury					= Action.Create({ Type = "Spell", ID = 20572	}),
    Fireblood					= Action.Create({ Type = "Spell", ID = 265221	}),
    AncestralCall				= Action.Create({ Type = "Spell", ID = 274738	}),
    Berserking					= Action.Create({ Type = "Spell", ID = 26297	}),
    ArcanePulse             	= Action.Create({ Type = "Spell", ID = 260364	}),
    QuakingPalm           		= Action.Create({ Type = "Spell", ID = 107079	}),
    Haymaker           			= Action.Create({ Type = "Spell", ID = 287712	}), 
    BullRush           			= Action.Create({ Type = "Spell", ID = 255654	}),    
    WarStomp        			= Action.Create({ Type = "Spell", ID = 20549	}),
    GiftofNaaru   				= Action.Create({ Type = "Spell", ID = 59544	}),
    Shadowmeld   				= Action.Create({ Type = "Spell", ID = 58984    }),
    Stoneform 					= Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks					= Action.Create({ Type = "Spell", ID = 312411	}),
    WilloftheForsaken			= Action.Create({ Type = "Spell", ID = 7744		}),   
    EscapeArtist				= Action.Create({ Type = "Spell", ID = 20589    }), 
    EveryManforHimself			= Action.Create({ Type = "Spell", ID = 59752    }),
    LightsJudgment				= Action.Create({ Type = "Spell", ID = 255647   }), 	
    Darkflight  				= Action.Create({ Type = "Spell", ID = 68992   }), 
    
    Frostbolt      = Action.Create({ Type = "Spell", ID = 116 }),
    ConeofCold     = Action.Create({ Type = "Spell", ID = 120 }),
    FrostNova      = Action.Create({ Type = "Spell", ID = 122 }),
    Fireball       = Action.Create({ Type = "Spell", ID = 133 }),
    ArcaneExplosion= Action.Create({ Type = "Spell", ID = 1449 }),
    ArcaneIntellect= Action.Create({ Type = "Spell", ID = 1459 }),
    Blink          = Action.Create({ Type = "Spell", ID = 1953 }),
    Counterspell   = Action.Create({ Type = "Spell", ID = 2139 }),
    ArcaneBlast    = Action.Create({ Type = "Spell", ID = 30451 }),
    Waterbolt      = Action.Create({ Type = "Spell", ID = 31707 }),
    Freeze         = Action.Create({ Type = "Spell", ID = 33395 }),
    TimeWarp       = Action.Create({ Type = "Spell", ID = 80353 }),
    WaterJet       = Action.Create({ Type = "Spell", ID = 135029 }),
    ConjureRefreshment= Action.Create({ Type = "Spell", ID = 190336 }),
    FireBlast      = Action.Create({ Type = "Spell", ID = 319836 }),
    Teleport       = Action.Create({ Type = "Spell", ID = 343127 }),
    Portal         = Action.Create({ Type = "Spell", ID = 343140 }),
    Invisibility   = Action.Create({ Type = "Spell", ID = 66 }),
    RemoveCurse    = Action.Create({ Type = "Spell", ID = 475 }),
    ConjureManaGem = Action.Create({ Type = "Spell", ID = 759 }),
    IncantersFlow  = Action.Create({ Type = "Spell", ID = 1463 }),
    Flamestrike    = Action.Create({ Type = "Spell", ID = 2120 }),
    Scorch         = Action.Create({ Type = "Spell", ID = 2948 }),
    ArcaneMissiles = Action.Create({ Type = "Spell", ID = 5143 }),
    Pyroblast      = Action.Create({ Type = "Spell", ID = 11366 }),
    IceBarrier     = Action.Create({ Type = "Spell", ID = 11426 }),
    Evocation      = Action.Create({ Type = "Spell", ID = 12051 }),
    IcyVeins       = Action.Create({ Type = "Spell", ID = 12472 }),
    Shatter        = Action.Create({ Type = "Spell", ID = 12982 }),
    Spellsteal     = Action.Create({ Type = "Spell", ID = 30449 }),
    IceLance       = Action.Create({ Type = "Spell", ID = 30455 }),
    Slow           = Action.Create({ Type = "Spell", ID = 31589 }),
    DragonsBreath  = Action.Create({ Type = "Spell", ID = 31661 }),
    SummonWaterElemental= Action.Create({ Type = "Spell", ID = 31687 }),
    ArcaneBarrage  = Action.Create({ Type = "Spell", ID = 44425 }),
    LivingBomb     = Action.Create({ Type = "Spell", ID = 44457 }),
    Flurry         = Action.Create({ Type = "Spell", ID = 44614 }),
    IceBlock       = Action.Create({ Type = "Spell", ID = 45438 }),
    MirrorImage    = Action.Create({ Type = "Spell", ID = 55342 }),
    SplittingIce   = Action.Create({ Type = "Spell", ID = 56377 }),
    Clearcasting   = Action.Create({ Type = "Spell", ID = 79684 }),
    FrozenOrb      = Action.Create({ Type = "Spell", ID = 84714 }),
    Cauterize      = Action.Create({ Type = "Spell", ID = 86949 }),
    IceFloes       = Action.Create({ Type = "Spell", ID = 108839 }),
    FireBlast      = Action.Create({ Type = "Spell", ID = 108853 }),
    GreaterInvisibility= Action.Create({ Type = "Spell", ID = 110959 }),
    FingersofFrost = Action.Create({ Type = "Spell", ID = 112965 }),
    RingofFrost    = Action.Create({ Type = "Spell", ID = 113724 }),
    NetherTempest  = Action.Create({ Type = "Spell", ID = 114923 }),
    RuneofPower    = Action.Create({ Type = "Spell", ID = 116011 }),
    RuneofPowerBuff    = Action.Create({ Type = "Spell", ID = 116014 }),
    CriticalMass   = Action.Create({ Type = "Spell", ID = 117216 }),
    Meteor         = Action.Create({ Type = "Spell", ID = 153561 }),
    CometStorm     = Action.Create({ Type = "Spell", ID = 153595 }),
    ArcaneOrb      = Action.Create({ Type = "Spell", ID = 153626 }),
    Kindling       = Action.Create({ Type = "Spell", ID = 155148 }),
    ThermalVoid    = Action.Create({ Type = "Spell", ID = 155149 }),
    Pyrotechnics   = Action.Create({ Type = "Spell", ID = 157642 }),
    Supernova      = Action.Create({ Type = "Spell", ID = 157980 }),
    BlastWave      = Action.Create({ Type = "Spell", ID = 157981 }),
    IceNova        = Action.Create({ Type = "Spell", ID = 157997 }),
    Combustion     = Action.Create({ Type = "Spell", ID = 190319 }),
    Blizzard       = Action.Create({ Type = "Spell", ID = 190356 }),
    BrainFreeze    = Action.Create({ Type = "Spell", ID = 190447 }),
    GlacialSpike   = Action.Create({ Type = "Spell", ID = 199786 }),
    FlameAccelerant= Action.Create({ Type = "Spell", ID = 203275 }),
    Pyromaniac     = Action.Create({ Type = "Spell", ID = 205020 }),
    RayofFrost     = Action.Create({ Type = "Spell", ID = 205021 }),
    ArcaneFamiliar = Action.Create({ Type = "Spell", ID = 205022 }),
    Conflagration  = Action.Create({ Type = "Spell", ID = 205023 }),
    LonelyWinter   = Action.Create({ Type = "Spell", ID = 205024 }),
    PresenceofMind = Action.Create({ Type = "Spell", ID = 205025 }),
    Firestarter    = Action.Create({ Type = "Spell", ID = 205026 }),
    BoneChilling   = Action.Create({ Type = "Spell", ID = 205027 }),
    Resonance      = Action.Create({ Type = "Spell", ID = 205028 }),
    FlameOn        = Action.Create({ Type = "Spell", ID = 205029 }),
    FrozenTouch    = Action.Create({ Type = "Spell", ID = 205030 }),
    IceWard        = Action.Create({ Type = "Spell", ID = 205036 }),
    FlamePatch     = Action.Create({ Type = "Spell", ID = 205037 }),
    Shimmer        = Action.Create({ Type = "Spell", ID = 212653 }),
    ArcingCleave   = Action.Create({ Type = "Spell", ID = 231564 }),
    ColdSnap       = Action.Create({ Type = "Spell", ID = 235219 }),
    FrigidWinds    = Action.Create({ Type = "Spell", ID = 235224 }),
    BlazingBarrier = Action.Create({ Type = "Spell", ID = 235313 }),
    PrismaticBarrier= Action.Create({ Type = "Spell", ID = 235450 }),
    ChronoShift    = Action.Create({ Type = "Spell", ID = 235711 }),
    AlexstraszasFury= Action.Create({ Type = "Spell", ID = 235870 }),
    Slipstream     = Action.Create({ Type = "Spell", ID = 236457 }),
    Amplification  = Action.Create({ Type = "Spell", ID = 236628 }),
    IceCaller      = Action.Create({ Type = "Spell", ID = 236662 }),
    Ebonbolt       = Action.Create({ Type = "Spell", ID = 257537 }),
    PhoenixFlames  = Action.Create({ Type = "Spell", ID = 257541 }),
    RuleofThrees   = Action.Create({ Type = "Spell", ID = 264354 }),
    SearingTouch   = Action.Create({ Type = "Spell", ID = 269644 }),
    Pyroclasm      = Action.Create({ Type = "Spell", ID = 269650 }),
    PyroclasmBuff      = Action.Create({ Type = "Spell", ID = 269651 }),
    FreezingRain   = Action.Create({ Type = "Spell", ID = 270233 }),
    ChainReaction  = Action.Create({ Type = "Spell", ID = 278309 }),
    Reverberate    = Action.Create({ Type = "Spell", ID = 281482 }),
    Enlightened    = Action.Create({ Type = "Spell", ID = 321387 }),
    ImprovedClearcasting= Action.Create({ Type = "Spell", ID = 321420 }),
    TouchoftheMagi = Action.Create({ Type = "Spell", ID = 321507 }),
    ManaAdept      = Action.Create({ Type = "Spell", ID = 321526 }),
    ArcanePower    = Action.Create({ Type = "Spell", ID = 321739 }),
    ImprovedPrismaticBarrier= Action.Create({ Type = "Spell", ID = 321745 }),
    CracklingEnergy= Action.Create({ Type = "Spell", ID = 321752 }),
    ArcaneEcho     = Action.Create({ Type = "Spell", ID = 342231 }),
    AlterTime      = Action.Create({ Type = "Spell", ID = 342245 }),
    AlterTimeBuff      = Action.Create({ Type = "Spell", ID = 342246 }),
    MasterofTime   = Action.Create({ Type = "Spell", ID = 342249 }),
    FromtheAshes   = Action.Create({ Type = "Spell", ID = 342344 }),
    ImprovedFrostNova= Action.Create({ Type = "Spell", ID = 343183 }),
    CalloftheSunKing= Action.Create({ Type = "Spell", ID = 343222 }),
    ImprovedFlamestrike= Action.Create({ Type = "Spell", ID = 343230 }),
    ArcaneSurge    = Action.Create({ Type = "Spell", ID = 365350 }),
    RadiantSpark   = Action.Create({ Type = "Spell", ID = 376103 }),
    PerpetualWinter= Action.Create({ Type = "Spell", ID = 378198 }),
    Wintertide     = Action.Create({ Type = "Spell", ID = 378406 }),
    IcyPropulsion  = Action.Create({ Type = "Spell", ID = 378433 }),
    FracturedFrost = Action.Create({ Type = "Spell", ID = 378448 }),
    DeepShatter    = Action.Create({ Type = "Spell", ID = 378749 }),
    Frostbite      = Action.Create({ Type = "Spell", ID = 378756 }),
    SnapFreeze     = Action.Create({ Type = "Spell", ID = 378901 }),
    PiercingCold   = Action.Create({ Type = "Spell", ID = 378919 }),
    GlacialAssault = Action.Create({ Type = "Spell", ID = 378947 }),
    SplinteringCold= Action.Create({ Type = "Spell", ID = 379049 }),
    FlashFreeze    = Action.Create({ Type = "Spell", ID = 379993 }),
    Subzero        = Action.Create({ Type = "Spell", ID = 380154 }),
    Hailstones     = Action.Create({ Type = "Spell", ID = 381244 }),
    Snowstorm      = Action.Create({ Type = "Spell", ID = 381706 }),
    FreezingWinds  = Action.Create({ Type = "Spell", ID = 382103 }),
    ColdFront      = Action.Create({ Type = "Spell", ID = 382110 }),
    SlickIce       = Action.Create({ Type = "Spell", ID = 382144 }),
    FlowofTime     = Action.Create({ Type = "Spell", ID = 382268 }),
    DivertedEnergy = Action.Create({ Type = "Spell", ID = 382270 }),
    TempestBarrier = Action.Create({ Type = "Spell", ID = 382289 }),
    CryoFreeze     = Action.Create({ Type = "Spell", ID = 382292 }),
    IncantationofSwiftness= Action.Create({ Type = "Spell", ID = 382293 }),
    QuickWitted    = Action.Create({ Type = "Spell", ID = 382297 }),
    WintersProtection= Action.Create({ Type = "Spell", ID = 382424 }),
    ShiftingPower  = Action.Create({ Type = "Spell", ID = 382440 }),
    RigidIce       = Action.Create({ Type = "Spell", ID = 382481 }),
    TomeofAntonidas= Action.Create({ Type = "Spell", ID = 382490 }),
    TomeofRhonin   = Action.Create({ Type = "Spell", ID = 382493 }),
    Reduplication  = Action.Create({ Type = "Spell", ID = 382569 }),
    AccumulativeShielding= Action.Create({ Type = "Spell", ID = 382800 }),
    Reabsorption   = Action.Create({ Type = "Spell", ID = 382820 }),
    TemporalVelocity= Action.Create({ Type = "Spell", ID = 382826 }),
    ArcaneWarding  = Action.Create({ Type = "Spell", ID = 383092 }),
    MassPolymorph  = Action.Create({ Type = "Spell", ID = 383121 }),
    TimeAnomaly    = Action.Create({ Type = "Spell", ID = 383243 }),
    FeeltheBurn    = Action.Create({ Type = "Spell", ID = 383391 }),
    PhoenixReborn  = Action.Create({ Type = "Spell", ID = 383476 }),
    Wildfire       = Action.Create({ Type = "Spell", ID = 383489 }),
    Firemind       = Action.Create({ Type = "Spell", ID = 383499 }),
    ImprovedScorch = Action.Create({ Type = "Spell", ID = 383604 }),
    FieryRush      = Action.Create({ Type = "Spell", ID = 383634 }),
    TemperedFlames = Action.Create({ Type = "Spell", ID = 383659 }),
    ImprovedArcaneMissiles= Action.Create({ Type = "Spell", ID = 383661 }),
    IncendiaryEruptions= Action.Create({ Type = "Spell", ID = 383665 }),
    ControlledDestruction= Action.Create({ Type = "Spell", ID = 383669 }),
    Impetus        = Action.Create({ Type = "Spell", ID = 383676 }),
    NetherPrecision= Action.Create({ Type = "Spell", ID = 383782 }),
    FeveredIncantation= Action.Create({ Type = "Spell", ID = 383810 }),
    Hyperthermia   = Action.Create({ Type = "Spell", ID = 383860 }),
    SunKingsBlessing= Action.Create({ Type = "Spell", ID = 383886 }),
    SunKingsBlessingStacks= Action.Create({ Type = "Spell", ID = 383882 }),
    SunKingsBlessingBuff= Action.Create({ Type = "Spell", ID = 383883 }),
    ImprovedCombustion= Action.Create({ Type = "Spell", ID = 383967 }),
    ArcaneTempo    = Action.Create({ Type = "Spell", ID = 383980 }),
    Firefall       = Action.Create({ Type = "Spell", ID = 384033 }),
    IlluminatedThoughts= Action.Create({ Type = "Spell", ID = 384060 }),
    MasterofFlame  = Action.Create({ Type = "Spell", ID = 384174 }),
    SiphonStorm    = Action.Create({ Type = "Spell", ID = 384187 }),
    CascadingPower = Action.Create({ Type = "Spell", ID = 384276 }),
    Concentration  = Action.Create({ Type = "Spell", ID = 384374 }),
    ArcaneHarmony  = Action.Create({ Type = "Spell", ID = 384452 }),
    ArcaneBombardment= Action.Create({ Type = "Spell", ID = 384581 }),
    ProdigiousSavant= Action.Create({ Type = "Spell", ID = 384612 }),
    ChargedOrb     = Action.Create({ Type = "Spell", ID = 384651 }),
    HarmonicEcho   = Action.Create({ Type = "Spell", ID = 384683 }),
    OrbBarrage     = Action.Create({ Type = "Spell", ID = 384858 }),
    Foresight      = Action.Create({ Type = "Spell", ID = 384861 }),
    EverlastingFrost= Action.Create({ Type = "Spell", ID = 385167 }),
    TemporalWarp   = Action.Create({ Type = "Spell", ID = 386539 }),
    FreezingCold   = Action.Create({ Type = "Spell", ID = 386763 }),
    EnergizedBarriers= Action.Create({ Type = "Spell", ID = 386828 }),
    FerventFlickering= Action.Create({ Type = "Spell", ID = 387044 }),
    TimeManipulation= Action.Create({ Type = "Spell", ID = 387807 }),
    VolatileDetonation= Action.Create({ Type = "Spell", ID = 389627 }),
    Displacement   = Action.Create({ Type = "Spell", ID = 389713 }),
    OverflowingEnergy= Action.Create({ Type = "Spell", ID = 390218 }),
    MassSlow       = Action.Create({ Type = "Spell", ID = 391102 }),
    HeatingUp       = Action.Create({ Type = "Spell", ID = 48107 }),
    HotStreak       = Action.Create({ Type = "Spell", ID = 48108 }),
    Ignite       = Action.Create({ Type = "Spell", ID = 12654 }),
    
	Quaking                         = Action.Create({ Type = "Spell", ID = 240447, Hidden = true  }),
	AeratedManaPotion1				= Action.Create({ Type = "Potion", ID = 191384, Texture = 176108, Hidden = true  }),
	AeratedManaPotion2				= Action.Create({ Type = "Potion", ID = 191385, Texture = 176108, Hidden = true  }),
	AeratedManaPotion3				= Action.Create({ Type = "Potion", ID = 191386, Texture = 176108, Hidden = true  }),
}

local A = setmetatable(Action[ACTION_CONST_MAGE_FIRE], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
local target = "target"
local pet = "pet"
local focus = "focus"

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
    delayFireBlast                          = 0, 
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
}


local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end 

    local noDefensiveActive = Unit(player):HasBuffs(A.AlterTimeBuff.ID) == 0 and Unit(player):HasBuffs(A.IceBlock.ID) == 0

    local useRacial = A.GetToggle(1, "Racial")
    local autoAlterTime = false

    if noDefensiveActive then
        if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1 then
            if A.AlterTime:IsReady(player) then
                autoAlterTime = true
                return A.AlterTime
            end
            if A.MirrorImage:IsReady(player) then
                return A.MirrorImage
            end
        end
    end

    if Unit(player):HasBuffs(A.AlterTimeBuff.ID) > 0 and not autoAlterTime and MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) == 0 then
        return A.AlterTime
    end

	-- Stoneform on self dispel (only PvE)
	if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
		return A.Stoneform
	end 

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then

        if A.Counterspell:IsReady(unitID) and useKick and not notInterruptable then
            return A.Counterspell
        end

        if A.DragonsBreath:IsReady(player) and useCC and Unit(unitID):GetRange() < 10 then
            return A.DragonsBreath
        end
        
   	    if useRacial and A.QuakingPalm:AutoRacial(unitID) then 
   	        return A.QuakingPalm
   	    end 
    
   	    if useRacial and A.Haymaker:AutoRacial(unitID) then 
            return A.Haymaker
   	    end 
    
   	    if useRacial and A.WarStomp:AutoRacial(unitID) then 
            return A.WarStomp
   	    end 
    
   	    if useRacial and A.BullRush:AutoRacial(ununitIDit) then 
            return A.BullRush
   	    end 
    end
end

local function Cleanse(unitID)
    
    local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
    local unitGUID = UnitGUID(unitID)  

    if A.RemoveCurse:IsReady(unitID) and useDispel and AuraIsValid(unitID, "UseDispel", "Dispel") then
        return A.RemoveCurse
    end 


end

local function Purge(unitID)

    if A.Spellsteal:IsReady(unitID) and (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) then 
		return A.Spellsteal
	end 

end

local function UseTrinkets(unitID)
	local TrinketType1 = A.GetToggle(2, "TrinketType1")
	local TrinketType2 = A.GetToggle(2, "TrinketType2")
	local TrinketValue1 = A.GetToggle(2, "TrinketValue1")
	local TrinketValue2 = A.GetToggle(2, "TrinketValue2")	

	if A.Trinket1:IsReady(unitID) then
		if TrinketType1 == "Damage" and Player:ManaPercentage() >= 20 then
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
		if TrinketType2 == "Damage" and Player:ManaPercentage() >= 20 then
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


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
	local stopCasting = MultiUnits:GetByRangeCasting(60, 1, nil, Temp.stopCasting) >= 1
    local incAoE = MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1
	local quakingTime = 99
	if Unit(player):HasDeBuffs(A.Quaking.ID) > 0 then
		quakingTime = Unit(player):HasDeBuffs(A.Quaking.ID)
	end

    Player:AddTier("Tier29", { 200318, 200320, 200315, 200317, 200319, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

    Player:AddTier("Tier30", { 202554, 202552, 202551, 202550, 202549, })
    local T30has2P = Player:HasTier("Tier30", 2)
    local T30has4P = Player:HasTier("Tier30", 4)

    local hasFloes = Unit(player):HasBuffs(A.IceFloes.ID) > 0
    local heatingUp = Unit(player):HasBuffs(A.HeatingUp.ID) > 0
    local hotStreak = Unit(player):HasBuffs(A.HotStreak.ID) > 0
    local hasBlessing = Unit(player):HasBuffs(A.SunKingsBlessingBuff.ID, true, true) > A.Pyroblast:GetSpellCastTime()
    local hasPyroclasm = Unit(player):HasBuffs(A.PyroclasmBuff.ID) > A.Pyroblast:GetSpellCastTime() and (Unit(player):HasBuffsStacks(A.SunKingsBlessingStacks.ID) < 6 or Unit(player):HasBuffsStacks(A.PyroclasmBuff.ID) == 2)
    local hasCombustion = Unit(player):HasBuffs(A.Combustion.ID) > 0 
    local anySpellInFlight = A.Fireball:IsSpellInFlight() or A.Pyroblast:IsSpellInFlight() or A.PhoenixFlames:IsSpellInFlight()
    local useFlamestrike = Player:GetDeBuffsUnitCount(A.Ignite.ID, true) >= 3 and MultiUnits:GetActiveEnemies() >= 3 and A.GetToggle(2, "AoE")

	if (Unit(player):IsCastingRemains() > quakingTime + 0.5)
    or (Unit(player):IsCasting() == A.Pyroblast:Info() and not hasPyroclasm and not hasBlessing) then
		return A:Show(icon, ACTION_CONST_STOPCAST)	
	end

    local playerstatus = UnitThreatSituation(player)
    if A.BlazingBarrier:IsReady(player) and Unit(player):HasBuffs(A.BlazingBarrier.ID) == 0 and (not inCombat or ((Unit(player):IsTanking() or playerstatus == 3 or incAoE or stopCasting))) and not Unit(player):IsCasting() then
        return A.GiftofNaaru:Show(icon)
    end

    local function EnemyRotation(unitID)
        
        local useScorch = Unit(unitID):HealthPercent() < 30 and A.SearingTouch:IsTalentLearned()
        local critWindow = Unit(unitID):HealthPercent() > 90 and A.Firestarter:IsTalentLearned()
        local areaTTD = MultiUnits:GetByRangeAreaTTD(20) > 20 and Unit(unitID):HealthPercent() > 10
        local poolForCombustion = A.Combustion:GetCooldown() < A.FireBlast:GetSpellChargesFullRechargeTime()

        if not inCombat then
            if A.Pyroblast:IsReady(unitID) and not hotStreak and (hasBlessing or hasPyroclasm or (hotStreak and Unit(player):HasBuffs(A.HotStreak.ID) < A.Fireball:GetSpellCastTime())) then
                return A.Pyroblast:Show(icon)
            end
            if A.Fireball:IsReady(unitID) and not useScorch then
                return A.Fireball:Show(icon)
            end
        end

        -- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end

		local DoPurge = Purge(unitID)
		if DoPurge then 
			return DoPurge:Show(icon)
		end	

		local UseTrinket = UseTrinkets(unitID)
		if UseTrinket then
			return UseTrinket:Show(icon)
		end  

        if A.IceFloes:IsReady(player, nil, nil, true) then
            --[[if isMoving and inCombat and not hasFloes and not useScorch then
                return A.IceFloes:Show(icon)
            end]]
            --[[if hasFloes and isMoving and Unit(player):IsCastingRemains() < 0.5 and Unit(player):IsCastingRemains() > 0 then
                return A.IceFloes:Show(icon)
            end]]
            if (Unit(player):IsCasting() == A.Pyroblast:Info() or Unit(player):IsCasting() == A.ShiftingPower:Info() or Unit(player):IsCasting() == A.Flamestrike:Info()) and Unit(player):HasBuffs(A.IceFloes.ID) <= A.Pyroblast:GetSpellCastTime() then
                return A.IceFloes:Show(icon)
            end
        end

        if not hasCombustion then
            if A.ShiftingPower:IsReady(player, nil, nil, true) and (not isMoving or hasFloes) and A.Combustion:GetCooldown() > 15 and A.FireBlast:GetSpellCharges() == 0 and Unit(player):IsCastingRemains() < 0.5 and not heatingUp and not hotStreak then
                if A.IceFloes:IsReady(player) and not hasFloes then
                    return A.IceFloes:Show(icon)
                end
                return A.ShiftingPower:Show(icon)
            end

            if A.RuneofPower:IsReady(player, nil, nil, true) and not isMoving and (Unit(player):HasBuffs(A.SunKingsBlessingBuff.ID, true, true) > (A.Pyroblast:GetSpellCastTime() + A.RuneofPower:GetSpellCastTime()) or Unit(player):HasBuffsStacks(A.SunKingsBlessingStacks.ID) <= 5) and Unit(unitID):TimeToDie() > 18 and A.Combustion:GetCooldown() > 10 and Unit(player):HasBuffs(A.RuneofPowerBuff.ID) == 0 and Unit(player):IsCastingRemains() < 0.5 then
                return A.RuneofPower:Show(icon)
            end

            if A.Flamestrike:IsReady(player, nil, nil, true) and useFlamestrike and hotStreak and Unit(player):IsCastingRemains() < 0.5 then
                return A.Flamestrike:Show(icon)
            end

            --Hardcast AoE
            if A.Flamestrike:IsReady(unitID, nil, nil, true) and useFlamestrike and (hasBlessing or hasPyroclasm) and (not isMoving or hasFloes) and not hotStreak and Unit(unitID):TimeToDie() > 15 and Unit(player):IsCastingRemains() < 0.5 and Unit(player):IsCasting() ~= A.Flamestrike:Info() then
                return A.Flamestrike:Show(icon)
            end

            --Hardcast
            if A.Pyroblast:IsReady(unitID, nil, nil, true) and not useFlamestrike and (hasBlessing or hasPyroclasm) and (not isMoving or hasFloes) and not hotStreak and Unit(unitID):TimeToDie() > 15 and Unit(player):IsCastingRemains() < 0.5 and Unit(player):IsCasting() ~= A.Pyroblast:Info() then
                return A.Pyroblast:Show(icon)
            end

            if A.Meteor:IsReady(player, nil, nil, true) and not hasCombustion and Unit(player):IsCastingRemains() < 0.5 then
                if A.RuneofPower:GetCooldown() > 15 and A.Combustion:GetCooldown() > 15 then
                    return A.Meteor:Show(icon)
                end
                if A.RuneofPower:IsReady(player) and not isMoving then
                    return A.RuneofPower:Show(icon)
                end
                if A.Combustion:IsReady(player) then
                    return A.Meteor:Show(icon)
                end
            end

            if A.Combustion:IsReady(player, nil, nil, true) and (BurstIsON(unitID) or Unit(unitID):IsBoss()) and Unit(unitID):TimeToDie() > 15 and Unit(player):IsCastingRemains() < 0.5 and Unit(player):HasBuffs(A.Combustion.ID) == 0 then
                if A.Firestarter:IsTalentLearned() and A.SunKingsBlessing:IsTalentLearned() then
                    if Unit(player):IsCasting() == A.Pyroblast:Info() and (hasBlessing and Unit(player):IsCastingRemains() < 0.5 or Unit(player):HasBuffsStacks(A.SunKingsBlessing.ID) == 1) then
                        return A.Darkflight:Show(icon)
                    end
                end
                if A.Firestarter:IsTalentLearned() and Unit(unitID):HealthPercent() < 90 then
                    return A.Darkflight:Show(icon)
                end
                if not A.Firestarter:IsTalentLearned() then
                    return A.Darkflight:Show(icon)
                end
            end

            if A.DragonsBreath:IsReady(player, nil, nil, true) and MultiUnits:GetByRangeInCombat(10, 5) >= 3 and heatingUp and A.AlexstraszasFury:IsTalentLearned() then
                return A.DragonsBreath:Show(icon)
            end

            if A.PhoenixFlames:IsReady(unitID, nil, nil, true) and A.PhoenixFlames:GetSpellChargesFullRechargeTime() < A.GetGCD() and not hotStreak and not critWindow and not anySpellInFlight and Unit(player):IsCastingRemains() < 0.5 then
                return A.PhoenixFlames:Show(icon)
            end

            if A.FireBlast:IsReady(unitID, nil, nil, true) and not Player:PrevOffGCD(1, A.FireBlast) and A.FireBlast:GetSpellChargesFullRechargeTime() < A.GetGCD() and A.FireBlast:GetSpellChargesMax() > 1 and not anySpellInFlight and not hotStreak and not critWindow and not poolForCombustion then
                return A.FireBlast:Show(icon)
            end

            --Instant AoE
            if A.Flamestrike:IsReady(unitID, nil, nil, true) and useFlamestrike and (hotStreak or (useScorch and heatingUp and Unit(player):IsCasting() == A.Scorch:Info())) and (Unit(player):IsCasting() or (isMoving and not hasFloes and not useScorch) or Unit(player):HasBuffs(A.HotStreak.ID) < A.Fireball:GetSpellCastTime() or hasBlessing or hasPyroclasm) and Unit(player):IsCastingRemains() < 0.5 then
                return A.Flamestrike:Show(icon)
            end

            --Instant
            if A.Pyroblast:IsReady(unitID, nil, nil, true) and not useFlamestrike and (hotStreak or (useScorch and heatingUp and Unit(player):IsCasting() == A.Scorch:Info())) and (Unit(player):IsCasting() or (isMoving and not hasFloes and not useScorch) or Unit(player):HasBuffs(A.HotStreak.ID) < A.Fireball:GetSpellCastTime() or hasBlessing or hasPyroclasm) and Unit(player):IsCastingRemains() < 0.5 then
                return A.Pyroblast:Show(icon)
            end

            if A.FireBlast:IsReady(unitID, nil, nil, true) and not Player:PrevOffGCD(1, A.FireBlast) and heatingUp and not anySpellInFlight and not poolForCombustion then
                return A.FireBlast:Show(icon)
            end

            if A.LivingBomb:IsReady(unitID, nil, nil, true) then
                return A.LivingBomb:Show(icon)
            end

            if A.Scorch:IsReady(unitID, nil, nil, true) and useScorch and (Unit(player):IsCasting() ~= A.Scorch:Info() or A.FireBlast:GetSpellCharges() < 1) and Unit(player):IsCastingRemains() < 0.5 then
                return A.Scorch:Show(icon)
            end

        end

        if hasCombustion then

            if A.ShiftingPower:IsReady(player, nil, nil, true) and (not isMoving or hasFloes) and A.Combustion:GetCooldown() > 15 and A.FireBlast:GetSpellCharges() == 0 and A.PhoenixFlames:GetSpellCharges() == 0 and not heatingUp and not hotStreak then
                if A.IceFloes:IsReady(player, nil, nil, true) and not hasFloes and Unit(player):IsCastingRemains() < 0.5 then
                    return A.IceFloes:Show(icon)
                end
                return A.ShiftingPower:Show(icon)
            end

            if A.Meteor:IsReady(player, nil, nil, true) and Unit(player):IsCastingRemains() < 0.5 then
                return A.Meteor:Show(icon)
            end

            --Hardcast AoE
            if A.Flamestrike:IsReady(unitID, nil, nil, true) and useFlamestrike and (hasPyroclasm or hasBlessing) and Unit(unitID):TimeToDie() > 15 and Unit(player):IsCastingRemains() < 0.5 and Unit(player):IsCasting() ~= A.Pyroblast:Info() then
                return A.Flamestrike:Show(icon)
            end

            --Hardcast
            if A.Pyroblast:IsReady(unitID, nil, nil, true) and not useFlamestrike and (hasPyroclasm or hasBlessing) and Unit(unitID):TimeToDie() > 15 and Unit(player):IsCastingRemains() < 0.5 and Unit(player):IsCasting() ~= A.Pyroblast:Info() then
                return A.Pyroblast:Show(icon)
            end

            --Instant AoE
            if A.Flamestrike:IsReady(player, nil, nil, true) and useFlamestrike and (hotStreak or (heatingUp and Unit(player):IsCasting() == A.Scorch:Info())) and Unit(player):IsCastingRemains() < 0.5 then
                return A.Flamestrike:Show(icon)
            end

            --Instant
            if A.Pyroblast:IsReady(unitID, nil, nil, true) and not useFlamestrike and (hotStreak or (heatingUp and Unit(player):IsCasting() == A.Scorch:Info())) and Unit(player):IsCastingRemains() < 0.5 then
                return A.Pyroblast:Show(icon)
            end

            if A.FireBlast:IsReady(unitID, nil, nil, true) and (not Player:PrevOffGCD(1, A.FireBlast) or A.PhoenixFlames:GetSpellCharges() == 0) and not hotStreak and not anySpellInFlight and not poolForCombustion then
                if (A.FeeltheBurn:IsTalentLearned() and Unit(player):HasBuffs(A.FeeltheBurn.ID) < 2 or not A.FeeltheBurn:IsTalentLearned()) then
                    return A.FireBlast:Show(icon)
                end
            end

            if A.PhoenixFlames:IsReady(unitID, nil, nil, true) and not hotStreak and Unit(player):IsCastingRemains() < 0.5 then
                return A.PhoenixFlames:Show(icon)
            end

            if A.Scorch:IsReady(unitID, nil, nil, true) and A.Scorch:GetSpellCastTime() < Unit(player):HasBuffs(A.Combustion.ID) and Unit(player):IsCastingRemains() < 0.5 then
                return A.Scorch:Show(icon)
            end

            if A.IceNova:IsReady(unitID, nil, nil, true) and Unit(player):IsCastingRemains() < 0.5 then
                return A.IceNova:Show(icon)
            end

        end

        if Unit(player):IsCastingRemains() < 0.5 then
            if A.Fireball:IsReady(unitID, nil, nil, true) and (not isMoving or hasFloes) and not useScorch and not hasCombustion then
                return A.Fireball:Show(icon)
            end

            if A.Scorch:IsReady(unitID, nil, nil, true) then
                return A.Scorch:Show(icon)
            end
        end
        
    end

	-- Defensive
	local SelfDefensive = SelfDefensives()
	if SelfDefensive then 
		return SelfDefensive:Show(icon)
	end 

    if A.IsUnitEnemy(target) then 
        unitID = target
        if EnemyRotation(unitID) and A.Fireball:IsInRange(unitID) then 
            return true
        end 
    end
end
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil