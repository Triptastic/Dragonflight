--#################################
--##### TRIP'S SUBTLETY ROGUE #####
--#################################

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

Action[ACTION_CONST_ROGUE_SUBTLETY] = {
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
    
    Backstab       = Action.Create({ Type = "Spell", ID = 53 }),
    KidneyShot     = Action.Create({ Type = "Spell", ID = 408 }),
    Garrote        = Action.Create({ Type = "Spell", ID = 703 }),
    Mutilate       = Action.Create({ Type = "Spell", ID = 1329 }),
    Distract       = Action.Create({ Type = "Spell", ID = 1725 }),
    SinisterStrike = Action.Create({ Type = "Spell", ID = 1752 }),
    Kick           = Action.Create({ Type = "Spell", ID = 1766 }),
    Stealth        = Action.Create({ Type = "Spell", ID = 1784 }),
    PickLock       = Action.Create({ Type = "Spell", ID = 1804 }),
    CheapShot      = Action.Create({ Type = "Spell", ID = 1833 }),
    Vanish         = Action.Create({ Type = "Spell", ID = 1856 }),
    Rupture        = Action.Create({ Type = "Spell", ID = 1943 }),
    Dispatch       = Action.Create({ Type = "Spell", ID = 2098 }),
    Sprint         = Action.Create({ Type = "Spell", ID = 2983 }),
    CripplingPoison= Action.Create({ Type = "Spell", ID = 3408 }),
    Wrath          = Action.Create({ Type = "Spell", ID = 5176 }),
    Ambush         = Action.Create({ Type = "Spell", ID = 8676 }),
    WoundPoison    = Action.Create({ Type = "Spell", ID = 8679 }),
    Envenom        = Action.Create({ Type = "Spell", ID = 32645 }),
    FanofKnives    = Action.Create({ Type = "Spell", ID = 51723 }),
    ShurikenToss   = Action.Create({ Type = "Spell", ID = 114014 }),
    ShroudofConcealment= Action.Create({ Type = "Spell", ID = 114018 }),
    CrimsonVial    = Action.Create({ Type = "Spell", ID = 185311 }),
    Shadowstrike   = Action.Create({ Type = "Spell", ID = 185438 }),
    PoisonedKnife  = Action.Create({ Type = "Spell", ID = 185565 }),
    PistolShot     = Action.Create({ Type = "Spell", ID = 185763 }),
    Eviscerate     = Action.Create({ Type = "Spell", ID = 196819 }),
    ShurikenStorm  = Action.Create({ Type = "Spell", ID = 197835 }),
    FindTreasure = Action.Create({ Type = "Spell", ID = 199736 }),
    SymbolsofDeath = Action.Create({ Type = "Spell", ID = 212283 }),
    BetweentheEyes = Action.Create({ Type = "Spell", ID = 315341 }),
    SliceandDice   = Action.Create({ Type = "Spell", ID = 315496 }),
    InstantPoison  = Action.Create({ Type = "Spell", ID = 315584 }),
    Gouge          = Action.Create({ Type = "Spell", ID = 1776 }),
    Feint          = Action.Create({ Type = "Spell", ID = 1966 }),
    Blind          = Action.Create({ Type = "Spell", ID = 2094 }),
    DeadlyPoison   = Action.Create({ Type = "Spell", ID = 2823 }),
    Evasion        = Action.Create({ Type = "Spell", ID = 5277 }),
    NumbingPoison  = Action.Create({ Type = "Spell", ID = 5761 }),
    Shiv           = Action.Create({ Type = "Spell", ID = 5938 }),
    Sap            = Action.Create({ Type = "Spell", ID = 6770 }),
    AdrenalineRush = Action.Create({ Type = "Spell", ID = 13750 }),
    BladeFlurry    = Action.Create({ Type = "Spell", ID = 13877 }),
    Nightstalker   = Action.Create({ Type = "Spell", ID = 14062 }),
    Ruthlessness   = Action.Create({ Type = "Spell", ID = 14161 }),
    SealFate       = Action.Create({ Type = "Spell", ID = 14190 }),
    Vigor          = Action.Create({ Type = "Spell", ID = 14983 }),
    CloakofShadows = Action.Create({ Type = "Spell", ID = 31224 }),
    CheatDeath     = Action.Create({ Type = "Spell", ID = 31230 }),
    FatalFlourish  = Action.Create({ Type = "Spell", ID = 35551 }),
    CuttotheChase  = Action.Create({ Type = "Spell", ID = 51667 }),
    KillingSpree   = Action.Create({ Type = "Spell", ID = 51690 }),
    TricksoftheTrade= Action.Create({ Type = "Spell", ID = 57934 }),
    RelentlessStrikes= Action.Create({ Type = "Spell", ID = 58423 }),
    CombatPotency  = Action.Create({ Type = "Spell", ID = 61329 }),
    Elusiveness    = Action.Create({ Type = "Spell", ID = 79008 }),
    RestlessBlades = Action.Create({ Type = "Spell", ID = 79096 }),
    VenomousWounds = Action.Create({ Type = "Spell", ID = 79134 }),
    FindWeakness   = Action.Create({ Type = "Spell", ID = 91023 }),
    FindWeaknessDebuff   = Action.Create({ Type = "Spell", ID = 316220 }),
    Subterfuge     = Action.Create({ Type = "Spell", ID = 108208 }),
    ShadowFocus    = Action.Create({ Type = "Spell", ID = 108209 }),
    DirtyTricks    = Action.Create({ Type = "Spell", ID = 108216 }),
    CrimsonTempest = Action.Create({ Type = "Spell", ID = 121411 }),
    ShadowBlades   = Action.Create({ Type = "Spell", ID = 121471 }),
    PreyontheWeak  = Action.Create({ Type = "Spell", ID = 131511 }),
    MarkedforDeath = Action.Create({ Type = "Spell", ID = 137619 }),
    VenomRush      = Action.Create({ Type = "Spell", ID = 152152 }),
    DeepeningShadows= Action.Create({ Type = "Spell", ID = 185314 }),
    DeeperStratagem= Action.Create({ Type = "Spell", ID = 193531 }),
    Weaponmaster   = Action.Create({ Type = "Spell", ID = 193537 }),
    Alacrity       = Action.Create({ Type = "Spell", ID = 193539 }),
    IronStomach    = Action.Create({ Type = "Spell", ID = 193546 }),
    ElaboratePlanning= Action.Create({ Type = "Spell", ID = 193640 }),
    GrapplingHook  = Action.Create({ Type = "Spell", ID = 195457 }),
    IronWire       = Action.Create({ Type = "Spell", ID = 196861 }),
    HitandRun      = Action.Create({ Type = "Spell", ID = 196922 }),
    AcrobaticStrikes= Action.Create({ Type = "Spell", ID = 196924 }),
    GhostlyStrike  = Action.Create({ Type = "Spell", ID = 196937 }),
    QuickDraw      = Action.Create({ Type = "Spell", ID = 196938 }),
    MasterofShadows= Action.Create({ Type = "Spell", ID = 196976 }),
    Gloomblade     = Action.Create({ Type = "Spell", ID = 200758 }),
    Exsanguinate   = Action.Create({ Type = "Spell", ID = 200806 }),
    ImprovedSprint = Action.Create({ Type = "Spell", ID = 231691 }),
    DeadenedNerves = Action.Create({ Type = "Spell", ID = 231719 }),
    ImprovedBetweentheEyes= Action.Create({ Type = "Spell", ID = 235484 }),
    DarkShadow     = Action.Create({ Type = "Spell", ID = 245687 }),
    PoisonBomb     = Action.Create({ Type = "Spell", ID = 255544 }),
    MasterAssassin = Action.Create({ Type = "Spell", ID = 255989 }),
    BlindingPowder = Action.Create({ Type = "Spell", ID = 256165 }),
    LoadedDice     = Action.Create({ Type = "Spell", ID = 256170 }),
    RetractableHook= Action.Create({ Type = "Spell", ID = 256188 }),
    ShotintheDark  = Action.Create({ Type = "Spell", ID = 257505 }),
    BladeRush      = Action.Create({ Type = "Spell", ID = 271877 }),
    DancingSteel   = Action.Create({ Type = "Spell", ID = 272026 }),
    ShurikenTornado= Action.Create({ Type = "Spell", ID = 277925 }),
    NightTerrors   = Action.Create({ Type = "Spell", ID = 277953 }),
    Opportunity    = Action.Create({ Type = "Spell", ID = 279876 }),
    LeechingPoison = Action.Create({ Type = "Spell", ID = 280716 }),
    SecretTechnique= Action.Create({ Type = "Spell", ID = 280719 }),
    RolltheBones   = Action.Create({ Type = "Spell", ID = 315508 }),
    ImprovedShiv   = Action.Create({ Type = "Spell", ID = 319032 }),
    ImprovedWoundPoison= Action.Create({ Type = "Spell", ID = 319066 }),
    BlackPowder    = Action.Create({ Type = "Spell", ID = 319175 }),
    ImprovedBackstab= Action.Create({ Type = "Spell", ID = 319949 }),
    ImprovedShurikenStorm= Action.Create({ Type = "Spell", ID = 319951 }),
    Blindside      = Action.Create({ Type = "Spell", ID = 328085 }),
    Dreadblades    = Action.Create({ Type = "Spell", ID = 343142 }),
    Premeditation  = Action.Create({ Type = "Spell", ID = 343160 }),
    PremeditationBuff  = Action.Create({ Type = "Spell", ID = 343173 }),
    Riposte        = Action.Create({ Type = "Spell", ID = 344363 }),
    FloatLikeaButterfly= Action.Create({ Type = "Spell", ID = 354897 }),
    Deathmark      = Action.Create({ Type = "Spell", ID = 360194 }),
    NimbleFingers  = Action.Create({ Type = "Spell", ID = 378427 }),
    MasterPoisoner = Action.Create({ Type = "Spell", ID = 378436 }),
    RushedSetup    = Action.Create({ Type = "Spell", ID = 378803 }),
    Shadowrunner   = Action.Create({ Type = "Spell", ID = 378807 }),
    FleetFooted    = Action.Create({ Type = "Spell", ID = 378813 }),
    Recuperator    = Action.Create({ Type = "Spell", ID = 378996 }),
    Blackjack      = Action.Create({ Type = "Spell", ID = 379005 }),
    DeadlyPrecision= Action.Create({ Type = "Spell", ID = 381542 }),
    VirulentPoisons= Action.Create({ Type = "Spell", ID = 381543 }),
    ThiefsVersatility= Action.Create({ Type = "Spell", ID = 381619 }),
    ImprovedAmbush = Action.Create({ Type = "Spell", ID = 381620 }),
    TightSpender   = Action.Create({ Type = "Spell", ID = 381621 }),
    ResoundingClarity= Action.Create({ Type = "Spell", ID = 381622 }),
    ThistleTea     = Action.Create({ Type = "Spell", ID = 381623 }),
    ImprovedPoisons= Action.Create({ Type = "Spell", ID = 381624 }),
    BloodyMess     = Action.Create({ Type = "Spell", ID = 381626 }),
    InternalBleeding= Action.Create({ Type = "Spell", ID = 381627 }),
    ThrownPrecision= Action.Create({ Type = "Spell", ID = 381629 }),
    IntenttoKill   = Action.Create({ Type = "Spell", ID = 381630 }),
    FlyingDaggers  = Action.Create({ Type = "Spell", ID = 381631 }),
    ImprovedGarrote= Action.Create({ Type = "Spell", ID = 381632 }),
    ViciousVenoms  = Action.Create({ Type = "Spell", ID = 381634 }),
    AtrophicPoison = Action.Create({ Type = "Spell", ID = 381637 }),
    LethalDose     = Action.Create({ Type = "Spell", ID = 381640 }),
    SystemicFailure= Action.Create({ Type = "Spell", ID = 381652 }),
    AmplifyingPoison= Action.Create({ Type = "Spell", ID = 381664 }),
    TwisttheKnife  = Action.Create({ Type = "Spell", ID = 381669 }),
    Doomblade      = Action.Create({ Type = "Spell", ID = 381673 }),
    DashingScoundrel= Action.Create({ Type = "Spell", ID = 381797 }),
    ZoldyckRecipe  = Action.Create({ Type = "Spell", ID = 381798 }),
    ScentofBlood   = Action.Create({ Type = "Spell", ID = 381799 }),
    TinyToxicBlade = Action.Create({ Type = "Spell", ID = 381800 }),
    DragonTemperedBlades= Action.Create({ Type = "Spell", ID = 381801 }),
    IndiscriminateCarnage= Action.Create({ Type = "Spell", ID = 381802 }),
    Ambidexterity  = Action.Create({ Type = "Spell", ID = 381822 }),
    AceUpYourSleeve= Action.Create({ Type = "Spell", ID = 381828 }),
    SleightofHand  = Action.Create({ Type = "Spell", ID = 381839 }),
    Audacity       = Action.Create({ Type = "Spell", ID = 381845 }),
    FantheHammer   = Action.Create({ Type = "Spell", ID = 381846 }),
    CombatStamina  = Action.Create({ Type = "Spell", ID = 381877 }),
    DeftManeuvers  = Action.Create({ Type = "Spell", ID = 381878 }),
    HeavyHitter    = Action.Create({ Type = "Spell", ID = 381885 }),
    TripleThreat   = Action.Create({ Type = "Spell", ID = 381894 }),
    CounttheOdds   = Action.Create({ Type = "Spell", ID = 381982 }),
    PreciseCuts    = Action.Create({ Type = "Spell", ID = 381985 }),
    SwiftSlasher   = Action.Create({ Type = "Spell", ID = 381988 }),
    KeepItRolling  = Action.Create({ Type = "Spell", ID = 381989 }),
    SummarilyDispatched= Action.Create({ Type = "Spell", ID = 381990 }),
    TheRotten      = Action.Create({ Type = "Spell", ID = 382015 }),
    TheRottenBuff      = Action.Create({ Type = "Spell", ID = 394203 }),
    Veiltouched    = Action.Create({ Type = "Spell", ID = 382017 }),
    Lethality      = Action.Create({ Type = "Spell", ID = 382238 }),
    ColdBlood      = Action.Create({ Type = "Spell", ID = 382245 }),
    QuickDecisions = Action.Create({ Type = "Spell", ID = 382503 }),
    DarkBrew       = Action.Create({ Type = "Spell", ID = 382504 }),
    TheFirstDance  = Action.Create({ Type = "Spell", ID = 382505 }),
    ReplicatingShadows= Action.Create({ Type = "Spell", ID = 382506 }),
    ShroudedinDarkness= Action.Create({ Type = "Spell", ID = 382507 }),
    PlannedExecution= Action.Create({ Type = "Spell", ID = 382508 }),
    StilettoStaccato= Action.Create({ Type = "Spell", ID = 382509 }),
    ShadowedFinishers= Action.Create({ Type = "Spell", ID = 382511 }),
    Inevitability  = Action.Create({ Type = "Spell", ID = 382512 }),
    WithoutaTrace  = Action.Create({ Type = "Spell", ID = 382513 }),
    FadetoNothing  = Action.Create({ Type = "Spell", ID = 382514 }),
    CloakedinShadows= Action.Create({ Type = "Spell", ID = 382515 }),
    DeeperDaggers  = Action.Create({ Type = "Spell", ID = 382517 }),
    PerforatedVeins= Action.Create({ Type = "Spell", ID = 382518 }),
    PerforatedVeinsBuff= Action.Create({ Type = "Spell", ID = 394254 }),
    InvigoratingShadowdust= Action.Create({ Type = "Spell", ID = 382523 }),
    LingeringShadow= Action.Create({ Type = "Spell", ID = 382524 }),
    LingeringShadowBuff= Action.Create({ Type = "Spell", ID = 385960 }),
    Finality       = Action.Create({ Type = "Spell", ID = 382525 }),
    DanseMacabre   = Action.Create({ Type = "Spell", ID = 382528 }),
    DanseMacabreBuff   = Action.Create({ Type = "Spell", ID = 393969 }),
    TakeembySurprise= Action.Create({ Type = "Spell", ID = 382742 }),
    ImprovedMainGauche= Action.Create({ Type = "Spell", ID = 382746 }),
    HiddenOpportunity= Action.Create({ Type = "Spell", ID = 383281 }),
    Flagellation   = Action.Create({ Type = "Spell", ID = 384631 }),
    FlagellationBuff   = Action.Create({ Type = "Spell", ID = 394758 }),
    Sepsis         = Action.Create({ Type = "Spell", ID = 385408 }),
    StealthedSepsis         = Action.Create({ Type = "Spell", ID = 375939 }),
    SerratedBoneSpike= Action.Create({ Type = "Spell", ID = 385424 }),
    ShroudedSuffocation= Action.Create({ Type = "Spell", ID = 385478 }),
    EchoingReprimand= Action.Create({ Type = "Spell", ID = 385616 }),
    Kingsbane      = Action.Create({ Type = "Spell", ID = 385627 }),
    SilentStorm    = Action.Create({ Type = "Spell", ID = 385722 }),
    SilentStormBuff    = Action.Create({ Type = "Spell", ID = 385727 }),
    GreenskinsWickers= Action.Create({ Type = "Spell", ID = 386823 }),
    FatalConcoction= Action.Create({ Type = "Spell", ID = 392384 }),
    SoothingDarkness= Action.Create({ Type = "Spell", ID = 393970 }),
    ImprovedShadowDance= Action.Create({ Type = "Spell", ID = 393972 }),
    ImprovedShadowTechniques= Action.Create({ Type = "Spell", ID = 394023 }),
    SwiftDeath     = Action.Create({ Type = "Spell", ID = 394309 }),
    SecretStratagem= Action.Create({ Type = "Spell", ID = 394320 }),
    DeviousStratagem= Action.Create({ Type = "Spell", ID = 394321 }),
    Reverberation  = Action.Create({ Type = "Spell", ID = 394332 }),
    ShadowDance    = Action.Create({ Type = "Spell", ID = 394930 }),
    Shadowstep     = Action.Create({ Type = "Spell", ID = 394931 }),
    LightweightShiv= Action.Create({ Type = "Spell", ID = 394983 }),
    ImprovedAdrenalineRush= Action.Create({ Type = "Spell", ID = 395422 }),
    FinalityRupture= Action.Create({ Type = "Spell", ID = 385951 }),
    
}

