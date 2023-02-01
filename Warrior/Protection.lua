--#####################################
--##### TRIP'S PROTECTION WARRIOR #####
--#####################################

local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
local Covenant									= _G.LibStub("Covenant")
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
local CovenantIsON								= Action.CovenantIsON
local AuraIsValid								= Action.AuraIsValid
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

Action[ACTION_CONST_WARRIOR_PROTECTION] = {
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
    WilltoSurvive			= Action.Create({ Type = "Spell", ID = 59752    }),
    LightsJudgment				= Action.Create({ Type = "Spell", ID = 255647   }), 

    Charge         = Action.Create({ Type = "Spell", ID = 100 }),
    Taunt          = Action.Create({ Type = "Spell", ID = 355 }),
    Slam           = Action.Create({ Type = "Spell", ID = 1464 }),
    Whirlwind      = Action.Create({ Type = "Spell", ID = 1680 }),
    Hamstring      = Action.Create({ Type = "Spell", ID = 1715 }),
    ShieldBlock    = Action.Create({ Type = "Spell", ID = 2565 }),
    ShieldBlockBuff    = Action.Create({ Type = "Spell", ID = 132404 }),
    Execute        = Action.Create({ Type = "Spell", ID = 5308 }),
    Pummel         = Action.Create({ Type = "Spell", ID = 6552 }),
    BattleShout    = Action.Create({ Type = "Spell", ID = 6673 }),
    Devastate      = Action.Create({ Type = "Spell", ID = 20243 }),
    ShieldSlam     = Action.Create({ Type = "Spell", ID = 23922 }),
    VictoryRush    = Action.Create({ Type = "Spell", ID = 34428 }),
    HeroicThrow    = Action.Create({ Type = "Spell", ID = 57755 }),
    Attack         = Action.Create({ Type = "Spell", ID = 88163 }),
    Rend           = Action.Create({ Type = "Spell", ID = 772 }),
    Cleave         = Action.Create({ Type = "Spell", ID = 845 }),
    ShieldWall     = Action.Create({ Type = "Spell", ID = 871 }),
    DemoralizingShout= Action.Create({ Type = "Spell", ID = 1160 }),
    ChallengingShout= Action.Create({ Type = "Spell", ID = 1161 }),
    Recklessness   = Action.Create({ Type = "Spell", ID = 1719 }),
    Intervene      = Action.Create({ Type = "Spell", ID = 3411 }),
    IntimidatingShout= Action.Create({ Type = "Spell", ID = 5246 }),
    ThunderClap    = Action.Create({ Type = "Spell", ID = 6343 }),
    HeroicLeap     = Action.Create({ Type = "Spell", ID = 6544 }),
    Revenge        = Action.Create({ Type = "Spell", ID = 6572 }),
    Overpower      = Action.Create({ Type = "Spell", ID = 7384 }),
    MortalStrike   = Action.Create({ Type = "Spell", ID = 12294 }),
    PiercingHowl   = Action.Create({ Type = "Spell", ID = 12323 }),
    ImprovedWhirlwind= Action.Create({ Type = "Spell", ID = 12950 }),
    LastStand      = Action.Create({ Type = "Spell", ID = 12975 }),
    BerserkerRage  = Action.Create({ Type = "Spell", ID = 18499 }),
    Bloodthirst    = Action.Create({ Type = "Spell", ID = 23881 }),
    SpellReflection= Action.Create({ Type = "Spell", ID = 23920 }),
    SuddenDeath    = Action.Create({ Type = "Spell", ID = 29725 }),
    SecondWind     = Action.Create({ Type = "Spell", ID = 29838 }),
    Shockwave      = Action.Create({ Type = "Spell", ID = 46968 }),
    ShatteringThrow= Action.Create({ Type = "Spell", ID = 64382 }),
    SingleMindedFury= Action.Create({ Type = "Spell", ID = 81099 }),
    RagingBlow     = Action.Create({ Type = "Spell", ID = 85288 }),
    RallyingCry    = Action.Create({ Type = "Spell", ID = 97462 }),
    DoubleTime     = Action.Create({ Type = "Spell", ID = 103827 }),
    StormBolt      = Action.Create({ Type = "Spell", ID = 107570 }),
    Avatar         = Action.Create({ Type = "Spell", ID = 107574 }),
    DiebytheSword  = Action.Create({ Type = "Spell", ID = 118038 }),
    AngerManagement= Action.Create({ Type = "Spell", ID = 152278 }),
    ColossusSmash  = Action.Create({ Type = "Spell", ID = 167105 }),
    EnragedRegeneration= Action.Create({ Type = "Spell", ID = 184364 }),
    Rampage        = Action.Create({ Type = "Spell", ID = 184367 }),
    Tactician      = Action.Create({ Type = "Spell", ID = 184783 }),
    IgnorePain     = Action.Create({ Type = "Spell", ID = 190456 }),
    Indomitable    = Action.Create({ Type = "Spell", ID = 202095 }),
    BoundingStride = Action.Create({ Type = "Spell", ID = 202163 }),
    ImpendingVictory= Action.Create({ Type = "Spell", ID = 202168 }),
    FervorofBattle = Action.Create({ Type = "Spell", ID = 202316 }),
    BestServedCold = Action.Create({ Type = "Spell", ID = 202560 }),
    IntotheFray    = Action.Create({ Type = "Spell", ID = 202603 }),
    BoomingVoice   = Action.Create({ Type = "Spell", ID = 202743 }),
    HeavyRepercussions= Action.Create({ Type = "Spell", ID = 203177 }),
    CracklingThunder= Action.Create({ Type = "Spell", ID = 203201 }),
    Massacre       = Action.Create({ Type = "Spell", ID = 206315 }),
    Warpaint       = Action.Create({ Type = "Spell", ID = 208154 }),
    FreshMeat      = Action.Create({ Type = "Spell", ID = 215568 }),
    FrothingBerserker= Action.Create({ Type = "Spell", ID = 215571 }),
    Bladestorm     = Action.Create({ Type = "Spell", ID = 227847 }),
    Ravager        = Action.Create({ Type = "Spell", ID = 228920 }),
    Devastator     = Action.Create({ Type = "Spell", ID = 236279 }),
    InForTheKill   = Action.Create({ Type = "Spell", ID = 248621 }),
    Skullsplitter  = Action.Create({ Type = "Spell", ID = 260643 }),
    SweepingStrikes= Action.Create({ Type = "Spell", ID = 260708 }),
    Dreadnaught    = Action.Create({ Type = "Spell", ID = 262150 }),
    Warbreaker     = Action.Create({ Type = "Spell", ID = 262161 }),
    WarMachine     = Action.Create({ Type = "Spell", ID = 262231 }),
    Punish         = Action.Create({ Type = "Spell", ID = 275334 }),
    UnstoppableForce= Action.Create({ Type = "Spell", ID = 275336 }),
    Menace         = Action.Create({ Type = "Spell", ID = 275338 }),
    RumblingEarth  = Action.Create({ Type = "Spell", ID = 275339 }),
    Bolster        = Action.Create({ Type = "Spell", ID = 280001 }),
    MeatCleaver    = Action.Create({ Type = "Spell", ID = 280392 }),
    Onslaught      = Action.Create({ Type = "Spell", ID = 315720 }),
    ImprovedExecute= Action.Create({ Type = "Spell", ID = 316402 }),
    MartialProwess = Action.Create({ Type = "Spell", ID = 316440 }),
    CollateralDamage= Action.Create({ Type = "Spell", ID = 334779 }),
    Frenzy         = Action.Create({ Type = "Spell", ID = 335077 }),
    SpearofBastion = Action.Create({ Type = "Spell", ID = 376079 }),
    LeechingStrikes= Action.Create({ Type = "Spell", ID = 382258 }),
    FastFootwork   = Action.Create({ Type = "Spell", ID = 382260 }),
    InspiringPresence= Action.Create({ Type = "Spell", ID = 382310 }),
    HonedReflexes  = Action.Create({ Type = "Spell", ID = 382461 }),
    PainandGain    = Action.Create({ Type = "Spell", ID = 382549 }),
    CrushingForce  = Action.Create({ Type = "Spell", ID = 382764 }),
    OverwhelmingRage= Action.Create({ Type = "Spell", ID = 382767 }),
    OneHandedWeaponSpecialization= Action.Create({ Type = "Spell", ID = 382895 }),
    TwoHandedWeaponSpecialization= Action.Create({ Type = "Spell", ID = 382896 }),
    DualWieldSpecialization= Action.Create({ Type = "Spell", ID = 382900 }),
    ReinforcedPlates= Action.Create({ Type = "Spell", ID = 382939 }),
    EnduranceTraining= Action.Create({ Type = "Spell", ID = 382940 }),
    WildStrikes    = Action.Create({ Type = "Spell", ID = 382946 }),
    PiercingVerdict= Action.Create({ Type = "Spell", ID = 382948 }),
    StormofSteel   = Action.Create({ Type = "Spell", ID = 382953 }),
    CacophonousRoar= Action.Create({ Type = "Spell", ID = 382954 }),
    SeismicReverberation= Action.Create({ Type = "Spell", ID = 382956 }),
    BarbaricTraining= Action.Create({ Type = "Spell", ID = 383082 }),
    FueledbyViolence= Action.Create({ Type = "Spell", ID = 383103 }),
    ConcussiveBlows= Action.Create({ Type = "Spell", ID = 383115 }),
    Bloodletting   = Action.Create({ Type = "Spell", ID = 383154 }),
    ExhilaratingBlows= Action.Create({ Type = "Spell", ID = 383219 }),
    Bloodborne     = Action.Create({ Type = "Spell", ID = 383287 }),
    Juggernaut     = Action.Create({ Type = "Spell", ID = 383292 }),
    ReapingSwings  = Action.Create({ Type = "Spell", ID = 383293 }),
    DeftExperience = Action.Create({ Type = "Spell", ID = 383295 }),
    CriticalThinking= Action.Create({ Type = "Spell", ID = 383297 }),
    MercilessBonegrinder= Action.Create({ Type = "Spell", ID = 383317 }),
    ValorinVictory = Action.Create({ Type = "Spell", ID = 383338 }),
    SharpenedBlades= Action.Create({ Type = "Spell", ID = 383341 }),
    Impale         = Action.Create({ Type = "Spell", ID = 383430 }),
    BluntInstruments= Action.Create({ Type = "Spell", ID = 383442 }),
    SwiftStrikes   = Action.Create({ Type = "Spell", ID = 383459 }),
    InvigoratingFury= Action.Create({ Type = "Spell", ID = 383468 }),
    FocusinChaos   = Action.Create({ Type = "Spell", ID = 383486 }),
    FrenziedFlurry = Action.Create({ Type = "Spell", ID = 383605 }),
    Fatality       = Action.Create({ Type = "Spell", ID = 383703 }),
    BitterImmunity = Action.Create({ Type = "Spell", ID = 383762 }),
    ImprovedEnrage = Action.Create({ Type = "Spell", ID = 383848 }),
    ImprovedBloodthirst= Action.Create({ Type = "Spell", ID = 383852 }),
    ImprovedRagingBlow= Action.Create({ Type = "Spell", ID = 383854 }),
    HackandSlash   = Action.Create({ Type = "Spell", ID = 383877 }),
    ViciousContempt= Action.Create({ Type = "Spell", ID = 383885 }),
    Annihilator    = Action.Create({ Type = "Spell", ID = 383916 }),
    DepthsofInsanity= Action.Create({ Type = "Spell", ID = 383922 }),
    ColdSteelHotBlood= Action.Create({ Type = "Spell", ID = 383959 }),
    BrutalVitality = Action.Create({ Type = "Spell", ID = 384036 }),
    Strategist     = Action.Create({ Type = "Spell", ID = 384041 }),
    UnnervingFocus = Action.Create({ Type = "Spell", ID = 384042 }),
    EnduringAlacrity= Action.Create({ Type = "Spell", ID = 384063 }),
    FocusedVigor   = Action.Create({ Type = "Spell", ID = 384067 }),
    ImpenetrableWall= Action.Create({ Type = "Spell", ID = 384072 }),
    TitanicThrow   = Action.Create({ Type = "Spell", ID = 384090 }),
    BerserkerShout = Action.Create({ Type = "Spell", ID = 384100 }),
    WreckingThrow  = Action.Create({ Type = "Spell", ID = 384110 }),
    ArmoredtotheTeeth= Action.Create({ Type = "Spell", ID = 384124 }),
    BloodandThunder= Action.Create({ Type = "Spell", ID = 384277 }),
    ThunderousRoar = Action.Create({ Type = "Spell", ID = 384318 }),
    Bloodsurge     = Action.Create({ Type = "Spell", ID = 384361 }),
    Sidearm        = Action.Create({ Type = "Spell", ID = 384404 }),
    ThunderousWords= Action.Create({ Type = "Spell", ID = 384969 }),
    TestofMight    = Action.Create({ Type = "Spell", ID = 385008 }),
    OdynsFury      = Action.Create({ Type = "Spell", ID = 385059 }),
    StormofSwords  = Action.Create({ Type = "Spell", ID = 385512 }),
    ImprovedOverpower= Action.Create({ Type = "Spell", ID = 385571 }),
    ImprovedMortalStrike= Action.Create({ Type = "Spell", ID = 385573 }),
    Thunderlord    = Action.Create({ Type = "Spell", ID = 385840 }),
    ShowofForce    = Action.Create({ Type = "Spell", ID = 385843 }),
    ToughasNails   = Action.Create({ Type = "Spell", ID = 385888 }),
    ShieldCharge   = Action.Create({ Type = "Spell", ID = 385952 }),
    ShieldSpecialization= Action.Create({ Type = "Spell", ID = 386011 }),
    EnduringDefenses= Action.Create({ Type = "Spell", ID = 386027 }),
    BraceForImpact = Action.Create({ Type = "Spell", ID = 386030 }),
    ImprovedHeroicThrow= Action.Create({ Type = "Spell", ID = 386034 }),
    DisruptingShout= Action.Create({ Type = "Spell", ID = 386071 }),
    BattleStance   = Action.Create({ Type = "Spell", ID = 386164 }),
    BerserkerStance= Action.Create({ Type = "Spell", ID = 386196 }),
    DefensiveStance= Action.Create({ Type = "Spell", ID = 386208 }),
    ElysianMight   = Action.Create({ Type = "Spell", ID = 386285 }),
    ChampionsBulwark= Action.Create({ Type = "Spell", ID = 386328 }),
    TideofBlood    = Action.Create({ Type = "Spell", ID = 386357 }),
    BattleScarredVeteran= Action.Create({ Type = "Spell", ID = 386394 }),
    ViolentOutburst= Action.Create({ Type = "Spell", ID = 386477 }),
    ViolentOutburstBuff= Action.Create({ Type = "Spell", ID = 38647 }),
    Unhinged       = Action.Create({ Type = "Spell", ID = 386628 }),
    Battlelord     = Action.Create({ Type = "Spell", ID = 386630 }),
    ExecutionersPrecision= Action.Create({ Type = "Spell", ID = 386634 }),
    SlaughteringStrikes= Action.Create({ Type = "Spell", ID = 388004 }),
    RagingArmaments= Action.Create({ Type = "Spell", ID = 388049 }),
    StormWall      = Action.Create({ Type = "Spell", ID = 388807 }),
    Tenderize      = Action.Create({ Type = "Spell", ID = 388933 }),
    UnbridledFerocity= Action.Create({ Type = "Spell", ID = 389603 }),
    BerserkersTorment= Action.Create({ Type = "Spell", ID = 390123 }),
    TitansTorment  = Action.Create({ Type = "Spell", ID = 390135 }),
    BlademastersTorment= Action.Create({ Type = "Spell", ID = 390138 }),
    WarlordsTorment= Action.Create({ Type = "Spell", ID = 390140 }),
    FuriousBlows   = Action.Create({ Type = "Spell", ID = 390354 }),
    Hurricane      = Action.Create({ Type = "Spell", ID = 390563 }),
    DanceofDeath   = Action.Create({ Type = "Spell", ID = 390713 }),
    SonicBoom      = Action.Create({ Type = "Spell", ID = 390725 }),
    Uproar         = Action.Create({ Type = "Spell", ID = 391572 }),
    DancingBlades  = Action.Create({ Type = "Spell", ID = 391683 }),
    AshenJuggernaut= Action.Create({ Type = "Spell", ID = 392536 }),
    CruelStrikes   = Action.Create({ Type = "Spell", ID = 392777 }),
    Cruelty        = Action.Create({ Type = "Spell", ID = 392931 }),
    WrathandFury   = Action.Create({ Type = "Spell", ID = 392936 }),
    SpellBlock     = Action.Create({ Type = "Spell", ID = 392966 }),
    Bloodcraze     = Action.Create({ Type = "Spell", ID = 393950 }),
    ImmovableObject= Action.Create({ Type = "Spell", ID = 394307 }),
    Instigate      = Action.Create({ Type = "Spell", ID = 394311 }),
    BatteringRam   = Action.Create({ Type = "Spell", ID = 394312 }),
    TitanicRage    = Action.Create({ Type = "Spell", ID = 394329 }),
    RecklessAbandon= Action.Create({ Type = "Spell", ID = 396749 }),
    DefendersAegis = Action.Create({ Type = "Spell", ID = 397103 }),
    VanguardsDetermination = Action.Create({ Type = "Spell", ID = 394056 }),   
    Healthstone     = Action.Create({ Type = "Item", ID = 5512 }),
}

