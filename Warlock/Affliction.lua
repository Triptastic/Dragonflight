--#####################################
--##### TRIP'S AFFLICTION WARLOCK #####
--#####################################

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

Action[ACTION_CONST_WARLOCK_AFFLICTION] = {
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

    EyeofKilrogg   = Action.Create({ Type = "Spell", ID = 126 }),
    Corruption     = Action.Create({ Type = "Spell", ID = 172 }),
    Immolate       = Action.Create({ Type = "Spell", ID = 348 }),
    ShadowBolt     = Action.Create({ Type = "Spell", ID = 686 }),
    SummonImp= Action.Create({ Type = "Spell", ID = 688, Texture = 111859 }),
    SummonFelhunter= Action.Create({ Type = "Spell", ID = 691 }),
    SummonVoidwalker= Action.Create({ Type = "Spell", ID = 697 }),
    RitualofSummoning= Action.Create({ Type = "Spell", ID = 698 }),
    CurseofWeakness= Action.Create({ Type = "Spell", ID = 702 }),
    HealthFunnel   = Action.Create({ Type = "Spell", ID = 755 }),
    Agony          = Action.Create({ Type = "Spell", ID = 980 }),
    SubjugateDemon = Action.Create({ Type = "Spell", ID = 1098 }),
    Firebolt= Action.Create({ Type = "Spell", ID = 3110 }),
    ConsumingShadows= Action.Create({ Type = "Spell", ID = 3716 }),
    Fear           = Action.Create({ Type = "Spell", ID = 5782 }),
    CreateHealthstone= Action.Create({ Type = "Spell", ID = 6201 }),
    Seduction= Action.Create({ Type = "Spell", ID = 6358 }),
    Whiplash= Action.Create({ Type = "Spell", ID = 6360 }),
    LashofPain= Action.Create({ Type = "Spell", ID = 7814 }),
    LesserInvisibility= Action.Create({ Type = "Spell", ID = 7870 }),
    Suffering= Action.Create({ Type = "Spell", ID = 17735 }),
    ShadowBulwark= Action.Create({ Type = "Spell", ID = 17767 }),
    Immolation     = Action.Create({ Type = "Spell", ID = 19483 }),
    DevourMagic= Action.Create({ Type = "Spell", ID = 19505 }),
    SpellLock= Action.Create({ Type = "Spell", ID = 19647 }),
    SpellLockSac= Action.Create({ Type = "Spell", ID = 132409 }),
    Soulstone      = Action.Create({ Type = "Spell", ID = 20707 }),
    Incinerate     = Action.Create({ Type = "Spell", ID = 29722 }),
    SummonFelguard= Action.Create({ Type = "Spell", ID = 30146 }),
    Pursuit= Action.Create({ Type = "Spell", ID = 30151 }),
    LegionStrike= Action.Create({ Type = "Spell", ID = 30213 }),
    ShadowBite= Action.Create({ Type = "Spell", ID = 54049 }),
    DoomBolt       = Action.Create({ Type = "Spell", ID = 85692 }),
    Felstorm= Action.Create({ Type = "Spell", ID = 89751 }),
    AxeToss= Action.Create({ Type = "Spell", ID = 89766 }),
    Flee= Action.Create({ Type = "Spell", ID = 89792 }),
    SingeMagic= Action.Create({ Type = "Spell", ID = 89808 }),
    UnendingResolve= Action.Create({ Type = "Spell", ID = 104773 }),
    HandofGuldan   = Action.Create({ Type = "Spell", ID = 105174 }),
    ThreateningPresence= Action.Create({ Type = "Spell", ID = 112042 }),
    CommandDemon   = Action.Create({ Type = "Spell", ID = 119898 }),
    Cripple        = Action.Create({ Type = "Spell", ID = 170995 }),
    BurningPresence= Action.Create({ Type = "Spell", ID = 171011 }),
    Seethe= Action.Create({ Type = "Spell", ID = 171014 }),
    MeteorStrike   = Action.Create({ Type = "Spell", ID = 171017 }),
    TorchMagic= Action.Create({ Type = "Spell", ID = 171021 }),
    ShadowLock= Action.Create({ Type = "Spell", ID = 171138 }),
    DrainLife      = Action.Create({ Type = "Spell", ID = 234153 }),
    RitualofDoom   = Action.Create({ Type = "Spell", ID = 342601 }),
    SummonSayaad   = Action.Create({ Type = "Spell", ID = 366222 }),
    Doom           = Action.Create({ Type = "Spell", ID = 603 }),
    Banish         = Action.Create({ Type = "Spell", ID = 710 }),
    SummonInfernal= Action.Create({ Type = "Spell", ID = 1122 }),
    HowlofTerror   = Action.Create({ Type = "Spell", ID = 5484 }),
    RainofFire     = Action.Create({ Type = "Spell", ID = 5740 }),
    SoulFire       = Action.Create({ Type = "Spell", ID = 6353 }),
    MortalCoil     = Action.Create({ Type = "Spell", ID = 6789 }),
    Shadowburn     = Action.Create({ Type = "Spell", ID = 17877 }),
    Conflagrate    = Action.Create({ Type = "Spell", ID = 17962 }),
    ConflagrateDebuff    = Action.Create({ Type = "Spell", ID = 265931 }),
    SeedofCorruption= Action.Create({ Type = "Spell", ID = 27243 }),
    Shadowfury     = Action.Create({ Type = "Spell", ID = 30283 }),
    ShadowEmbrace  = Action.Create({ Type = "Spell", ID = 32388 }),
    ShadowEmbraceDebuff  = Action.Create({ Type = "Spell", ID = 32390 }),
    Haunt          = Action.Create({ Type = "Spell", ID = 48181 }),
    SiphonLife     = Action.Create({ Type = "Spell", ID = 63106 }),
    Havoc          = Action.Create({ Type = "Spell", ID = 80240 }),
    CallDreadstalkers= Action.Create({ Type = "Spell", ID = 104316 }),
    SoulLink       = Action.Create({ Type = "Spell", ID = 108415 }),
    DarkPact       = Action.Create({ Type = "Spell", ID = 108416 }),
    GrimoireofSacrifice= Action.Create({ Type = "Spell", ID = 108503 }),
    Nightfall      = Action.Create({ Type = "Spell", ID = 108558 }),
    NightfallBuff      = Action.Create({ Type = "Spell", ID = 264571 }),
    BurningRush    = Action.Create({ Type = "Spell", ID = 111400 }),
    DemonicGateway = Action.Create({ Type = "Spell", ID = 111771 }),
    GrimoireFelguard= Action.Create({ Type = "Spell", ID = 111898 }),
    ChaosBolt      = Action.Create({ Type = "Spell", ID = 116858 }),
    Cataclysm      = Action.Create({ Type = "Spell", ID = 152108 }),
    GrimoireofSynergy= Action.Create({ Type = "Spell", ID = 171975 }),
    WritheinAgony  = Action.Create({ Type = "Spell", ID = 196102 }),
    AbsoluteCorruption= Action.Create({ Type = "Spell", ID = 196103 }),
    SowtheSeeds    = Action.Create({ Type = "Spell", ID = 196226 }),
    Implosion      = Action.Create({ Type = "Spell", ID = 196277 }),
    Backdraft      = Action.Create({ Type = "Spell", ID = 196406 }),
    BackdraftBuff      = Action.Create({ Type = "Spell", ID = 117828 }),
    FireandBrimstone= Action.Create({ Type = "Spell", ID = 196408 }),
    Eradication    = Action.Create({ Type = "Spell", ID = 196412 }),
    EradicationDebuff    = Action.Create({ Type = "Spell", ID = 196414 }),
    ChannelDemonfire= Action.Create({ Type = "Spell", ID = 196447 }),
    SoulFlame      = Action.Create({ Type = "Spell", ID = 199471 }),
    HarvesterofSouls= Action.Create({ Type = "Spell", ID = 201424 }),
    DemonicCalling = Action.Create({ Type = "Spell", ID = 205145 }),
    ReverseEntropy = Action.Create({ Type = "Spell", ID = 205148 }),
    PhantomSingularity= Action.Create({ Type = "Spell", ID = 205179 }),
    SummonDarkglare= Action.Create({ Type = "Spell", ID = 205180 }),
    RoaringBlaze   = Action.Create({ Type = "Spell", ID = 205184 }),
    SoulConduit    = Action.Create({ Type = "Spell", ID = 215941 }),
    DemonSkin      = Action.Create({ Type = "Spell", ID = 219272 }),
    ImprovedConflagrate= Action.Create({ Type = "Spell", ID = 231793 }),
    CreepingDeath  = Action.Create({ Type = "Spell", ID = 264000 }),
    SoulStrike     = Action.Create({ Type = "Spell", ID = 264057 }),
    Dreadlash      = Action.Create({ Type = "Spell", ID = 264078 }),
    SummonVilefiend= Action.Create({ Type = "Spell", ID = 264119 }),
    PowerSiphon    = Action.Create({ Type = "Spell", ID = 264130 }),
    Demonbolt      = Action.Create({ Type = "Spell", ID = 264178 }),
    Darkfury       = Action.Create({ Type = "Spell", ID = 264874 }),
    SummonDemonicTyrant= Action.Create({ Type = "Spell", ID = 265187 }),
    RainofChaos    = Action.Create({ Type = "Spell", ID = 266086 }),
    RainofChaosBuff    = Action.Create({ Type = "Spell", ID = 266087 }),
    InternalCombustion= Action.Create({ Type = "Spell", ID = 266134 }),
    FromtheShadows = Action.Create({ Type = "Spell", ID = 267170 }),
    DemonicStrength= Action.Create({ Type = "Spell", ID = 267171 }),
    BilescourgeBombers= Action.Create({ Type = "Spell", ID = 267211 }),
    SacrificedSouls= Action.Create({ Type = "Spell", ID = 267214 }),
    InnerDemons    = Action.Create({ Type = "Spell", ID = 267216 }),
    NetherPortal   = Action.Create({ Type = "Spell", ID = 267217 }),
    DemonicCircle  = Action.Create({ Type = "Spell", ID = 268358 }),
    Inferno        = Action.Create({ Type = "Spell", ID = 270545 }),
    VileTaint      = Action.Create({ Type = "Spell", ID = 278350 }),
    DemonicEmbrace = Action.Create({ Type = "Spell", ID = 288843 }),
    UnstableAffliction= Action.Create({ Type = "Spell", ID = 316099 }),
    XavianTeachings= Action.Create({ Type = "Spell", ID = 317031 }),
    StrengthofWill = Action.Create({ Type = "Spell", ID = 317138 }),
    MaleficRapture = Action.Create({ Type = "Spell", ID = 324536 }),
    AmplifyCurse   = Action.Create({ Type = "Spell", ID = 328774 }),
    FelDomination  = Action.Create({ Type = "Spell", ID = 333889 }),
    InevitableDemise= Action.Create({ Type = "Spell", ID = 334319 }),
    InevitableDemiseBuff= Action.Create({ Type = "Spell", ID = 334320 }),
    SoulboundTyrant= Action.Create({ Type = "Spell", ID = 334585 }),
    Shadowflame    = Action.Create({ Type = "Spell", ID = 384069 }),
    TeachingsoftheBlackHarvest= Action.Create({ Type = "Spell", ID = 385881 }),
    Soulburn       = Action.Create({ Type = "Spell", ID = 385899 }),
    CursesofEnfeeblement= Action.Create({ Type = "Spell", ID = 386105 }),
    FiendishStride = Action.Create({ Type = "Spell", ID = 386110 }),
    FelPact        = Action.Create({ Type = "Spell", ID = 386113 }),
    FelArmor       = Action.Create({ Type = "Spell", ID = 386124 }),
    AnnihilanTraining= Action.Create({ Type = "Spell", ID = 386174 }),
    DemonicKnowledge= Action.Create({ Type = "Spell", ID = 386185 }),
    CarnivorousStalkers= Action.Create({ Type = "Spell", ID = 386194 }),
    FelandSteel    = Action.Create({ Type = "Spell", ID = 386200 }),
    SummonSoulkeeper= Action.Create({ Type = "Spell", ID = 386244 }),
    InquisitorsGaze= Action.Create({ Type = "Spell", ID = 386344 }),
    AccruedVitality= Action.Create({ Type = "Spell", ID = 386613 }),
    DemonicFortitude= Action.Create({ Type = "Spell", ID = 386617 }),
    DesperatePact  = Action.Create({ Type = "Spell", ID = 386619 }),
    SweetSouls     = Action.Create({ Type = "Spell", ID = 386620 }),
    Lifeblood      = Action.Create({ Type = "Spell", ID = 386646 }),
    Nightmare      = Action.Create({ Type = "Spell", ID = 386648 }),
    GreaterBanish  = Action.Create({ Type = "Spell", ID = 386651 }),
    DarkAccord     = Action.Create({ Type = "Spell", ID = 386659 }),
    IchorofDevils  = Action.Create({ Type = "Spell", ID = 386664 }),
    FrequentDonor  = Action.Create({ Type = "Spell", ID = 386686 }),
    GrimFeast      = Action.Create({ Type = "Spell", ID = 386689 }),
    PandemicInvocation= Action.Create({ Type = "Spell", ID = 386759 }),
    Guillotine     = Action.Create({ Type = "Spell", ID = 386833 }),
    DemonicInspiration= Action.Create({ Type = "Spell", ID = 386858 }),
    WrathfulMinion = Action.Create({ Type = "Spell", ID = 386864 }),
    AgonizingCorruption= Action.Create({ Type = "Spell", ID = 386922 }),
    SoulSwap       = Action.Create({ Type = "Spell", ID = 386951 }),
    WitheringBolt  = Action.Create({ Type = "Spell", ID = 386976 }),
    SacrolashsDarkStrike= Action.Create({ Type = "Spell", ID = 386986 }),
    SoulRot= Action.Create({ Type = "Spell", ID = 386997 }),
    DarkHarvest    = Action.Create({ Type = "Spell", ID = 387016 }),
    WrathofConsumption= Action.Create({ Type = "Spell", ID = 387065 }),
    SoulTap        = Action.Create({ Type = "Spell", ID = 387073 }),
    TormentedCrescendo= Action.Create({ Type = "Spell", ID = 387075 }),
    TormentedCrescendoBuff= Action.Create({ Type = "Spell", ID = 387079 }),
    GrandWarlocksDesign= Action.Create({ Type = "Spell", ID = 387084 }),
    ImprovedImmolate= Action.Create({ Type = "Spell", ID = 387093 }),
    Pyrogenics     = Action.Create({ Type = "Spell", ID = 387095 }),
    Ruin           = Action.Create({ Type = "Spell", ID = 387103 }),
    ConflagrationofChaos= Action.Create({ Type = "Spell", ID = 387108 }),
    BurntoAshes    = Action.Create({ Type = "Spell", ID = 387153 }),
    BurntoAshesBuff    = Action.Create({ Type = "Spell", ID = 387154 }),
    RitualofRuin   = Action.Create({ Type = "Spell", ID = 387156 }),
    RitualofRuinBuff   = Action.Create({ Type = "Spell", ID = 387157 }),
    AvatarofDestruction= Action.Create({ Type = "Spell", ID = 387159 }),
    MasterRitualist= Action.Create({ Type = "Spell", ID = 387165 }),
    RagingDemonfire= Action.Create({ Type = "Spell", ID = 387166 }),
    DiabolicEmbers = Action.Create({ Type = "Spell", ID = 387173 }),
    Decimation     = Action.Create({ Type = "Spell", ID = 387176 }),
    SeizedVitality = Action.Create({ Type = "Spell", ID = 387250 }),
    AshenRemains   = Action.Create({ Type = "Spell", ID = 387252 }),
    Flashpoint     = Action.Create({ Type = "Spell", ID = 387259 }),
    MalevolentVisionary= Action.Create({ Type = "Spell", ID = 387273 }),
    ChaosIncarnate = Action.Create({ Type = "Spell", ID = 387275 }),
    PowerOverwhelming= Action.Create({ Type = "Spell", ID = 387279 }),
    HauntedSoul    = Action.Create({ Type = "Spell", ID = 387301 }),
    ShadowsBite    = Action.Create({ Type = "Spell", ID = 387322 }),
    FelMight       = Action.Create({ Type = "Spell", ID = 387338 }),
    BloodboundImps = Action.Create({ Type = "Spell", ID = 387349 }),
    CrashingChaos  = Action.Create({ Type = "Spell", ID = 387355 }),
    Backlash       = Action.Create({ Type = "Spell", ID = 387384 }),
    DreadCalling   = Action.Create({ Type = "Spell", ID = 387391 }),
    DemonicMeteor  = Action.Create({ Type = "Spell", ID = 387396 }),
    FelSunder      = Action.Create({ Type = "Spell", ID = 387399 }),
    MadnessoftheAzjAqir= Action.Create({ Type = "Spell", ID = 387400 }),
    FelCovenant    = Action.Create({ Type = "Spell", ID = 387432 }),
    ImpGangBoss    = Action.Create({ Type = "Spell", ID = 387445 }),
    InfernalBrand  = Action.Create({ Type = "Spell", ID = 387475 }),
    KazaaksFinalCurse= Action.Create({ Type = "Spell", ID = 387483 }),
    RippedthroughthePortal= Action.Create({ Type = "Spell", ID = 387485 }),
    HoundsofWar    = Action.Create({ Type = "Spell", ID = 387488 }),
    AntoranArmaments= Action.Create({ Type = "Spell", ID = 387494 }),
    Mayhem         = Action.Create({ Type = "Spell", ID = 387506 }),
    Pandemonium    = Action.Create({ Type = "Spell", ID = 387509 }),
    CryHavoc       = Action.Create({ Type = "Spell", ID = 387522 }),
    NerzhulsVolition= Action.Create({ Type = "Spell", ID = 387526 }),
    PactoftheImpMother= Action.Create({ Type = "Spell", ID = 387541 }),
    InfernalCommand= Action.Create({ Type = "Spell", ID = 387549 }),
    RollingHavoc   = Action.Create({ Type = "Spell", ID = 387569 }),
    GuldansAmbition= Action.Create({ Type = "Spell", ID = 387578 }),
    TheExpendables = Action.Create({ Type = "Spell", ID = 387600 }),
    StolenPower    = Action.Create({ Type = "Spell", ID = 387602 }),
    TeachingsoftheSatyr= Action.Create({ Type = "Spell", ID = 387972 }),
    DimensionalRift= Action.Create({ Type = "Spell", ID = 387976 }),
    DrainSoul      = Action.Create({ Type = "Spell", ID = 388667 }),
    ExplosivePotential= Action.Create({ Type = "Spell", ID = 388827 }),
    ScaldingFlames = Action.Create({ Type = "Spell", ID = 388832 }),
    ResoluteBarrier= Action.Create({ Type = "Spell", ID = 389359 }),
    FelSynergy     = Action.Create({ Type = "Spell", ID = 389367 }),
    ProfaneBargain = Action.Create({ Type = "Spell", ID = 389576 }),
    DemonicResilience= Action.Create({ Type = "Spell", ID = 389590 }),
    AbyssWalker    = Action.Create({ Type = "Spell", ID = 389609 }),
    GorefiendsResolve= Action.Create({ Type = "Spell", ID = 389623 }),
    SoulEatersGluttony= Action.Create({ Type = "Spell", ID = 389630 }),
    MaleficAffliction= Action.Create({ Type = "Spell", ID = 389761 }),
    DoomBlossom    = Action.Create({ Type = "Spell", ID = 389764 }),
    DreadTouch     = Action.Create({ Type = "Spell", ID = 389775 }),
    DreadTouchDebuff     = Action.Create({ Type = "Spell", ID = 389868 }),
    GrimReach      = Action.Create({ Type = "Spell", ID = 389992 }),
    ReignofTyranny = Action.Create({ Type = "Spell", ID = 390173 }),
    GrimoireofSacrificeBuff = Action.Create({ Type = "Spell", ID = 196099 }),     
    InquisitorsGazeBuff = Action.Create({ Type = "Spell", ID = 388068 }),   
    Blasphemy = Action.Create({ Type = "Spell", ID = 387161 }),   
    MadnessCB = Action.Create({ Type = "Spell", ID = 387409 }),   
    MadnessROF = Action.Create({ Type = "Spell", ID = 387413 }),  
    Healthstone     = Action.Create({ Type = "Item", ID = 5512 }),	
    VileTaintDebuff     = Action.Create({ Type = "Spell", ID = 386931 }),	
    PowerInfusion     = Action.Create({ Type = "Spell", ID = 10060 }),
    CurseofTongues     = Action.Create({ Type = "Spell", ID = 1714 }),
    
}

