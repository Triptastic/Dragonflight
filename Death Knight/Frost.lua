--####################################
--##### TRIP'S FROST DEATHKNIGHT #####
--####################################

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

Action[ACTION_CONST_DEATHKNIGHT_FROST] = {
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
	
    PathofFrost    = Action.Create({ Type = "Spell", ID = 3714 }),
    Strength       = Action.Create({ Type = "Spell", ID = 27973 }),
    ArmyoftheDead  = Action.Create({ Type = "Spell", ID = 42650 }),
    DeathandDecay  = Action.Create({ Type = "Spell", ID = 43265 }),
    DeathandDecayBuff  = Action.Create({ Type = "Spell", ID = 188290 }),
    DeathStrike    = Action.Create({ Type = "Spell", ID = 45470 }),
    ChainsofIce    = Action.Create({ Type = "Spell", ID = 45524 }),
    RaiseDead      = Action.Create({ Type = "Spell", ID = 46584 }),
    RisenGhoulSelfStun= Action.Create({ Type = "Spell", ID = 47466 }),
    Claw           = Action.Create({ Type = "Spell", ID = 47468 }),
    Gnaw           = Action.Create({ Type = "Spell", ID = 47481 }),
    Leap           = Action.Create({ Type = "Spell", ID = 47482 }),
    Huddle         = Action.Create({ Type = "Spell", ID = 47484 }),
    MindFreeze     = Action.Create({ Type = "Spell", ID = 47528 }),
    DeathCoil      = Action.Create({ Type = "Spell", ID = 47541 }),
    DeathCoilPlayer      = Action.Create({ Type = "Spell", ID = 47541, Texture = 98008 }),
    EmpowerRuneWeapon= Action.Create({ Type = "Spell", ID = 47568 }),
    VeteranoftheThirdWar= Action.Create({ Type = "Spell", ID = 48263 }),
    DeathsAdvance  = Action.Create({ Type = "Spell", ID = 48265 }),
    AntiMagicShell = Action.Create({ Type = "Spell", ID = 48707 }),
    DeathPact      = Action.Create({ Type = "Spell", ID = 48743 }),
    IceboundFortitude= Action.Create({ Type = "Spell", ID = 48792 }),
    Obliterate     = Action.Create({ Type = "Spell", ID = 49020 }),
    DancingRuneWeapon= Action.Create({ Type = "Spell", ID = 49028 }),
    Lichborne      = Action.Create({ Type = "Spell", ID = 49039 }),
    FrostStrike    = Action.Create({ Type = "Spell", ID = 49143 }),
    HowlingBlast   = Action.Create({ Type = "Spell", ID = 49184 }),
    SummonGargoyle = Action.Create({ Type = "Spell", ID = 49206 }),
    SuddenDoom     = Action.Create({ Type = "Spell", ID = 49530 }),
    DeathGrip      = Action.Create({ Type = "Spell", ID = 49576 }),
    BloodBoil      = Action.Create({ Type = "Spell", ID = 50842 }),
    DeathGate      = Action.Create({ Type = "Spell", ID = 50977 }),
    AntiMagicZone  = Action.Create({ Type = "Spell", ID = 51052 }),
    KillingMachine = Action.Create({ Type = "Spell", ID = 51124 }),
    PillarofFrost  = Action.Create({ Type = "Spell", ID = 51271 }),
    RunicCorruption= Action.Create({ Type = "Spell", ID = 51460 }),
    Razorice       = Action.Create({ Type = "Spell", ID = 51714 }),
    GargoyleStrike = Action.Create({ Type = "Spell", ID = 51963 }),
    OnaPaleHorse   = Action.Create({ Type = "Spell", ID = 51986 }),
    RuneofRazorice = Action.Create({ Type = "Spell", ID = 53343 }),
    RuneoftheFallenCrusader= Action.Create({ Type = "Spell", ID = 53344 }),
    UnholyStrength = Action.Create({ Type = "Spell", ID = 53365 }),
    BloodPlague    = Action.Create({ Type = "Spell", ID = 55078 }),
    ScourgeStrike  = Action.Create({ Type = "Spell", ID = 55090 }),
    FrostFever     = Action.Create({ Type = "Spell", ID = 55095 }),
    VampiricBlood  = Action.Create({ Type = "Spell", ID = 55233 }),
    IncreaseVersatility15= Action.Create({ Type = "Spell", ID = 55564 }),
    DarkCommand    = Action.Create({ Type = "Spell", ID = 56222 }),
    HornofWinter   = Action.Create({ Type = "Spell", ID = 57330 }),
    GlyphofFoulMenagerie= Action.Create({ Type = "Spell", ID = 58642 }),
    Geist          = Action.Create({ Type = "Spell", ID = 58707 }),
    FoulMenagerie  = Action.Create({ Type = "Spell", ID = 58723 }),
    Rime           = Action.Create({ Type = "Spell", ID = 59052 }),
    RaiseAlly      = Action.Create({ Type = "Spell", ID = 61999 }),
    StoneskinGargoyle= Action.Create({ Type = "Spell", ID = 62157 }),
    RuneoftheStoneskinGargoyle= Action.Create({ Type = "Spell", ID = 62158 }),
    BasicAttackFocusCostModifier= Action.Create({ Type = "Spell", ID = 62762 }),
    DarkTransformation= Action.Create({ Type = "Spell", ID = 63560 }),
    DeathStrikeOffHand= Action.Create({ Type = "Spell", ID = 66188 }),
    FrostStrikeOffHand= Action.Create({ Type = "Spell", ID = 66196 }),
    ObliterateOffHand= Action.Create({ Type = "Spell", ID = 66198 }),
    MasteryMasterofBeasts= Action.Create({ Type = "Spell", ID = 76657 }),
    MasteryBloodShield= Action.Create({ Type = "Spell", ID = 77513 }),
    MasteryFrozenHeart= Action.Create({ Type = "Spell", ID = 77514 }),
    MasteryDreadblade= Action.Create({ Type = "Spell", ID = 77515 }),
    BloodShield    = Action.Create({ Type = "Spell", ID = 77535 }),
    Outbreak       = Action.Create({ Type = "Spell", ID = 77575 }),
    CrimsonScourge = Action.Create({ Type = "Spell", ID = 81136 }),
    RunicEmpowerment= Action.Create({ Type = "Spell", ID = 81229 }),
    BloodBurst     = Action.Create({ Type = "Spell", ID = 81280 }),
    MightoftheFrozenWastes= Action.Create({ Type = "Spell", ID = 81333 }),
    FesteringStrike= Action.Create({ Type = "Spell", ID = 85948 }),
    SweepingClaws  = Action.Create({ Type = "Spell", ID = 91778 }),
    MonstrousBlow  = Action.Create({ Type = "Spell", ID = 91797 }),
    ShamblingRush  = Action.Create({ Type = "Spell", ID = 91802 }),
    PutridBulwark  = Action.Create({ Type = "Spell", ID = 91837 }),
    ItemProcMastery= Action.Create({ Type = "Spell", ID = 92322 }),
    VoidTouched    = Action.Create({ Type = "Spell", ID = 97821 }),
    DarkSuccor     = Action.Create({ Type = "Spell", ID = 101568 }),
    Asphyxiate     = Action.Create({ Type = "Spell", ID = 108194 }),
    GorefiendsGrasp= Action.Create({ Type = "Spell", ID = 108199 }),
    ControlUndead  = Action.Create({ Type = "Spell", ID = 111673 }),
    Purgatory      = Action.Create({ Type = "Spell", ID = 114556 }),
    UnholyBlight   = Action.Create({ Type = "Spell", ID = 115989 }),
    ShroudofPurgatory= Action.Create({ Type = "Spell", ID = 116888 }),
    Perdition      = Action.Create({ Type = "Spell", ID = 123981 }),
    CorpseExploder = Action.Create({ Type = "Spell", ID = 127344 }),
    BattleFatigue  = Action.Create({ Type = "Spell", ID = 134732 }),
    PvPRulesEnabledHARDCODED= Action.Create({ Type = "Spell", ID = 134735 }),
    DeathKnight    = Action.Create({ Type = "Spell", ID = 137005 }),
    FrostDeathKnight= Action.Create({ Type = "Spell", ID = 137006 }),
    UnholyDeathKnight= Action.Create({ Type = "Spell", ID = 137007 }),
    BloodDeathKnight= Action.Create({ Type = "Spell", ID = 137008 }),
    ElementalShaman= Action.Create({ Type = "Spell", ID = 137040 }),
    Skeleton       = Action.Create({ Type = "Spell", ID = 147963 }),
    BreathofSindragosa= Action.Create({ Type = "Spell", ID = 152279 }),
    Defile         = Action.Create({ Type = "Spell", ID = 152280 }),
    Riposte        = Action.Create({ Type = "Spell", ID = 161797 }),
    StatNegationAuraStrengthDPS= Action.Create({ Type = "Spell", ID = 162698 }),
    StatNegationAuraStrengthTank= Action.Create({ Type = "Spell", ID = 162702 }),
    FrostBreath    = Action.Create({ Type = "Spell", ID = 190780 }),
    AspectoftheBeast= Action.Create({ Type = "Spell", ID = 191384 }),
    VirulentPlague = Action.Create({ Type = "Spell", ID = 191587 }),
    Stormkeeper    = Action.Create({ Type = "Spell", ID = 191634 }),
    VirulentEruption= Action.Create({ Type = "Spell", ID = 191685 }),
    FesteringWound = Action.Create({ Type = "Spell", ID = 194310 }),
    RapidDecomposition= Action.Create({ Type = "Spell", ID = 194662 }),
    RuneTap        = Action.Create({ Type = "Spell", ID = 194679 }),
    Bonestorm      = Action.Create({ Type = "Spell", ID = 194844 }),
    IcyTalons      = Action.Create({ Type = "Spell", ID = 194878 }),
    FrozenPulse    = Action.Create({ Type = "Spell", ID = 194909 }),
    GatheringStorm = Action.Create({ Type = "Spell", ID = 194912 }),
    GlacialAdvance = Action.Create({ Type = "Spell", ID = 194913 }),
    AllWillServe   = Action.Create({ Type = "Spell", ID = 194916 }),
    PestilentPustules= Action.Create({ Type = "Spell", ID = 194917 }),
    BoneShield     = Action.Create({ Type = "Spell", ID = 195181 }),
    Marrowrend     = Action.Create({ Type = "Spell", ID = 195182 }),
    DeathsCaress   = Action.Create({ Type = "Spell", ID = 195292 }),
    Bloodworms     = Action.Create({ Type = "Spell", ID = 195679 }),
    Bloodworm      = Action.Create({ Type = "Spell", ID = 196361 }),
    RemorselessWinter= Action.Create({ Type = "Spell", ID = 196770 }),
    ActivatingSpecialization= Action.Create({ Type = "Spell", ID = 200749 }),
    Consumption    = Action.Create({ Type = "Spell", ID = 205224 }),
    RedThirst      = Action.Create({ Type = "Spell", ID = 205723 }),
    AntiMagicBarrier= Action.Create({ Type = "Spell", ID = 205727 }),
    HeartStrike    = Action.Create({ Type = "Spell", ID = 206930 }),
    Blooddrinker   = Action.Create({ Type = "Spell", ID = 206931 }),
    MarkofBlood    = Action.Create({ Type = "Spell", ID = 206940 }),
    WilloftheNecropolis= Action.Create({ Type = "Spell", ID = 206967 }),
    TighteningGrasp= Action.Create({ Type = "Spell", ID = 206970 }),
    FoulBulwark    = Action.Create({ Type = "Spell", ID = 206974 }),
    ShatteringBlade= Action.Create({ Type = "Spell", ID = 207057 }),
    MurderousEfficiency= Action.Create({ Type = "Spell", ID = 207061 }),
    RunicAttenuation= Action.Create({ Type = "Spell", ID = 207104 }),
    Icecap         = Action.Create({ Type = "Spell", ID = 207126 }),
    Avalanche      = Action.Create({ Type = "Spell", ID = 207142 }),
    BlindingSleet  = Action.Create({ Type = "Spell", ID = 207167 }),
    VolatileShielding= Action.Create({ Type = "Spell", ID = 207188 }),
    Permafrost     = Action.Create({ Type = "Spell", ID = 207200 }),
    Frostscythe    = Action.Create({ Type = "Spell", ID = 207230 }),
    Obliteration   = Action.Create({ Type = "Spell", ID = 207256 }),
    BurstingSores  = Action.Create({ Type = "Spell", ID = 207264 }),
    EbonFever      = Action.Create({ Type = "Spell", ID = 207269 }),
    InfectedClaws  = Action.Create({ Type = "Spell", ID = 207272 }),
    UnholyAssault  = Action.Create({ Type = "Spell", ID = 207289 }),
    ClawingShadows = Action.Create({ Type = "Spell", ID = 207311 }),
    SludgeBelcher  = Action.Create({ Type = "Spell", ID = 207313 }),
    Epidemic       = Action.Create({ Type = "Spell", ID = 207317 }),
    SpellEater     = Action.Create({ Type = "Spell", ID = 207321 }),
    DarkArbiter    = Action.Create({ Type = "Spell", ID = 207349 }),
    KoltirasNewfoundWill= Action.Create({ Type = "Spell", ID = 208782 }),
    Heartbreaker   = Action.Create({ Type = "Spell", ID = 210738 }),
    DarkEmpowerment= Action.Create({ Type = "Spell", ID = 211947 }),
    SkulkerShot    = Action.Create({ Type = "Spell", ID = 212423 }),
    WraithWalk     = Action.Create({ Type = "Spell", ID = 212552 }),
    Ossuary        = Action.Create({ Type = "Spell", ID = 219786 }),
    Tombstone      = Action.Create({ Type = "Spell", ID = 219809 }),
    BloodStrike    = Action.Create({ Type = "Spell", ID = 220890 }),
    BloodTap       = Action.Create({ Type = "Spell", ID = 221699 }),
    VindicaarMatrixCrystal= Action.Create({ Type = "Spell", ID = 251463 }),
    ItemDeathKnightT21Unholy2PBonus= Action.Create({ Type = "Spell", ID = 251871 }),
    CoilsofDevastation= Action.Create({ Type = "Spell", ID = 253367 }),
    InexorableAssault= Action.Create({ Type = "Spell", ID = 253593 }),
    Haste          = Action.Create({ Type = "Spell", ID = 261582 }),
    ResoundingProtection= Action.Create({ Type = "Spell", ID = 263962 }),
    AzeriteEmpowered= Action.Create({ Type = "Spell", ID = 263978 }),
    ElementalWhirl = Action.Create({ Type = "Spell", ID = 263984 }),
    HeedMyCall     = Action.Create({ Type = "Spell", ID = 263987 }),
    BloodSiphon    = Action.Create({ Type = "Spell", ID = 264108 }),
    OverwhelmingPower= Action.Create({ Type = "Spell", ID = 266180 }),
    AzeriteGlobules= Action.Create({ Type = "Spell", ID = 266936 }),
    Gutripper      = Action.Create({ Type = "Spell", ID = 266937 }),
    Lifespeed      = Action.Create({ Type = "Spell", ID = 267665 }),
    WindsofWar     = Action.Create({ Type = "Spell", ID = 267671 }),
    AzeriteVeins   = Action.Create({ Type = "Spell", ID = 267683 }),
    OnMyWay        = Action.Create({ Type = "Spell", ID = 267879 }),
    Woundbinder    = Action.Create({ Type = "Spell", ID = 267880 }),
    ConcentratedMending= Action.Create({ Type = "Spell", ID = 267882 }),
    Savior         = Action.Create({ Type = "Spell", ID = 267883 }),
    BracingChill   = Action.Create({ Type = "Spell", ID = 267884 }),
    EphemeralRecovery= Action.Create({ Type = "Spell", ID = 267886 }),
    BlessedPortents= Action.Create({ Type = "Spell", ID = 267889 }),
    SynergisticGrowth= Action.Create({ Type = "Spell", ID = 267892 }),
    AzeriteFortification= Action.Create({ Type = "Spell", ID = 268435 }),
    ImpassiveVisage= Action.Create({ Type = "Spell", ID = 268437 }),
    Longstrider    = Action.Create({ Type = "Spell", ID = 268594 }),
    BulwarkoftheMasses= Action.Create({ Type = "Spell", ID = 268595 }),
    Gemhide        = Action.Create({ Type = "Spell", ID = 268596 }),
    VampiricSpeed  = Action.Create({ Type = "Spell", ID = 268599 }),
    SelfReliance   = Action.Create({ Type = "Spell", ID = 268600 }),
    CrystallineCarapace= Action.Create({ Type = "Spell", ID = 271536 }),
    AblativeShielding= Action.Create({ Type = "Spell", ID = 271540 }),
    StrengthinNumbers= Action.Create({ Type = "Spell", ID = 271546 }),
    ShimmeringHaven= Action.Create({ Type = "Spell", ID = 271557 }),
    DeepCuts       = Action.Create({ Type = "Spell", ID = 272684 }),
    IcyCitadel     = Action.Create({ Type = "Spell", ID = 272718 }),
    BoneSpikeGraveyard= Action.Create({ Type = "Spell", ID = 273088 }),
    LatentChill    = Action.Create({ Type = "Spell", ID = 273093 }),
    HorridExperimentation= Action.Create({ Type = "Spell", ID = 273095 }),
    RuinousBolt    = Action.Create({ Type = "Spell", ID = 273150 }),
    MeticulousScheming= Action.Create({ Type = "Spell", ID = 273682 }),
    RezansFury     = Action.Create({ Type = "Spell", ID = 273790 }),
    BlightborneInfusion= Action.Create({ Type = "Spell", ID = 273823 }),
    SecretsoftheDeep= Action.Create({ Type = "Spell", ID = 273829 }),
    FilthyTransfusion= Action.Create({ Type = "Spell", ID = 273834 }),
    Hemostasis     = Action.Create({ Type = "Spell", ID = 273946 }),
    GripoftheDead  = Action.Create({ Type = "Spell", ID = 273952 }),
    Voracious      = Action.Create({ Type = "Spell", ID = 273953 }),
    Marrowblood    = Action.Create({ Type = "Spell", ID = 274057 }),
    Festermight    = Action.Create({ Type = "Spell", ID = 274081 }),
    Apocalypse     = Action.Create({ Type = "Spell", ID = 275699 }),
    EchoingHowl    = Action.Create({ Type = "Spell", ID = 275917 }),
    HarrowingDecay = Action.Create({ Type = "Spell", ID = 275929 }),
    HarbingerofDoom= Action.Create({ Type = "Spell", ID = 276023 }),
    DeathsReach    = Action.Create({ Type = "Spell", ID = 276079 }),
    ArmyoftheDamned= Action.Create({ Type = "Spell", ID = 276837 }),
    Pestilence     = Action.Create({ Type = "Spell", ID = 277234 }),
    EternalRuneWeapon= Action.Create({ Type = "Spell", ID = 278479 }),
    KillerFrost    = Action.Create({ Type = "Spell", ID = 278480 }),
    CankerousWounds= Action.Create({ Type = "Spell", ID = 278482 }),
    BonesoftheDamned= Action.Create({ Type = "Spell", ID = 278484 }),
    FrozenTempest  = Action.Create({ Type = "Spell", ID = 278487 }),
    LastSurprise   = Action.Create({ Type = "Spell", ID = 278489 }),
    FrostwyrmsFury = Action.Create({ Type = "Spell", ID = 279302 }),
    UnstableFlames = Action.Create({ Type = "Spell", ID = 279899 }),
    Earthlink      = Action.Create({ Type = "Spell", ID = 279926 }),
    RunicBarrier   = Action.Create({ Type = "Spell", ID = 280010 }),
    MarchoftheDamned= Action.Create({ Type = "Spell", ID = 280011 }),
    BarrageOfManyBombs= Action.Create({ Type = "Spell", ID = 280163 }),
    RicochetingInflatablePyrosaw= Action.Create({ Type = "Spell", ID = 280168 }),
    AutoSelfCauterizer= Action.Create({ Type = "Spell", ID = 280172 }),
    SynapticSparkCapacitor= Action.Create({ Type = "Spell", ID = 280174 }),
    RelationalNormalizationGizmo= Action.Create({ Type = "Spell", ID = 280178 }),
    PersonalAbsorboTron= Action.Create({ Type = "Spell", ID = 280181 }),
    DaggerintheBack= Action.Create({ Type = "Spell", ID = 280284 }),
    ThunderousBlast= Action.Create({ Type = "Spell", ID = 280380 }),
    TidalSurge     = Action.Create({ Type = "Spell", ID = 280402 }),
    BloodRite      = Action.Create({ Type = "Spell", ID = 280407 }),
    IncitethePack  = Action.Create({ Type = "Spell", ID = 280410 }),
    SwirlingSands  = Action.Create({ Type = "Spell", ID = 280429 }),
    ArchiveoftheTitans= Action.Create({ Type = "Spell", ID = 280555 }),
    LaserMatrix    = Action.Create({ Type = "Spell", ID = 280559 }),
    GloryinBattle  = Action.Create({ Type = "Spell", ID = 280577 }),
    RetaliatoryFury= Action.Create({ Type = "Spell", ID = 280579 }),
    CombinedMight  = Action.Create({ Type = "Spell", ID = 280580 }),
    CollectiveWill = Action.Create({ Type = "Spell", ID = 280581 }),
    BattlefieldFocus= Action.Create({ Type = "Spell", ID = 280582 }),
    SylvanasResolve= Action.Create({ Type = "Spell", ID = 280598 }),
    LiberatorsMight= Action.Create({ Type = "Spell", ID = 280623 }),
    LastGift       = Action.Create({ Type = "Spell", ID = 280624 }),
    StrongerTogether= Action.Create({ Type = "Spell", ID = 280625 }),
    StandAsOne     = Action.Create({ Type = "Spell", ID = 280626 }),
    BattlefieldPrecision= Action.Create({ Type = "Spell", ID = 280627 }),
    AnduinsDedication= Action.Create({ Type = "Spell", ID = 280628 }),
    ChampionofAzeroth= Action.Create({ Type = "Spell", ID = 280710 }),
    ColdHeart      = Action.Create({ Type = "Spell", ID = 281208 }),
    UnstableCatalyst= Action.Create({ Type = "Spell", ID = 281514 }),
    Tradewinds     = Action.Create({ Type = "Spell", ID = 281841 }),
    Helchains      = Action.Create({ Type = "Spell", ID = 286832 }),
    FrostwhelpsIndignation= Action.Create({ Type = "Spell", ID = 287283 }),
    ShadowofElune  = Action.Create({ Type = "Spell", ID = 287467 }),
    AncientsBulwark= Action.Create({ Type = "Spell", ID = 287604 }),
    ApothecarysConcoctions= Action.Create({ Type = "Spell", ID = 287631 }),
    EndlessHunger  = Action.Create({ Type = "Spell", ID = 287662 }),
    FightorFlight  = Action.Create({ Type = "Spell", ID = 287818 }),
    MagusoftheDead = Action.Create({ Type = "Spell", ID = 288417 }),
    ColdHearted    = Action.Create({ Type = "Spell", ID = 288424 }),
    ShadowBolt     = Action.Create({ Type = "Spell", ID = 288546 }),
    Frostbolt      = Action.Create({ Type = "Spell", ID = 288548 }),
    SeductivePower = Action.Create({ Type = "Spell", ID = 288749 }),
    BondedSouls    = Action.Create({ Type = "Spell", ID = 288802 }),

    TreacherousCovenant= Action.Create({ Type = "Spell", ID = 288953 }),
    BloodyRuneblade= Action.Create({ Type = "Spell", ID = 289339 }),
    StriveforPerfection= Action.Create({ Type = "Spell", ID = 296321 }),
    VisionofPerfection= Action.Create({ Type = "Spell", ID = 297745 }),
    PersonComputerInterface= Action.Create({ Type = "Spell", ID = 300168 }),
    ClockworkHeart = Action.Create({ Type = "Spell", ID = 300170 }),
    ArcaneHeart    = Action.Create({ Type = "Spell", ID = 303006 }),
    LoyaltotheEnd  = Action.Create({ Type = "Spell", ID = 303007 }),
    UndulatingTides= Action.Create({ Type = "Spell", ID = 303008 }),
    ChillStreak    = Action.Create({ Type = "Spell", ID = 305392 }),
    SwarmingMist   = Action.Create({ Type = "Spell", ID = 311730 }),
    RuneStrike     = Action.Create({ Type = "Spell", ID = 316239 }),
    ImprovedFrostStrike= Action.Create({ Type = "Spell", ID = 316803 }),
    ImprovedRime   = Action.Create({ Type = "Spell", ID = 316838 }),
    ImprovedFesteringStrike= Action.Create({ Type = "Spell", ID = 316867 }),
    CleavingStrikes= Action.Create({ Type = "Spell", ID = 316916 }),
    UnholyCommand  = Action.Create({ Type = "Spell", ID = 316941 }),
    ImprovedVampiricBlood= Action.Create({ Type = "Spell", ID = 317133 }),
    HeartofDarkness= Action.Create({ Type = "Spell", ID = 317137 }),
    ImprovedObliterate= Action.Create({ Type = "Spell", ID = 317198 }),
    Frostreaper    = Action.Create({ Type = "Spell", ID = 317214 }),
    RelishinBlood  = Action.Create({ Type = "Spell", ID = 317610 }),
    UnholyPact     = Action.Create({ Type = "Spell", ID = 319230 }),
    HypothermicPresence= Action.Create({ Type = "Spell", ID = 321995 }),
    DeathsDue      = Action.Create({ Type = "Spell", ID = 324164 }),
    RuneofSanguination= Action.Create({ Type = "Spell", ID = 326801 }),
    Satiated       = Action.Create({ Type = "Spell", ID = 326809 }),
    RuneofSpellwarding= Action.Create({ Type = "Spell", ID = 326855 }),
    Lethargy       = Action.Create({ Type = "Spell", ID = 326868 }),
    RuneofHysteria = Action.Create({ Type = "Spell", ID = 326911 }),
    RuneofUnendingThirst= Action.Create({ Type = "Spell", ID = 326977 }),
    UnendingThirst = Action.Create({ Type = "Spell", ID = 326982 }),
    RuneoftheApocalypse= Action.Create({ Type = "Spell", ID = 327082 }),
    SacrificialPact= Action.Create({ Type = "Spell", ID = 327574 }),
    ToxicAccumulator= Action.Create({ Type = "Spell", ID = 333388 }),
    BryndaorsMight = Action.Create({ Type = "Spell", ID = 334501 }),
    CrimsonRuneWeapon= Action.Create({ Type = "Spell", ID = 334525 }),
    VampiricAura   = Action.Create({ Type = "Spell", ID = 334547 }),
    GorefiendsDomination= Action.Create({ Type = "Spell", ID = 334580 }),
    KoltirasFavor  = Action.Create({ Type = "Spell", ID = 334583 }),
    BitingCold     = Action.Create({ Type = "Spell", ID = 334678 }),
    AbsoluteZero   = Action.Create({ Type = "Spell", ID = 334692 }),
    GripoftheEverlasting= Action.Create({ Type = "Spell", ID = 334724 }),
    DeathsEmbrace  = Action.Create({ Type = "Spell", ID = 334728 }),
    ReanimatedShambler= Action.Create({ Type = "Spell", ID = 334836 }),
    FrenziedMonstrosity= Action.Create({ Type = "Spell", ID = 334888 }),
    DeathsCertainty= Action.Create({ Type = "Spell", ID = 334898 }),
    DeadliestCoil  = Action.Create({ Type = "Spell", ID = 334949 }),
    Superstrain    = Action.Create({ Type = "Spell", ID = 334974 }),
    Phearomones    = Action.Create({ Type = "Spell", ID = 335177 }),
    WilloftheBerserker= Action.Create({ Type = "Spell", ID = 335594 }),
    EternalHunger  = Action.Create({ Type = "Spell", ID = 337381 }),
    ChilledResilience= Action.Create({ Type = "Spell", ID = 337704 }),
    SpiritDrain    = Action.Create({ Type = "Spell", ID = 337705 }),
    ReinforcedShell= Action.Create({ Type = "Spell", ID = 337764 }),
    AcceleratedCold= Action.Create({ Type = "Spell", ID = 337822 }),
    WitheringPlague= Action.Create({ Type = "Spell", ID = 337884 }),
    EradicatingBlow= Action.Create({ Type = "Spell", ID = 337934 }),
    BloodBond      = Action.Create({ Type = "Spell", ID = 337957 }),
    HardenedBones  = Action.Create({ Type = "Spell", ID = 337972 }),
    EmbraceDeath   = Action.Create({ Type = "Spell", ID = 337980 }),
    Everfrost      = Action.Create({ Type = "Spell", ID = 337988 }),
    FleetingWind   = Action.Create({ Type = "Spell", ID = 338089 }),
    UnendingGrip   = Action.Create({ Type = "Spell", ID = 338311 }),
    InsatiableAppetite= Action.Create({ Type = "Spell", ID = 338330 }),
    MeatShield     = Action.Create({ Type = "Spell", ID = 338435 }),
    UnleashedFrenzy= Action.Create({ Type = "Spell", ID = 338492 }),
    DebilitatingMalady= Action.Create({ Type = "Spell", ID = 338516 }),
    ConvocationoftheDead= Action.Create({ Type = "Spell", ID = 338553 }),
    LingeringPlague= Action.Create({ Type = "Spell", ID = 338566 }),
    ImpenetrableGloom= Action.Create({ Type = "Spell", ID = 338628 }),
    BrutalGrasp    = Action.Create({ Type = "Spell", ID = 338651 }),
    Proliferation  = Action.Create({ Type = "Spell", ID = 338664 }),
    WitheringGround= Action.Create({ Type = "Spell", ID = 341344 }),
    RageoftheFrozenChampion= Action.Create({ Type = "Spell", ID = 341724 }),
    SoulReaper     = Action.Create({ Type = "Spell", ID = 343294 }),
    AbominationsFrenzy= Action.Create({ Type = "Spell", ID = 353447 }),
    InsatiableHunger= Action.Create({ Type = "Spell", ID = 353699 }),
    FinalSentence  = Action.Create({ Type = "Spell", ID = 353822 }),
    RampantTransference= Action.Create({ Type = "Spell", ID = 353882 }),
    ArcticAssault  = Action.Create({ Type = "Spell", ID = 363411 }),
    HarvestTime    = Action.Create({ Type = "Spell", ID = 363560 }),
    EndlessRuneWaltz= Action.Create({ Type = "Spell", ID = 363590 }),
    RemnantsDespair= Action.Create({ Type = "Spell", ID = 368690 }),
    EndlessRuneWaltzEnergize= Action.Create({ Type = "Spell", ID = 368938 }),
    MercilessStrikes= Action.Create({ Type = "Spell", ID = 373923 }),
    Acclimation    = Action.Create({ Type = "Spell", ID = 373926 }),
    ProliferatingChill= Action.Create({ Type = "Spell", ID = 373930 }),
    BloodScent     = Action.Create({ Type = "Spell", ID = 374030 }),
    Suppression    = Action.Create({ Type = "Spell", ID = 374049 }),
    MightofThassarian= Action.Create({ Type = "Spell", ID = 374111 }),
    UnholyBond     = Action.Create({ Type = "Spell", ID = 374261 }),
    UnholyGround   = Action.Create({ Type = "Spell", ID = 374265 }),
    ImprovedDeathStrike= Action.Create({ Type = "Spell", ID = 374277 }),
    Assimilation   = Action.Create({ Type = "Spell", ID = 374383 }),
    Brittle        = Action.Create({ Type = "Spell", ID = 374504 }),
    RuneMastery    = Action.Create({ Type = "Spell", ID = 374574 }),
    BloodDraw      = Action.Create({ Type = "Spell", ID = 374598 }),
    ImprovedBoneShield= Action.Create({ Type = "Spell", ID = 374715 }),
    ImprovedHeartStrike= Action.Create({ Type = "Spell", ID = 374717 }),
    BloodFortification= Action.Create({ Type = "Spell", ID = 374721 }),
    ReinforcedBones= Action.Create({ Type = "Spell", ID = 374737 }),
    PerseveranceoftheEbonBlade= Action.Create({ Type = "Spell", ID = 374747 }),
    RunicCommand   = Action.Create({ Type = "Spell", ID = 376251 }),
    FrigidExecutioner= Action.Create({ Type = "Spell", ID = 377073 }),
    ColdBloodedRage= Action.Create({ Type = "Spell", ID = 377083 }),
    InvigoratingFreeze= Action.Create({ Type = "Spell", ID = 377092 }),
    Bonegrinder    = Action.Create({ Type = "Spell", ID = 377098 }),
    EnduringStrength= Action.Create({ Type = "Spell", ID = 377190 }),
    FrostwhelpsAid = Action.Create({ Type = "Spell", ID = 377226 }),
    PiercingChill  = Action.Create({ Type = "Spell", ID = 377351 }),
    EnduringChill  = Action.Create({ Type = "Spell", ID = 377376 }),
    UnholyAura     = Action.Create({ Type = "Spell", ID = 377440 }),
    Reaping        = Action.Create({ Type = "Spell", ID = 377514 }),
    DeathRot       = Action.Create({ Type = "Spell", ID = 377537 }),
    ImprovedDeathCoil= Action.Create({ Type = "Spell", ID = 377580 }),
    ReplenishingWounds= Action.Create({ Type = "Spell", ID = 377585 }),
    GhoulishFrenzy = Action.Create({ Type = "Spell", ID = 377587 }),
    Morbidity      = Action.Create({ Type = "Spell", ID = 377592 }),
    LeechingStrike = Action.Create({ Type = "Spell", ID = 377629 }),
    InsatiableBlade= Action.Create({ Type = "Spell", ID = 377637 }),
    ShatteringBone = Action.Create({ Type = "Spell", ID = 377640 }),
    Heartrend      = Action.Create({ Type = "Spell", ID = 377655 }),
    EverlastingBond= Action.Create({ Type = "Spell", ID = 377668 }),
    BeastMaster    = Action.Create({ Type = "Spell", ID = 378007 }),
    TrainingExpert = Action.Create({ Type = "Spell", ID = 378209 }),
    Coldthirst     = Action.Create({ Type = "Spell", ID = 378848 }),
    Ferocity       = Action.Create({ Type = "Spell", ID = 378916 }),
    AbominationLimb= Action.Create({ Type = "Spell", ID = 383312 }),
    ClenchingGrasp = Action.Create({ Type = "Spell", ID = 389679 }),
    UnholyEndurance= Action.Create({ Type = "Spell", ID = 389682 }),
    FeastingStrikes= Action.Create({ Type = "Spell", ID = 390161 }),
    RunicMastery   = Action.Create({ Type = "Spell", ID = 390166 }),
    Plaguebringer  = Action.Create({ Type = "Spell", ID = 390175 }),
    RupturedViscera= Action.Create({ Type = "Spell", ID = 390220 }),
    CommanderoftheDead= Action.Create({ Type = "Spell", ID = 390259 }),
    EternalAgony   = Action.Create({ Type = "Spell", ID = 390268 }),
    CoilofDevastation= Action.Create({ Type = "Spell", ID = 390270 }),
    RottenTouch    = Action.Create({ Type = "Spell", ID = 390275 }),
    VileContagion  = Action.Create({ Type = "Spell", ID = 390279 }),
    BloodFeast     = Action.Create({ Type = "Spell", ID = 391386 }),
    IronHeart      = Action.Create({ Type = "Spell", ID = 391395 }),
    Bloodshot      = Action.Create({ Type = "Spell", ID = 391398 }),
    SanguineGround = Action.Create({ Type = "Spell", ID = 391458 }),
    Coagulopathy   = Action.Create({ Type = "Spell", ID = 391477 }),
    UmbilicusEternus= Action.Create({ Type = "Spell", ID = 391517 }),
    MarchofDarkness= Action.Create({ Type = "Spell", ID = 391546 }),
    InsidiousChill = Action.Create({ Type = "Spell", ID = 391566 }),
    GloomWard      = Action.Create({ Type = "Spell", ID = 391571 }),
    Enfeeble       = Action.Create({ Type = "Spell", ID = 392487 }),
    Icebreaker     = Action.Create({ Type = "Spell", ID = 392950 }),
    DeathKnightBloodClassSet2pc= Action.Create({ Type = "Spell", ID = 393621 }),
    DeathKnightBloodClassSet4pc= Action.Create({ Type = "Spell", ID = 393622 }),
    DeathKnightFrostClassSet2pc= Action.Create({ Type = "Spell", ID = 393623 }),
    DeathKnightFrostClassSet4pc= Action.Create({ Type = "Spell", ID = 393624 }),
    DeathKnightUnholyClassSet2pc= Action.Create({ Type = "Spell", ID = 393626 }),
    DeathKnightUnholyClassSet4pc= Action.Create({ Type = "Spell", ID = 393627 }),
    VigorousLifeblood= Action.Create({ Type = "Spell", ID = 394559 }),
    VileInfusion   = Action.Create({ Type = "Spell", ID = 394863 }),
    GhoulishInfusion= Action.Create({ Type = "Spell", ID = 394899 }),
    FatalFixation  = Action.Create({ Type = "Spell", ID = 405166 }),
    DeathKnightBlood101ClassSet2pc= Action.Create({ Type = "Spell", ID = 405499 }),
    DeathKnightBlood101ClassSet4pc= Action.Create({ Type = "Spell", ID = 405500 }),
    DeathKnightFrost101ClassSet2pc= Action.Create({ Type = "Spell", ID = 405501 }),
    DeathKnightFrost101ClassSet4pc= Action.Create({ Type = "Spell", ID = 405502 }),
    DeathKnightUnholy101ClassSet2pc= Action.Create({ Type = "Spell", ID = 405503 }),
    DeathKnightUnholy101ClassSet4pc= Action.Create({ Type = "Spell", ID = 405504 }),
    VampiricStrength= Action.Create({ Type = "Spell", ID = 408356 }),
    WrathoftheFrostwyrm= Action.Create({ Type = "Spell", ID = 408368 }),
    MasterofDeath  = Action.Create({ Type = "Spell", ID = 408375 }),
    DeathDealer    = Action.Create({ Type = "Spell", ID = 408376 }),
    DoomDealer     = Action.Create({ Type = "Spell", ID = 408377 }),
    LingeringChill = Action.Create({ Type = "Spell", ID = 410879 }),
    


}