local A = setmetatable(Action[ACTION_CONST_WARRIOR_PROTECTION], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
local target = "target"
local pet = "pet"
local targettarget = "targettarget"

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
    healerStressedIncMagic					= { 372735, -- Tectonic Slam (RLP)
												372808, -- Frigid Shard (RLP)
												385536, -- Flame Dance (RLP)
												392488, -- Lightning Storm (RLP)
												392486, -- Lightning Storm (RLP)
												387564, -- Mystic Vapors (AV)
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
												388862, -- Surge (AA)
												212784, -- Eye Storm (CoS)
												211406, -- Firebolt (CoS)
												207906, -- Burning Intensity (CoS)
												207881, -- Infernal Eruption (CoS)
												156722, -- Void Bolt (SBG)
												152814, -- Shadow Bolt (SBG)
	},
	IncMagic								= { 372863, -- Ritual of Blazebinding (RLP)
												381605, -- Flamespit (RLP)
												381602, -- Flamespit (RLP)
												381607, -- Flamespit (RLP)
												374789, -- Infused Strike (AV)
												374567, -- Explosive Brand (AV)
												374570, -- Explosive Brand (AV)
												374582, -- Explosive Brand (AV)
												370764, -- Piercing Shards (AV)
												377105, -- Ice Cutter (AV)
												372222, -- Arcane Cleave (AV)
												388008, -- Absolute Zero (AV)
												384978, -- Dragon Strike (AV)
												385916, -- Tectonic Stomp (NO)
												386028, -- Thunder Clap (NO)
												384686, -- Energy Surge (NO)
												384316, -- Lightning Strike (NO)
												382670, -- Gale Arrow (NO)
												376827, -- Conductive Strike (NO)
												388923, -- Burst Forth (AA)
												377991, -- Storm Slash (AA)
												377004, -- Deafening Screech (AA)
												396812, -- Mystic Blast (AA)
												385958, -- Arcane Expulsion (AA)
												387975, -- Arcane Missiles (AA)
												200901, -- Eye of the Storm (HoV)
												200682, -- Eye of the Storm (HoV)
												192288, -- Searing Light (HoV)
												198888, -- Lightning Breath (HoV)
												209404, -- Seal Magic (CoS)
												209410, -- Nightfall Orb (CoS)
												211299, -- Searing Glare (CoS)
												211473, -- Shadow Slash (CoS)
												397892, -- Scream of Pain (CoS)
												373364, -- Vampiric Claws (CoS)
												214692, -- Shadow Bolt Volley (CoS)
												164907, -- Void Slash (SBG)
												152792, -- Void Blast (SBG)
												156717, -- Death Venom (SBG)
												153485, -- Fetid Spit (SBG)
												153680, -- Fetid Spit (SBG)
												152964, -- Void Pulse (SBG)
												397888, -- Hydrolance (TJS)
												397878, -- Tainted Ripple (TJS)
												114646, -- Haunting Gaze (TJS)
												114571, -- Agony (TJS)
												397931, -- Dark Claw (TJS)
												106823, -- Serpent Strike (TJS)
												106841, -- Jade Serpent Strike (TJS)
												117665, -- Bounds of Reality (TJS)

	},
	healerStressedIncPhys					= { 191284, -- Horn of Valor (HoV)

	},
	IncPhys									= { 372794, -- Steel Barrage (RLP)
												372047, -- Steel Barrage (RLP)
												392395, -- Thunder Jaw (RLP)
												395303, -- Thunder Jaw (RLP)
												392394, -- Fire Maw (RLP)
												395292, -- Fire Maw (RLP)
												372858, -- Searing Blows (RLP)
												372859, -- Searing Blows (RLP)
												396991, -- Bestial Roar (AV)
												381683, -- Swift Stab (NO)
												384476, -- Rain of Arrows (NO)
												387826, -- Heavy Slash (NO)
												388801, -- Mortal Strike (NO)
												382836, -- Brutalize (NO)
												384336, -- War Stomp (NO)
												375937, -- Rending Strike (NO)
												388544, -- Barkbreaker (AA)
												376997, -- Savage Peck (AA)
												388911, -- Severing Slash (AA)
												199772, -- Power Attack (HoV)
												193092, -- Bloodletting Sweep (HoV)
												198944, -- Breach Armor (HoV)
												199050, -- Mortal Hew (HoV)
												199210, -- Penetrating Shot (HoV)
												199108, -- Frantic Gore (HoV)
												199151, -- Piercing Horns (HoV)
												196512, -- Claw Frenzy (HoV)
												199177, -- Ferocious Bite (HoV)
												199652, -- Sever (HoV)
												193668, -- Savage Blade (HoV)
												209495, -- Charged Smash (CoS)
												396007, -- Vicious Peck (TJS)
												396018, -- Fit of Rage (TJS)
												397904, -- Setting Sun Kick (TJS)

	},
}