local A = setmetatable(Action[ACTION_CONST_WARLOCK_AFFLICTION], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
local target = "target"
local pet = "pet"

Pet:AddActionsSpells(265, {
	A.LashofPain.ID,
	A.Whiplash.ID,
	A.ShadowBite.ID, 
}, true)

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
    TargetDelay                             = 0,
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
    scaryDebuffs                            = { 394917, --Leaping Flames
                                                391686, --Conductive Mark
    },
    curseOfTongues                          = { 131318, -- Elder Leaxa
                                                133835, -- Feral Bloodswarmer
    },
    curseofWeakness                         = {

    },
}

local function SelfDefensives()

    local defensiveActive = Unit(player):HasBuffs(A.DarkPact.ID) > 0 or Unit(player):HasBuffs(A.UnendingResolve.ID) > 0
    local isMoving = A.Player:IsMoving()

    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end  

	if A.CanUseHealthstoneOrHealingPotion() then
        if A.Soulburn:IsReady(player) then
            return A.Soulburn
        end
		return A.Healthstone
	end

    if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1 or Unit(player):HasDeBuffs(Temp.scaryDebuffs) > 0 and not defensiveActive then
        if A.DarkPact:IsReady(player) and Unit(player):HealthPercent() >= 50 then
            return A.DarkPact
        end
        if A.UnendingResolve:IsReady(player) then
            return A.UnendingResolve
        end
    end

    local UnendingResolveHP = A.GetToggle(2, "UnendingResolveHP")
    if A.UnendingResolve:IsReady(player) and Unit(player):HealthPercent() <= UnendingResolveHP then
        return A.UnendingResolve
    end

    local FelPactHP = A.GetToggle(2, "FelPactHP")
    if A.FelPact:IsReady(player) and Unit(player):HealthPercent() <= FelPactHP then
        return A.FelPact
    end

    local MortalCoilHP = A.GetToggle(2, "MortalCoilHP")
    if A.MortalCoil:IsReady(unitID) and Unit(player):HealthPercent() <= MortalCoilHP then
        return A.MortalCoil
    end

    local DrainLifeHP = A.GetToggle(2, "DrainLifeHP")
    if A.DrainLife:IsReady(unitID) and Unit(player):HealthPercent() <= DrainLifeHP and not isMoving then
        return A.DrainLife
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        -- Silence
        if useKick and not notInterruptable and A.SpellLockSac:IsReady(unitID, nil, nil, true) then 
            return A.SpellLockSac
        end

        if useCC and A.MortalCoil:IsReady(unitID) and castRemainsTime > A.Banish:GetSpellCastTime() and not Unit(unitID):IsBoss() then 
            return A.MortalCoil
        end

        if useCC and A.Banish:IsReady(unitID) and castRemainsTime > A.Banish:GetSpellCastTime() and not Unit(unitID):IsBoss() and (Unit(unitID):CreatureType() == "Demon" or Unit(unitID):CreatureType() == "Aberration" or Unit(unitID):CreatureType() == "Elemental") then 
            return A.Banish
        end

        if useCC and A.Fear:IsReady(unitID) and castRemainsTime > A.Fear:GetSpellCastTime() and not Unit(unitID):IsBoss() then 
            return A.Fear
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