local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_FROST], { __index = Action })

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
local focus = "focus"
local mouseover = "mouseover"



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
    useOpener                               = false,
	incomingAoEDamage                       = { 372735, -- Tectonic Slam (RLP)
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
                                                241687, -- Sonic Scream (DPS Mage Tower)
                                                188114, -- Shatter (NL)
                                                413387, -- Crashing Stone (VP)
                                                374586, -- Might of the Forge (N)

    },
    deathStrikeDOT                          = { 378020, -- Gash Frenzy (BH)

    },
    useDefensiveDebuff                      = { 378229, --Marked for Butchery (BH)
                                                367484, --Vicious Clawmangle (BH)
                                                367521, --Bone Bolt (BH)
                                                384974, --Scented Meat (BH)
                                                384425, --Smells Like Meat (BH)
                                                265016, --Blood Harvest (Underrot)
                                                265568, --Dark Omen (Underrot)
                                                257739, --Blind Rage (Freehold)
                                                183539, --Barbed Tongue (Neltharion)
                                                200154, --Burning Hatred (Neltharion)
                                                372225, --Dragonbone Axe (Neltharion)
                                                378818, --Magma Conflagration (Neltharion)
                                                374073, --Seismic Slam (Halls of Infusion)
                                                374724, --Molten Subduction (Halls of Infusion)
                                                385832, --Bloodthirsty Charge (Brackenhide Hollow)
                                                368287, --Toxic Trap (Brackenhide Hollow)
                                                388060, --Stink Breath (Brackenhide Hollow)
                                                266107, --Thirst for Blood (Underrot)
                                                377522, --Burning Pursuit (N)
                                                369328, --Earthquake (Uldaman)


    },
    useAMZoneCast                           = { 384014, -- Statis Surge (HoI)
                                                376208, -- Rewind Timeflow (Ulda)
                                                374594, -- Might of the Forge (Neltharus)
    },
    useAMShellCast                          = { 381694, -- Decayed Senses (BH)
                                                376170, -- Choking Rotcloud (BH)
                                                389179, -- Power Overload (HoI)
                                                389443, -- Purifying Blast (HoI)
                                                387559, -- Infused Globules (HoI)
                                                382303, -- Quaking Totem (Ulda)
                                                369061, -- Searing Clap (Ulda)
                                                377017, -- Molten Gold (Neltharus)
                                                88194, -- Icy Buffet (VP)
                                                411002, -- Turbulence (VP)
                                                384623, -- Forgestomp (N)
                                                384663, -- Forgewrought Fury (N)
                                                374365, -- Volatile Mutation (N)
                                                391634, -- Deep Chill (HoI)
                                                388882, -- Inundate (HoI)
                                                388424, -- Tempest's Fury (HoI)
                                                381593, -- Thunderous Clap (Ulda)

                                                
    },
    useAMSShellTarget                       = { 373424, -- Grounding Spear (Neltharus)

    },
    useAMShellDebuff                        = { 377864, -- Infectious Spit (BH)
                                                374389, -- Gulp Swong Toxin (HoI)
                                                374812, -- Blazing Aegis (Neltharus)
                                                374842, -- Blazing Aegis (Neltharus)
    },
    useDeathsAdvanceCast                    = { 372701, -- Crushing Stomp (Ulda)
                                                376049, -- Wing Buffet (Ulda)
                                                373424, -- Grounding Spear (Neltharus)
                                                188114, -- Shatter (Neltharion's Lair)
                                                376934, -- Grasping Vines (BH)
    },
}