local function InMelee(unitID)
    return A.Bloodthirst:IsInRange(unitID)
end 
InMelee = A.MakeFunctionCachedDynamic(InMelee)

local function HealerStressed()
	 
    local total = 0
	for _, thisUnit in pairs(TeamCache.Friendly.GUIDs) do
		if Unit(thisUnit):HealthPercent() > 75 then
			total = total + 1
		end
	end
	
    return total 
end 

local function MassPull()

	defensive = false 
	for _, thisUnit in pairs(MultiUnits:GetActiveUnitPlates()) do
		if Unit(thisUnit):Health() > Unit(player):HealthMax() * 30 then
			defensive = true
		end
	end
	
    return defensive 

end

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end  

	if A.CanUseHealthstoneOrHealingPotion() then
		return A.Healthstone
	end

    local useRacial = A.GetToggle(1, "Racial")

	local SpellReflectionActive = Unit(player):HasBuffs(A.SpellReflection.ID) > 0
	local ShieldWallActive = Unit(player):HasBuffs(A.ShieldWall.ID) > 0
	local noDefensiveActive = not SpellReflectionActive and not ShieldWallActive
	local healerStressed = HealerStressed()
	local massPull = MassPull()

    if A.RallyingCry:IsReady(player) and MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1 then
        return A.RallyingCry
    end

	if noDefensiveActive then
		if healerStressed then
			if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.healerStressedIncMagic) >= 1 then
				if A.SpellReflection:IsReady(player) then
					return A.SpellReflection
				elseif A.ShieldWall:IsReady(player) then
					return A.ShieldWall
				end
			end
			if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.healerStressedIncPhys) >= 1 then
				if A.ShieldWall:IsReady(player) then
					return A.ShieldWall
				end
			end
		end
		--[[if massPull then
			if A.DampenHarm:IsReady(player) then
				return A.DampenHarm
			elseif A.FortifyingBrew:IsReady(player) then
				return A.FortifyingBrew
			end
		end]]
		if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.IncMagic) >= 1 then
			if A.SpellReflection:IsReady(player) then
				return A.SpellReflection
			elseif A.ShieldWall:IsReady(player) then
				return A.ShieldWall
			end
		end
		if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.IncPhys) >= 1 then
			if A.ShieldWall:IsReady(player) then
				return A.ShieldWall
			end
		end
	end

	if A.BerserkerRage:IsReady(player) and (LoC:Get("FEAR") > 0 or LoC:Get("INCAPACITATE") > 0) then
		return A.BerserkerRage
	end

	if A.WilltoSurvive:IsReady(player) and useRacial and LoC:Get("STUN") > 0 then
		return A.WilltoSurvive
	end

    local ShieldWallHP = A.GetToggle(2, "ShieldWallHP")
    if A.ShieldWall:IsReady(player) and Unit(player):HealthPercent() <= ShieldWallHP then
        return A.ShieldWall
    end

    local BitterImmunityHP = A.GetToggle(2, "BitterImmunityHP")
    if A.BitterImmunity:IsReady(player) and Unit(player):HealthPercent() <= BitterImmunityHP then
        return A.BitterImmunity
    end   

    local LastStandHP = A.GetToggle(2, "LastStandHP")
    if A.LastStand:IsReady(player) and Unit(player):HealthPercent() <= LastStandHP then
        return A.LastStand
    end

    local VictoryRushHP = A.GetToggle(2, "VictoryRushHP")
    if A.VictoryRush:IsReady(player) and Unit(player):HealthPercent() <= VictoryRushHP then
        return A.VictoryRush
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        if useKick and not notInterruptable and A.Pummel:IsReady(unitID, nil, nil, true) then 
            return A.Pummel
        end
        if useCC and A.StormBolt:IsReady(unitID) then 
            return A.StormBolt
        end
        if useCC and A.IntimidatingShout:IsReady(unitID) then 
            return A.IntimidatingShout
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
 
        if useRacial and A.BullRush:AutoRacial(unitID) then 
         return A.BullRush
        end 
    end