local function Purge(unitID)

    if A.DevourMagic:IsReady(unitID) and (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) then 
		return A.DevourMagic
	end 

end

local function UseTrinkets(unitID)
	local TrinketType1 = A.GetToggle(2, "TrinketType1")
	local TrinketType2 = A.GetToggle(2, "TrinketType2")
	local TrinketValue1 = A.GetToggle(2, "TrinketValue1")
	local TrinketValue2 = A.GetToggle(2, "TrinketValue2")	

	if A.Trinket1:IsReady(player) then
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

	if A.Trinket2:IsReady(player) then
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

local function HandlePetChoice()
    local petChoices = {
        IMP = A.SummonImp,
        VOIDWALKER = A.SummonVoidwalker,
        FELHUNTER = A.SummonFelhunter,
        SAYAAD = A.SummonSayaad,
        FELGUARD = A.SummonFelguard,
    }
    local choice = Action.GetToggle(2, "PetChoice")
    local currentSummon = petChoices[choice]
    if currentSummon:IsReady(player) then
        return currentSummon
    end
end

local function ActiveEnemies()

    local spells = {A.ShadowBite.ID, A.Whiplash.ID, A.LegionStrike.ID}
    local aoeDetection = A.GetToggle(2, "aoeDetection")

    for _, spell in pairs(spells) do
        if Pet:IsSpellKnown(spell) and aoeDetection == "Pet" then
            return Pet:GetInRange(spell)
        else return MultiUnits:GetActiveEnemies()
        end
    end