local mouseoverCoI = {
    [18864] = true,

}   

local blockAbom = {
    [196712] = true, -- HoI first boss
    [189719] = true, -- HoI first boss adds
    [184018] = true, -- Bromach Uldaman (Abom for totem only)

}

local forceAbom = {
    [186696] = true, -- Quaking Totam (Uldaman)

}

local function SelfDefensives()	

	if Unit(player):CombatTime() == 0 then 
        return 
    end 

	if A.CanUseHealthstoneOrHealingPotion() then
		return A.Healthstone
	end

    local defensiveActive = Unit(player):HasBuffs(A.Lichborne.ID) > 0 or Unit(player):HasBuffs(A.IceboundFortitude.ID) > 0
    if (Unit(player):HasDeBuffs(Temp.useDefensiveDebuff) > 0 or Unit(player):HealthPercent() <= 30) and not defensiveActive then
        if A.Lichborne:IsReady(player) then
            return A.Darkflight
        end
        if A.IceboundFortitude:IsReady(player) then
            return A.IceboundFortitude
        end
    end

    if A.AntiMagicShell:IsReady(player) and Unit(player):HasDeBuffs(Temp.useAMShellDebuff) > 0 then
        return A.AntiMagicShell
    end

    if A.AntiMagicZone:IsReady(player) and MultiUnits:GetByRangeCasting(60, 1, nil, Temp.useAMZoneCast) >= 1 then
        return A.AntiMagicZone
    end

    if A.AntiMagicShell:IsReady(player) and (MultiUnits:GetByRangeCasting(60, 1, nil, Temp.useAMShellCast) >= 1 or (Unit(target):IsCasting() == Temp.useAMSShellTarget and Unit(target):IsCastingRemains() <= 1)) then
        return A.AntiMagicShell
    end

    if A.DeathsAdvance:IsReady(player) and MultiUnits:GetByRangeCasting(60, 1, nil, Temp.useDeathsAdvanceCast) >= 1 then
        return A.DeathsAdvance
    end

    if A.DeathPact:IsReady(player) and Unit(player):HealthPercent() <= A.GetToggle(2, "DeathPactHP") then
        return A.DeathPact
    end

    if A.DeathCoilPlayer:IsReady(player) and Unit(player):HasBuffs(A.Lichborne.ID) > 0 and Unit(player):HealthPercent() <= A.GetToggle(2, "DeathStrikeHP") then
        return A.DeathCoilPlayer
    end

    if A.DeathStrike:IsReady(unitID) and (Unit(player):HealthPercent() <= A.GetToggle(2, "DeathStrikeHP") or Unit(player):HasDeBuffs(Temp.deathStrikeDOT) > 0) then
        return A.DeathStrike
    end

	if A.Fireblood:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
		return A.Fireblood
	end 

    if A.WraithWalk:IsReady(player) and (LoC:Get("SNARE") > 0 or LoC:Get("ROOT") > 0 or Unit(player):GetMaxSpeed() <= 70) and Unit(player):HasBuffs(A.WraithWalk.ID) == 0 then
		return A.WraithWalk
	end   