local A = setmetatable(Action[ACTION_CONST_ROGUE_SUBTLETY], { __index = Action })

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
	customFeintCast                         = { 372735, -- Tectonic Slam (RLP)
                                                385536, -- Flame Dance (RLP)
                                                392488, -- Lightning Storm (RLP)
                                                392486, -- Lightning Storm (RLP)
                                                372863, -- Ritual of Blazebinding (RLP)
                                                373680, 373688, -- Frost Overload (RLP)
                                                374720, -- Consuming Stomp (AV)
                                                384132, -- Overwhelming Energy (AV)
                                                388804, -- Unleashed Destruction (AV)
                                                388817, -- Shards of Stone (NO)
                                                387135, -- Arcing Strike (NO)
                                                387145, -- Totemic Overload (NO)
                                                386012, -- Stormbolt (NO)
                                                386025, -- Tempest (NO)
                                                384620, -- Electrical Storm (NO)
                                                387411, -- Death Bolt Volley (NO)
                                                387145, -- Totemic Overload (NO)
                                                377004, -- Deafening Screech (AA)
                                                388537, -- Arcane Fissue (AA)
                                                388923, -- Burst Forth (AA)
                                                212784, -- Eye Storm (CoS)
                                                211406, -- Firebolt (CoS)
                                                207906, -- Burning Intensity (CoS)
                                                207881, -- Infernal Eruption (CoS)
                                                397892, -- Scream of Pain (CoS)
                                                153094, -- Whispers of the Dark Star (SBG)
                                                164974, -- Dark Eclipse (SBG)
                                                192305, -- Eye of the Storm (mini-boss)
                                                200901, -- Eye of the Storm (boss)
                                                153804, -- Inhale
                                                175988, -- Omen of Death
                                                106228, -- Nothingness
                                                388008, -- Absolute Zero
                                                191284, -- Horn of Valor (HoV)
    },
    customCloakCast                         = {

    },
    customEvasionCast                       = {

    },
    customFeintDebuff                       = { 381862, -- Infernocore (RLP)

    },
    customCloakDebuff                       = { 392641, -- Rolling Thunder (RLP)
                                                372811, -- Molten Boulder (RLP)
                                                370764, -- Piercing Shards (AV)
    },
    customEvasionDebuff                     = {

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

    local useRacial = A.GetToggle(1, "Racial")

    local crimsonVialHP = A.GetToggle(2, "crimsonVialHP")
    if A.CrimsonVial:IsReady(player) and Unit(player):HealthPercent() <= crimsonVialHP then
        return A.CrimsonVial
    end

    if A.Feint:IsReady(player) and Unit(player):HasBuffs(A.Feint.ID) == 0 then
        if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.customFeintCast) >= 1 or Unit(player):HasDeBuffs(Temp.customFeintDebuff) > 0 then
            return A.Feint
        end
    end

    if A.CloakofShadows:IsReady(player) then 
        if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.customCloakCast) >= 1 or Unit(player):HasDeBuffs(Temp.customCloakDebuff) > 0 then
            return A.CloakofShadows
        end
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

        if A.Kick:IsReady(unitID) and useKick and not notInterruptable then
            return A.Kick
        end
        
        if A.Gouge:IsReady(unitID) and useCC and Player:IsBehind(1) and not Unit(unitID):IsBoss() then
            return A.Gouge
        end

        if A.Blind:IsReady(unitID) and useCC and not Unit(unitID):IsBoss() then
            return A.Blind
        end

        if A.KidneyShot:IsReady(unitID) and useCC and Player:ComboPoints() <= 3 and not Unit(unitID):IsBoss() then
            return A.KidneyShot
        end

        if A.CheapShot:IsReady(unitID) and useCC and not Unit(unitID):IsBoss() then
            return A.CheapShot
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
    local comboPoints = Player:ComboPoints()
    local comboPointsMax = Player:ComboPointsMax()
    local comboPointsDeficit = Player:ComboPointsDeficit()
    local energy = Player:Energy()
    local energyRegen = Player:EnergyRegen()
    local energyDeficit = Player:EnergyDeficit()
    local stealthedAll = Player:IsStealthed() or Unit(player):HasBuffs(A.ShadowDance.ID) > 0

    local playerstatus = UnitThreatSituation(player)
    if A.Evasion:IsReady(player) and (Unit(player):IsTanking() or playerstatus == 3) and Unit(player):InGroup() then
        return A.Evasion:Show(icon)
    end

    local function EnemyRotation(unitID)

        local areaTTD = MultiUnits:GetByRangeAreaTTD(20)
        local useRacial = A.GetToggle(1, "Racial")

        -- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end

		local UseTrinket = UseTrinkets(unitID)
		if UseTrinket then
			return UseTrinket:Show(icon)
		end  

        -- # Executed before combat begins. Accepts non-harmful actions only.
        -- actions.precombat=apply_poison

        local LethalPoison = A.GetToggle(2, "Poison")
        if not isMoving and (Unit(player):HasBuffs(A.InstantPoison.ID, true) == 0 and Unit(player):HasBuffs(A.WoundPoison.ID, true) == 0) or (not inCombat and Unit(player):HasBuffs(A.InstantPoison.ID, true) < 300 and Unit(player):HasBuffs(A.WoundPoison.ID, true) < 300) then
            if LethalPoison == "Instant" and A.InstantPoison:IsReady(player) then
                return A.InstantPoison:Show(icon)
            elseif LethalPoison == "Wound" and A.WoundPoison:IsReady(player) then
                return A.WoundPoison:Show(icon)
            end
        end

        if not isMoving and (Unit(player):HasBuffs(A.CripplingPoison.ID, true) == 0 and Unit(player):HasBuffs(A.NumbingPoison.ID, true) == 0 and Unit(player):HasBuffs(A.AtrophicPoison.ID, true) == 0) or (not inCombat and Unit(player):HasBuffs(A.CripplingPoison.ID, true) < 300 and Unit(player):HasBuffs(A.NumbingPoison.ID, true) < 300 and Unit(player):HasBuffs(A.AtrophicPoison.ID, true) < 300) then
            if A.AtrophicPoison:IsReady(player) then
                return A.AtrophicPoison:Show(icon)
            elseif A.NumbingPoison:IsReady(player) then
                return A.NumbingPoison:Show(icon)
            elseif A.CripplingPoison:IsReady(player) then
                return A.CripplingPoison:Show(icon)
            end
        end       
        -- actions.precombat+=/flask
        -- actions.precombat+=/augmentation
        -- actions.precombat+=/food
        -- # Snapshot raid buffed stats before combat begins and pre-potting is done.
        -- actions.precombat+=/snapshot_stats
        -- actions.precombat+=/stealth
        local autoStealth = A.GetToggle(2, "autoStealth")
        if A.Stealth:IsReady(player) and not Player:IsStealthed() then
            return A.Stealth:Show(icon)
        end
        -- actions.precombat+=/marked_for_death,precombat_seconds=15
        if A.MarkedforDeath:IsReady(unitID) then
            return A.MarkedforDeath:Show(icon)
        end
        -- actions.precombat+=/variable,name=algethar_puzzle_box_precombat_cast,value=3
        -- actions.precombat+=/use_item,name=algethar_puzzle_box
        -- actions.precombat+=/slice_and_dice,precombat_seconds=1
        if A.SliceandDice:IsReady(player) and Unit(player):HasBuffs(A.SliceandDice.ID, true) < 1 then
            return A.SliceandDice:Show(icon)
        end
        -- # Executed every time the actor is available.
        -- # Restealth if possible (no vulnerable enemies in combat)
        -- actions=stealth
        -- # Interrupt on cooldown to allow simming interactions with that
        -- actions+=/kick
        -- # Used to determine whether cooldowns wait for SnD based on targets.
        -- actions+=/variable,name=snd_condition,value=buff.slice_and_dice.up|spell_targets.shuriken_storm>=cp_max_spend
        local sndCondition = Unit(player):HasBuffs(A.SliceandDice.ID, true) > 0 or MultiUnits:GetByRange(10) >= comboPointsMax
        -- # Check to see if the next CP (in the event of a ShT proc) is Animacharged
        -- actions+=/variable,name=is_next_cp_animacharged,if=talent.echoing_reprimand.enabled,value=combo_points=1&buff.echoing_reprimand_2.up|combo_points=2&buff.echoing_reprimand_3.up|combo_points=3&buff.echoing_reprimand_4.up|combo_points=4&buff.echoing_reprimand_5.up
        -- # Account for ShT reaction time by ignoring low-CP animacharged matches in the 0.5s preceeding a potential ShT proc
        -- actions+=/variable,name=effective_combo_points,value=effective_combo_points
        -- actions+=/variable,name=effective_combo_points,if=talent.echoing_reprimand.enabled&effective_combo_points>combo_points&combo_points.deficit>2&time_to_sht.4.plus<0.5&!variable.is_next_cp_animacharged,value=combo_points
        -- # Check CDs at first
        -- actions+=/call_action_list,name=cds
        local useBurst = inCombat and BurstIsON(unitID) and (Unit(unitID):TimeToDie() > 20 or Unit(unitID):IsBoss()) and A.Backstab:IsInRange(unitID)
        local autoVanish = A.GetToggle(2, "autoVanish") and Unit(player):InGroup()
        if useBurst then
            -- # Cooldowns  Use Dance off-gcd before the first Shuriken Storm from Tornado comes in.
            -- actions.cds=shadow_dance,use_off_gcd=1,if=!buff.shadow_dance.up&buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
            if A.ShadowDance:IsReady(player, nil, nil, true) and Unit(player):HasBuffs(A.ShadowDance.ID, true) == 0 and Unit(player):HasBuffs(A.ShurikenTornado.ID, true) > 0 and Unit(player):HasBuffs(A.ShurikenTornado.ID, true) <= 3.5 then
                return A.ShadowDance:Show(icon)
            end
            -- # (Unless already up because we took Shadow Focus) use Symbols off-gcd before the first Shuriken Storm from Tornado comes in.
            -- actions.cds+=/symbols_of_death,use_off_gcd=1,if=buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
            if A.SymbolsofDeath:IsReady(player, nil, nil, true) and Unit(player):HasBuffs(A.ShadowDance.ID, true) == 0 and Unit(player):HasBuffs(A.ShurikenTornado.ID, true) > 0 and Unit(player):HasBuffs(A.ShurikenTornado.ID, true) <= 3.5 then
                return A.SymbolsofDeath:Show(icon)
            end
            -- # Vanish for Shadowstrike with Danse Macabre at adaquate stacks
            -- actions.cds+=/vanish,if=buff.danse_macabre.stack>3&combo_points<=2
            if autoVanish and A.Vanish:IsReady(player) and Unit(player):HasBuffsStacks(A.DanseMacabreBuff.ID) > 3 and comboPoints <= 2 then
                return A.Vanish:Show(icon)
            end
            -- # Cold Blood on 5 combo points when not playing Secret Technique
            -- actions.cds+=/cold_blood,if=!talent.secret_technique&combo_points>=5
            if A.ColdBlood:IsReady(player) and not A.SecretTechnique:IsTalentLearned() and comboPoints >= 5 then
                return A.ColdBlood:Show(icon)
            end
            -- actions.cds+=/flagellation,target_if=max:target.time_to_die,if=variable.snd_condition&combo_points>=5&target.time_to_die>10
            if A.Flagellation:IsReady(unitID) and sndCondition and comboPoints >= 5 and Unit(unitID):TimeToDie() > 10 then
                return A.Flagellation:Show(icon)
            end
            -- # Pool for Tornado pre-SoD with ShD ready when not running SF.
            -- actions.cds+=/pool_resource,for_next=1,if=talent.shuriken_tornado.enabled&!talent.shadow_focus.enabled

            -- # Use Tornado pre SoD when we have the energy whether from pooling without SF or just generally.
            -- actions.cds+=/shuriken_tornado,if=spell_targets.shuriken_storm<=1&energy>=60&variable.snd_condition&cooldown.symbols_of_death.up&cooldown.shadow_dance.charges>=1&(!talent.flagellation.enabled&!cooldown.flagellation.up|buff.flagellation_buff.up|spell_targets.shuriken_storm>=5)&combo_points<=2&!buff.premeditation.up
            if A.ShurikenTornado:IsReady(player) and MultiUnits:GetByRange(10) == 1 and energy >= 60 and sndCondition and A.SymbolsofDeath:GetCooldown() == 0 and A.ShadowDance:GetSpellCharges() >= 1 and (not A.Flagellation:IsTalentLearned() or Unit(player):HasBuffs(A.Flagellation.ID) > 0 or Unit(player):HasBuffs(A.FlagellationBuff.ID) > 0 or MultiUnits:GetByRange(10) >= 5) and comboPoints <= 2 and Unit(player):HasBuffs(A.PremeditationBuff.ID) == 0 then
                return A.ShurikenTornado:Show(icon)
            end
            -- actions.cds+=/sepsis,if=variable.snd_condition&combo_points.deficit>=1&target.time_to_die>=16
            if A.Sepsis:IsReady(unitID) and sndCondition and comboPointsDeficit >= 1 and Unit(unitID):TimeToDie() >= 16 then
                return A.Sepsis:Show(icon)
            end
            -- # Use Symbols on cooldown (after first SnD) unless we are going to pop Tornado and do not have Shadow Focus.
            -- actions.cds+=/symbols_of_death,if=variable.snd_condition&(!talent.flagellation|cooldown.flagellation.remains>10|cooldown.flagellation.up&combo_points>=5)
            if A.SymbolsofDeath:IsReady(player, nil, nil, true) and sndCondition and (not A.Flagellation:IsTalentLearned() or A.Flagellation:GetCooldown() > 10 or A.Flagellation:GetCooldown() == 0 and comboPoints >= 5) then
                return A.SymbolsofDeath:Show(icon)
            end
            -- # If adds are up, snipe the one with lowest TTD. Use when dying faster than CP deficit or not stealthed without any CP.
            -- actions.cds+=/marked_for_death,line_cd=1.5,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.all&combo_points.deficit>=cp_max_spend)
            -- # If no adds will die within the next 30s, use MfD on boss without any CP.
            -- actions.cds+=/marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
            if A.MarkedforDeath:IsReady(unitID) and comboPointsDeficit >= comboPointsMax then
                return A.MarkedforDeath:Show(icon)
            end
            -- actions.cds+=/shadow_blades,if=variable.snd_condition&combo_points.deficit>=2&target.time_to_die>=10&(dot.sepsis.ticking|cooldown.sepsis.remains<=8|!talent.sepsis)|fight_remains<=20
            if A.ShadowBlades:IsReady(player) and sndCondition and comboPointsDeficit >= 2 and Unit(unitID):TimeToDie() >= 10 and (Unit(unitID):HasDeBuffs(A.Sepsis.ID, true) > 0 or A.Sepsis:GetCooldown() <= 8 or not A.Sepsis:IsTalentLearned()) then
                return A.ShadowBlades:Show(icon)
            end
            -- actions.cds+=/echoing_reprimand,if=variable.snd_condition&combo_points.deficit>=3&(variable.priority_rotation|spell_targets.shuriken_storm<=4|talent.resounding_clarity)&(buff.shadow_dance.up|!talent.danse_macabre)
            if A.EchoingReprimand:IsReady(unitID) and sndCondition and comboPointsDeficit >= 3 and (MultiUnits:GetByRange(10) <= 4 or A.ResoundingClarity:IsTalentLearned()) and (Unit(player):HasBuffs(A.ShadowDance.ID) > 0 or not A.DanseMacabre:IsTalentLearned()) then
                return A.EchoingReprimand:Show(icon)
            end
            -- # With SF, if not already done, use Tornado with SoD up.
            -- actions.cds+=/shuriken_tornado,if=variable.snd_condition&buff.symbols_of_death.up&combo_points<=2&(!buff.premeditation.up|spell_targets.shuriken_storm>4)
            if A.ShurikenTornado:IsReady(player) and sndCondition and Unit(player):HasBuffs(A.SymbolsofDeath.ID, true) > 0 and comboPoints <= 2 and (Unit(player):HasBuffs(A.PremeditationBuff.ID) == 0 or MultiUnits:GetByRange(10) > 4) then
                return A.ShurikenTornado:Show(icon)
            end
            -- actions.cds+=/shuriken_tornado,if=cooldown.shadow_dance.ready&!stealthed.all&spell_targets.shuriken_storm>=3&!talent.flagellation.enabled
            if A.ShurikenTornado:IsReady(player) and A.ShadowDance:GetCooldown() == 0 and stealthedAll and MultiUnits:GetByRange(10) >= 3 and not A.Flagellation:IsTalentLearned() then
                return A.ShurikenTornado:Show(icon)
            end
            -- actions.cds+=/shadow_dance,if=!buff.shadow_dance.up&fight_remains<=8+talent.subterfuge.enabled
            if A.ShadowDance:IsReady(player, nil, nil, true) and Unit(player):HasBuffs(A.ShadowDance.ID) == 0 and Unit(unitID):IsBoss() and Unit(unitID):TimeToDie() <= 8 and A.Subterfuge:IsTalentLearned() then
                return A.ShadowDance:Show(icon)
            end
            -- actions.cds+=/thistle_tea,if=cooldown.symbols_of_death.remains>=3&!buff.thistle_tea.up&(energy.deficit>=100|cooldown.thistle_tea.charges_fractional>=2.75&buff.shadow_dance.up)|buff.shadow_dance.remains>=4&!buff.thistle_tea.up&spell_targets.shuriken_storm>=3|!buff.thistle_tea.up&fight_remains<=(6*cooldown.thistle_tea.charges)
            if A.ThistleTea:IsReady(player) and A.SymbolsofDeath:GetCooldown() >= 3 and Unit(player):HasBuffs(A.ThistleTea.ID) == 0 then
                if (energyDeficit >= 100 or A.ThistleTea:GetSpellChargesFrac() >= 2.75 and Unit(player):HasBuffs(A.ShadowDance.ID) > 0) or Unit(player):HasBuffs(A.ShadowDance.ID) >= 4 and MultiUnits:GetByRange(10) >= 3 then
                    return A.ThistleTea:Show(icon)
                end
            end
            -- actions.cds+=/potion,if=buff.bloodlust.react|fight_remains<30|buff.symbols_of_death.up&(buff.shadow_blades.up|cooldown.shadow_blades.remains<=10)
            if useRacial and Unit(player):HasBuffs(A.SymbolsofDeath.ID) > 0 then
                -- actions.cds+=/blood_fury,if=buff.symbols_of_death.up
                if A.BloodFury:IsReady(player) then
                    return A.BloodFury:Show(icon)
                end
                -- actions.cds+=/berserking,if=buff.symbols_of_death.up
                if A.Berserking:IsReady(player) then
                    return A.Berserking:Show(icon)
                end
                -- actions.cds+=/fireblood,if=buff.symbols_of_death.up
                if A.Fireblood:IsReady(player) then
                    return A.Fireblood:Show(icon)
                end
                -- actions.cds+=/ancestral_call,if=buff.symbols_of_death.up
                if A.AncestralCall:IsReady(player) then
                    return A.AncestralCall:Show(icon)
                end
            end
            -- actions.cds+=/use_item,name=manic_grieftorch,use_off_gcd=1,if=gcd.remains>gcd.max-0.1,if=!stealthed.all
            -- # Default fallback for usable items: Use with Symbols of Death.
            -- actions.cds+=/use_items,if=buff.symbols_of_death.up|fight_remains<20
        end

        -- # Apply Slice and Dice at 4+ CP if it expires within the next GCD or is not up
        -- actions+=/slice_and_dice,if=spell_targets.shuriken_storm<cp_max_spend&buff.slice_and_dice.remains<gcd.max&fight_remains>6&combo_points>=4
        if A.SliceandDice:IsReady(player) and MultiUnits:GetByRange(10) < comboPointsMax and Unit(player):HasBuffs(A.SliceandDice.ID) < A.GetGCD() and areaTTD > 6 and comboPoints >= 4 then
            return A.SliceandDice:Show(icon)
        end
        -- # Run fully switches to the Stealthed Rotation (by doing so, it forces pooling if nothing is available).
        -- actions+=/run_action_list,name=stealthed,if=stealthed.all
        if stealthedAll and A.Backstab:IsInRange(unitID) then
            -- # Stealthed Rotation  If Stealth/vanish are up, use Shadowstrike to benefit from the passive bonus and Find Weakness, even if we are at max CP (unless using Master Assassin)
            -- actions.stealthed=shadowstrike,if=(buff.stealth.up|buff.vanish.up)&(spell_targets.shuriken_storm<4|variable.priority_rotation)
            if A.Shadowstrike:IsReady(unitID) then
                if (Unit(player):HasBuffs(A.Stealth.ID) > 0 or Unit(player):HasBuffs(A.Vanish.ID) > 0) and MultiUnits:GetByRange(10) < 4 then
                    return A.Shadowstrike:Show(icon)
                end
            end
            -- # Variable to Gloomblade / Backstab when on 4 or 5 combo points with premediation and when the combo point is not anima charged
            -- actions.stealthed+=/variable,name=gloomblade_condition,value=buff.danse_macabre.stack<5&(combo_points.deficit=2|combo_points.deficit=3)&(buff.premeditation.up|effective_combo_points<7)&(spell_targets.shuriken_storm<=8|talent.lingering_shadow)
            local gloombladeCondition = Unit(player):HasBuffsStacks(A.DanseMacabreBuff.ID) < 5 and (ComboPointsDeficit == 2 or comboPointsDeficit == 3) and (Unit(player):HasBuffs(A.PremeditationBuff.ID) > 0 or comboPoints < 7) and (MultiUnits:GetByRange(10) <= 8 or A.LingeringShadow:IsTalentLearned())
            -- actions.stealthed+=/shuriken_storm,if=variable.gloomblade_condition&buff.silent_storm.up&!debuff.find_weakness.remains&talent.improved_shuriken_storm.enabled
            if A.ShurikenStorm:IsReady(player) and gloombladeCondition and Unit(player):HasBuffs(A.SilentStormBuff.ID) > 0 and Unit(unitID):HasDeBuffs(A.FindWeaknessDebuff.ID, true) == 0 and A.ImprovedShurikenStorm:IsTalentLearned() then
                return A.ShurikenStorm:Show(icon)
            end
            -- actions.stealthed+=/gloomblade,if=variable.gloomblade_condition
            if A.Gloomblade:IsReady(unitID) and gloombladeCondition then
                return A.Gloomblade:Show(icon)
            end
            -- actions.stealthed+=/backstab,if=variable.gloomblade_condition&talent.danse_macabre&buff.danse_macabre.stack<=2&spell_targets.shuriken_storm<=2
            if A.Backstab:IsReady(unitID) and not A.Gloomblade:IsTalentLearned() and gloombladeCondition and A.DanseMacabre:IsTalentLearned() and Unit(player):HasBuffsStacks(A.DanseMacabreBuff.ID) <= 2 and MultiUnits:GetByRange(10) <= 2 then
                return A.Backstab:Show(icon)
            end
            -- actions.stealthed+=/call_action_list,name=finish,if=variable.effective_combo_points>=cp_max_spend
            -- # Finish earlier with Shuriken tornado up.
            -- actions.stealthed+=/call_action_list,name=finish,if=buff.shuriken_tornado.up&combo_points.deficit<=2
            -- # Also safe to finish at 4+ CP with exactly 4 targets. (Same as outside stealth.)
            -- actions.stealthed+=/call_action_list,name=finish,if=spell_targets.shuriken_storm>=4-talent.seal_fate&variable.effective_combo_points>=4
            -- # Finish at lower combo points if you are talented in DS, SS or Seal Fate
            -- actions.stealthed+=/call_action_list,name=finish,if=combo_points.deficit<=1+(talent.seal_fate|talent.deeper_stratagem|talent.secret_stratagem)
            -- # Use Gloomblade or Backstab when close to hitting max PV stacks
            if (comboPoints >= comboPointsMax) or (Unit(player):HasBuffs(A.ShurikenTornado.ID) > 0 and comboPointsDeficit <= 2) or (MultiUnits:GetByRange(10) >= 4 - (num(A.SealFate:IsTalentLearned())) and comboPoints >= 4) or (comboPointsDeficit <= (1+(A.SealFate:IsTalentLearned() or A.DeeperStratagem:IsTalentLearned() or A.SecretStratagem:IsTalentLearned()))) then
                -- # Finishers  While using Premeditation, avoid casting Slice and Dice when Shadow Dance is soon to be used, except for Kyrian
                -- actions.finish=variable,name=premed_snd_condition,value=talent.premeditation.enabled&spell_targets.shuriken_storm<5
                local premedSNDCondition = A.Premeditation:IsTalentLearned() and MultiUnits:GetByRange(10) < 5
                -- actions.finish+=/slice_and_dice,if=!variable.premed_snd_condition&spell_targets.shuriken_storm<6&!buff.shadow_dance.up&buff.slice_and_dice.remains<fight_remains&refreshable
                if A.SliceandDice:IsReady(player) and not premedSNDCondition and MultiUnits:GetByRange(10) < 6 and Unit(player):HasBuffs(A.ShadowDance.ID) == 0 and Unit(player):HasBuffs(A.SliceandDice.ID) < areaTTD and A.SliceandDice:GetSpellPandemicThreshold() then
                    return A.SliceandDice:Show(icon)
                end
                -- actions.finish+=/slice_and_dice,if=variable.premed_snd_condition&cooldown.shadow_dance.charges_fractional<1.75&buff.slice_and_dice.remains<cooldown.symbols_of_death.remains&(cooldown.shadow_dance.ready&buff.symbols_of_death.remains-buff.shadow_dance.remains<1.2)
                if A.SliceandDice:IsReady(player) and premedSNDCondition and A.ShadowDance:GetSpellChargesFrac() < 1.75 and Unit(player):HasBuffs(A.SliceandDice.ID) < A.SymbolsofDeath:GetCooldown() and (A.ShadowDance:GetCooldown() == 0 and Unit(player):HasBuffs(A.SymbolsofDeath.ID) - Unit(player):HasBuffs(A.ShadowDance.ID) < 1.2) then
                    return A.SliceandDice:Show(icon)
                end
                -- actions.finish+=/variable,name=skip_rupture,value=buff.thistle_tea.up&spell_targets.shuriken_storm=1|buff.shadow_dance.up&(spell_targets.shuriken_storm=1|dot.rupture.ticking&spell_targets.shuriken_storm>=2)
                local skipRupture = Unit(player):HasBuffs(A.ThistleTea.ID) > 0 and MultiUnits:GetByRange(10) == 1 or Unit(player):HasBuffs(A.ShadowDance.ID) > 0 and (MultiUnits:GetByRange(10) == 0 or Unit(unitID):HasDeBuffs(A.Rupture.ID) > 0 and MultiUnits:GetByRange(10) >= 2)
                -- # Keep up Rupture if it is about to run out.
                -- actions.finish+=/rupture,if=(!variable.skip_rupture|variable.priority_rotation)&target.time_to_die-remains>6&refreshable
                if A.Rupture:IsReady(unitID) and not skipRupture and Unit(unitID):TimeToDie() > 6 and A.Rupture:GetSpellPandemicThreshold() then
                    return A.Rupture:Show(icon)
                end
                -- # Refresh Rupture early for Finality
                -- actions.finish+=/rupture,if=!variable.skip_rupture&buff.finality_rupture.up&cooldown.shadow_dance.remains<12&cooldown.shadow_dance.charges_fractional<=1&spell_targets.shuriken_storm=1&(talent.dark_brew|talent.danse_macabre)
                if A.Rupture:IsReady(unitID) and not skipRupture and Unit(player):HasBuffs(A.FinalityRupture.ID) > 0 and A.ShadowDance:GetCooldown() < 12 and A.ShadowDance:GetSpellChargesFrac() <= 1 and MultiUnits:GetByRange(10) == 1 and (A.DarkBrew:IsTalentLearned() or A.DanseMacabre:IsTalentLearned()) then
                    return A.Rupture:Show(icon)
                end
                -- # Sync Cold Blood with Secret Technique when possible
                -- actions.finish+=/cold_blood,if=buff.shadow_dance.up&(buff.danse_macabre.stack>=3|!talent.danse_macabre)&cooldown.secret_technique.ready
                if A.ColdBlood:IsReady(player) and Unit(player):HasBuffs(A.ShadowDance.ID) > 0 and (Unit(player):HasBuffsStacks(A.DanseMacabreBuff.ID) >= 3 or not A.DanseMacabre:IsTalentLearned()) and A.SecretTechnique:GetCooldown() == 0 then
                    return A.ColdBlood:Show(icon)
                end
                -- actions.finish+=/secret_technique,if=buff.shadow_dance.up&(buff.danse_macabre.stack>=3|!talent.danse_macabre)&(!talent.cold_blood|cooldown.cold_blood.remains>buff.shadow_dance.remains-2)
                if A.SecretTechnique:IsReady(unitID) and Unit(player):HasBuffs(A.ShadowDance.ID) > 0 and (Unit(player):HasBuffsStacks(A.DanseMacabreBuff.ID) >= 3 or not A.DanseMacabre:IsTalentLearned()) and (not A.ColdBlood:IsTalentLearned() or A.ColdBlood:GetCooldown() > Unit(player):HasBuffs(A.ShadowDance.ID) - 2) then
                    return A.SecretTechnique:Show(icon)
                end
                -- # Multidotting targets that will live for the duration of Rupture, refresh during pandemic.
                -- actions.finish+=/rupture,cycle_targets=1,if=!variable.skip_rupture&!variable.priority_rotation&spell_targets.shuriken_storm>=2&target.time_to_die>=(2*combo_points)&refreshable

                -- # Refresh Rupture early if it will expire during Symbols. Do that refresh if SoD gets ready in the next 5s.
                -- actions.finish+=/rupture,if=!variable.skip_rupture&remains<cooldown.symbols_of_death.remains+10&cooldown.symbols_of_death.remains<=5&target.time_to_die-remains>cooldown.symbols_of_death.remains+5
                if A.Rupture:IsReady(unitID) and not skipRupture and Unit(unitID):HasDeBuffs(A.Rupture.ID) < A.SymbolsofDeath:GetCooldown() + 10 and A.SymbolsofDeath:GetCooldown() <= 5 and Unit(unitID):TimeToDie() > A.SymbolsofDeath:GetCooldown() + 5 then
                    return A.Rupture:Show(icon)
                end
                -- actions.finish+=/black_powder,if=!variable.priority_rotation&spell_targets>=3
                if A.BlackPowder:IsReady(player) and MultiUnits:GetByRange(10) >= 3 then
                    return A.BlackPowder:Show(icon)
                end 
                -- actions.finish+=/eviscerate
                if A.Eviscerate:IsReady(unitID) then
                    return A.Eviscerate:Show(icon)
                end

            end
            -- actions.stealthed+=/gloomblade,if=buff.perforated_veins.stack>=5&spell_targets.shuriken_storm<3
            if A.Gloomblade:IsReady(unitID) and Unit(player):HasBuffsStacks(A.PerforatedVeinsBuff.ID) >= 5 and MultiUnits:GetByRange(10) < 3 then
                return A.Gloomblade:Show(icon)
            end
            -- actions.stealthed+=/backstab,if=buff.perforated_veins.stack>=5&spell_targets.shuriken_storm<3
            if A.Backstab:IsReady(unitID) and not A.Gloomblade:IsTalentLearned() and Unit(player):HasBuffsStacks(A.PerforatedVeinsBuff.ID) >= 5 and MultiUnits:GetByRange(10) < 3 then
                return A.Backstab:Show(icon)
            end
            -- actions.stealthed+=/shadowstrike,if=stealthed.sepsis&spell_targets.shuriken_storm<4
            if A.Shadowstrike:IsReady(unitID) and Unit(player):HasBuffs(A.StealthedSepsis.ID) > 0 and MultiUnits:GetByRange(10) < 4 then
                return A.Shadowstrike:Show(icon)
            end
            -- actions.stealthed+=/shuriken_storm,if=spell_targets>=3+buff.the_rotten.up&(!buff.premeditation.up|spell_targets>=7)
            if A.ShurikenStorm:IsReady(player) and MultiUnits:GetByRange(10) >= 3 + num(Unit(player):HasBuffs(A.TheRottenBuff.ID) > 0) and (Unit(player):HasBuffs(A.PremeditationBuff.ID) == 0 or MultiUnits:GetByRange(10) >= 7) then
                return A.ShurikenStorm:Show(icon)
            end
            -- # Shadowstrike to refresh Find Weakness and to ensure we can carry over a full FW into the next SoD if possible.
            -- actions.stealthed+=/shadowstrike,if=debuff.find_weakness.remains<=1|cooldown.symbols_of_death.remains<18&debuff.find_weakness.remains<cooldown.symbols_of_death.remains
            if A.Shadowstrike:IsReady(unitID) then
                return A.Shadowstrike:Show(icon)
            end
            -- actions.stealthed+=/shadowstrike       

        end
        -- # Only change rotation if we have priority_rotation set.
        -- actions+=/variable,name=priority_rotation,value=priority_rotation
        -- # Used to define when to use stealth CDs or builders
        -- actions+=/variable,name=stealth_threshold,value=25+talent.vigor.enabled*20+talent.master_of_shadows.enabled*20+talent.shadow_focus.enabled*25+talent.alacrity.enabled*20+25*(spell_targets.shuriken_storm>=4)
        local stealthThreshold = 25 + num(A.Vigor:IsTalentLearned()) * 20 + num(A.MasterofShadows:IsTalentLearned()) * 20 + num(A.ShadowFocus:IsTalentLearned()) * 25 + num(A.Alacrity:IsTalentLearned()) * 20 + 25 * num(MultiUnits:GetByRange(10) >= 4)
        -- # Consider using a Stealth CD when reaching the energy threshold
        -- actions+=/call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold
        if energyDeficit <= stealthThreshold and useBurst then
            -- # Stealth Cooldowns  Helper Variable
            -- actions.stealth_cds=variable,name=shd_threshold,value=cooldown.shadow_dance.charges_fractional>=0.75+talent.shadow_dance
            local shdThreshold = A.ShadowDance:GetSpellChargesFrac() >= 0.75 and A.ShadowDance:IsTalentLearned()
            -- # Vanish if we are capping on Dance charges. Early before first dance if we have no Nightstalker but Dark Shadow in order to get Rupture up (no Master Assassin).
            -- actions.stealth_cds+=/vanish,if=(!talent.danse_macabre|spell_targets.shuriken_storm>=3)&!variable.shd_threshold&combo_points.deficit>1
            if A.Vanish:IsReady(player) and autoVanish then
                if (not A.DanseMacabre:IsTalentLearned() or MultiUnits:GetByRange(10) >= 3) and not shdThreshold and comboPointsDeficit > 1 then
                    return A.Vanish:Show(icon)
                end
            end
            -- # Pool for Shadowmeld + Shadowstrike unless we are about to cap on Dance charges. Only when Find Weakness is about to run out.
            -- actions.stealth_cds+=/pool_resource,for_next=1,extra_amount=40,if=race.night_elf
            -- actions.stealth_cds+=/shadowmeld,if=energy>=40&energy.deficit>=10&!variable.shd_threshold&combo_points.deficit>4
            -- # CP thresholds for entering Shadow Dance Default to start dance with 0 or 1 combo point
            -- actions.stealth_cds+=/variable,name=shd_combo_points,value=combo_points<=1
            local shdComboPoints = comboPoints <= 1
            -- # Use stealth cooldowns with high combo points when playing shuriken tornado or with high target counts
            -- actions.stealth_cds+=/variable,name=shd_combo_points,value=combo_points.deficit<=1,if=spell_targets.shuriken_storm>(4-2*talent.shuriken_tornado.enabled)|variable.priority_rotation&spell_targets.shuriken_storm>=4
            if MultiUnits:GetByRange(10) >= (4 - 2 * num(A.ShurikenTornado:IsTalentLearned())) then
                shdComboPoints = comboPointsDeficit <= 1 
            end
            -- # Use stealth cooldowns on any combo point on 4 targets
            -- actions.stealth_cds+=/variable,name=shd_combo_points,value=1,if=spell_targets.shuriken_storm=(4-talent.seal_fate)
            if MultiUnits:GetByRange(10) == (4 - num(A.SealFate:IsTalentLearned())) then
                shdComboPoints = 1
            end
            -- # Dance during Symbols or above threshold.
            -- actions.stealth_cds+=/shadow_dance,if=(variable.shd_combo_points&(buff.symbols_of_death.remains>=(2.2-talent.flagellation.enabled)|variable.shd_threshold)|buff.flagellation.up|buff.flagellation_persist.remains>=6|spell_targets.shuriken_storm>=4&cooldown.symbols_of_death.remains>10)&!buff.the_rotten.up
            if A.ShadowDance:IsReady(player, nil, nil, true) then
                if (shdComboPoints and (Unit(player):HasBuffs(A.SymbolsofDeath.ID) >= (2.2 - num(A.Flagellation:IsTalentLearned())) or shdThreshold) or Unit(player):HasBuffs(A.FlagellationBuff.ID) > 0 or MultiUnits:GetByRange(10) >= 4 and A.SymbolsofDeath:GetCooldown() > 10) and Unit(player):HasBuffs(A.TheRottenBuff.ID) == 0 then
                    return A.ShadowDance:Show(icon)
                end
            end
            -- # Burn Dances charges if before the fight ends if SoD won't be ready in time.
            -- actions.stealth_cds+=/shadow_dance,if=variable.shd_combo_points&fight_remains<cooldown.symbols_of_death.remains|!talent.shadow_dance&dot.rupture.ticking&spell_targets.shuriken_storm<=4&!buff.the_rotten.up

        end

        -- actions+=/call_action_list,name=finish,if=variable.effective_combo_points>=cp_max_spend
        -- # Finish at maximum or close to maximum combo point value
        -- actions+=/call_action_list,name=finish,if=combo_points.deficit<=1+buff.the_rotten.up|fight_remains<=1&variable.effective_combo_points>=3
        -- # Finish at 4+ against 4 targets (outside stealth)
        -- actions+=/call_action_list,name=finish,if=spell_targets.shuriken_storm>=(4-talent.seal_fate)&variable.effective_combo_points>=4

        if (comboPoints >= comboPointsMax) or (comboPointsDeficit <= (1 + num(Unit(player):HasBuffs(A.TheRottenBuff.ID) > 0)) or areaTTD <= 1 and comboPoints >= 3) or (MultiUnits:GetByRange(10) >= (4 - num(A.SealFate:IsTalentLearned())) and comboPoints >= 4) then
            -- # Finishers  While using Premeditation, avoid casting Slice and Dice when Shadow Dance is soon to be used, except for Kyrian
            -- actions.finish=variable,name=premed_snd_condition,value=talent.premeditation.enabled&spell_targets.shuriken_storm<5
            local premedSNDCondition = A.Premeditation:IsTalentLearned() and MultiUnits:GetByRange(10) < 5
            -- actions.finish+=/slice_and_dice,if=!variable.premed_snd_condition&spell_targets.shuriken_storm<6&!buff.shadow_dance.up&buff.slice_and_dice.remains<fight_remains&refreshable
            if A.SliceandDice:IsReady(player) and not premedSNDCondition and MultiUnits:GetByRange(10) < 6 and Unit(player):HasBuffs(A.ShadowDance.ID) == 0 and Unit(player):HasBuffs(A.SliceandDice.ID) < areaTTD and A.SliceandDice:GetSpellPandemicThreshold() then
                return A.SliceandDice:Show(icon)
            end
            -- actions.finish+=/slice_and_dice,if=variable.premed_snd_condition&cooldown.shadow_dance.charges_fractional<1.75&buff.slice_and_dice.remains<cooldown.symbols_of_death.remains&(cooldown.shadow_dance.ready&buff.symbols_of_death.remains-buff.shadow_dance.remains<1.2)
            if A.SliceandDice:IsReady(player) and premedSNDCondition and A.ShadowDance:GetSpellChargesFrac() < 1.75 and Unit(player):HasBuffs(A.SliceandDice.ID) < A.SymbolsofDeath:GetCooldown() and (A.ShadowDance:GetCooldown() == 0 and Unit(player):HasBuffs(A.SymbolsofDeath.ID) - Unit(player):HasBuffs(A.ShadowDance.ID) < 1.2) then
                return A.SliceandDice:Show(icon)
            end
            -- actions.finish+=/variable,name=skip_rupture,value=buff.thistle_tea.up&spell_targets.shuriken_storm=1|buff.shadow_dance.up&(spell_targets.shuriken_storm=1|dot.rupture.ticking&spell_targets.shuriken_storm>=2)
            local skipRupture = Unit(player):HasBuffs(A.ThistleTea.ID) > 0 and MultiUnits:GetByRange(10) == 1 or Unit(player):HasBuffs(A.ShadowDance.ID) > 0 and (MultiUnits:GetByRange(10) == 0 or Unit(unitID):HasDeBuffs(A.Rupture.ID) > 0 and MultiUnits:GetByRange(10) >= 2)
            -- # Keep up Rupture if it is about to run out.
            -- actions.finish+=/rupture,if=(!variable.skip_rupture|variable.priority_rotation)&target.time_to_die-remains>6&refreshable
            if A.Rupture:IsReady(unitID) and not skipRupture and Unit(unitID):TimeToDie() > 6 and A.Rupture:GetSpellPandemicThreshold() then
                return A.Rupture:Show(icon)
            end
            -- # Refresh Rupture early for Finality
            -- actions.finish+=/rupture,if=!variable.skip_rupture&buff.finality_rupture.up&cooldown.shadow_dance.remains<12&cooldown.shadow_dance.charges_fractional<=1&spell_targets.shuriken_storm=1&(talent.dark_brew|talent.danse_macabre)
            if A.Rupture:IsReady(unitID) and not skipRupture and Unit(player):HasBuffs(A.FinalityRupture.ID) > 0 and A.ShadowDance:GetCooldown() < 12 and A.ShadowDance:GetSpellChargesFrac() <= 1 and MultiUnits:GetByRange(10) == 1 and (A.DarkBrew:IsTalentLearned() or A.DanseMacabre:IsTalentLearned()) then
                return A.Rupture:Show(icon)
            end
            -- # Sync Cold Blood with Secret Technique when possible
            -- actions.finish+=/cold_blood,if=buff.shadow_dance.up&(buff.danse_macabre.stack>=3|!talent.danse_macabre)&cooldown.secret_technique.ready
            if A.ColdBlood:IsReady(player) and Unit(player):HasBuffs(A.ShadowDance.ID) > 0 and (Unit(player):HasBuffsStacks(A.DanseMacabreBuff.ID) >= 3 or not A.DanseMacabre:IsTalentLearned()) and A.SecretTechnique:GetCooldown() == 0 then
                return A.ColdBlood:Show(icon)
            end
            -- actions.finish+=/secret_technique,if=buff.shadow_dance.up&(buff.danse_macabre.stack>=3|!talent.danse_macabre)&(!talent.cold_blood|cooldown.cold_blood.remains>buff.shadow_dance.remains-2)
            if A.SecretTechnique:IsReady(unitID) and Unit(player):HasBuffs(A.ShadowDance.ID) > 0 and (Unit(player):HasBuffsStacks(A.DanseMacabreBuff.ID) >= 3 or not A.DanseMacabre:IsTalentLearned()) and (not A.ColdBlood:IsTalentLearned() or A.ColdBlood:GetCooldown() > Unit(player):HasBuffs(A.ShadowDance.ID) - 2) then
                return A.SecretTechnique:Show(icon)
            end
            -- # Multidotting targets that will live for the duration of Rupture, refresh during pandemic.
            -- actions.finish+=/rupture,cycle_targets=1,if=!variable.skip_rupture&!variable.priority_rotation&spell_targets.shuriken_storm>=2&target.time_to_die>=(2*combo_points)&refreshable

            -- # Refresh Rupture early if it will expire during Symbols. Do that refresh if SoD gets ready in the next 5s.
            -- actions.finish+=/rupture,if=!variable.skip_rupture&remains<cooldown.symbols_of_death.remains+10&cooldown.symbols_of_death.remains<=5&target.time_to_die-remains>cooldown.symbols_of_death.remains+5
            if A.Rupture:IsReady(unitID) and not skipRupture and Unit(unitID):HasDeBuffs(A.Rupture.ID) < A.SymbolsofDeath:GetCooldown() + 10 and A.SymbolsofDeath:GetCooldown() <= 5 and Unit(unitID):TimeToDie() > A.SymbolsofDeath:GetCooldown() + 5 then
                return A.Rupture:Show(icon)
            end
            -- actions.finish+=/black_powder,if=!variable.priority_rotation&spell_targets>=3
            if A.BlackPowder:IsReady(player) and MultiUnits:GetByRange(10) >= 3 then
                return A.BlackPowder:Show(icon)
            end 
            -- actions.finish+=/eviscerate
            if A.Eviscerate:IsReady(unitID) then
                return A.Eviscerate:Show(icon)
            end
        end

        -- # Use a builder when reaching the energy threshold
        -- actions+=/call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
        if energyDeficit <= stealthThreshold then
            -- # Builders
            -- actions.build=shuriken_storm,if=spell_targets>=2+(talent.gloomblade&buff.lingering_shadow.remains>=6|buff.perforated_veins.up)
            if A.ShurikenStorm:IsReady(player) and MultiUnits:GetByRange(10) >= 2 + num(A.Gloomblade:IsTalentLearned() and Unit(player):HasBuffs(A.LingeringShadowBuff.ID) >= 6 or Unit(player):HasBuffs(A.PerforatedVeinsBuff.ID) > 0) then
                return A.ShurikenStorm:Show(icon)
            end
            -- # Build immediately unless the next CP is Animacharged and we won't cap energy waiting for it.
            -- actions.build+=/variable,name=anima_helper,value=!talent.echoing_reprimand.enabled|!(variable.is_next_cp_animacharged&(time_to_sht.3.plus<0.5|time_to_sht.4.plus<1)&energy<60)
            --local animaHelper = not A.EchoingReprimand:IsTalentLearned() or not ()
            -- actions.build+=/gloomblade,if=variable.anima_helper
            if A.Gloomblade:IsReady(unitID) then
                return A.Gloomblade:Show(icon)
            end
            -- actions.build+=/backstab,if=variable.anima_helper
            if A.Backstab:IsReady(unitID) then
                return A.Backstab:Show(icon)
            end
        end
        -- # Lowest priority in all of the APL because it causes a GCD
        -- actions+=/arcane_torrent,if=energy.deficit>=15+energy.regen
        if A.ArcaneTorrent:IsReady(player) and A.Backstab:IsInRange(unitID) and energyDeficit >= 15 + energyRegen then
            return A.ArcaneTorrent:Show(icon)
        end
        -- actions+=/arcane_pulse
        -- actions+=/lights_judgment
        -- actions+=/bag_of_tricks

        
    end

	-- Defensive
	local SelfDefensive = SelfDefensives()
	if SelfDefensive then 
		return SelfDefensive:Show(icon)
	end 

    if A.IsUnitEnemy(target) then 
        unitID = target
        if EnemyRotation(unitID) then 
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