end

--Trinkets
local function UseTrinkets(unitID)
	local TrinketType1 = A.GetToggle(2, "TrinketType1")
	local TrinketType2 = A.GetToggle(2, "TrinketType2")
	local TrinketValue1 = A.GetToggle(2, "TrinketValue1")
	local TrinketValue2 = A.GetToggle(2, "TrinketValue2")	

	if A.Trinket1:IsReady(unitID) then
		if TrinketType1 == "Damage" then
			if A.BurstIsON(unitID) and A.IsUnitEnemy(unitID) and InMelee() then
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
			if A.BurstIsON(unitID) and A.IsUnitEnemy(unitID) and InMelee() then
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

A[3] = function(icon, isMulti)
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local TTD = MultiUnits.GetByRangeAreaTTD(10)
    local useRacial = A.GetToggle(1, "Racial")

    local function DamageRotation(unitID)

        local inMelee = A.Slam:IsInRange(unitID)
        -- Defensive
        local SelfDefensive = SelfDefensives()
        if SelfDefensive then 
            return SelfDefensive:Show(icon)
        end 

        -- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end 

        local UseTrinket = UseTrinkets(unitID)
        if UseTrinket and Unit(unitID):GetRange() <= 10 then
            return UseTrinket:Show(icon)
        end    

        if A.Taunt:IsReady(unitID, true) and not Unit(unitID):IsBoss() and not Unit(unitID):IsDummy() and Unit(targettarget):InfoGUID() ~= Unit(player):InfoGUID() and Unit(targettarget):InfoGUID() ~= nil and A.IsUnitFriendly(targettarget) then 
            return A.Taunt:Show(icon)
        end 

        -- actions+=/avatar
        if A.Avatar:IsReady(player) and BurstIsON(unitID) and inMelee and TTD > 15 then
            return A.Avatar:Show(icon)
        end
        -- actions+=/shield_wall,if=talent.immovable_object.enabled&buff.avatar.down

        if BurstIsON(unitID) and useRacial and inMelee and TTD > 15 then
            -- actions+=/blood_fury
            if A.BloodFury:IsReady(player) then
                return A.BloodFury:Show(icon)
            end
            -- actions+=/berserking
            if A.Berserking:IsReady(player) then
                return A.Berserking:Show(icon)
            end
            -- actions+=/arcane_torrent
            if A.ArcaneTorrent:IsReady(player) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- actions+=/lights_judgment
            if A.LightsJudgment:IsReady(unitID) then
                return A.LightsJudgment:Show(icon)
            end
            -- actions+=/fireblood
            if A.Fireblood:IsReady(player) then
                return A.Fireblood:Show(icon)
            end
            -- actions+=/ancestral_call
            if A.AncestralCall:IsReady(player) then
                return A.AncestralCall:Show(icon)
            end
            -- actions+=/bag_of_tricks
            if A.BagofTricks:IsReady(player) then
                return A.BagofTricks:Show(icon)
            end
        end
        -- actions+=/potion,if=buff.avatar.up|buff.avatar.up&target.health.pct<=20
        -- actions+=/ignore_pain,if=target.health.pct>=20&(rage.deficit<=15&cooldown.shield_slam.ready|rage.deficit<=40&cooldown.shield_charge.ready&talent.champions_bulwark.enabled|rage.deficit<=20&cooldown.shield_charge.ready|rage.deficit<=30&cooldown.demoralizing_shout.ready&talent.booming_voice.enabled|rage.deficit<=20&cooldown.avatar.ready|rage.deficit<=45&cooldown.demoralizing_shout.ready&talent.booming_voice.enabled&buff.last_stand.up&talent.unnerving_focus.enabled|rage.deficit<=30&cooldown.avatar.ready&buff.last_stand.up&talent.unnerving_focus.enabled|rage.deficit<=20|rage.deficit<=40&cooldown.shield_slam.ready&buff.violent_outburst.up&talent.heavy_repercussions.enabled&talent.impenetrable_wall.enabled|rage.deficit<=55&cooldown.shield_slam.ready&buff.violent_outburst.up&buff.last_stand.up&talent.unnerving_focus.enabled&talent.heavy_repercussions.enabled&talent.impenetrable_wall.enabled|rage.deficit<=17&cooldown.shield_slam.ready&talent.heavy_repercussions.enabled|rage.deficit<=18&cooldown.shield_slam.ready&talent.impenetrable_wall.enabled),use_off_gcd=1
        if A.IgnorePain:IsReady(player, nil, nil, true) and inMelee then
            if Unit(unitID):HealthPercent() >= 20 and (Player:RageDeficit() <= 15 and A.ShieldSlam:GetCooldown() == 0 or Player:RageDeficit() <= 40 and A.ShieldCharge:GetCooldown() == 0 and A.ChampionsBulwark:IsTalentLearned() or Player:RageDeficit() <= 20 and A.ShieldCharge:GetCooldown() == 0 or Player:RageDeficit() <= 30 and A.DemoralizingShout:GetCooldown() == 0 and A.BoomingVoice:IsTalentLearned() or Player:RageDeficit() <= 20 and A.Avatar:GetCooldown() == 0 or Player:RageDeficit() <= 45 and A.DemoralizingShout:GetCooldown() == 0 and A.BoomingVoice:GetCooldown() == 0 and Unit(player):HasBuffs(A.LastStand.ID) > 0 and A.UnnervingFocus:IsTalentLearned() or Player:RageDeficit() <= 30 and A.Avatar:GetCooldown() == 0 and Unit(player):HasBuffs(A.LastStand.ID) > 0 and A.UnnervingFocus:IsTalentLearned() or Player:RageDeficit() <= 20 or Player:RageDeficit() <= 40 and A.ShieldSlam:GetCooldown() == 0 and Unit(player):HasBuffs(A.ViolentOutburstBuff.ID) > 0 and A.HeavyRepercussions:IsTalentLearned() and A.ImpenetrableWall:IsTalentLearned() or Player:RageDeficit() <= 55 and A.ShieldSlam:GetCooldown() == 0 and Unit(player):HasBuffs(A.ViolentOutburstBuff.ID) > 0 and Unit(player):HasBuffs(A.LastStand.ID) > 0 and A.UnnervingFocus:IsTalentLearned() and A.HeavyRepercussions:IsTalentLearned() and A.ImpenetrableWall:IsTalentLearned() or Player:RageDeficit() <= 17 and A.ShieldSlam:GetCooldown() == 0 and A.HeavyRepercussions:IsTalentLearned() or Player:RageDeficit() <= 18 and A.ShieldSlam:GetCooldown() == 0 and A.ImpenetrableWall:IsTalentLearned()) then
                return A.IgnorePain:Show(icon)
            end
        end
        -- actions+=/last_stand,if=(target.health.pct>=90&talent.unnerving_focus.enabled|target.health.pct<=20&talent.unnerving_focus.enabled)|talent.bolster.enabled
        if A.LastStand:IsReady(player) then
            if (Unit(unitID):HealthPercent() >= 90 and A.UnnervingFocus:IsTalentLearned() or Unit(unitID):HealthPercent() <= 20 and A.UnnervingFocus:IsTalentLearned()) or A.Bolster:IsTalentLearned() then
                return A.LastStand:Show(icon)
            end
        end
        -- actions+=/ravager
        if A.Ravager:IsReady(player) and not isMoving and inMelee and BurstIsON(unitID) and TTD > 15 then
            return A.Ravager:Show(icon)
        end
        -- actions+=/demoralizing_shout,if=talent.booming_voice.enabled
        if A.DemoralizingShout:IsReady(player) and inMelee and not isMoving then
            return A.DemoralizingShout:Show(icon)
        end
        -- actions+=/spear_of_bastion
        if A.SpearofBastion:IsReady(player) and BurstIsON(unitID) and inMelee and not isMoving and TTD > 15 then
            return A.SpearofBastion:Show(icon)
        end
        -- actions+=/thunderous_roar
        if A.ThunderousRoar:IsReady(player) and BurstIsON(unitID) and inMelee and not isMoving and TTD > 15 then
            return A.ThunderousRoar:Show(icon)
        end
        -- actions+=/shockwave,if=talent.sonic_boom.enabled&buff.avatar.up&talent.unstoppable_force.enabled&!talent.rumbling_earth.enabled
        if A.Shockwave:IsReady(player) and inMelee and not isMoving and A.SonicBoom:IsTalentLearned() and Unit(player):HasBuffs(A.Avatar.ID) > 0 and A.UnstoppableForce:IsTalentLearned() and not A.RumblingEarth:IsTalentLearned() then
            return A.Shockwave:Show(icon)
        end
        -- actions+=/shield_charge
        if A.ShieldCharge:IsReady(unitID) then
            return A.ShieldCharge:Show(icon)
        end
        -- actions+=/shield_block,if=buff.shield_block.duration<=18&talent.enduring_defenses.enabled|buff.shield_block.duration<=12
        if A.ShieldBlock:IsReady(player) and A.HeroicThrow:IsInRange(unitID) and (Unit(player):HasBuffs(A.ShieldBlockBuff.ID) <= 18 and A.EnduringDefenses:IsTalentLearned() or Unit(player):HasBuffs(A.ShieldBlockBuff.ID) <= 12) then
            return A.ShieldBlock:Show(icon)
        end

        local function AOE(unitID)
            -- actions.aoe=thunder_clap,if=dot.rend.remains<=1
            if A.ThunderClap:IsReady(player) and Unit(unitID):HasDeBuffs(A.Rend.ID, true) <= 1 then
                return A.ThunderClap:Show(icon)
            end
            -- actions.aoe+=/thunder_clap,if=buff.violent_outburst.up&spell_targets.thunderclap>5&buff.avatar.up&talent.unstoppable_force.enabled
            if A.ThunderClap:IsReady(player) and Unit(player):HasBuffs(A.ViolentOutburstBuff.ID) > 0 and MultiUnits:GetByRange(10, 4) > 5 and Unit(player):HasBuffs(A.Avatar.ID) > 0 and A.UnstoppableForce:IsTalentLearned() then
                return A.ThunderClap:Show(icon)
            end
            -- actions.aoe+=/revenge,if=rage>=70&talent.seismic_reverberation.enabled&spell_targets.revenge>=3
            if A.Revenge:IsReady(player) and Player:Rage() >= 70 and A.SeismicReverberation:IsTalentLearned() then
                return A.Revenge:Show(icon)
            end
            -- actions.aoe+=/shield_slam,if=rage<=60|buff.violent_outburst.up&spell_targets.thunderclap<=4
            if A.ShieldSlam:IsReady(unitID) and (Player:Rage() <= 60 or Unit(player):HasBuffs(A.ViolentOutburstBuff.ID) > 0 and MultiUnits:GetByRange(10, 4) <= 4) then
                return A.ShieldSlam:Show(icon)
            end
            -- actions.aoe+=/thunder_clap
            if A.ThunderClap:IsReady(player) then
                return A.ThunderClap:Show(icon)
            end
            -- actions.aoe+=/revenge,if=rage>=30|rage>=40&talent.barbaric_training.enabled
            if A.Revenge:IsReady(player) and (Player:Rage() >= 30 or Player:Rage() >= 40 and A.BarbaricTraining:IsTalentLearned()) then
                return A.Revenge:Show(icon)
            end     
        end

        local function Generic(unitID)
            -- actions.generic=shield_slam
            if A.ShieldSlam:IsReady(unitID) then
                return A.ShieldSlam:Show(icon)
            end
            -- actions.generic+=/thunder_clap,if=dot.rend.remains<=1&buff.violent_outburst.down
            if A.ThunderClap:IsReady(player) and inMelee and Unit(unitID):HasDeBuffs(A.Rend.ID, true) <= 1 and Unit(player):HasBuffs(A.ViolentOutburstBuff.ID) == 0 then
                return A.ThunderClap:Show(icon)
            end
            -- actions.generic+=/execute,if=buff.sudden_death.up&talent.sudden_death.enabled
            if A.Execute:IsReady(unitID) and Unit(player):HasBuffs(A.SuddenDeath.ID) > 0 then
                return A.Execute:Show(icon)
            end
            -- actions.generic+=/execute,if=spell_targets.revenge=1&(talent.massacre.enabled|talent.juggernaut.enabled)&rage>=50
            if A.Execute:IsReady(unitID) and MultiUnits:GetByRange(10, 4) == 1 and (A.Massacre:IsTalentLearned() or A.Juggernaut:IsTalentLearned()) and Player:Rage() >= 50 then
                return A.Execute:Show(icon)
            end
            -- actions.generic+=/revenge,if=buff.vanguards_determination.down&rage>=40
            if A.Revenge:IsReady(player) and inMelee and Unit(player):HasBuffs(A.VanguardsDetermination.ID) == 0 and Player:Rage() >= 40 then
                return A.Revenge:Show(icon)
            end
            -- actions.generic+=/execute,if=spell_targets.revenge=1&rage>=50
            if A.Execute:IsReady(unitID) and MultiUnits:GetByRange(10, 4) == 1 and Player:Rage() >= 50 then
                return A.Execute:Show(icon)
            end
            -- actions.generic+=/thunder_clap,if=(spell_targets.thunder_clap>1|cooldown.shield_slam.remains&!buff.violent_outburst.up)
            if A.ThunderClap:IsReady(player) and inMelee and (MultiUnits:GetByRange(10, 4) > 1 or A.ShieldSlam:GetCooldown() > A.GetGCD() and Unit(player):HasBuffs(A.ViolentOutburstBuff.ID) == 0) then
                return A.ThunderClap:Show(icon)
            end
            -- actions.generic+=/revenge,if=(rage>=60&target.health.pct>20|buff.revenge.up&target.health.pct<=20&rage<=18&cooldown.shield_slam.remains|buff.revenge.up&target.health.pct>20)|(rage>=60&target.health.pct>35|buff.revenge.up&target.health.pct<=35&rage<=18&cooldown.shield_slam.remains|buff.revenge.up&target.health.pct>35)&talent.massacre.enabled
            if A.Revenge:IsReady(player) and inMelee then
                if (Player:Rage() >= 60 and Unit(unitID):HealthPercent() > 20 or Unit(player):HasBuffs(A.Revenge.ID) > 0 and Unit(unitID):HealthPercent() <= 20 and Player:Rage() <= 18 and A.ShieldSlam:GetCooldown() > 0 or Unit(player):HasBuffs(A.Revenge.ID) > 0 and Unit(unitID):HealthPercent() > 20) or (Player:Rage() >= 60 and Unit(unitID):HealthPercent() > 35 or Unit(player):HasBuffs(A.Revenge.ID) > 0 and Unit(unitID):HealthPercent() <= 35 and Player:Rage() <= 18 and A.ShieldSlam:GetCooldown() > 0 or Unit(player):HasBuffs(A.Revenge.ID) > 0 and Unit(unitID):HealthPercent() > 35) and A.Massacre:IsTalentLearned() then
                    return A.Revenge:Show(icon)
                end
            end
            -- actions.generic+=/execute,if=spell_targets.revenge=1
            if A.Execute:IsReady(unitID) and MultiUnits:GetByRange(10, 4) == 1 then
                return A.Execute:Show(icon)
            end
            -- actions.generic+=/revenge
            if A.Revenge:IsReady(player) and inMelee then
                return A.Revenge:Show(icon)
            end
            -- actions.generic+=/thunder_clap,if=(spell_targets.thunder_clap>=1|cooldown.shield_slam.remains&buff.violent_outburst.up)
            if A.ThunderClap:IsReady(player) and inMelee and (MultiUnits:GetByRange(10, 4) >= 1 or A.ShieldSlam:GetCooldown() > 0 and Unit(player):HasBuffs(A.ViolentOutburstBuff.ID) > 0) then
                return A.ThunderClap:Show(icon)
            end
            -- actions.generic+=/devastate
            if A.Devastate:IsReady(unitID) then
                return A.Devastate:Show(icon)
            end
        end

        if MultiUnits:GetByRange(10, 4) > 2 then
            return AOE(unitID)  
            else return Generic(unitID)
        end

    end

    -- Target  
	if A.IsUnitEnemy(target) then 
		unitID = target 
		if DamageRotation(unitID) then 
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