end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        if useKick and not notInterruptable and A.MindFreeze:IsReady(unitID) then 
            return A.MindFreeze
        end
		    
        if useCC and not Unit(unitID):IsBoss() and A.Asphyxiate:IsReady(unitID) then 
            return A.Asphyxiate
        end

        if useCC and not Unit(unitID):IsBoss() and Unit(unitID):GetRange() <= 10 and A.BlindingSleet:IsReady(player) then 
            return A.BlindingSleet
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

local function InMelee(unitID)
	-- @return boolean 
	return A.FrostStrike:IsInRange(unitID)
end 



--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local runicPower = Player:RunicPower()
    local runicPowerDeficit = Player:RunicPowerDeficit()
    local runicPowerMax = Player:RunicPowerMax()
    local UseRacial = A.GetToggle(1, "Racial")
    local useAoE = A.GetToggle(2, "AoE")
    local rwBuffs = A.GatheringStorm:IsTalentLearned() or A.Everfrost:IsTalentLearned()
    local check2h = IsEquippedItemType("Two-Hand")
    local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID = GetWeaponEnchantInfo()
    local hasRazorice = mainHandEnchantID == 3370
    local hasFallenCrusader = mainHandEnchantID == 3368
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local enemiesInRange = MultiUnits:GetByRange(10, 5)
    local activeEnemies = MultiUnits:GetByRange(10, 5)
    if Unit(target):IsEnemy() and InMelee() and activeEnemies == 0 then
        activeEnemies = 1
    end
     
    local petTime = Player:GetTotemTimeLeft(1)
    Player:AddTier("Tier30", { 205810, 202462, 202461, 202460, 202459, })
    local T30has2P = Player:HasTier("Tier30", 2)
    local T30has4P = Player:HasTier("Tier30", 4)

    -- actions.variables=variable,name=st_planning,value=active_enemies=1&(raid_event.adds.in>15|!raid_event.adds.exists)
    local stPlanning = activeEnemies <= 1
    -- actions.variables+=/variable,name=adds_remain,value=active_enemies>=2&(!raid_event.adds.exists|raid_event.adds.exists&raid_event.adds.remains>5)
    local addsRemain = activeEnemies >= 2
    -- actions.variables+=/variable,name=rime_buffs,value=buff.rime.react&(talent.rage_of_the_frozen_champion|talent.avalanche|talent.icebreaker)
    local rimeBuffs = Unit(player):HasBuffs(A.Rime.ID) > 0 and (A.RageoftheFrozenChampion:IsTalentLearned() or A.Avalanche:IsTalentLearned() or A.Icebreaker:IsTalentLearned())
    -- actions.variables+=/variable,name=rp_buffs,value=talent.unleashed_frenzy&(buff.unleashed_frenzy.remains<gcd.max*3|buff.unleashed_frenzy.stack<3)|talent.icy_talons&(buff.icy_talons.remains<gcd.max*3|buff.icy_talons.stack<3)
    local rpBuffs = A.UnleashedFrenzy:IsTalentLearned() and (Unit(player):HasBuffs(A.UnleashedFrenzy.ID) < A.GetGCD() * 3 or Unit(player):HasBuffsStacks(A.UnleashedFrenzy.ID) < 3) or A.IcyTalons:IsTalentLearned() and (Unit(player):HasBuffs(A.IcyTalons.ID) < A.GetGCD() * 3 or Unit(player):HasBuffsStacks(A.IcyTalons.ID) < 3)
    -- actions.variables+=/variable,name=cooldown_check,value=talent.pillar_of_frost&buff.pillar_of_frost.up&(talent.obliteration&buff.pillar_of_frost.remains<6|!talent.obliteration)|!talent.pillar_of_frost&buff.empower_rune_weapon.up|!talent.pillar_of_frost&!talent.empower_rune_weapon|active_enemies>=2&buff.pillar_of_frost.up
    local cooldownCheck = A.PillarofFrost:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) > 0 and (A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) < 6 or not A.Obliteration:IsTalentLearned()) or not A.PillarofFrost:IsTalentLearned() and Unit(player):HasBuffs(A.EmpowerRuneWeapon.ID) > 0 or not A.PillarofFrost:IsTalentLearned() and not A.EmpowerRuneWeapon:IsTalentLearned() or activeEnemies >= 2 and Unit(player):HasBuffs(A.PillarofFrost.ID) > 0

    -- actions.variables+=/variable,name=frostscythe_priority,value=talent.frostscythe&(buff.killing_machine.react|active_enemies>=3)&(!talent.improved_obliterate&!talent.frigid_executioner&!talent.frostreaper&!talent.might_of_the_frozen_wastes|!talent.cleaving_strikes|talent.cleaving_strikes&(active_enemies>6|!death_and_decay.ticking&active_enemies>3))
    local frostscythePriority = A.Frostscythe:IsTalentLearned() and (Unit(player):HasBuffs(A.KillingMachine.ID) > 0 or activeEnemies >=3) and (not A.ImprovedObliterate:IsTalentLearned() and not A.FrigidExecutioner:IsTalentLearned() and not A.Frostreaper:IsTalentLearned() and not A.MightoftheFrozenWastes:IsTalentLearned() or not A.CleavingStrikes:IsTalentLearned() or A.CleavingStrikes:IsTalentLearned() and (activeEnemies > 6 or Unit(player):HasBuffs(A.DeathandDecayBuff.ID) == 0 and activeEnemies > 3))

    -- actions.variables+=/variable,name=oblit_pooling_time,op=setif,value=((cooldown.pillar_of_frost.remains_expected+1)%gcd.max)%((rune+3)*(runic_power+5))*100,value_else=3,condition=runic_power<35&rune<2&cooldown.pillar_of_frost.remains_expected<10
    if runicPower < 35 and Player:Rune() < 2 and A.PillarofFrost:GetCooldown() < 10 then
        oblitPoolingTime = (((A.PillarofFrost:GetCooldown() + 1) % A.GetGCD()) / ((Player:Rune() + 3) * (runicPower + 5))) * 100
    else
        oblitPoolingTime = 3
    end
    -- actions.variables+=/variable,name=breath_pooling_time,op=setif,value=((cooldown.breath_of_sindragosa.remains+1)%gcd.max)%((rune+1)*(runic_power+20))*100,value_else=3,condition=runic_power.deficit>10&cooldown.breath_of_sindragosa.remains<10
    if runicPowerDeficit > 10 and A.BreathofSindragosa:GetCooldown() < 10 then
        breathPoolingTime = (((A.BreathofSindragosa:GetCooldown() + 1) % A.GetGCD()) / ((Player:Rune() + 1) * (runicPower + 20))) * 100
    else
        breathPoolingTime = 3
    end

    -- actions.variables+=/variable,name=pooling_runes,value=rune<4&talent.obliteration&cooldown.pillar_of_frost.remains_expected<variable.oblit_pooling_time
    if Player:Rune() < 4 and A.Obliteration:IsTalentLearned() and A.PillarofFrost:GetCooldown() < oblitPoolingTime then
        poolingRunes = true
    else
        poolingRunes = false
    end

    -- actions.variables+=/variable,name=pooling_runic_power,value=talent.breath_of_sindragosa&cooldown.breath_of_sindragosa.remains<variable.breath_pooling_time|talent.obliteration&runic_power<35&cooldown.pillar_of_frost.remains_expected<variable.oblit_pooling_time
    if (A.BreathofSindragosa:IsTalentLearned() and A.BreathofSindragosa:GetCooldown() < breathPoolingTime) or (A.Obliteration:IsTalentLearned() and runicPower < 35 and A.PillarofFrost:GetCooldown() < oblitPoolingTime) then
        poolingRunicPower = true
    else
        poolingRunicPower = false
    end
    
    if Player:IsSwimming() and not inCombat then
        if A.PathofFrost:IsReady(player) and Unit(player):HasBuffs(A.PathofFrost.ID) == 0 then
            return A.PathofFrost:Show(icon)
        end
    end


    local function DungeonStuff(unitID)
		
        local npcID = select(6, Unit(mouseover):InfoGUID())	
        if A.ChainsofIce:IsReady(mouseover) and mouseoverCoI[npcID] and Unit(mouseover):HasDeBuffs(A.ChainsofIce.ID) == 0 then
            return A.ChainsofIce:Show(icon)
        end

    end


    local function AoERotation(unitID)

        -- actions.aoe=remorseless_winter
        if A.RemorselessWinter:IsReady(player) then
            return A.RemorselessWinter:Show(icon)
        end
        -- actions.aoe+=/howling_blast,if=buff.rime.react|!dot.frost_fever.ticking
        if Unit(player):HasBuffs(A.Rime.ID) > 0 or Unit(unitID):HasDeBuffs(A.FrostFever.ID) == 0 then
            if A.HowlingBlast:IsReady(unitID) then
                return A.HowlingBlast:Show(icon)
            end
        end
        -- actions.aoe+=/glacial_advance,if=!variable.pooling_runic_power&variable.rp_buffs
        if not poolingRunicPower and rpBuffs then
            if A.GlacialAdvance:IsReady(player) then
                return A.GlacialAdvance:Show(icon)
            end
        end    
        -- actions.aoe+=/obliterate,if=buff.killing_machine.react&talent.cleaving_strikes&death_and_decay.ticking&!variable.frostscythe_priority
        if Unit(player):HasBuffs(A.KillingMachine.ID) > 0 and A.CleavingStrikes:IsTalentLearned() and Unit(player):HasBuffs(A.DeathandDecayBuff.ID) > 0 and not frostscythePriority then
            if A.Obliterate:IsReady(unitID) then
                return A.Obliterate:Show(icon)
            end
        end
        -- actions.aoe+=/glacial_advance,if=!variable.pooling_runic_power
        if not poolingRunicPower then
            if A.GlacialAdvance:IsReady(player) then
                return A.GlacialAdvance:Show(icon)
            end
        end    
        -- actions.aoe+=/frostscythe,if=variable.frostscythe_priority
        if frostscythePriority then
            if A.Frostscythe:IsReady(player) then
                return A.Frostscythe:Show(icon)
            end
        end    
        -- actions.aoe+=/obliterate,if=!variable.frostscythe_priority
        if not frostscythePriority then
            if A.Obliterate:IsReady(unitID) then
                return A.Obliterate:Show(icon)
            end
        end    
        -- actions.aoe+=/frost_strike,if=!variable.pooling_runic_power&!talent.glacial_advance
        if not poolingRunicPower and not A.GlacialAdvance:IsTalentLearned() then
            if A.FrostStrike:IsReady(unitID) then
                return A.FrostStrike:Show(icon)
            end
        end    
        -- actions.aoe+=/horn_of_winter,if=rune<2&runic_power.deficit>25
        if Player:Rune() < 2 and runicPowerDeficit > 25 then
            if A.HornofWinter:IsReady(player) then
                return A.HornofWinter:Show(icon)
            end
        end    
        -- actions.aoe+=/arcane_torrent,if=runic_power.deficit>25
        if runicPowerDeficit > 25 then
            if A.ArcaneTorrent:IsReady(unitID) and useRacial then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
    end
    
    local function Breath(unitID)
        -- actions.breath=remorseless_winter,if=variable.rw_buffs|variable.adds_remain
        if rwBuffs or addsRemain then
            if A.RemorselessWinter:IsReady(player) then
                return A.RemorselessWinter:Show(icon)
            end
        end
        -- actions.breath+=/howling_blast,if=variable.rime_buffs&runic_power>(45-talent.rage_of_the_frozen_champion*8)
        if rimeBuffs and runicPower > (45 - (A.RageoftheFrozenChampion:IsTalentLearned() and 8 or 0)) then
            if A.HowlingBlast:IsReady(unitID) then
                return A.HowlingBlast:Show(icon) 
            end
        end
        -- actions.breath+=/horn_of_winter,if=rune<2&runic_power.deficit>25
        if Player:Rune() < 2 and runicPowerDeficit > 25 then
            if A.HornofWinter:IsReady(player) then
                return A.HornofWinter:Show(icon)
            end
        end
        -- actions.breath+=/obliterate,target_if=max:(debuff.Razorice.stack+1)%(debuff.Razorice.remains+1)*death_knight.runeforge.Razorice,if=buff.killing_machine.react&!variable.frostscythe_priority
        if Unit(player):HasBuffs(A.KillingMachine.ID) > 0 and not frostscythePriority then
            if A.Obliterate:IsReady(unitID) then
                return A.Obliterate:Show(icon)
            end
        end
    
        -- actions.breath+=/frostscythe,if=buff.killing_machine.react&variable.frostscythe_priority
        if Unit(player):HasBuffs(A.KillingMachine.ID) > 0 and frostscythePriority then
            if A.Frostscythe:IsReady(player) then
                return A.Frostscythe:Show(icon)
            end
        end
        -- actions.breath+=/frostscythe,if=variable.frostscythe_priority&runic_power>45
        if frostscythePriority and runicPower > 45 then
            if A.Frostscythe:IsReady(player) then
                return A.Frostscythe:Show(icon)
            end
        end
    
        -- actions.breath+=/obliterate,if=runic_power.deficit>40|buff.pillar_of_frost.up&runic_power.deficit>17
        if runicPowerDeficit > 40 or (Unit(player):HasBuffs(A.PillarofFrost.ID) > 0 and runicPowerDeficit > 17) then
            if A.Obliterate:IsReady(unitID) then
                return A.Obliterate:Show(icon)
            end
        end
    
        -- actions.breath+=/death_and_decay,if=runic_power<36&rune.time_to_2>runic_power%18
        if runicPower < 36 and Player:RuneTimeToX(2) > runicPower % 18 then
            if A.DeathandDecay:IsReady(player) and not isMoving and InMelee() then
                return A.DeathandDecay:Show(icon)
            end
        end
    
        -- actions.breath+=/remorseless_winter,if=runic_power<36&rune.time_to_2>runic_power%18
        if runicPower < 36 and Player:RuneTimeToX(2) > runicPower % 18 then
            if A.RemorselessWinter:IsReady(player) then
                return A.RemorselessWinter:Show(icon)
            end
        end
    
        -- actions.breath+=/howling_blast,if=runic_power<36&rune.time_to_2>runic_power%18
        if runicPower < 36 and Player:RuneTimeToX(2) > runicPower % 18 then
            if A.HowlingBlast:IsReady(unitID) then
                return A.HowlingBlast:Show(icon)
            end
        end
    
        -- actions.breath+=/obliterate,if=runic_power.deficit>25
        if runicPowerDeficit > 25 then
            if A.Obliterate:IsReady(unitID) then
                return A.Obliterate:Show(icon)
            end
        end
    
        -- actions.breath+=/howling_blast,if=buff.rime.react
        if Unit(player):HasBuffs(A.Rime.ID) > 0 then
            if A.HowlingBlast:IsReady(unitID) then
                return A.HowlingBlast:Show(icon)
            end
        end
    
        -- actions.breath+=/arcane_torrent,if=runic_power<60
        if runicPower < 60 then
            if A.ArcaneTorrent:IsReady(unitID) and useRacial then
                return A.ArcaneTorrent:Show(icon)
            end
        end
    
    end
    
    local function BreathOblit(unitID)
    
        -- actions.breath_oblit=frostscythe,if=buff.killing_machine.up&variable.frostscythe_priority
        if Unit(player):HasBuffs(A.KillingMachine.ID) > 0 and frostscythePriority then
            if A.Frostscythe:IsReady(player) and InMelee() then
                return A.Frostscythe:Show(icon)
            end
        end
    
        -- actions.breath_oblit+=/obliterate,if=buff.killing_machine.up
        if Unit(player):HasBuffs(A.KillingMachine.ID) > 0 then
            if A.Obliterate:IsReady(unitID) then
                return A.Obliterate:Show(icon)
            end
        end
    
        -- actions.breath_oblit+=/howling_blast,if=buff.rime.react
        if Unit(player):HasBuffs(A.Rime.ID) > 0 then
            if A.HowlingBlast:IsReady(unitID) then
                return A.HowlingBlast:Show(icon)
            end
        end
    
        -- actions.breath_oblit+=/howling_blast,if=!buff.killing_machine.up
        if Unit(player):HasBuffs(A.KillingMachine.ID) == 0 then
            if A.HowlingBlast:IsReady(unitID) then
                return A.HowlingBlast:Show(icon)
            end
        end
    
        -- actions.breath_oblit+=/horn_of_winter,if=runic_power.deficit>25
        if runicPowerDeficit > 25 then
            if A.HornofWinter:IsReady(player) then
                return A.HornofWinter:Show(icon)
            end
        end
    
        -- actions.breath_oblit+=/arcane_torrent,if=runic_power.deficit>20
        if runicPowerDeficit > 20 then
            if A.ArcaneTorrent:IsReady(player) and useRacial then
                return A.ArcaneTorrent:Show(icon)
            end
        end
    end
    
    local function ColdHeart(unitID)
    
        -- actions.cold_heart=chains_of_ice,if=fight_remains<gcd&(rune<2|!buff.killing_machine.up&(!variable.2hCheck&buff.cold_heart.stack>=4|variable.2hCheck&buff.cold_heart.stack>8)|buff.killing_machine.up&(!variable.2hCheck&buff.cold_heart.stack>8|variable.2hCheck&buff.cold_heart.stack>10))
        if (Player:Rune() < 2 or (Unit(player):HasBuffs(A.KillingMachine.ID) == 0 and (not check2h and Unit(player):HasBuffsStacks(A.ColdHeart.ID) >= 4 or check2h and Unit(player):HasBuffsStacks(A.ColdHeart.ID) > 8)) or (Unit(player):HasBuffs(A.KillingMachine.ID) > 0 and (not check2h and Unit(player):HasBuffsStacks(A.ColdHeart.ID) > 8 or check2h and Unit(player):HasBuffsStacks(A.ColdHeart.ID) > 10))) then
            if A.ChainsofIce:IsReady(unitID) then
                return A.ChainsofIce:Show(icon)
            end
        end
    
        -- actions.cold_heart+=/chains_of_ice,if=!talent.obliteration&buff.pillar_of_frost.up&buff.cold_heart.stack>=10&(buff.pillar_of_frost.remains<gcd*(1+(talent.frostwyrms_fury&cooldown.frostwyrms_fury.ready))|buff.unholy_strength.up&buff.unholy_strength.remains<gcd)
        if not A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) > 0 and Unit(player):HasBuffsStacks(A.ColdHeart.ID) >= 10 and (Unit(player):HasBuffs(A.PillarofFrost.ID) < A.ChainsofIce:Cooldown() * (1 + (A.FrostwyrmsFury:IsTalentLearned() and A.FrostwyrmsFury:Cooldown() == 0)) or Unit(player):HasBuffs(A.UnholyStrength.ID) > 0 and Unit(player):HasBuffs(A.UnholyStrength.ID) < A.ChainsofIce:Cooldown()) then
            if A.ChainsofIce:IsReady(unitID) then
                return A.ChainsofIce:Show(icon)
            end
        end
    
        -- actions.cold_heart+=/chains_of_ice,if=!talent.obliteration&death_knight.runeforge.fallen_crusader&!buff.pillar_of_frost.up&cooldown.pillar_of_frost.remains_expected>15&(buff.cold_heart.stack>=10&buff.unholy_strength.up|buff.cold_heart.stack>=13)
        if not A.Obliteration:IsTalentLearned() and hasFallenCrusader and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 and A.PillarofFrost:GetCooldown() > 15 and (Unit(player):HasBuffsStacks(A.ColdHeart.ID) >= 10 and Unit(player):HasBuffs(A.UnholyStrength.ID) > 0 or Unit(player):HasBuffsStacks(A.ColdHeart.ID) >= 13) then
            if A.ChainsofIce:IsReady(unitID) then
                return A.ChainsofIce:Show(icon)
            end
        end
    
        -- actions.cold_heart+=/chains_of_ice,if=!talent.obliteration&!death_knight.runeforge.fallen_crusader&buff.cold_heart.stack>=10&!buff.pillar_of_frost.up&cooldown.pillar_of_frost.remains_expected>20
        if not A.Obliteration:IsTalentLearned() and not hasFallenCrusader and Unit(player):HasBuffsStacks(A.ColdHeart.ID) >= 10 and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 and A.PillarofFrost:GetCooldown() > 20 then
            if A.ChainsofIce:IsReady(unitID) then
                return A.ChainsofIce:Show(icon)
            end
        end
    
        -- actions.cold_heart+=/chains_of_ice,if=talent.obliteration&!buff.pillar_of_frost.up&(buff.cold_heart.stack>=14&(buff.unholy_strength.up|buff.chaos_bane.up)|buff.cold_heart.stack>=19|cooldown.pillar_of_frost.remains_expected<3&buff.cold_heart.stack>=14)
        if A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 and (Unit(player):HasBuffsStacks(A.ColdHeart.ID) >= 14 and (Unit(player):HasBuffs(A.UnholyStrength.ID) > 0 or Unit(player):HasBuffs(A.ChaosBane.ID) > 0) or Unit(player):HasBuffsStacks(A.ColdHeart.ID) >= 19 or A.PillarofFrost:GetCooldown() < 3 and Unit(player):HasBuffsStacks(A.ColdHeart.ID) >= 14) then
            if A.ChainsofIce:IsReady(unitID) then
                return A.ChainsofIce:Show(icon)
            end
        end
        
    end
    
    local function Cooldowns(unitID)
    
        -- actions.cooldowns=potion,if=variable.cooldown_check|fight_remains<25
    
    
        -- actions.cooldowns+=/empower_rune_weapon,if=talent.obliteration&!buff.empower_rune_weapon.up&rune<6&(cooldown.pillar_of_frost.remains_expected<7&(variable.adds_remain|variable.st_planning)|buff.pillar_of_frost.up)|fight_remains<20
        if A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.EmpowerRuneWeapon.ID) == 0 and Player:Rune() < 6 and (A.PillarofFrost:GetCooldown() < 7 and (addsRemain or stPlanning) or Unit(player):HasBuffs(A.PillarofFrost.ID) > 0) then
            if A.EmpowerRuneWeapon:IsReady(player) then
                return A.EmpowerRuneWeapon:Show(icon)
            end
        end
    
        -- actions.cooldowns+=/empower_rune_weapon,use_off_gcd=1,if=buff.breath_of_sindragosa.up&talent.breath_of_sindragosa&!buff.empower_rune_weapon.up&(runic_power<70&rune<3|time<10)
        if Unit(player):HasBuffs(A.BreathofSindragosa.ID) > 0 and A.BreathofSindragosa:IsTalentLearned() and Unit(player):HasBuffs(A.EmpowerRuneWeapon.ID) == 0 and (runicPower < 70 and Player:Rune() < 3 or combatTime < 10) then
            if A.EmpowerRuneWeapon:IsReady(player) then
                return A.EmpowerRuneWeapon:Show(icon)
            end
        end
    
        -- actions.cooldowns+=/empower_rune_weapon,use_off_gcd=1,if=!talent.breath_of_sindragosa&!talent.obliteration&!buff.empower_rune_weapon.up&rune<5&(cooldown.pillar_of_frost.remains_expected<7|buff.pillar_of_frost.up|!talent.pillar_of_frost)
        if not A.BreathofSindragosa:IsTalentLearned() and not A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.EmpowerRuneWeapon.ID) == 0 and Player:Rune() < 5 and (A.PillarofFrost:GetCooldown() < 7 or Unit(player):HasBuffs(A.PillarofFrost.ID) > 0 or not A.PillarofFrost:IsTalentLearned()) then
            if A.EmpowerRuneWeapon:IsReady(player) then
                return A.EmpowerRuneWeapon:Show(icon)
            end
        end

        -- actions.cooldowns+=/abomination_limb,if=talent.obliteration&!buff.pillar_of_frost.up&cooldown.pillar_of_frost.remains<3&(variable.adds_remain|variable.st_planning)|fight_remains<12
        local npcID = select(6, Unit(unitID):InfoGUID())	
        if not blockAbom[npcID] and Unit(player):HasDeBuffs(384425) == 0 then --Smell Like Meat Brakenhide (don't want to accidently pull hyena into player)
            if A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 and A.PillarofFrost:GetCooldown() < 3 and (addsRemain or stPlanning) then
                if A.AbominationLimb:IsReady(player) then 
                    return A.AbominationLimb:Show(icon)
                end
            end        

            -- actions.cooldowns+=/abomination_limb,if=talent.breath_of_sindragosa&(variable.adds_remain|variable.st_planning)
            if A.BreathofSindragosa:IsTalentLearned() and (addsRemain or stPlanning) then
                if A.AbominationLimb:IsReady(player) then 
                    return A.AbominationLimb:Show(icon)
                end
            end

            -- actions.cooldowns+=/abomination_limb,if=!talent.breath_of_sindragosa&!talent.obliteration&(variable.adds_remain|variable.st_planning)
            if not A.BreathofSindragosa:IsTalentLearned() and not A.Obliteration:IsTalentLearned() and (addsRemain or stPlanning) then
                if A.AbominationLimb:IsReady(player) then 
                    return A.AbominationLimb:Show(icon)
                end
            end
        end

        if forceAbom[npcID] then
            if A.AbominationLimb:IsReady(player) then
                return A.AbominationLimb:Show(icon)
            end
        end

        -- actions.cooldowns+=/chill_streak,if=active_enemies>=2&(!death_and_decay.ticking&talent.cleaving_strikes|!talent.cleaving_strikes|active_enemies<=5)
        if activeEnemies >= 2 and (Unit(player):HasBuffs(A.DeathandDecayBuff.ID) == 0 and A.CleavingStrikes:IsTalentLearned() or not A.CleavingStrikes:IsTalentLearned() or activeEnemies <= 5) then
            if A.ChillStreak:IsReady(unitID) then
                return A.ChillStreak:Show(icon)
            end
        end    
    
        -- actions.cooldowns+=/pillar_of_frost,if=talent.obliteration&(variable.adds_remain|variable.st_planning)&(buff.empower_rune_weapon.up|cooldown.empower_rune_weapon.remains)|fight_remains<12
        if A.PillarofFrost:IsReady(player) and A.PillarofFrost:IsTalentLearned() and (addsRemain or stPlanning) and (Unit(player):HasBuffs(A.EmpowerRuneWeapon.ID) > 0 or A.EmpowerRuneWeapon:GetCooldown() > 0) then
            return A.PillarofFrost:Show(icon)
        end
        
        -- actions.cooldowns+=/pillar_of_frost,if=talent.breath_of_sindragosa&(variable.adds_remain|variable.st_planning)&(!talent.icecap&(runic_power>70|cooldown.breath_of_sindragosa.remains>40)|talent.icecap&(cooldown.breath_of_sindragosa.remains>10|buff.breath_of_sindragosa.up))
        if A.PillarofFrost:IsReady(player) and A.PillarofFrost:IsTalentLearned() and (addsRemain or stPlanning) and 
        ((not A.Icecap:IsTalentLearned() and (runicPower > 70 or A.BreathofSindragosa:GetCooldown() > 40)) or 
        (A.Icecap:IsTalentLearned() and (A.BreathofSindragosa:GetCooldown() > 10 or Unit(player):HasBuffs(A.BreathofSindragosa.ID) > 0))) then
            return A.PillarofFrost:Show(icon)
        end
        
        -- actions.cooldowns+=/pillar_of_frost,if=talent.icecap&!talent.obliteration&!talent.breath_of_sindragosa&(variable.adds_remain|variable.st_planning)
        if A.PillarofFrost:IsReady(player) and A.PillarofFrost:IsTalentLearned() and not A.Obliteration:IsTalentLearned() and not A.BreathofSindragosa:IsTalentLearned() and (addsRemain or stPlanning) then
            return A.PillarofFrost:Show(icon)
        end
        
        -- actions.cooldowns+=/breath_of_sindragosa,if=!buff.breath_of_sindragosa.up&runic_power>60&(variable.adds_remain|variable.st_planning)|fight_remains<30
        if A.BreathofSindragosa:IsReady(player) and InMelee() and Unit(player):HasBuffs(A.BreathofSindragosa.ID) == 0 and runicPower > 60 and (addsRemain or stPlanning) then
            return A.BreathofSindragosa:Show(icon)
        end
        
        -- actions.cooldowns+=/frostwyrms_fury,if=active_enemies=1&(talent.pillar_of_frost&buff.pillar_of_frost.remains<gcd*2&buff.pillar_of_frost.up&!talent.obliteration|!talent.pillar_of_frost)&(!raid_event.adds.exists|(raid_event.adds.in>15+raid_event.adds.duration|talent.absolute_zero&raid_event.adds.in>15+raid_event.adds.duration))|fight_remains<3
        if A.BreathofSindragosa:IsReady(player) and InMelee() and Unit(player):HasBuffs(A.BreathofSindragosa.ID) == 0 and runicPower > 60 and (addsRemain or stPlanning) then
            return A.BreathofSindragosa:Show(icon)
        end
        
        -- actions.cooldowns+=/frostwyrms_fury,if=active_enemies>=2&(talent.pillar_of_frost&buff.pillar_of_frost.up|raid_event.adds.exists&raid_event.adds.up&raid_event.adds.in>cooldown.pillar_of_frost.remains_expected-raid_event.adds.in-raid_event.adds.duration)&(buff.pillar_of_frost.remains<gcd*2|raid_event.adds.exists&raid_event.adds.remains<gcd*2)
        if A.FrostwyrmsFury:IsReady(player) and activeEnemies >= 2 and (A.PillarofFrost:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) > 0) and (Unit(player):HasBuffs(A.PillarofFrost.ID) < A.PillarofFrost:GetCooldown() * 2) then
            return A.FrostwyrmsFury:Show(icon)
        end


        -- actions.cooldowns+=/frostwyrms_fury,if=talent.obliteration&(talent.pillar_of_frost&buff.pillar_of_frost.up&!variable.2h_check|!buff.pillar_of_frost.up&variable.2h_check&cooldown.pillar_of_frost.remains|!talent.pillar_of_frost)&((buff.pillar_of_frost.remains<gcd|buff.unholy_strength.up&buff.unholy_strength.remains<gcd)&(debuff.Razorice.stack=5|!death_knight.runeforge.Razorice&!talent.glacial_advance))
        if A.FrostwyrmsFury:IsReady(player) and 
        (A.Obliteration:IsTalentLearned() and 
            (A.PillarofFrost:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) > 0 and not check2h or 
            Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 and check2h and A.PillarofFrost:GetCooldown() > 0 or 
            not A.PillarofFrost:IsTalentLearned()) and 
            ((Unit(player):HasBuffs(A.PillarofFrost.ID) < A.GetGCD() or Unit(player):HasBuffs(A.UnholyStrength.ID) > 0 and Unit(player):HasBuffs(A.UnholyStrength.ID) < A.GetGCD()) and 
            (Unit(unitID):HasDeBuffsStacks(A.Razorice.ID) >= 5 or not hasRazorice and not A.GlacialAdvance:IsTalentLearned()))) then
            return A.FrostwyrmsFury:Show(icon)
        end

        -- actions.cooldowns+=/raise_dead
        if A.RaiseDead:IsReady(player) then
            return A.RaiseDead:Show(icon)
        end

        -- actions.cooldowns+=/soul_reaper,if=fight_remains>5&target.time_to_pct_35<5&active_enemies<=2&(talent.obliteration&(buff.pillar_of_frost.up&!buff.killing_machine.react|!buff.pillar_of_frost.up)|talent.breath_of_sindragosa&(buff.breath_of_sindragosa.up&runic_power>40|!buff.breath_of_sindragosa.up)|!talent.breath_of_sindragosa&!talent.obliteration)
        if A.SoulReaper:IsReady(unitID) and Unit(unitID):TimeToDieX(35) < 5 and activeEnemies <= 2 and (A.Obliteration:IsTalentLearned() and (Unit(player):HasBuffs(A.PillarofFrost.ID) > 0 and Unit(player):HasBuffs(A.KillingMachine.ID) == 0 or Unit(player):HasBuffs(A.PillarofFrost.ID) == 0) or A.BreathofSindragosa:IsTalentLearned() and (Unit(player):HasBuffs(A.BreathofSindragosa.ID) > 0 and runicPower > 40 or Unit(player):HasBuffs(A.BreathofSindragosa.ID) == 0) or not A.BreathofSindragosa:IsTalentLearned() and not A.Obliteration:IsTalentLearned()) then
            return A.SoulReaper:Show(icon)
        end

        -- actions.cooldowns+=/sacrificial_pact,if=!talent.glacial_advance&!buff.breath_of_sindragosa.up&pet.ghoul.remains<gcd*2&active_enemies>3
        if A.SacrificialPact:IsReady(player) and not A.GlacialAdvance:IsTalentLearned() and Unit(player):HasBuffs(A.BreathofSindragosa.ID) == 0 and petTime < A.GetGCD() * 2 and petTime > 0 and activeEnemies > 3 then
            return A.SacrificialPact:Show(icon)
        end

        -- actions.cooldowns+=/any_dnd,if=!death_and_decay.ticking&variable.adds_remain&(buff.pillar_of_frost.up&buff.pillar_of_frost.remains>5&buff.pillar_of_frost.remains<11|!buff.pillar_of_frost.up&cooldown.pillar_of_frost.remains>10|fight_remains<11)&(active_enemies>5|talent.cleaving_strikes&active_enemies>=2)
        if A.DeathandDecay:IsReady(player) and not isMoving and Unit(player):HasBuffs(A.DeathandDecayBuff.ID) == 0 and addsRemain and (Unit(player):HasBuffs(A.PillarofFrost.ID) > 5 and Unit(player):HasBuffs(A.PillarofFrost.ID) < 11 or Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 and A.PillarofFrost:GetCooldown() > 10) and (activeEnemies > 5 or A.CleavingStrikes:IsTalentLearned() and activeEnemies >= 2) then
            return A.DeathandDecay:Show(icon)
        end
    
    end

    local function HighPrioActions(unitID)

        -- actions.high_prio_actions+=/antimagic_zone,if=death_knight.amz_absorb_percent>0&runic_power.deficit>70&talent.assimilation&(buff.breath_of_sindragosa.up&cooldown.empower_rune_weapon.charges<2|!talent.breath_of_sindragosa&!buff.pillar_of_frost.up)

        -- actions.high_prio_actions+=/howling_blast,if=!dot.frost_fever.ticking&active_enemies>=2&(!talent.obliteration|talent.obliteration&(!cooldown.pillar_of_frost.ready|buff.pillar_of_frost.up&!buff.killing_machine.react))
        if A.HowlingBlast:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.FrostFever.ID) == 0 and activeEnemies >= 2 and (not A.Obliteration:IsTalentLearned() or A.Obliteration:IsTalentLearned() and (A.PillarofFrost:GetCooldown() > 0 or Unit(player):HasBuffs(A.PillarofFrost.ID) > 0 and Unit(player):HasBuffs(A.KillingMachine.ID) == 0)) then
            return A.HowlingBlast:Show(icon)
        end

        -- actions.high_prio_actions+=/glacial_advance,if=active_enemies>=2&variable.rp_buffs&talent.obliteration&talent.breath_of_sindragosa&!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up&cooldown.breath_of_sindragosa.remains>variable.breath_pooling_time
        if A.GlacialAdvance:IsReady(player) and activeEnemies >= 2 and rpBuffs and A.Obliteration:IsTalentLearned() and A.BreathofSindragosa:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 and Unit(player):HasBuffs(A.BreathofSindragosa.ID) == 0 and A.BreathofSindragosa:GetCooldown() > breathPoolingTime then
            return A.GlacialAdvance:Show(icon)
        end

        -- actions.high_prio_actions+=/glacial_advance,if=active_enemies>=2&variable.rp_buffs&talent.breath_of_sindragosa&!buff.breath_of_sindragosa.up&cooldown.breath_of_sindragosa.remains>variable.breath_pooling_time
        if A.GlacialAdvance:IsReady(player) and activeEnemies >= 2 and rpBuffs and A.BreathofSindragosa:IsTalentLearned() and Unit(unitID):HasBuffs(A.BreathofSindragosa.ID) == 0 and A.BreathofSindragosa:GetCooldown() > breathPoolingTime then
            return A.GlacialAdvance:Show(icon)
        end

        -- actions.high_prio_actions+=/glacial_advance,if=active_enemies>=2&variable.rp_buffs&!talent.breath_of_sindragosa&talent.obliteration&!buff.pillar_of_frost.up
        if A.GlacialAdvance:IsReady(player) and activeEnemies >= 2 and rpBuffs and not A.BreathofSindragosa:IsTalentLearned() and A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 then
            return A.GlacialAdvance:Show(icon)
        end

        -- actions.high_prio_actions+=/frost_strike,if=active_enemies=1&variable.rp_buffs&talent.obliteration&talent.breath_of_sindragosa&!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up&cooldown.breath_of_sindragosa.remains>variable.breath_pooling_time
        if A.FrostStrike:IsReady(unitID) and activeEnemies <= 1 and rpBuffs and A.Obliteration:IsTalentLearned() and A.BreathofSindragosa:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 and Unit(player):HasBuffs(A.BreathofSindragosa.ID) == 0 and A.BreathofSindragosa:GetCooldown() > breathPoolingTime then
            return A.FrostStrike:Show(icon)
        end

        -- actions.high_prio_actions+=/frost_strike,if=active_enemies=1&variable.rp_buffs&talent.breath_of_sindragosa&!buff.breath_of_sindragosa.up&cooldown.breath_of_sindragosa.remains>variable.breath_pooling_time
        if A.FrostStrike:IsReady(unitID) and activeEnemies <= 1 and rpBuffs and A.BreathofSindragosa:IsTalentLearned() and Unit(player):HasBuffs(A.BreathofSindragosa.ID) == 0 and A.BreathofSindragosa:GetCooldown() > breathPoolingTime then
            return A.FrostStrike:Show(icon)
        end

        -- actions.high_prio_actions+=/frost_strike,if=active_enemies=1&variable.rp_buffs&!talent.breath_of_sindragosa&talent.obliteration&!buff.pillar_of_frost.up
        if A.FrostStrike:IsReady(unitID) and activeEnemies <= 1 and rpBuffs and not A.BreathofSindragosa:IsTalentLearned() and A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 then
            return A.FrostStrike:Show(icon)
        end

        -- actions.high_prio_actions+=/remorseless_winter,if=!talent.breath_of_sindragosa&!talent.obliteration&variable.rw_buffs
        if A.RemorselessWinter:IsReady(player) and not A.BreathofSindragosa:IsTalentLearned() and not A.Obliteration:IsTalentLearned() and rwBuffs then
            return A.RemorselessWinter:Show(icon)
        end

        -- actions.high_prio_actions+=/remorseless_winter,if=talent.obliteration&active_enemies>=3&variable.adds_remain
        if A.RemorselessWinter:IsReady(player) and A.Obliteration:IsTalentLearned() and activeEnemies >= 3 and addsRemain then
            return A.RemorselessWinter:Show(icon)
        end
  

    end

    local function Obliteration(unitID)

        --actions.obliteration=remorseless_winter,if=active_enemies>3
        if activeEnemies > 3 and A.RemorselessWinter:IsReady(player) then
            return A.RemorselessWinter:Show(icon)
        end

        --actions.obliteration+=/howling_blast,if=buff.killing_machine.stack<2&buff.pillar_of_frost.remains<gcd&buff.rime.react
        if Unit(player):HasBuffsStacks(A.KillingMachine.ID) < 2 and Unit(player):HasBuffs(A.PillarofFrost.ID) < A.GetGCD() and Unit(player):HasBuffs(A.Rime.ID) > 0 and A.HowlingBlast:IsReady(unitID) then
            return A.HowlingBlast:Show(icon)
        end

        --actions.obliteration+=/frost_strike,if=buff.killing_machine.stack<2&buff.pillar_of_frost.remains<gcd&!death_and_decay.ticking
        if Unit(player):HasBuffsStacks(A.KillingMachine.ID) < 2 and Unit(player):HasBuffs(A.PillarofFrost.ID) < A.GetGCD() and Unit(player):HasBuffs(A.DeathandDecayBuff.ID) == 0 and A.FrostStrike:IsReady(unitID) then
            return A.FrostStrike:Show(icon)
        end

        --actions.obliteration+=/glacial_advance,if=buff.killing_machine.stack<2&buff.pillar_of_frost.remains<gcd&!death_and_decay.ticking
        if Unit(player):HasBuffsStacks(A.KillingMachine.ID) < 2 and Unit(player):HasBuffs(A.PillarofFrost.ID) < A.GetGCD() and Unit(player):HasBuffs(A.DeathandDecayBuff.ID) == 0 and A.GlacialAdvance:IsReady(player) then
            return A.GlacialAdvance:Show(icon)
        end

        -- actions.obliteration+=/obliterate,target_if=max:(debuff.Razorice.stack+1)%(debuff.Razorice.remains+1)*death_knight.runeforge.Razorice,if=buff.killing_machine.react&!variable.frostscythe_priority
        if A.Obliterate:IsReady(unitID) and Unit(player):HasBuffs(A.KillingMachine.ID) > 0 and not frostscythePriority then
            return A.Obliterate:Show(icon)
        end

        -- actions.obliteration+=/frostscythe,if=buff.killing_machine.react&variable.frostscythe_priority
        if Unit(unitID):HasBuffs(A.KillingMachine.ID) > 0 and frostscythePriority and A.Frostscythe:IsReady(player) and InMelee() then
            return A.Frostscythe:Show(icon)
        end

        -- actions.obliteration+=/howling_blast,if=!buff.killing_machine.react&(!dot.frost_fever.ticking|buff.rime.react&set_bonus.tier30_2pc&!variable.rp_buffs)
        if A.HowlingBlast:IsReady(unitID) and Unit(player):HasBuffs(A.KillingMachine.ID) == 0 and (Unit(unitID):HasDeBuffs(A.FrostFever.ID) == 0 or (Unit(player):HasBuffs(A.Rime.ID) > 0 and T30has2P and not rpBuffs)) then
            return A.HowlingBlast:Show(icon)
        end

        -- actions.obliteration+=/glacial_advance,if=!buff.killing_machine.react&(!death_knight.runeforge.Razorice&(!talent.avalanche|debuff.Razorice.stack<5|debuff.Razorice.remains<gcd*3)|(variable.rp_buffs&active_enemies>1))
        if A.GlacialAdvance:IsReady(player) and Unit(player):HasBuffs(A.KillingMachine.ID) == 0 and ((not hasRazorice and (not A.Avalanche:IsTalentLearned() or Unit(unitID):HasDeBuffsStacks(A.Razorice.ID) < 5 or Unit(unitID):HasDeBuffs(A.Razorice.ID) < A.GetGCD() * 3)) or (rpBuffs and activeEnemies > 1)) then
            return A.GlacialAdvance:Show(icon)
        end

        -- actions.obliteration+=/frost_strike,target_if=max:(debuff.Razorice.stack+1)%(debuff.Razorice.remains+1)*death_knight.runeforge.Razorice,if=!buff.killing_machine.react&(rune<2|variable.rp_buffs|debuff.Razorice.stack=5&talent.shattering_blade)&!variable.pooling_runic_power&(!talent.glacial_advance|active_enemies=1)
        if A.FrostStrike:IsReady(unitID) and Unit(player):HasBuffs(A.KillingMachine.ID) == 0 and (Player:Rune() < 2 or rpBuffs or (Unit(unitID):HasDeBuffsStacks(A.Razorice.ID) == 5 and A.ShatteringBlade:IsTalentLearned())) and not poolingRunicPower and (not A.GlacialAdvance:IsTalentLearned() or activeEnemies <= 1) then
            return A.FrostStrike:Show(icon)
        end

        -- actions.obliteration+=/howling_blast,if=buff.rime.react&!buff.killing_machine.react
        if A.HowlingBlast:IsReady(unitID) and Unit(player):HasBuffs(A.Rime.ID) > 0 and Unit(player):HasBuffs(A.KillingMachine.ID) == 0 then
            return A.HowlingBlast:Show(icon)
        end

        -- actions.obliteration+=/glacial_advance,if=!variable.pooling_runic_power&variable.rp_buffs&!buff.killing_machine.react&active_enemies>=2
        if A.GlacialAdvance:IsReady(player) and not poolingRunicPower and rpBuffs and Unit(player):HasBuffs(A.KillingMachine.ID) == 0 and activeEnemies >= 2 then
            return A.GlacialAdvance:Show(icon)
        end

        -- actions.obliteration+=/frost_strike,target_if=max:(debuff.Razorice.stack+1)%(debuff.Razorice.remains+1)*death_knight.runeforge.Razorice,if=!buff.killing_machine.react&!variable.pooling_runic_power&(!talent.glacial_advance|active_enemies=1)
        if A.FrostStrike:IsReady(unitID) and Unit(player):HasBuffs(A.KillingMachine.ID) == 0 and not poolingRunicPower and (not A.GlacialAdvance:IsTalentLearned() or activeEnemies <= 1) then
            return A.FrostStrike:Show(icon)
        end

        -- actions.obliteration+=/howling_blast,if=!buff.killing_machine.react&runic_power<25
        if A.HowlingBlast:IsReady(unitID) and Unit(player):HasBuffs(A.KillingMachine.ID) == 0 and runicPower < 25 then
            return A.HowlingBlast:Show(icon)
        end

        -- actions.obliteration+=/arcane_torrent,if=rune<1&runic_power<25
        if A.ArcaneTorrent:IsReady(player) and Player:Rune() < 1 and runicPower < 25 then
            return A.ArcaneTorrent:Show(icon)
        end

        -- actions.obliteration+=/glacial_advance,if=!variable.pooling_runic_power&active_enemies>=2
        if A.GlacialAdvance:IsReady(player) and not poolingRunicPower and activeEnemies >= 2 then
            return A.GlacialAdvance:Show(icon)
        end
        
        -- actions.obliteration+=/frost_strike,target_if=max:(debuff.Razorice.stack+1)%(debuff.Razorice.remains+1)*death_knight.runeforge.Razorice,if=!variable.pooling_runic_power&(!talent.glacial_advance|active_enemies=1)
        if A.FrostStrike:IsReady(unitID) and not poolingRunicPower and (not A.GlacialAdvance:IsTalentLearned() or activeEnemies <= 1) then
            return A.FrostStrike:Show(icon)
        end

        -- actions.obliteration+=/howling_blast,if=buff.rime.react
        if A.HowlingBlast:IsReady(unitID) and Unit(player):HasBuffs(A.Rime.ID) > 0 then
            return A.HowlingBlast:Show(icon)
        end

        -- actions.obliteration+=/obliterate,target_if=max:(debuff.Razorice.stack+1)%(debuff.Razorice.remains+1)*death_knight.runeforge.Razorice
        if A.Obliterate:IsReady(unitID) then
            return A.Obliterate:Show(icon)
        end

    end

    local function Racials(unitID)

        if cooldownCheck then
            -- actions.racials=blood_fury,if=variable.cooldown_check
            if A.BloodFury:IsReady(player) then
                return A.BloodFury:Show(icon)
            end
            -- actions.racials+=/berserking,if=variable.cooldown_check
            if A.Berserking:IsReady(player) then
                return A.Berserking:Show(icon)
            end
            -- actions.racials+=/arcane_pulse,if=variable.cooldown_check
            if A.ArcanePulse:IsReady(unitID) then
                return A.ArcanePulse:Show(icon)
            end
            -- actions.racials+=/lights_judgment,if=variable.cooldown_check
            if A.LightsJudgment:IsReady(unitID) then
                return A.LightsJudgment:Show(icon)
            end
            -- actions.racials+=/ancestral_call,if=variable.cooldown_check
            if A.AncestralCall:IsReady(player) then
                return A.AncestralCall:Show(icon)
            end
            -- actions.racials+=/fireblood,if=variable.cooldown_check
            if A.Fireblood:IsReady(player) then
                return A.Fireblood:Show(icon)
            end
        end
        
        -- actions.racials+=/bag_of_tricks,if=talent.obliteration&!buff.pillar_of_frost.up&buff.unholy_strength.up
        if A.BagofTricks:IsReady(unitID) and A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 and Unit(player):HasBuffs(A.UnholyStrength.ID) > 0 then
            return A.BagofTricks:Show(icon)
        end

        -- actions.racials+=/bag_of_tricks,if=!talent.obliteration&buff.pillar_of_frost.up&(buff.unholy_strength.up&buff.unholy_strength.remains<gcd*3|buff.pillar_of_frost.remains<gcd*3)
        if A.BagofTricks:IsReady(unitID) and not A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) > 0 and 
            (Unit(player):HasBuffs(A.UnholyStrength.ID) > 0 and Unit(player):HasBuffs(A.UnholyStrength.ID) < A.GetGCD() * 3 or Unit(player):HasBuffs(A.PillarofFrost.ID) < A.GetGCD() * 3) then
            return A.BagofTricks:Show(icon)
        end


    end

    local function SingleTarget(unitID)

        -- actions.single_target=remorseless_winter,if=variable.rw_buffs|variable.adds_remain
        if A.RemorselessWinter:IsReady(player) and (rwBuffs or addsRemain) then
            return A.RemorselessWinter:Show(icon)
        end

        -- actions.single_target+=/frost_strike,if=buff.killing_machine.stack<2&runic_power.deficit<20&!variable.2h_check
        if A.FrostStrike:IsReady(unitID) and Unit(player):HasBuffsStacks(A.KillingMachine.ID) < 2 and runicPowerDeficit < 20 and not check2h then
            return A.FrostStrike:Show(icon)
        end

        -- actions.single_target+=/howling_blast,if=buff.rime.react&set_bonus.tier30_2pc&buff.killing_machine.stack<2
        if A.HowlingBlast:IsReady(unitID) and Unit(player):HasBuffs(A.Rime.ID) > 0 and T30has2P and Unit(player):HasBuffsStacks(A.KillingMachine.ID) < 2 then
            return A.HowlingBlast:Show(icon)
        end

        -- actions.single_target+=/frostscythe,if=buff.killing_machine.react&variable.frostscythe_priority
        if A.Frostscythe:IsReady(player) and InMelee() and Unit(player):HasBuffs(A.KillingMachine.ID) > 0 and frostscythePriority then
            return A.Frostscythe:Show(icon)
        end

        -- actions.single_target+=/obliterate,if=buff.killing_machine.react
        if A.Obliterate:IsReady(unitID) and Unit(player):HasBuffs(A.KillingMachine.ID) > 0 then
            return A.Obliterate:Show(icon)
        end

        -- actions.single_target+=/howling_blast,if=buff.rime.react&talent.icebreaker.rank=2
        if A.HowlingBlast:IsReady(unitID) and Unit(player):HasBuffs(A.Rime.ID) > 0 and A.Icebreaker:IsTalentLearned() then
            return A.HowlingBlast:Show(icon)
        end

        -- actions.single_target+=/horn_of_winter,if=rune<4&runic_power.deficit>25&talent.obliteration&talent.breath_of_sindragosa
        if A.HornofWinter:IsReady(player) and Player:Rune() < 4 and runicPowerDeficit > 25 and A.Obliteration:IsTalentLearned() and A.BreathofSindragosa:IsTalentLearned() then
            return A.HornofWinter:Show(icon)
        end

        -- actions.single_target+=/frost_strike,if=!variable.pooling_runic_power&(variable.rp_buffs|runic_power.deficit<25|debuff.Razorice.stack=5&talent.shattering_blade)
        if A.FrostStrike:IsReady(unitID) and not poolingRunicPower and (rpBuffs or runicPowerDeficit < 25 or (Unit(unitID):HasDeBuffsStacks(A.Razorice.ID) >= 5 and A.ShatteringBlade:IsTalentLearned())) then
            return A.FrostStrike:Show(icon)
        end

        -- actions.single_target+=/howling_blast,if=variable.rime_buffs
        if A.HowlingBlast:IsReady(unitID) and rimeBuffs then
            return A.HowlingBlast:Show(icon)
        end

        -- actions.single_target+=/glacial_advance,if=!variable.pooling_runic_power&!death_knight.runeforge.Razorice&(debuff.Razorice.stack<5|debuff.Razorice.remains<gcd*3)
        if A.GlacialAdvance:IsReady(player) and not poolingRunicPower and not hasRazorice and (Unit(unitID):HasDeBuffsStacks(A.Razorice.ID) < 5 or Unit(unitID):HasDeBuffs(A.Razorice.ID) < A.GetGCD() * 3) then
            return A.GlacialAdvance:Show(icon)
        end

        -- actions.single_target+=/obliterate,if=!variable.pooling_runes
        if A.Obliterate:IsReady(unitID) and not poolingRunes then
            return A.Obliterate:Show(icon)
        end

        -- actions.single_target+=/horn_of_winter,if=rune<4&runic_power.deficit>25&(!talent.breath_of_sindragosa|cooldown.breath_of_sindragosa.remains>cooldown.horn_of_winter.duration)
        if A.HornofWinter:IsReady(player) and Player:Rune() < 4 and runicPowerDeficit > 25 and (not A.BreathofSindragosa:IsTalentLearned() or A.BreathofSindragosa:GetCooldown() > Unit(player):HasBuffs(A.HornofWinter.ID)) then
            return A.HornofWinter:Show(icon)
        end

        -- actions.single_target+=/arcane_torrent,if=runic_power.deficit>20
        if A.ArcaneTorrent:IsReady(player) and runicPowerDeficit > 20 then
            return A.ArcaneTorrent:Show(icon)
        end

        -- actions.single_target+=/frost_strike,if=!variable.pooling_runic_power
        if A.FrostStrike:IsReady(unitID) and not poolingRunicPower then
            return A.FrostStrike:Show(icon)
        end


    end


    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unitID)

        -- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end 

        -- actions+=/call_action_list,name=high_prio_actions
        local highprioactions = HighPrioActions(unitID)
        if highprioactions and InMelee() then
            return highprioactions
        end
        -- actions+=/call_action_list,name=trinkets
        local UseTrinket = UseTrinkets(unitID)
        if UseTrinket and InMelee() then
            return UseTrinket:Show(icon)
        end  
        -- actions+=/call_action_list,name=cooldowns
        if Cooldowns(unitID) and A.BurstIsON(unitID) and MultiUnits:GetByRangeAreaTTD(20) >= 20 and InMelee() then
            return Cooldowns(unitID)
        end
        -- actions+=/call_action_list,name=racials
        if Racials(unitID) and useRacial then
            return Racials(unitID)
        end
        -- actions+=/call_action_list,name=cold_heart,if=talent.cold_heart&(!buff.killing_machine.up|talent.breath_of_sindragosa)&((debuff.Razorice.stack=5|!death_knight.runeforge.Razorice&!talent.glacial_advance&!talent.avalanche)|fight_remains<=gcd)
        if ColdHeart(unitID) and A.ColdHeart:IsTalentLearned() and (Unit(player):HasBuffs(A.KillingMachine.ID) == 0 or A.BreathofSindragosa:IsTalentLearned()) and ((Unit(unitID):HasDeBuffsStacks(A.Razorice.ID, true) >= 5 or not hasRazorice and not A.GlacialAdvance:IsTalentLearned() and not A.Avalanche:IsTalentLearned())) then
            return ColdHeart(unitID)
        end
        -- actions+=/run_action_list,name=breath_oblit,if=buff.breath_of_sindragosa.up&talent.obliteration&buff.pillar_of_frost.up
        if BreathOblit(unitID) and Unit(player):HasBuffs(A.BreathofSindragosa.ID) > 0 and A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) > 0 then
            return BreathOblit(unitID)
        end
        -- actions+=/run_action_list,name=breath,if=buff.breath_of_sindragosa.up&(!talent.obliteration|talent.obliteration&!buff.pillar_of_frost.up)
        if Breath(unitID) and Unit(player):HasBuffs(A.BreathofSindragosa.ID) > 0 and (not A.Obliteration:IsTalentLearned() or A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0) then
            return Breath(unitID)
        end
        -- actions+=/run_action_list,name=obliteration,if=talent.obliteration&buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
        if Obliteration(unitID) and A.Obliteration:IsTalentLearned() and Unit(player):HasBuffs(A.PillarofFrost.ID) > 0 and Unit(player):HasBuffs(A.BreathofSindragosa.ID) == 0 then
            return Obliteration(unitID)
        end
        -- actions+=/call_action_list,name=aoe,if=active_enemies>=2
        if AoERotation(unitID) and activeEnemies >= 2 and useAoE then
            return AoERotation(unitID)
        end
        -- actions+=/call_action_list,name=single_target,if=active_enemies=1    
        if SingleTarget(unitID) then
            return SingleTarget(unitID)
        end

    end

    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
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