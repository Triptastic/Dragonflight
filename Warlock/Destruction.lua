--######################################
--##### TRIP'S DESTRUCTION WARLOCK #####
--######################################

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

Action[ACTION_CONST_WARLOCK_DESTRUCTION] = {
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
    Haunt          = Action.Create({ Type = "Spell", ID = 48181 }),
    SiphonLife     = Action.Create({ Type = "Spell", ID = 63106 }),
    Havoc          = Action.Create({ Type = "Spell", ID = 80240 }),
    CallDreadstalkers= Action.Create({ Type = "Spell", ID = 104316 }),
    SoulLink       = Action.Create({ Type = "Spell", ID = 108415 }),
    DarkPact       = Action.Create({ Type = "Spell", ID = 108416 }),
    GrimoireofSacrifice= Action.Create({ Type = "Spell", ID = 108503 }),
    Nightfall      = Action.Create({ Type = "Spell", ID = 108558 }),
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
    GrimReach      = Action.Create({ Type = "Spell", ID = 389992 }),
    ReignofTyranny = Action.Create({ Type = "Spell", ID = 390173 }),
    GrimoireofSacrificeBuff = Action.Create({ Type = "Spell", ID = 196099 }),     
    InquisitorsGazeBuff = Action.Create({ Type = "Spell", ID = 388068 }),   
    Blasphemy = Action.Create({ Type = "Spell", ID = 387161 }),   
    MadnessCB = Action.Create({ Type = "Spell", ID = 387409 }),   
    MadnessROF = Action.Create({ Type = "Spell", ID = 387413 }),  
    Healthstone     = Action.Create({ Type = "Item", ID = 5512 }),
}