end

local function PredSoulShards()

    incShards = 0
    currentShards = Player:SoulShards()

    if Unit(player):IsCasting() == A.SeedofCorruption:Info() then
        incShards = -1
    elseif Unit(player):IsCasting() == A.VileTaint:Info() then
        incShards = -1
    elseif Unit(player):IsCasting() == A.MaleficRapture:Info() and Unit(player):HasBuffs(A.TormentedCrescendoBuff.ID) == 0 then
        incShards = -1
    end

    predictedShards = currentShards + incShards
    
    return predictedShards

end

function CurseCheck(npcID, npcIDList)
    for _, id in ipairs(npcIDList) do
        if id == npcID then
            return true
        end
    end
    return false
end


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving() or A.Player:IsFalling()
    local inCombat = Unit(player):CombatTime() > 0
    local useAoE = A.GetToggle(2, "AoE")
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local activeEnemies = ActiveEnemies()
    local useRacial = A.GetToggle(1, "Racial")
    local soulShards = PredSoulShards()
    local TTD = MultiUnits.GetByRangeAreaTTD(40)
    local darkglareActive = Player:GetTotemTimeLeft(1)
    local totemName = select(2, Player:GetTotemInfo(1))
    local UAActive = Player:GetDeBuffsUnitCount(A.UnstableAffliction.ID) >= 1
    local seedActive = Player:GetDeBuffsUnitCount(A.SeedofCorruption.ID) >= 1
    local maxAgony = Player:GetDeBuffsUnitCount(A.Agony.ID) >= 5
    local maxSiphonLife = Player:GetDeBuffsUnitCount(A.Agony.ID) >= 3
    local autoDOT = A.GetToggle(2, "autoDOT")
    local isDrainingSoul = Player:IsChanneling() == A.DrainSoul:Info()

    if Temp.TargetDelay > 0 then
        Temp.TargetDelay = Temp.TargetDelay - 1
    end

    Player:AddTier("Tier29", { 200327, 200326, 200328, 200324, 200329, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

    -- actions.precombat+=/summon_pet
    local summonPet = HandlePetChoice()
    if summonPet and (not Unit(pet):IsExists() or Unit(pet):IsDead()) and Unit(player):HasBuffs(A.GrimoireofSacrificeBuff.ID) == 0 then
        if (inCombat or A.GrimoireofSacrifice:IsTalentLearned()) and A.FelDomination:IsReady(player) then
            return A.FelDomination:Show(icon)
        end
        if not isMoving then
            return summonPet:Show(icon)
        end
    end

    if A.GrimoireofSacrifice:IsReady(player, nil, nil, true) and Unit(pet):IsExists() and not isMoving then
        return A.GrimoireofSacrifice:Show(icon)
    end

    local HealthFunnelHP = A.GetToggle(2, "HealthFunnelHP")
    if A.HealthFunnel:IsReady(player) and Unit(pet):HealthPercent() <= HealthFunnelHP and Unit(pet):IsExists() and not Unit(pet):IsDead() then
        return A.HealthFunnel:Show(icon)
    end

    local function EnemyRotation(unitID)
        local npcID = select(6, Unit(unitID):InfoGUID())	
        local useBurst = A.BurstIsON(unitID)
        local worthDoTing = Unit(unitID):TimeToDie() > 7
        local inRange = A.ShadowBolt:IsInRange(unitID)
        if inRange and (Unit(player):IsCastingRemains() < 0.5 or Player:IsChanneling() == A.DrainSoul:Info()) then 
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

            local DoPurge = Purge(unitID)
            if DoPurge then 
                return DoPurge:Show(icon)
            end	

            if Unit(unitID):IsExplosives() then
                if A.DrainLife:IsReady(unitID) then
                    return A.DrainLife:Show(icon)
                end
            end

            if not inCombat and not Unit(player):IsCasting() then
                -- actions.precombat+=/variable,name=cleave_apl,default=0,op=reset
                -- actions.precombat+=/grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled

                -- actions.precombat+=/seed_of_corruption,if=spell_targets.seed_of_corruption_aoe>3
                if A.SeedofCorruption:IsReady(unitID, nil, nil, true) and useAoE and activeEnemies > 3 and Unit(player):IsCasting() ~= A.SeedofCorruption:Info() and not seedActive and not isMoving and soulShards >= 1 then
                    return A.SeedofCorruption:Show(icon)
                end
                -- actions.precombat+=/haunt
                if A.Haunt:IsReady(unitID, nil, nil, true) and Unit(player):IsCasting() ~= A.Haunt:Info() and not isMoving then
                    return A.Haunt:Show(icon)
                end
                -- actions.precombat+=/unstable_affliction,if=!talent.soul_swap
                if A.UnstableAffliction:IsReady(unitID) and not A.SoulSwap:IsTalentLearned() and not UAActive and Unit(player):IsCasting() ~= A.UnstableAffliction:Info() and not isMoving then
                    return A.UnstableAffliction:Show(icon)
                end
                -- actions.precombat+=/shadow_bolt
                if A.ShadowBolt:IsReady(unitID, nil, nil, true) and not A.DrainSoul:IsTalentLearned() and Unit(player):IsCasting() ~= A.ShadowBolt:Info() and (not isMoving or Unit(player):HasBuffs(A.NightfallBuff.ID) > 0) then
                    return A.ShadowBolt:Show(icon)
                end
            end

            --Curses
            if CurseCheck(npcID, Temp.curseOfTongues) then
                if A.CurseofTongues:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.CurseofTongues.ID) == 0 and Unit(unitID):HasDeBuffs(A.CurseofWeakness, true) == 0 then
                    return A.CurseofTongues:Show(icon)
                end
            end
            if CurseCheck(npcID, Temp.curseofWeakness) then
                if A.CurseofWeakness:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.CurseofWeakness.ID) == 0 and Unit(unitID):HasDeBuffs(A.CurseofTongues.ID, true) == 0 then
                    return A.CurseofWeakness:Show(icon)
                end
            end


            --VARIABLES
            -- actions.variables=variable,name=ps_up,op=set,value=dot.phantom_singularity.ticking|!talent.phantom_singularity
            local ps_up = Unit(unitID):HasDeBuffs(A.PhantomSingularity.ID, true) > 0 or not A.PhantomSingularity:IsTalentLearned()
            -- actions.variables+=/variable,name=vt_up,op=set,value=dot.vile_taint_dot.ticking|!talent.vile_taint
            local vt_up = Unit(unitID):HasDeBuffs(A.VileTaintDebuff.ID, true) > 0 or not A.VileTaint:IsTalentLearned()
            -- actions.variables+=/variable,name=sr_up,op=set,value=dot.soul_rot.ticking|!talent.soul_rot
            local sr_up = Unit(unitID):HasDeBuffs(A.SoulRot.ID, true) > 0 or not A.SoulRot:IsTalentLearned()
            -- actions.variables+=/variable,name=cd_dots_up,op=set,value=variable.ps_up&variable.vt_up&variable.sr_up
            local cd_dots_up = ps_up and vt_up and sr_up
            -- actions.variables+=/variable,name=has_cds,op=set,value=talent.phantom_singularity|talent.vile_taint|talent.soul_rot|talent.summon_darkglare
            local has_cds = A.PhantomSingularity:IsTalentLearned() or A.VileTaint:IsTalentLearned() or A.SoulRot:IsTalentLearned() or A.SummonDarkglare:IsTalentLearned()
            -- actions.variables+=/variable,name=cds_active,op=set,value=!variable.has_cds|(pet.darkglare.active|variable.cd_dots_up|buff.power_infusion.react)
            local cds_active = not has_cds or (darkglareActive or cd_dots_up or Unit(player):HasBuffs(A.PowerInfusion.ID) > 0)
           

            --ogcd
            if useBurst then
            -- actions.ogcd=potion,if=variable.cds_active
                if useRacial and cds_active then
                 -- actions.ogcd+=/berserking,if=variable.cds_active
                    if A.Berserking:IsReady(player, nil, nil, true) then
                        return A.Berserking:Show(icon)
                    end
                    -- actions.ogcd+=/blood_fury,if=variable.cds_active
                    if A.BloodFury:IsReady(player, nil, nil, true) then
                        return A.BloodFury:Show(icon)
                    end
                    -- actions.ogcd+=/fireblood,if=variable.cds_active
                    if A.Fireblood:IsReady(player, nil, nil, true) then
                        return A.Fireblood:Show(icon)
                    end
                    -- actions.ogcd+=/ancestral_call,if=variable.cds_active  
                    if A.AncestralCall:IsReady(player, nil, nil, true) then
                        return A.AncestralCall:Show(icon)
                    end          
                end
            end

            --items
            local UseTrinket = UseTrinkets(unitID)
            if UseTrinket and not isMoving then
                return UseTrinket:Show(icon)
            end 

            -- actions+=/call_action_list,name=cleave,if=active_enemies!=1&active_enemies<4|variable.cleave_apl
            if activeEnemies > 1 and activeEnemies < 4 then

                -- actions.cleave+=/malefic_rapture,if=soul_shard=5
                if A.MaleficRapture:IsReady(player, nil, nil, true) and soulShards == 5 and UAActive and not isMoving then
                    return A.MaleficRapture:Show(icon)
                end
                -- actions.cleave+=/haunt
                if A.Haunt:IsReady(unitID, nil, nil, true) and not isMoving and Unit(player):IsCasting() ~= A.Haunt:Info() then
                    return A.Haunt:Show(icon)
                end
                -- actions.cleave+=/unstable_affliction,if=remains<5
                if A.UnstableAffliction:IsReady(unitID, nil, nil, true) and ((Unit(unitID):HasDeBuffs(A.UnstableAffliction.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.UnstableAffliction.ID, true) < 5) or not UAActive) and Unit(player):IsCasting() ~= A.UnstableAffliction:Info() and not isMoving then
                    return A.UnstableAffliction:Show(icon)
                end
                -- actions.cleave+=/agony,if=remains<5
                if A.Agony:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.Agony.ID, true) < 5 and worthDoTing then
                    return A.Agony:Show(icon)
                end
                -- actions.cleave+=/agony,target_if=!(target=self.target)&remains<5
                if autoDOT and A.Agony:IsReady(unitID, nil, nil, true) and (not A.VileTaint:IsTalentLearned() or A.VileTaint:GetCooldown() > 12) and Temp.TargetDelay == 0 then
                    local agonyPlates = MultiUnits:GetActiveEnemies()
                    if agonyPlates then
                        for dotUnit in pairs(ActiveUnitPlates) do 
                            if not UnitIsUnit("target", dotUnit) then
                                if Unit(dotUnit):HasDeBuffs(A.Agony.ID, true) < 5 and Unit(dotUnit):GetRange() < 40 and not Unit(dotUnit):InLOS() and Unit(dotUnit):TimeToDie() > 7 then 
                                    Temp.TargetDelay = 50
                                    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                                end
                            end 
                        end
                    end
                end
                -- actions.cleave+=/siphon_life,if=remains<5
                if A.SiphonLife:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.SiphonLife.ID, true) < 5 and worthDoTing then
                    return A.SiphonLife:Show(icon)
                end
                -- actions.cleave+=/siphon_life,target_if=!(target=self.target)&remains<3
                if autoDOT and A.SiphonLife:IsReady(unitID, nil, nil, true) and not maxSiphonLife and Temp.TargetDelay == 0 then
                    local siphonlifePlates = MultiUnits:GetActiveEnemies()
                    if siphonlifePlates then
                        for dotUnit in pairs(ActiveUnitPlates) do 
                            if not UnitIsUnit("target", dotUnit) then
                                if Unit(dotUnit):HasDeBuffs(A.SiphonLife.ID, true) < 3 and Unit(dotUnit):GetRange() < 40 and not Unit(dotUnit):InLOS() and Unit(dotUnit):TimeToDie() > 7 then 
                                    Temp.TargetDelay = 50
                                    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                                end
                            end 
                        end
                    end
                end
                -- actions.cleave+=/seed_of_corruption,if=!talent.absolute_corruption&dot.corruption.remains<5
                if A.SeedofCorruption:IsReady(unitID, nil, nil, true) and useAoE and Unit(unitID):HasDeBuffs(A.Corruption.ID, true) < 5 and Unit(player):IsCasting() ~= A.SeedofCorruption:Info() and not seedActive and not isMoving and soulShards >= 1 then
                    return A.SeedofCorruption:Show(icon)
                end
                -- actions.cleave+=/corruption,target_if=remains<5&(talent.absolute_corruption|!talent.seed_of_corruption)
                if A.Corruption:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.Corruption.ID, true) < 5 and Unit(player):IsCasting() ~= A.SeedofCorruption:Info() and not seedActive and worthDoTing then
                    return A.Corruption:Show(icon)
                end
                -- actions.cleave+=/phantom_singularity
                if A.PhantomSingularity:IsReady(unitID, nil, nil, true) and worthDoTing then
                    return A.PhantomSingularity:Show(icon)
                end
                -- actions.cleave+=/vile_taint
                if A.VileTaint:IsReady(player, nil, nil, true) and Unit(player):IsCasting() ~= A.VileTaint:Info() and not isMoving then
                    return A.VileTaint:Show(icon)
                end
                -- actions.cleave+=/soul_rot
                if A.SoulRot:IsReady(unitID, nil, nil, true) and Unit(player):IsCasting() ~= A.SoulRot:Info() and not isMoving then
                    return A.SoulRot:Show(icon)
                end
                -- actions.cleave+=/summon_darkglare
                if A.SummonDarkglare:IsReady(player, nil, nil, true) and useBurst then
                    return A.SummonDarkglare:Show(icon)
                end
                -- actions.cleave+=/malefic_rapture,if=talent.malefic_affliction&buff.malefic_affliction.stack<3
                if A.MaleficRapture:IsReady(player, nil, nil, true) and soulShards >= 1 and A.MaleficAffliction:IsTalentLearned() and Unit(player):HasBuffsStacks(A.MaleficAffliction.ID) < 3 and not isMoving then
                    return A.MaleficRapture:Show(icon)
                end
                -- actions.cleave+=/malefic_rapture,if=talent.dread_touch&debuff.dread_touch.remains<gcd
                if A.MaleficRapture:IsReady(player, nil, nil, true) and soulShards >= 1 and A.DreadTouch:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.DreadTouchDebuff.ID, true) < A.GetGCD() and Unit(player):IsCasting() ~= A.MaleficRapture:Info() and not isMoving then
                    return A.MaleficRapture:Show(icon)
                end
                -- actions.cleave+=/malefic_rapture,if=!talent.dread_touch&buff.tormented_crescendo.up
                if A.MaleficRapture:IsReady(player, nil, nil, true) and not A.DreadTouch:IsTalentLearned() and Unit(player):HasBuffs(A.TormentedCrescendoBuff.ID) > A.MaleficRapture:GetSpellCastTime() and Unit(player):IsCasting() ~= A.MaleficRapture:Info() and not isMoving then
                    return A.MaleficRapture:Show(icon)
                end
                -- actions.cleave+=/malefic_rapture,if=!talent.dread_touch&(dot.soul_rot.remains>cast_time|dot.phantom_singularity.remains>cast_time|dot.vile_taint_dot.remains>cast_time|pet.darkglare.active)
                if A.MaleficRapture:IsReady(player, nil, nil, true) and soulShards >= 1 and not A.DreadTouch:IsTalentLearned() and (Unit(unitID):HasDeBuffs(A.SoulRot.ID, true) > A.MaleficRapture:GetSpellCastTime() or Unit(unitID):HasDeBuffs(A.PhantomSingularity.ID, true) > A.MaleficRapture:GetSpellCastTime() or Unit(unitID):HasDeBuffs(A.VileTaint.ID, true) > A.MaleficRapture:GetSpellCastTime() or darkglareActive) and not isMoving then
                    return A.MaleficRapture:Show(icon)
                end
                -- actions.cleave+=/drain_soul,if=buff.nightfall.react
                if A.DrainSoul:IsReady(unitID, nil, nil, true) and Unit(player):HasBuffs(A.NightfallBuff.ID) > 0 and not isMoving and not isDrainingSoul and A.GetCurrentGCD() == 0 then
                    return A.DrainSoul:Show(icon)
                end
                -- actions.cleave+=/shadow_bolt,if=buff.nightfall.react
                if A.ShadowBolt:IsReady(unitID, nil, nil, true) and not A.DrainSoul:IsTalentLearned() and Unit(player):HasBuffs(A.NightfallBuff.ID) > 0 then
                    return A.ShadowBolt:Show(icon)
                end
                -- actions.cleave+=/drain_life,if=buff.inevitable_demise.stack>48|buff.inevitable_demise.stack>20&fight_remains<4
                if A.DrainLife:IsReady(unitID, nil, nil, true) and not isMoving then
                    if Unit(player):HasBuffsStacks(A.InevitableDemiseBuff.ID) > 48 or Unit(player):HasBuffsStacks(A.InevitableDemiseBuff.ID) > 20 and TTD < 4 then
                        return A.DrainLife:Show(icon)
                    end
                end
                -- actions.cleave+=/drain_life,if=buff.soul_rot.up&buff.inevitable_demise.stack>10
                if A.DrainLife:IsReady(unitID, nil, nil, true) and not isMoving then
                    if Unit(unitID):HasDeBuffs(A.SoulRot.ID) > 0 and Unit(player):HasBuffsStacks(A.InevitableDemiseBuff.ID) > 10 then
                        return A.DrainLife:Show(icon)
                    end
                end
                -- actions.cleave+=/agony,target_if=refreshable
                if A.Agony:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.Agony.ID, true) < 5 and worthDoTing then
                    return A.Agony:Show(icon)
                end
                if autoDOT and A.Agony:IsReady(unitID, nil, nil, true) and (not A.VileTaint:IsTalentLearned() or A.VileTaint:GetCooldown() > 12) and Temp.TargetDelay == 0 then
                    local agonyPlates = MultiUnits:GetActiveEnemies()
                    if agonyPlates then
                        for dotUnit in pairs(ActiveUnitPlates) do 
                            if not UnitIsUnit("target", dotUnit) then
                                if Unit(dotUnit):HasDeBuffs(A.Agony.ID, true) < A.Agony:GetSpellPandemicThreshold() and Unit(dotUnit):GetRange() < 40 and not Unit(dotUnit):InLOS() and Unit(dotUnit):TimeToDie() > 7 then 
                                    Temp.TargetDelay = 50
                                    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                                end
                            end 
                        end
                    end
                end
                -- actions.cleave+=/corruption,target_if=refreshable
                if autoDOT and A.Corruption:IsReady(unitID, nil, nil, true) and not seedActive and Temp.TargetDelay == 0 then
                    local corruptionPlates = MultiUnits:GetActiveEnemies()
                    if corruptionPlates then
                        for dotUnit in pairs(ActiveUnitPlates) do 
                            if not UnitIsUnit("target", dotUnit) then
                                if Unit(dotUnit):HasDeBuffs(A.Corruption.ID, true) < A.Corruption:GetSpellPandemicThreshold() and Unit(dotUnit):GetRange() < 40 and not Unit(dotUnit):InLOS() and Unit(dotUnit):TimeToDie() > 7 then 
                                    Temp.TargetDelay = 50
                                    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                                end
                            end 
                        end
                    end
                end
                -- actions.cleave+=/drain_soul,interrupt_global=1
                if A.DrainSoul:IsReady(unitID, nil, nil, true) and not isMoving and not isDrainingSoul and A.GetCurrentGCD() == 0 then
                    return A.DrainSoul:Show(icon)
                end
                -- actions.cleave+=/shadow_bolt
                if A.ShadowBolt:IsReady(unitID, nil, nil, true) and not A.DrainSoul:IsTalentLearned() and not isMoving then
                    return A.ShadowBolt:Show(icon)
                end
            end
            -- actions+=/call_action_list,name=aoe,if=active_enemies>3
            if activeEnemies > 3 and useAoE then

                -- actions.aoe+=/haunt
                if A.Haunt:IsReady(unitID, nil, nil, true) and Unit(player):IsCasting() ~= A.Haunt:Info() and not isMoving then
                    return A.Haunt:Show(icon)
                end
                -- actions.aoe+=/vile_taint
                if A.VileTaint:IsReady(player, nil, nil, true) and Unit(player):IsCasting() ~= A.VileTaint:Info() and not isMoving then
                    return A.VileTaint:Show(icon)
                end
                -- actions.aoe+=/phantom_singularity
                if A.PhantomSingularity:IsReady(unitID, nil, nil, true) then
                    return A.PhantomSingularity:Show(icon)
                end
                -- actions.aoe+=/soul_rot
                if A.SoulRot:IsReady(unitID, nil, nil, true) and Unit(player):IsCasting() ~= A.SoulRot:Info() and not isMoving then
                    return A.SoulRot:Show(icon)
                end
                -- actions.aoe+=/unstable_affliction,if=remains<5
                if A.UnstableAffliction:IsReady(unitID, nil, nil, true) and ((Unit(unitID):HasDeBuffs(A.UnstableAffliction.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.UnstableAffliction.ID, true) < 5) or not UAActive) and Unit(player):IsCasting() ~= A.UnstableAffliction:Info() and not isMoving then
                    return A.UnstableAffliction:Show(icon)
                end
                -- actions.aoe+=/seed_of_corruption,if=dot.corruption.remains<5
                if A.SeedofCorruption:IsReady(unitID, nil, nil, true) and useAoE and Unit(unitID):HasDeBuffs(A.Corruption.ID, true) < 5 and Unit(player):IsCasting() ~= A.SeedofCorruption:Info() and not seedActive and not isMoving and soulShards >= 1 then
                    return A.SeedofCorruption:Show(icon)
                end
                -- actions.aoe+=/malefic_rapture,if=talent.malefic_affliction&buff.malefic_affliction.stack<3&talent.doom_blossom
                if A.MaleficRapture:IsReady(player, nil, nil, true) and soulShards >= 1 and A.MaleficAffliction:IsTalentLearned() and Unit(player):HasBuffsStacks(A.MaleficAffliction.ID) < 3 and A.DoomBlossom:IsTalentLearned() and not isMoving then
                    return A.MaleficRapture:Show(icon)
                end
                -- actions.aoe+=/agony,target_if=remains<5,if=active_dot.agony<5
                if A.Agony:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.Agony.ID, true) < 5 and worthDoTing then
                    return A.Agony:Show(icon)
                end
                if autoDOT and A.Agony:IsReady(unitID, nil, nil, true) and not maxAgony and (not A.VileTaint:IsTalentLearned() or A.VileTaint:GetCooldown() > 12) and Temp.TargetDelay == 0 then
                    local agonyPlates = MultiUnits:GetActiveEnemies()
                    if agonyPlates then
                        for dotUnit in pairs(ActiveUnitPlates) do 
                            if not UnitIsUnit("target", dotUnit) then
                                if Unit(dotUnit):HasDeBuffs(A.Agony.ID, true) < A.Agony:GetSpellPandemicThreshold() and Unit(dotUnit):GetRange() < 40 and not Unit(dotUnit):InLOS() and Unit(dotUnit):TimeToDie() > 7 then 
                                    Temp.TargetDelay = 50
                                    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                                end
                            end 
                        end
                    end
                end
                -- actions.aoe+=/summon_darkglare
                if A.SummonDarkglare:IsReady(player, nil, nil, true) and useBurst then
                    return A.SummonDarkglare:Show(icon)
                end
                -- actions.aoe+=/seed_of_corruption,if=talent.sow_the_seeds
                if A.SeedofCorruption:IsReady(unitID, nil, nil, true) and useAoE and A.SowtheSeeds:IsTalentLearned() and not isMoving and soulShards >= 1 then
                    return A.SeedofCorruption:Show(icon)
                end
                -- actions.aoe+=/malefic_rapture
                if A.MaleficRapture:IsReady(unitID, nil, nil, true) and soulShards >= 1 and not isMoving then
                    return A.MaleficRapture:Show(icon)
                end
                -- actions.aoe+=/drain_life,if=(buff.soul_rot.up|!talent.soul_rot)&buff.inevitable_demise.stack>10
                if A.DrainLife:IsReady(unitID, nil, nil, true) and (Unit(unitID):HasDeBuffs(A.SoulRot.ID, true) > 0 or not A.SoulRot:IsTalentLearned()) and Unit(player):HasBuffsStacks(A.InevitableDemiseBuff.ID) > 10 and not isMoving then
                    return A.DrainLife:Show(icon)
                end
                -- actions.aoe+=/summon_soulkeeper,if=buff.tormented_soul.stack=10|buff.tormented_soul.stack>3&fight_remains<10
                if A.SummonSoulkeeper:IsReady(player, nil, nil, true) and (A.SummonSoulkeeper:GetCount() == 10 or A.SummonSoulkeeper:GetCount() > 3 and TTD < 10) and not isMoving then
                    return A.SummonSoulkeeper:Show(icon)
                end
                -- actions.aoe+=/siphon_life,target_if=remains<5,if=active_dot.siphon_life<3
                if A.SiphonLife:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.SiphonLife.ID, true) < 5 and worthDoTing then
                    return A.SiphonLife:Show(icon)
                end
                if autoDOT and A.SiphonLife:IsReady(unitID, nil, nil, true) and not maxSiphonLife and Temp.TargetDelay == 0 then
                    local siphonlifePlates = MultiUnits:GetActiveEnemies()
                    if siphonlifePlates then
                        for dotUnit in pairs(ActiveUnitPlates) do 
                            if not UnitIsUnit("target", dotUnit) then
                                if Unit(dotUnit):HasDeBuffs(A.SiphonLife.ID, true) < 5 and Unit(dotUnit):GetRange() < 40 and not Unit(dotUnit):InLOS() and Unit(dotUnit):TimeToDie() > 7 then 
                                    Temp.TargetDelay = 50
                                    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                                end
                            end 
                        end
                    end
                end
                -- actions.cleave+=/drain_soul,interrupt_global=1
                if A.DrainSoul:IsReady(unitID, nil, nil, true) and not isMoving and not isDrainingSoul and A.GetCurrentGCD() == 0 then
                    return A.DrainSoul:Show(icon)
                end
                -- actions.cleave+=/shadow_bolt
                if A.ShadowBolt:IsReady(unitID, nil, nil, true) and not A.DrainSoul:IsTalentLearned() and not isMoving then
                    return A.ShadowBolt:Show(icon)
                end

            end
            -- actions+=/malefic_rapture,if=talent.dread_touch&debuff.dread_touch.remains<2&(dot.agony.ticking&dot.corruption.ticking&(!talent.siphon_life|dot.siphon_life.ticking))&(!talent.phantom_singularity|!cooldown.phantom_singularity.ready)&(!talent.vile_taint|!cooldown.vile_taint.ready)&(!talent.soul_rot|!cooldown.soul_rot.ready)
            if A.MaleficRapture:IsReady(player, nil, nil, true) and soulShards >= 1 and not isMoving then
                if A.DreadTouch:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.DreadTouchDebuff.ID) < 2 and (Unit(unitID):HasDeBuffs(A.Agony.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.Corruption.ID, true) > 0 and (not A.SiphonLife:IsTalentLearned() or Unit(unitID):HasDeBuffs(A.SiphonLife.ID, true) > 0)) and (not A.PhantomSingularity:IsTalentLearned() or A.PhantomSingularity:GetCooldown() > 0) and (not A.VileTaint:IsTalentLearned() or A.VileTaint:GetCooldown() > 0) and (not A.SoulRot:IsTalentLearned() or A.SoulRot:GetCooldown() > 0) then
                    return A.MaleficRapture:Show(icon)
                end
            end
            -- actions+=/unstable_affliction,if=remains<5
            if A.UnstableAffliction:IsReady(unitID, nil, nil, true) and ((Unit(unitID):HasDeBuffs(A.UnstableAffliction.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.UnstableAffliction.ID, true) < 5) or not UAActive) and Unit(player):IsCasting() ~= A.UnstableAffliction:Info() and not isMoving then
                return A.UnstableAffliction:Show(icon)
            end
            -- actions+=/agony,if=remains<5
            if A.Agony:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.Agony.ID, true) < 5 and worthDoTing then
                return A.Agony:Show(icon)
            end
            -- actions+=/corruption,if=remains<5
            if A.Corruption:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.Corruption.ID, true) < 5 and not seedActive and worthDoTing then
                return A.Corruption:Show(icon)
            end
            -- actions+=/siphon_life,if=remains<5
            if A.SiphonLife:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.SiphonLife.ID, true) < 5 and worthDoTing then
                return A.SiphonLife:Show(icon)
            end
            -- actions+=/haunt
            if A.Haunt:IsReady(unitID, nil, nil, true) and not isMoving and Unit(player):IsCasting() ~= A.Haunt:Info() then
                return A.Haunt:Show(icon)
            end
            -- actions+=/drain_soul,if=talent.shadow_embrace&(debuff.shadow_embrace.stack<3|debuff.shadow_embrace.remains<3)
            if A.DrainSoul:IsReady(unitID, nil, nil, true) and A.ShadowEmbrace:IsTalentLearned() and (Unit(unitID):HasDeBuffsStacks(A.ShadowEmbraceDebuff.ID, true) < 3 or Unit(unitID):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true) < 3) and not isMoving and not isDrainingSoul and A.GetCurrentGCD() == 0 then
                return A.DrainSoul:Show(icon)
            end
            -- actions+=/shadow_bolt,if=talent.shadow_embrace&(debuff.shadow_embrace.stack<3|debuff.shadow_embrace.remains<3)
            if A.ShadowBolt:IsReady(unitID, nil, nil, true) and A.ShadowEmbrace:IsTalentLearned() and not A.DrainSoul:IsTalentLearned() and (Unit(unitID):HasDeBuffsStacks(A.ShadowEmbraceDebuff.ID, true) < 3 or Unit(unitID):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true) < 3) and (not isMoving or Unit(player):HasBuffs(A.NightfallBuff.ID) > 0) then
                return A.ShadowBolt:Show(icon)
            end
            -- actions+=/phantom_singularity,if=!talent.soul_rot|cooldown.soul_rot.remains<=execute_time|cooldown.soul_rot.remains>=25
            if A.PhantomSingularity:IsReady(unitID, nil, nil, true) then
                if not A.SoulRot:IsTalentLearned() or A.SoulRot:GetCooldown() <= A.PhantomSingularity:GetSpellCastTime() or A.SoulRot:GetCooldown() >= 25 then
                    return A.PhantomSingularity:Show(icon)
                end
            end
            -- actions+=/vile_taint,if=!talent.soul_rot|cooldown.soul_rot.remains<=execute_time|talent.souleaters_gluttony.rank<2&cooldown.soul_rot.remains>=12
            if A.VileTaint:IsReady(player, nil, nil, true) and not isMoving and Unit(player):IsCasting() ~= A.VileTaint:Info() then
                if not A.SoulRot:IsTalentLearned() or A.SoulRot:GetCooldown() <= A.VileTaint:GetSpellCastTime() or (not A.SoulEatersGluttony:IsTalentLearned() and A.SoulRot:GetCooldown() >= 12) then
                    return A.VileTaint:Show(icon)
                end
            end
            -- actions+=/soul_rot,if=variable.vt_up&variable.ps_up
            if A.SoulRot:IsReady(unitID, nil, nil, true) and vt_up and ps_up and not isMoving and Unit(player):IsCasting() ~= A.SoulRot:Info() then
                return A.SoulRot:Show(icon)
            end
            -- actions+=/summon_darkglare,if=variable.ps_up&variable.vt_up&variable.sr_up|cooldown.invoke_power_infusion_0.duration>0&cooldown.invoke_power_infusion_0.up&!talent.soul_rot
            if A.SummonDarkglare:IsReady(player, nil, nil, true) and useBurst then
                if ps_up and vt_up and sr_up then
                    return A.SummonDarkglare:Show(icon)
                end
            end
            -- actions+=/malefic_rapture,if=soul_shard>4|(talent.tormented_crescendo&buff.tormented_crescendo.stack=1&soul_shard>3)
            if A.MaleficRapture:IsReady(player, nil, nil, true) and not isMoving then
                if soulShards > 4 or (A.TormentedCrescendo:IsTalentLearned() and Unit(player):HasBuffsStacks(A.TormentedCrescendoBuff.ID) == 1 and soulShards > 3) then
                    return A.MaleficRapture:Show(icon)
                end
            end
            -- actions+=/malefic_rapture,if=talent.tormented_crescendo&buff.tormented_crescendo.react&!debuff.dread_touch.react
            if A.MaleficRapture:IsReady(player, nil, nil, true) and A.TormentedCrescendo:IsTalentLearned() and Unit(player):HasBuffs(A.TormentedCrescendoBuff.ID) > 0 and Unit(unitID):HasDeBuffs(A.DreadTouchDebuff.ID) == 0 and not isMoving then
                return A.MaleficRapture:Show(icon)
            end
            -- actions+=/malefic_rapture,if=talent.tormented_crescendo&buff.tormented_crescendo.stack=2
            if A.MaleficRapture:IsReady(player, nil, nil, true) and A.TormentedCrescendo:IsTalentLearned() and Unit(player):HasBuffsStacks(A.TormentedCrescendoBuff.ID) == 2 and not isMoving then
                return A.MaleficRapture:Show(icon)
            end
            -- actions+=/malefic_rapture,if=variable.cd_dots_up|variable.vt_up&soul_shard>1
            if A.MaleficRapture:IsReady(player, nil, nil, true) and soulShards >= 1 and (cd_dots_up or (vt_up and soulShards > 1)) and not isMoving then
                return A.MaleficRapture:Show(icon)
            end
            -- actions+=/malefic_rapture,if=talent.tormented_crescendo&talent.nightfall&buff.tormented_crescendo.react&buff.nightfall.react
            if A.MaleficRapture:IsReady(player, nil, nil, true) and A.TormentedCrescendo:IsTalentLearned() and A.Nightfall:IsTalentLearned() and Unit(player):HasBuffs(A.TormentedCrescendoBuff.ID) > 0 and Unit(player):HasBuffs(A.NightfallBuff.ID) > 0 then
                return A.MaleficRapture:Show(icon)
            end
            -- actions+=/drain_life,if=buff.inevitable_demise.stack>48|buff.inevitable_demise.stack>20&fight_remains<4
            if A.DrainLife:IsReady(unitID, nil, nil, true) and not isMoving then
                if Unit(player):HasBuffsStacks(A.InevitableDemiseBuff.ID) > 48 or Unit(player):HasBuffsStacks(A.InevitableDemiseBuff.ID) > 20 and TTD < 4 then
                    return A.DrainLife:Show(icon)
                end
            end
            -- actions+=/drain_soul,if=buff.nightfall.react
            if A.DrainSoul:IsReady(unitID, nil, nil, true) and Unit(player):HasBuffs(A.NightfallBuff.ID) > 0 and not isMoving and not isDrainingSoul and A.GetCurrentGCD() == 0 then
                return A.DrainSoul:Show(icon)
            end
            -- actions+=/shadow_bolt,if=buff.nightfall.react
            if A.ShadowBolt:IsReady(unitID, nil, nil, true) and not A.DrainSoul:IsTalentLearned() and Unit(player):HasBuffs(A.NightfallBuff.ID) > 0 and not isDrainingSoul and A.GetCurrentGCD() == 0 then
                return A.DrainSoul:Show(icon)
            end
            -- actions+=/agony,if=refreshable
            if A.Agony:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.Agony.ID, true) < A.Agony:GetSpellPandemicThreshold() then
                return A.Agony:Show(icon)
            end
            -- actions+=/corruption,if=refreshable
            if A.Corruption:IsReady(unitID, nil, nil, true) and Unit(unitID):HasDeBuffs(A.Corruption.ID, true) < A.Corruption:GetSpellPandemicThreshold() then
                return A.Corruption:Show(icon)
            end
            -- actions+=/drain_soul,interrupt=1
            if A.DrainSoul:IsReady(unitID, nil, nil, true) and not isMoving and not isDrainingSoul and A.GetCurrentGCD() == 0 then
                return A.DrainSoul:Show(icon)
            end
            -- actions+=/shadow_bolt
            if A.ShadowBolt:IsReady(unitID, nil, nil, true) and not A.DrainSoul:IsTalentLearned() and not isMoving then
                return A.ShadowBolt:Show(icon)
            end
        end

    end

    -- Target  
    if A.IsUnitEnemy("target") then 
        unitID = "target"
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