local A = setmetatable(Action[ACTION_CONST_WARLOCK_DESTRUCTION], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
local target = "target"
local pet = "pet"

Pet:AddActionsSpells(267, {
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
    ImmolateDelay                           = 0,
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
    curseOfTongues                          = {

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
        if useKick and not notInterruptable and (A.SpellLock:IsReady(unitID) or A.SpellLockSac:IsReady(unitID)) then 
            return A.SpellLock
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

local function HandlePetChoice()
    local petChoices = {
        IMP = A.SummonImp,
        VOIDWALKER = A.SummonVoidwalker,
        FELHUNTER = A.SummonFelhunter,
        SAYAAD = A.SummonSayaad,
    }
    local choice = Action.GetToggle(2, "PetChoice")
    local currentSummon = petChoices[choice]
    if currentSummon:IsReady(player) then
        return currentSummon
    end
end

local function ActiveEnemies()

    local spells = {A.ShadowBite.ID, A.Whiplash.ID}
    local aoeDetection = A.GetToggle(2, "aoeDetection")

    for _, spell in pairs(spells) do
        if Pet:IsSpellKnown(spell) and aoeDetection == "Pet" then
            return Pet:GetInRange(spell)
            else return MultiUnits:GetActiveEnemies()
        end
    end

end

local function HavocTimer()

    local timer = 0
    local activeUnitPlates = MultiUnits:GetActiveUnitPlates()
	for namePlateUnitID in pairs(activeUnitPlates) do 
		if Unit(namePlateUnitID):HasDeBuffs(A.Havoc.ID, true) > 0 then
            timer = Unit(namePlateUnitID):HasDeBuffs(A.Havoc.ID, true)
        end
	end  

    return timer
end

local dontHavoc = {
    [59051] = true, -- Strife
    [59726] = true, -- Peril
}   

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local activeEnemies = ActiveEnemies()
    local useRacial = A.GetToggle(1, "Racial")
    local infernalRemaining = Player:GetTotemTimeLeft(1)
    local blasphemyRemaining = Unit(player):HasBuffs(A.Blasphemy.ID)
    local soulShards = Player:SoulShards()
    local havocRemains = HavocTimer()

    Player:AddTier("Tier29", { 200327, 200326, 200328, 200324, 200329, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)
    
    -- actions.precombat+=/summon_pet
    local summonPet = HandlePetChoice()
    if summonPet and (not Unit(pet):IsExists() or Unit(pet):IsDead()) and Unit(player):HasBuffs(A.GrimoireofSacrificeBuff.ID) == 0 then
        if inCombat and A.FelDomination:IsReady(player) then
            return A.FelDomination:Show(icon)
        end
        if not isMoving or Unit(player):HasBuffs(A.FelDomination.ID) > 0 then
            return summonPet:Show(icon)
        end
    end

    -- actions.precombat+=/grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
    if A.GrimoireofSacrifice:IsReady(player) and Unit(pet):IsExists() then
        return A.GrimoireofSacrifice:Show(icon)
    end
    -- actions.precombat+=/inquisitors_gaze
    if A.InquisitorsGaze:IsReady(player) and Unit(player):HasBuffs(A.InquisitorsGazeBuff.ID) == 0 then
        return A.InquisitorsGaze:Show(icon)
    end

    local HealthFunnelHP = A.GetToggle(2, "HealthFunnelHP")
    if A.HealthFunnel:IsReady(player) and Unit(pet):HealthPercent() <= HealthFunnelHP and Unit(pet):IsExists() and not Unit(pet):IsDead() then
        return A.HealthFunnel:Show(icon)
    end

    local function EnemyRotation(unitID)

        local TTD = Unit(unitID):TimeToDie()
        local inRange = A.Incinerate:IsInRange(unitID)
        local immolateRefreshable = Unit(unitID):HasDeBuffs(A.Immolate.ID, true) <= A.Immolate:GetSpellPandemicThreshold() and Temp.ImmolateDelay == 0
        local npcID = select(6, Unit(unitID):InfoGUID())	
        local blockHavoc = dontHavoc[npcID]

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

        if Temp.ImmolateDelay == 0 and Player:IsCasting() == A.Immolate:Info() then
            Temp.ImmolateDelay = 60
            elseif Temp.ImmolateDelay > 0 then
            Temp.ImmolateDelay = Temp.ImmolateDelay - 1
        end

        if Unit(unitID):IsExplosives() then
            if A.Shadowburn:IsReady(unitID) then
                return A.Shadowburn:Show(icon)
            end
            if A.DrainLife:IsReady(unitID) then
                return A.DrainLife:Show(icon)
            end
        end

        if not inCombat then
            -- actions.precombat+=/soul_fire
            if A.SoulFire:IsReady(unitID) and not isMoving then
                return A.SoulFire:Show(icon)
            end
            -- actions.precombat+=/cataclysm
            if A.Cataclysm:IsReady(player) and inRange and not isMoving then
                return A.Cataclysm:Show(icon)
            end
            -- actions.precombat+=/incinerate
            if A.Incinerate:IsReady(unitID) and not isMoving then
                return A.Incinerate:Show(icon)
            end
        end

        local function oGCD()

            if useRacial and BurstIsON(unitID) and inRange and (infernalRemaining > 0 or not A.SummonInfernal:IsTalentLearned()) then
                -- actions.ogcd+=/berserking,if=pet.infernal.active|!talent.summon_infernal|(time_to_die<(cooldown.summon_infernal.remains+cooldown.berserking.duration)&(time_to_die>cooldown.berserking.duration))|time_to_die<cooldown.summon_infernal.remains
                if A.Berserking:IsReady(player) then
                    return A.Berserking
                end
                -- actions.ogcd+=/blood_fury,if=pet.infernal.active|!talent.summon_infernal|(time_to_die<cooldown.summon_infernal.remains+10+cooldown.blood_fury.duration&time_to_die>cooldown.blood_fury.duration)|time_to_die<cooldown.summon_infernal.remains
                if A.BloodFury:IsReady(player) then
                    return A.BloodFury
                end
                -- actions.ogcd+=/fireblood,if=pet.infernal.active|!talent.summon_infernal|(time_to_die<cooldown.summon_infernal.remains+10+cooldown.fireblood.duration&time_to_die>cooldown.fireblood.duration)|time_to_die<cooldown.summon_infernal.remains
                if A.Fireblood:IsReady(player) then
                    return A.Fireblood
                end
            end

        end

        local function HavocRotation()  
            -- actions.havoc=conflagrate,if=talent.backdraft&buff.backdraft.down&soul_shard>=1&soul_shard<=4
            if A.Conflagrate:IsReady(unitID) and A.Backdraft:IsTalentLearned() and Unit(player):HasBuffs(A.BackdraftBuff.ID) == 0 and soulShards >= 1 and soulShards <= 4 then
                return A.Conflagrate
            end
            -- actions.havoc+=/soul_fire,if=cast_time<havoc_remains&soul_shard<3
            if A.SoulFire:IsReady(unitID) and not isMoving and A.SoulFire:GetSpellCastTime() <= havocRemains and soulShards < 3 then
                return A.SoulFire
            end
            -- actions.havoc+=/channel_demonfire,if=soul_shard<4.5&talent.raging_demonfire.rank=2&active_enemies>2
            if A.ChannelDemonfire:IsReady(player) and not isMoving and soulShards < 4.5 and A.RagingDemonfire:GetTalentTraits() == 2 and activeEnemies > 2 then
                return A.ChannelDemonfire
            end
            -- actions.havoc+=/immolate,cycle_targets=1,if=dot.immolate.refreshable&dot.immolate.remains<havoc_remains&soul_shard<4.5&(debuff.havoc.down|!dot.immolate.ticking)
            if A.Immolate:IsReady(unitID) and not isMoving and immolateRefreshable and Unit(unitID):HasDeBuffs(A.Immolate.ID, true) < havocRemains and soulShards < 4.5 and (havocRemains == 0 or Unit(unitID):HasDeBuffs(A.Immolate.ID, true) == 0) then
                return A.Immolate
            end
            -- actions.havoc+=/chaos_bolt,if=talent.cry_havoc&!talent.inferno&cast_time<havoc_remains
            if A.ChaosBolt:IsReady(unitID) and not isMoving and A.CryHavoc:IsTalentLearned() and not A.Inferno:IsTalentLearned() and A.ChaosBolt:GetSpellCastTime() <= havocRemains then
                return A.ChaosBolt
            end
            -- actions.havoc+=/chaos_bolt,if=cast_time<havoc_remains&(active_enemies<4-talent.inferno+talent.madness_of_the_azjaqir-(talent.inferno&(talent.rain_of_chaos|talent.avatar_of_destruction)&buff.rain_of_chaos.up))
            if A.ChaosBolt:IsReady(unitID) and not isMoving and A.ChaosBolt:GetSpellCastTime() < havocRemains and (activeEnemies < (4 - num(A.Inferno:IsTalentLearned()) + num(A.MadnessoftheAzjAqir:IsTalentLearned()) - num(A.Inferno:IsTalentLearned() and (A.RainofChaos:IsTalentLearned() or A.AvatarofDestruction:IsTalentLearned()) and Unit(player):HasBuffs(A.RainofChaosBuff.ID) > 0))) then
                return A.ChaosBolt
            end
            -- actions.havoc+=/rain_of_fire,if=(active_enemies>=4-talent.inferno+talent.madness_of_the_azjaqir)
            if A.RainofFire:IsReady(player) and activeEnemies >= 4 - (num(A.Inferno:IsTalentLearned()) + num(A.MadnessoftheAzjAqir:IsTalentLearned())) then
                return A.RainofFire
            end
            -- actions.havoc+=/rain_of_fire,if=active_enemies>1&(talent.avatar_of_destruction|(talent.rain_of_chaos&buff.rain_of_chaos.up))&talent.inferno.enabled
            if A.RainofFire:IsReady(player) and activeEnemies > 1 and (A.AvatarofDestruction:IsTalentLearned() or (A.RainofChaos:IsTalentLearned() and Unit(player):HasBuffs(A.RainofChaosBuff.ID) > 0) and A.Inferno:IsTalentLearned()) then
                return A.RainofFire
            end
            -- actions.havoc+=/conflagrate,if=!talent.backdraft
            if A.Conflagrate:IsReady(unitID) and not A.Backdraft:IsTalentLearned() then
                return A.Conflagrate
            end
            -- actions.havoc+=/incinerate,if=cast_time<havoc_remains
            if A.Incinerate:IsReady(unitID) and not isMoving and A.Incinerate:GetSpellCastTime() <= havocRemains then
                return A.Incinerate
            end
        end


        -- actions=call_action_list,name=cleave,if=active_enemies!=1&active_enemies<=2+(!talent.inferno&talent.madness_of_the_azjaqir&talent.ashen_remains)|variable.cleave_apl
        if activeEnemies > 1 and activeEnemies <= (2 + (num(not A.Inferno:IsTalentLearned() and A.MadnessoftheAzjAqir:IsTalentLearned() and A.AshenRemains:IsTalentLearned()))) then 
            -- actions.cleave=call_action_list,name=items
            -- actions.cleave+=/call_action_list,name=ogcd
            local useOGCD = oGCD()
            if useOGCD then
                return useOGCD:Show(icon)
            end
            -- actions.cleave+=/call_action_list,name=havoc,if=havoc_active&havoc_remains>gcd
            local useHavocRotation = HavocRotation()
            if useHavocRotation and havocRemains > 0 then
                return useHavocRotation:Show(icon)
            end
            -- actions.cleave+=/variable,name=pool_soul_shards,value=cooldown.havoc.remains<=10|talent.mayhem
            local poolSoulShards = A.Havoc:GetCooldown() <= 10 or A.Mayhem:IsTalentLearned()
            -- actions.cleave+=/conflagrate,if=(talent.roaring_blaze.enabled&debuff.conflagrate.remains<1.5)|charges=max_charges
            if A.Conflagrate:IsReady(unitID) then
                if (A.RoaringBlaze:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ConflagrateDebuff.ID, true) < 1.5) or A.Conflagrate:GetSpellCharges() == A.Conflagrate:GetSpellChargesMax() then
                    return A.Conflagrate:Show(icon)
                end
            end
            -- actions.cleave+=/dimensional_rift,if=soul_shard<4.7&(charges>2|time_to_die<cooldown.dimensional_rift.duration)
            if A.DimensionalRift:IsReady(unitID) and soulShards < 4.7 and A.DimensionalRift:GetSpellCharges() > 2 then
                return A.DimensionalRift:Show(icon)
            end
            -- actions.cleave+=/cataclysm
            if A.Cataclysm:IsReady(player) and not isMoving and inRange then
                return A.Cataclysm:Show(icon)
            end
            -- actions.cleave+=/channel_demonfire,if=talent.raging_demonfire
            if A.ChannelDemonfire:IsReady(player) and not isMoving and inRange and A.RagingDemonfire:IsTalentLearned() then
                return A.ChannelDemonfire:Show(icon)
            end
            -- actions.cleave+=/soul_fire,if=soul_shard<=4&!variable.pool_soul_shards
            if A.SoulFire:IsReady(unitID) and not isMoving and soulShards <= 4 and not poolSoulShards then
                return A.SoulFire:Show(icon)
            end
            -- actions.cleave+=/immolate,if=((talent.internal_combustion&dot.immolate.refreshable)|dot.immolate.remains<3)&(!talent.cataclysm|cooldown.cataclysm.remains>remains)&(!talent.soul_fire|cooldown.soul_fire.remains>remains)
            if A.Immolate:IsReady(unitID) and not isMoving and Temp.ImmolateDelay == 0 and ((A.InternalCombustion:IsTalentLearned() and immolateRefreshable) or Unit(unitID):HasDeBuffs(A.Immolate.ID, true) < 3) and (not A.Cataclysm:IsTalentLearned() or A.Cataclysm:GetCooldown() > Unit(unitID):HasDeBuffs(A.Immolate.ID, true)) and (not A.SoulFire:IsTalentLearned() or A.SoulFire:GetCooldown() > Unit(unitID):HasDeBuffs(A.Immolate.ID, true)) then
                return A.Immolate:Show(icon)
            end
            -- actions.cleave+=/havoc,if=!(target=self.target)&(!cooldown.summon_infernal.up|!talent.summon_infernal)
            if A.Havoc:IsReady(unitID) and not blockHavoc and (A.SummonInfernal:GetCooldown() > 0 or not A.SummonInfernal:IsTalentLearned()) then
                return A.Havoc:Show(icon)
            end
            -- actions.cleave+=/chaos_bolt,if=pet.infernal.active|pet.blasphemy.active|soul_shard>=4
            if A.ChaosBolt:IsReady(unitID) and not isMoving and (infernalRemaining > 0 or blasphemyRemaining > 0 or soulShards >= 4) then
                return A.ChaosBolt:Show(icon)
            end
            -- actions.cleave+=/summon_infernal
            if A.SummonInfernal:IsReady(player) and inRange and BurstIsON(unitID) then
                return A.SummonInfernal:Show(icon)
            end
            -- actions.cleave+=/channel_demonfire,if=talent.ruin.rank>1&!(talent.diabolic_embers&talent.avatar_of_destruction&(talent.burn_to_ashes|talent.chaos_incarnate))
            if A.ChannelDemonfire:IsReady(player) and not isMoving and A.Ruin:GetTalentTraits() > 1 and not (A.DiabolicEmbers:IsTalentLearned() and A.AvatarofDestruction:IsTalentLearned() and (A.BurntoAshes:IsTalentLearned() or A.ChaosIncarnate:IsTalentLearned())) then
                return A.ChannelDemonfire:Show(icon)
            end
            -- actions.cleave+=/conflagrate,if=buff.backdraft.down&soul_shard>=1.5&!variable.pool_soul_shards
            if A.Conflagrate:IsReady(unitID) and Unit(player):HasBuffs(A.BackdraftBuff.ID) == 0 and soulShards >= 1.5 and not poolSoulShards then
                return A.Conflagrate:Show(icon)
            end
            -- actions.cleave+=/incinerate,if=buff.burn_to_ashes.up&cast_time+action.chaos_bolt.cast_time<buff.madness_cb.remains
            if A.Incinerate:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.BurntoAshesBuff.ID) > 0 and A.Incinerate:GetSpellCastTime() + A.ChaosBolt:GetSpellCastTime() < Unit(player):HasBuffs(A.MadnessCB.ID) then
                return A.Incinerate:Show(icon)
            end
            -- actions.cleave+=/chaos_bolt,if=buff.rain_of_chaos.remains>cast_time
            if A.ChaosBolt:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.RainofChaosBuff.ID) > A.ChaosBolt:GetSpellCastTime() then
                return A.ChaosBolt:Show(icon)
            end
            -- actions.cleave+=/chaos_bolt,if=buff.backdraft.up&!variable.pool_soul_shards
            if A.ChaosBolt:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.BackdraftBuff.ID) > 0 and not poolSoulShards then
                return A.ChaosBolt:Show(icon)
            end
            -- actions.cleave+=/chaos_bolt,if=talent.eradication&!variable.pool_soul_shards&debuff.eradication.remains<cast_time&!action.chaos_bolt.in_flight
            if A.ChaosBolt:IsReady(unitID) and not isMoving and A.Eradication:IsTalentLearned() and not poolSoulShards and Unit(unitID):HasDeBuffs(A.EradicationDebuff.ID) < A.ChaosBolt:GetSpellCastTime() and not A.ChaosBolt:IsSpellInFlight() then
                return A.ChaosBolt:Show(icon)
            end
            -- actions.cleave+=/chaos_bolt,if=buff.madness_cb.up
            if A.ChaosBolt:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.MadnessCB.ID) > 0 then
                return A.ChaosBolt:Show(icon)
            end
            -- actions.cleave+=/soul_fire,if=soul_shard<=4&talent.mayhem
            if A.SoulFire:IsReady(unitID) and not isMoving and soulShards <= 4 and A.Mayhem:IsTalentLearned() then
                return A.SoulFire:Show(icon)
            end
            -- actions.cleave+=/channel_demonfire,if=!(talent.diabolic_embers&talent.avatar_of_destruction&(talent.burn_to_ashes|talent.chaos_incarnate))
            if A.ChannelDemonfire:IsReady(player) and not isMoving and not (A.DiabolicEmbers:IsTalentLearned() and A.AvatarofDestruction:IsTalentLearned() and (A.BurntoAshes:IsTalentLearned() or A.ChaosIncarnate:IsTalentLearned())) then
                return A.ChannelDemonfire:Show(icon)
            end
            -- actions.cleave+=/dimensional_rift
            if A.DimensionalRift:IsReady(unitID) then
                return A.DimensionalRift:Show(icon)
            end
            -- actions.cleave+=/chaos_bolt,if=soul_shard>3.5
            if A.ChaosBolt:IsReady(unitID) and not isMoving and soulShards > 3.5 then
                return A.ChaosBolt:Show(icon)
            end
            -- actions.cleave+=/chaos_bolt,if=!variable.pool_soul_shards&(talent.soul_conduit&!talent.madness_of_the_azjaqir|!talent.backdraft)
            if A.ChaosBolt:IsReady(unitID) and not isMoving and not poolSoulShards and ((A.SoulConduit:IsTalentLearned() and not A.MadnessoftheAzjAqir:IsTalentLearned()) or not A.Backdraft:IsTalentLearned()) then
                return A.ChaosBolt:Show(icon)
            end
            -- actions.cleave+=/chaos_bolt,if=time_to_die<5&time_to_die>cast_time+travel_time
            if A.ChaosBolt:IsReady(unitID) and not isMoving and TTD < 5 and TTD > A.ChaosBolt:GetSpellCastTime() + A.ChaosBolt:GetSpellTravelTime() then
                return A.ChaosBolt:Show(icon)
            end
            -- actions.cleave+=/conflagrate,if=charges>(max_charges-1)|time_to_die<gcd*charges
            if A.Conflagrate:IsReady(unitID) and (A.Conflagrate:GetSpellCharges() > (A.Conflagrate:GetSpellChargesMax() - 1) or TTD < A.GetGCD() * A.Conflagrate:GetSpellCharges()) then
                return A.Conflagrate:Show(icon)
            end
            -- actions.cleave+=/incinerate
            if A.Incinerate:IsReady(unitID) and not isMoving then
                return A.Incinerate:Show(icon)
            end
        
        end
        -- actions+=/call_action_list,name=aoe,if=active_enemies>=3
        if activeEnemies >= 3 then

            -- actions.aoe=call_action_list,name=ogcd
            local useOGCD = oGCD()
            if useOGCD then
                return useOGCD:Show(icon)
            end
            -- actions.aoe+=/call_action_list,name=havoc,if=havoc_active&havoc_remains>gcd&active_enemies<5+(talent.cry_havoc&!talent.inferno)
            local useHavocRotation = HavocRotation()
            if useHavocRotation and havocRemains > 0 and activeEnemies < (5 + num(A.CryHavoc:IsTalentLearned() and not A.Inferno:IsTalentLearned())) then
                return useHavocRotation:Show(icon)
            end
            -- actions.aoe+=/rain_of_fire,if=pet.infernal.active
            -- actions.aoe+=/rain_of_fire,if=talent.avatar_of_destruction
            -- actions.aoe+=/rain_of_fire,if=soul_shard=5
            if A.RainofFire:IsReady(player) and inRange then
                if infernalRemaining > 0 or A.AvatarofDestruction:IsTalentLearned() or soulShards == 5 then
                    return A.RainofFire:Show(icon)
                end
            end
            -- actions.aoe+=/chaos_bolt,if=soul_shard>3.5-(0.1*active_enemies)&!talent.rain_of_fire
            if A.ChaosBolt:IsReady(unitID) and not isMoving and soulShards > (3.5 - (0.1*activeEnemies)) and not A.RainofFire:IsTalentLearned() then
                return A.ChaosBolt:Show(icon)
            end
            -- actions.aoe+=/cataclysm
            if A.Cataclysm:IsReady(player) and not isMoving and inRange then
                return A.Cataclysm:Show(icon)
            end
            -- actions.aoe+=/channel_demonfire,if=dot.immolate.remains>cast_time&talent.raging_demonfire
            if A.ChannelDemonfire:IsReady(player) and not isMoving and Unit(unitID):HasDeBuffs(A.Immolate.ID, true) > A.ChannelDemonfire:GetSpellCastTime() and A.RagingDemonfire:IsTalentLearned() then
                return A.ChannelDemonfire:Show(icon)
            end
            -- actions.aoe+=/immolate,cycle_targets=1,if=dot.immolate.remains<5&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>dot.immolate.remains)&(!talent.raging_demonfire|cooldown.channel_demonfire.remains>remains)&active_dot.immolate<=6
            if A.Immolate:IsReady(unitID) and not isMoving and immolateRefreshable and (not A.Cataclysm:IsTalentLearned() or A.Cataclysm:GetCooldown() > Unit(unitID):HasDeBuffs(A.Immolate.ID, true)) and (not A.RagingDemonfire:IsTalentLearned() or A.ChannelDemonfire:GetCooldown() > Unit(unitID):HasDeBuffs(A.Immolate.ID, true)) and Player:GetDeBuffsUnitCount(A.Immolate.ID) <= 6 then
                return A.Immolate:Show(icon)
            end
            -- actions.aoe+=/havoc,cycle_targets=1,if=!(self.target=target)&!talent.rain_of_fire
            if A.Havoc:IsReady(unitID) and not blockHavoc and not A.RainofFire:IsTalentLearned() then
                return A.Havoc:Show(icon)
            end
            -- actions.aoe+=/summon_soulkeeper,if=buff.tormented_soul.stack=10
            if A.SummonSoulkeeper:IsReady(player) and not isMoving and inRange and A.SummonSoulkeeper:GetCount() == 10 then
                return A.SummonSoulkeeper:Show(icon)
            end
            -- actions.aoe+=/call_action_list,name=ogcd
            local useOGCD = oGCD()
            if useOGCD then
                return useOGCD:Show(icon)
            end
            -- actions.aoe+=/summon_infernal
            if A.SummonInfernal:IsReady(player) and inRange then
                return A.SummonInfernal:Show(icon)
            end
            -- actions.aoe+=/rain_of_fire
            if A.RainofFire:IsReady(player) and inRange then
                return A.RainofFire:Show(icon)
            end
            -- actions.aoe+=/havoc,cycle_targets=1,if=!(self.target=target)
            if A.Havoc:IsReady(unitID) and not blockHavoc then
                return A.Havoc:Show(icon)
            end
            -- actions.aoe+=/channel_demonfire,if=dot.immolate.remains>cast_time
            if A.ChannelDemonfire:IsReady(player) and not isMoving and Unit(unitID):HasDeBuffs(A.Immolate.ID, true) > A.ChannelDemonfire:GetSpellCastTime() then
                return A.ChannelDemonfire:Show(icon)
            end
            -- actions.aoe+=/immolate,cycle_targets=1,if=dot.immolate.remains<5&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>dot.immolate.remains)
            if A.Immolate:IsReady(unitID) and not isMoving and immolateRefreshable and (not A.Cataclysm:IsTalentLearned() or A.Cataclysm:GetCooldown() > Unit(unitID):HasDeBuffs(A.Immolate.ID, true)) then
                return A.Immolate:Show(icon)
            end
            -- actions.aoe+=/soul_fire,if=buff.backdraft.up
            if A.SoulFire:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.BackdraftBuff.ID) > 0 then
                return A.SoulFire:Show(icon)
            end
            -- actions.aoe+=/incinerate,if=talent.fire_and_brimstone.enabled&buff.backdraft.up
            if A.Incinerate:IsReady(unitID) and not isMoving and A.FireandBrimstone:IsTalentLearned() and Unit(player):HasBuffs(A.BackdraftBuff.ID) > 0 then
                return A.Incinerate:Show(icon)
            end
            -- actions.aoe+=/conflagrate,if=buff.backdraft.down|!talent.backdraft
            if A.Conflagrate:IsReady(unitID) and (Unit(player):HasBuffs(A.BackdraftBuff.ID) == 0 or not A.Backdraft:IsTalentLearned()) then
                return A.Conflagrate:Show(icon)
            end
            -- actions.aoe+=/dimensional_rift
            if A.DimensionalRift:IsReady(unitID) then
                return A.DimensionalRift:Show(icon)
            end
            -- actions.aoe+=/immolate,if=dot.immolate.refreshable
            if A.Immolate:IsReady(unitID) and not isMoving and immolateRefreshable then
                return A.Immolate:Show(icon)
            end
            -- actions.aoe+=/incinerate
            if A.Incinerate:IsReady(unitID) and not isMoving then
                return A.Incinerate:Show(icon)
            end

        end

        -- actions+=/call_action_list,name=ogcd
        local useOGCD = oGCD()
        if useOGCD then
            return useOGCD:Show(icon)
        end
        -- actions+=/conflagrate,if=(talent.roaring_blaze&debuff.conflagrate.remains<1.5)|charges=max_charges
        if A.Conflagrate:IsReady(unitID) then
            if (A.RoaringBlaze:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ConflagrateDebuff.ID) < 1.5) or A.Conflagrate:GetSpellCharges() == A.Conflagrate:GetSpellChargesMax() then
                return A.Conflagrate:Show(icon)
            end
        end
        -- actions+=/dimensional_rift,if=soul_shard<4.7&(charges>2|time_to_die<cooldown.dimensional_rift.duration)
        if A.DimensionalRift:IsReady(unitID) and soulShards < 4.7 and A.DimensionalRift:GetSpellCharges() > 2 then
            return A.DimensionalRift:Show(icon)
        end
        -- actions+=/cataclysm
        if A.Cataclysm:IsReady(player) and not isMoving and inRange then
            return A.Cataclysm:Show(icon)
        end
        -- actions+=/channel_demonfire,if=talent.raging_demonfire
        if A.ChannelDemonfire:IsReady(player) and not isMoving and inRange and A.RagingDemonfire:IsTalentLearned() then
            return A.ChannelDemonfire:Show(icon)
        end
        -- actions+=/soul_fire,if=soul_shard<=4
        if A.SoulFire:IsReady(unitID) and not isMoving and soulShards <= 4 then
            return A.SoulFire:Show(icon)
        end
        -- actions+=/immolate,if=((dot.immolate.refreshable&talent.internal_combustion)|dot.immolate.remains<3)&(!talent.cataclysm|cooldown.cataclysm.remains>dot.immolate.remains)&(!talent.soul_fire|cooldown.soul_fire.remains>dot.immolate.remains)
        if A.Immolate:IsReady(unitID) and not isMoving and ((A.InternalCombustion:IsTalentLearned() and immolateRefreshable) or Unit(unitID):HasDeBuffs(A.Immolate.ID, true) < 3) and (not A.Cataclysm:IsTalentLearned() or A.Cataclysm:GetCooldown() > Unit(unitID):HasDeBuffs(A.Immolate.ID, true)) and (not A.SoulFire:IsTalentLearned() or A.SoulFire:GetCooldown() > Unit(unitID):HasDeBuffs(A.Immolate.ID, true)) then
            return A.Immolate:Show(icon)
        end
        -- actions+=/havoc,if=talent.cry_havoc&((buff.ritual_of_ruin.up&pet.infernal.active&talent.burn_to_ashes)|((buff.ritual_of_ruin.up|pet.infernal.active)&!talent.burn_to_ashes))
        if A.Havoc:IsReady(unitID) and not blockHavoc and A.CryHavoc:IsTalentLearned() and ((Unit(player):HasBuffs(A.RitualofRuinBuff.ID) > 0 and infernalRemaining > 0 and A.BurntoAshes:IsTalentLearned()) or((Unit(player):HasBuffs(A.RitualofRuinBuff.ID) > 0 or infernalRemaining > 0) and not A.BurntoAshes:IsTalentLearned())) then
            return A.Havoc:Show(icon)
        end
        -- actions+=/chaos_bolt,if=pet.infernal.active|pet.blasphemy.active|soul_shard>=4
        if A.ChaosBolt:IsReady(unitID) and not isMoving and (infernalRemaining > 0 or blasphemyRemaining > 0 or soulShards >= 4) then
            return A.ChaosBolt:Show(icon)
        end
        -- actions+=/summon_infernal
        if A.SummonInfernal:IsReady(player) and inRange and BurstIsON(unitID) then
            return A.SummonInfernal:Show(icon)
        end
        -- actions+=/channel_demonfire,if=talent.ruin.rank>1&!(talent.diabolic_embers&talent.avatar_of_destruction&(talent.burn_to_ashes|talent.chaos_incarnate))&dot.immolate.remains>cast_time
        if A.ChannelDemonfire:IsReady(player) and not isMoving and A.Ruin:GetTalentTraits() > 1 and not (A.DiabolicEmbers:IsTalentLearned() and A.AvatarofDestruction:IsTalentLearned() and (A.BurntoAshes:IsTalentLearned() or A.ChaosIncarnate:IsTalentLearned())) and Unit(unitID):HasDeBuffs(A.Immolate.ID) > A.ChannelDemonfire:GetSpellCastTime() then
            return A.ChannelDemonfire:Show(icon)
        end
        -- actions+=/conflagrate,if=buff.backdraft.down&soul_shard>=1.5&!talent.roaring_blaze
        if A.Conflagrate:IsReady(unitID) and Unit(player):HasBuffs(A.BackdraftBuff.ID) == 0 and soulShards >= 1.5 and not A.RoaringBlaze:IsTalentLearned() then
            return A.Conflagrate:Show(icon)
        end
        -- actions+=/incinerate,if=buff.burn_to_ashes.up&cast_time+action.chaos_bolt.cast_time<buff.madness_cb.remains
        if A.Incinerate:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.BurntoAshesBuff.ID) > 0 and A.Incinerate:GetSpellCastTime() + A.ChaosBolt:GetSpellCastTime() < Unit(player):HasBuffs(A.MadnessCB.ID) then
            return A.Incinerate:Show(icon)
        end
        -- actions+=/chaos_bolt,if=buff.rain_of_chaos.remains>cast_time
        if A.ChaosBolt:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.RainofChaosBuff.ID) > A.ChaosBolt:GetSpellCastTime() then
            return A.ChaosBolt:Show(icon)
        end
        -- actions+=/chaos_bolt,if=buff.backdraft.up&!talent.eradication&!talent.madness_of_the_azjaqir
        if A.ChaosBolt:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.BackdraftBuff.ID) > 0 and not A.Eradication:IsTalentLearned() and not A.MadnessoftheAzjAqir:IsTalentLearned() then
            return A.ChaosBolt:Show(icon)
        end
        -- actions+=/chaos_bolt,if=buff.madness_cb.up
        if A.ChaosBolt:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.MadnessCB.ID) > 0 then
            return A.ChaosBolt:Show(icon)
        end
        -- actions+=/channel_demonfire,if=!(talent.diabolic_embers&talent.avatar_of_destruction&(talent.burn_to_ashes|talent.chaos_incarnate))&dot.immolate.remains>cast_time
        if A.ChannelDemonfire:IsReady(player) and not isMoving and not (A.DiabolicEmbers:IsTalentLearned() and A.AvatarofDestruction:IsTalentLearned() and (A.BurntoAshes:IsTalentLearned() or A.ChaosIncarnate:IsTalentLearned())) and Unit(unitID):HasDeBuffs(A.Immolate.ID) > A.ChannelDemonfire:GetSpellCastTime() then
            return A.ChannelDemonfire:Show(icon)
        end
        -- actions+=/dimensional_rift
        if A.DimensionalRift:IsReady(unitID) then
            return A.DimensionalRift:Show(icon)
        end
        -- actions+=/chaos_bolt,if=soul_shard>3.5
        if A.ChaosBolt:IsReady(unitID) and not isMoving and soulShards > 3.5 then
            return A.ChaosBolt:Show(icon)
        end
        -- actions+=/chaos_bolt,if=talent.soul_conduit&!talent.madness_of_the_azjaqir|!talent.backdraft
        if A.ChaosBolt:IsReady(unitID) and not isMoving and ((A.SoulConduit:IsTalentLearned() and not A.MadnessoftheAzjAqir:IsTalentLearned()) or not A.Backdraft:IsTalentLearned()) then
            return A.ChaosBolt:Show(icon)
        end
        -- actions+=/chaos_bolt,if=time_to_die<5&time_to_die>cast_time+travel_time
        if A.ChaosBolt:IsReady(unitID) and not isMoving and TTD < 5 and TTD > A.ChaosBolt:GetSpellCastTime() + A.ChaosBolt:GetSpellTravelTime() then
            return A.ChaosBolt:Show(icon)
        end
        -- actions+=/conflagrate,if=charges>(max_charges-1)|time_to_die<gcd*charges
        if A.Conflagrate:IsReady(unitID) and (A.Conflagrate:GetSpellCharges() > (A.Conflagrate:GetSpellChargesMax() - 1) or TTD < A.GetGCD() * A.Conflagrate:GetSpellCharges()) then
            return A.Conflagrate:Show(icon)
        end
        -- actions+=/incinerate
        if A.Incinerate:IsReady(unitID) and not isMoving then
            return A.Incinerate:Show(icon)
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