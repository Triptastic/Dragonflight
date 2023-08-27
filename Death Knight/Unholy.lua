--#####################################
--##### TRIP'S UNHOLY DEATHKNIGHT #####
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

Action[ACTION_CONST_DEATHKNIGHT_UNHOLY] = {
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

local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_UNHOLY], { __index = Action })

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
    if (Unit(player):HasDeBuffs(Temp.useDefensiveDebuff) > 0 or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1 or Unit(player):HealthPercent() <= 30) and not defensiveActive then
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
		    
        if useCC and not Unit(unitID):IsBoss() and A.Gnaw:IsReady(unitID) then 
            return A.Gnaw
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
	return A.FesteringStrike:IsInRange(unitID)
end 

local function shouldBurst(unitID)
    -- Adjust these values based on what you consider appropriate
    local singleTargetTTDThreshold = 20
    local areaTTDThreshold = 20

    -- Check the TTD of the current target
    if Unit(unitID):TimeToDie() > singleTargetTTDThreshold then
        return true
    end

    -- Check the combined TTD for enemies in the area
    if MultiUnits.GetByRangeAreaTTD(20) > areaTTDThreshold then
        return true
    end

    if Unit(unitID):IsBoss() then
        return true
    end

    return false
end



--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    unitID = "target"

    local runicPower = Player:RunicPower()
    local runicPowerDeficit = Player:RunicPowerDeficit()
    local runicPowerMax = Player:RunicPowerMax()
    local rune = Player:Rune()
    local UseRacial = A.GetToggle(1, "Racial")
    local useBurst = BurstIsON(unitID) and shouldBurst(unitID)
    local useAoE = A.GetToggle(2, "AoE")
    local fightRemains = MultiUnits.GetByRangeAreaTTD(20)
    local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID = GetWeaponEnchantInfo()
    local hasRazorice = mainHandEnchantID == 3370
    local hasFallenCrusader = mainHandEnchantID == 3368
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local enemiesInRange = MultiUnits:GetByRange(10, 10)
    local activeEnemies = MultiUnits:GetByRange(10, 10)
    if Unit(target):IsEnemy() and InMelee() and activeEnemies == 0 then
        activeEnemies = 1
    end
    local deathKnightFwoundedTargets = Player:GetDeBuffsUnitCount(A.FesteringWound.ID)
    local refreshVP = A.VirulentPlague:GetSpellPandemicThreshold() / (1 + num(A.EbonFever:IsTalentLearned()))

    local woundSpender
    if A.ClawingShadows:IsTalentLearned() then
        woundSpender = A.ClawingShadows
    else
        woundSpender = A.ScourgeStrike
    end

    local petTime = Player:GetTotemTimeLeft(1)
    local gargTime = math.max(25 - A.SummonGargoyle:GetSpellTimeSinceLastCast(), 0)
    local apocGhoul = math.max(20 - A.Apocalypse:GetSpellTimeSinceLastCast(), 0)
    local armyGhoul = math.max(30 - A.ArmyoftheDead:GetSpellTimeSinceLastCast(), 0)

    Player:AddTier("Tier30", { 205810, 202462, 202461, 202460, 202459, })
    local T30has2P = Player:HasTier("Tier30", 2)
    local T30has4P = Player:HasTier("Tier30", 4)

    -- actions.variables+=/variable,name=st_planning,op=setif,value=1,value_else=0,condition=active_enemies=1&(!raid_event.adds.exists|raid_event.adds.in>15)
    if activeEnemies <= 1 then
        stPlanning = true
    else
        stPlanning = false
    end

    -- actions.variables+=/variable,name=adds_remain,op=setif,value=1,value_else=0,condition=active_enemies>=2&(!raid_event.adds.exists|raid_event.adds.exists&raid_event.adds.remains>6)
    if activeEnemies >= 2 then
        addsRemain = true
    else
        addsRemain = false
    end

    -- actions.variables=variable,name=epidemic_priority,op=setif,value=1,value_else=0,condition=talent.improved_death_coil&!talent.coil_of_devastation&active_enemies>=3|talent.coil_of_devastation&active_enemies>=4|!talent.improved_death_coil&active_enemies>=2
    if (A.ImprovedDeathCoil:IsTalentLearned() and not A.CoilofDevastation:IsTalentLearned() and activeEnemies >= 3) or (A.CoilofDevastation:IsTalentLearned() and activeEnemies >= 4) or (not A.ImprovedDeathCoil:IsTalentLearned() and activeEnemies >= 2) then
        epidemicPriority = true
    else
        epidemicPriority = false
    end

    -- actions.variables+=/variable,name=garg_setup,op=setif,value=1,value_else=0,condition=active_enemies>=3|cooldown.summon_gargoyle.remains>1&cooldown.apocalypse.remains>1|!talent.apocalypse&cooldown.summon_gargoyle.remains>1|!talent.summon_gargoyle|time>20
    if activeEnemies >= 3 or (A.SummonGargoyle:GetCooldown() > 1 and A.Apocalypse:GetCooldown() > 1) or (not A.Apocalypse:IsTalentLearned() and A.SummonGargoyle:GetCooldown() > 1) or (not A.SummonGargoyle:IsTalentLearned()) or combatTime > 20 then
        gargSetup = true
    else
        gargSetup = false
    end

    -- actions.variables+=/variable,name=apoc_timing,op=setif,value=7,value_else=2,condition=cooldown.apocalypse.remains<10&debuff.festering_wound.stack<=4&cooldown.unholy_assault.remains>10
    if A.Apocalypse:GetCooldown() < 10 and Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) <= 4 and A.UnholyAssault:GetCooldown() > 10 then
        apocTiming = 7
    else
        apocTiming = 2
    end

    -- actions.variables+=/variable,name=festermight_tracker,op=setif,value=debuff.festering_wound.stack>=1,value_else=debuff.festering_wound.stack>=(3-talent.infected_claws),condition=!pet.gargoyle.active&talent.festermight&buff.festermight.up&(buff.festermight.remains%(5*gcd.max))>=1
    if gargTime == 0 and A.Festermight:IsTalentLearned() and Unit(player):HasBuffs(A.Festermight.ID) > 0 and (Unit(player):HasBuffs(A.Festermight.ID) % (5 * A.GetGCD())) >= 1 then
        festermightTracker = Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) >= 1
    else
        festermightTracker = Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) >= (3 - num(A.InfectedClaws:IsTalentLearned()))
    end

    -- actions.variables+=/variable,name=pop_wounds,op=setif,value=1,value_else=0,condition=(cooldown.apocalypse.remains>variable.apoc_timing|!talent.apocalypse)&(variable.festermight_tracker|debuff.festering_wound.stack>=1&!talent.apocalypse|debuff.festering_wound.stack>=1&cooldown.unholy_assault.remains<20&talent.unholy_assault&variable.st_planning|debuff.rotten_touch.up&debuff.festering_wound.stack>=1|debuff.festering_wound.stack>4)|fight_remains<5&debuff.festering_wound.stack>=1
    if (A.Apocalypse:GetCooldown() > apocTiming or not A.Apocalypse:IsTalentLearned()) and (festermightTracker or Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) >= 1 and not A.Apocalypse:IsTalentLearned() or Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) >= 1 and A.UnholyAssault:GetCooldown() < 20 and A.UnholyAssault:IsTalentLearned() and stPlanning or Unit(unitID):HasDeBuffs(A.RottenTouch.ID) > 0 and Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) >= 1 or Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) > 4) or fightRemains < 5 and Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) >= 1 then
        popWounds = true
    else
        popWounds = false
    end

    -- actions.variables+=/variable,name=pooling_runic_power,op=setif,value=1,value_else=0,condition=talent.vile_contagion&cooldown.vile_contagion.remains<3&runic_power<60&!variable.st_planning
    if A.VileContagion:IsTalentLearned() and A.VileContagion:GetCooldown() < 3 and Player:RunicPower() < 60 and not stPlanning then
        poolingRunicPower = true
    else
        poolingRunicPower = false
    end


    -- actions.cooldowns+=/raise_dead,if=!pet.ghoul.active
    if A.RaiseDead:IsReady(player) and (not Unit(pet):IsExists() or Unit(pet):IsDead()) then
        return A.RaiseDead:Show(icon)
    end



    local function highPrioActions(unitID)
    
        -- actions.high_prio_actions+=/army_of_the_dead,if=talent.summon_gargoyle&cooldown.summon_gargoyle.remains<2|!talent.summon_gargoyle|fight_remains<35
        if A.ArmyoftheDead:IsReady(player) and useBurst then
            if (A.SummonGargoyle:IsTalentLearned() and A.SummonGargoyle:GetCooldown() < 2) or not A.SummonGargoyle:IsTalentLearned() or fightRemains < 35 then
                return A.ArmyoftheDead:Show(icon)
            end
        end

        -- actions.high_prio_actions+=/death_coil,if=(active_enemies<=3|!talent.epidemic)&(pet.gargoyle.active&talent.commander_of_the_dead&buff.commander_of_the_dead.up&cooldown.apocalypse.remains<5&buff.commander_of_the_dead.remains>27|debuff.death_rot.up&debuff.death_rot.remains<gcd)
        if A.DeathCoil:IsReady(unitID) then
            if (activeEnemies <= 3 or not A.Epidemic:IsTalentLearned()) and (gargTime > 0 and A.CommanderoftheDead:IsTalentLearned() and Unit(player):HasBuffs(A.CommanderoftheDead.ID) > 0 and A.Apocalypse:GetCooldown() < 5 and Unit(player):HasBuffs(A.CommanderoftheDead.ID) > 27 or Unit(unitID):HasDeBuffs(A.DeathRot.ID) > 0 and Unit(unitID):HasDeBuffs(A.DeathRot.ID) < A.GetGCD()) then
                return A.DeathCoil:Show(icon)
            end
        end

        -- actions.high_prio_actions+=/epidemic,if=active_enemies>=4&(talent.commander_of_the_dead&buff.commander_of_the_dead.up&cooldown.apocalypse.remains<5|debuff.death_rot.up&debuff.death_rot.remains<gcd)
        if A.Epidemic:IsReady(player) then
            if activeEnemies >= 4 and (A.CommanderoftheDead:IsTalentLearned() and Unit(player):HasBuffs(A.CommanderoftheDead.ID) > 0 and A.Apocalypse:GetCooldown() < 5 or Unit(unitID):HasDeBuffs(A.DeathRot.ID) > 0 and Unit(unitID):HasDeBuffs(A.DeathRot.ID) < A.GetGCD()) then
                return A.Epidemic:Show(icon)
            end
        end

        -- actions.high_prio_actions+=/wound_spender,if=(cooldown.apocalypse.remains>variable.apoc_timing+3|active_enemies>=3)&talent.plaguebringer&(talent.superstrain|talent.unholy_blight)&buff.plaguebringer.remains<gcd
        if woundSpender:IsReady(unitID) then
            if (A.Apocalypse:GetCooldown() > apocTiming + 3 or activeEnemies >= 3) and A.Plaguebringer:IsTalentLearned() and (A.Superstrain:IsTalentLearned() or A.UnholyBlight:IsTalentLearned()) and Unit(player):HasBuffs(A.Plaguebringer.ID) < A.GetGCD() then
                return woundSpender:Show(icon) 
            end
        end

        -- actions.high_prio_actions+=/unholy_blight,if=variable.st_planning&((!talent.apocalypse|cooldown.apocalypse.remains)&talent.morbidity|!talent.morbidity)|variable.adds_remain|fight_remains<21
        if A.UnholyBlight:IsReady(player) and useBurst then
            if stPlanning and ((not A.Apocalypse:IsTalentLearned() or A.Apocalypse:GetCooldown() > 0) and A.Morbidity:IsTalentLearned() or not A.Morbidity:IsTalentLearned()) or addsRemain or fightRemains < 21 then
                return A.UnholyBlight:Show(icon)
            end
        end

        -- actions.high_prio_actions+=/outbreak,target_if=target.time_to_die>dot.virulent_plague.remains&(dot.virulent_plague.refreshable|talent.superstrain&(dot.frost_fever_superstrain.refreshable|dot.blood_plague_superstrain.refreshable))&(!talent.unholy_blight|talent.unholy_blight&cooldown.unholy_blight.remains>15%((talent.superstrain*3)+(talent.plaguebringer*2)+(talent.ebon_fever*2)))
        if A.Outbreak:IsReady(player) then
            if Unit(unitID):TimeToDie() > Unit(unitID):HasDeBuffs(A.VirulentPlague.ID) and (Unit(unitID):HasDeBuffs(A.VirulentPlague.ID) < refreshVP or A.Superstrain:IsTalentLearned() and (Unit(unitID):HasDeBuffs(A.FrostFever.ID) < A.FrostFever:GetSpellPandemicThreshold() or Unit(unitID):HasDeBuffs(A.BloodPlague.ID) < A.BloodPlague:GetSpellPandemicThreshold())) and (not A.UnholyBlight:IsTalentLearned() or A.UnholyBlight:IsTalentLearned() and A.UnholyBlight:GetCooldown() > 15 % ((num(A.Superstrain:IsTalentLearned()) * 3) + (num(A.Plaguebringer:IsTalentLearned()) * 2) + (num(A.EbonFever:IsTalentLearned()) * 2))) then
                return A.Outbreak:Show(icon)
            end
        end

    end

    local function gargSetup(unitID)

        -- actions.garg_setup=apocalypse,if=debuff.festering_wound.stack>=4&(buff.commander_of_the_dead.up&pet.gargoyle.remains<23|!talent.commander_of_the_dead)
        if A.Apocalypse:IsReady(player) and Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) >= 4 and (Unit("player"):HasBuffs(A.CommanderoftheDead.ID) > 0 and gargTime < 23 or not A.CommanderoftheDead:IsTalentLearned()) then
            return A.Apocalypse:Show(icon)
        end

        -- actions.garg_setup+=/army_of_the_dead,if=talent.commander_of_the_dead&(cooldown.dark_transformation.remains<3|buff.commander_of_the_dead.up)|!talent.commander_of_the_dead&talent.unholy_assault&cooldown.unholy_assault.remains<10|!talent.unholy_assault&!talent.commander_of_the_dead
        if A.ArmyoftheDead:IsReady(player) and ((A.CommanderoftheDead:IsTalentLearned() and (A.DarkTransformation:GetCooldown() < 3 or Unit("player"):HasBuffs(A.CommanderoftheDead.ID) > 0)) or (not A.CommanderoftheDead:IsTalentLearned() and A.UnholyAssault:IsTalentLearned() and A.UnholyAssault:GetCooldown() < 10) or (not A.UnholyAssault:IsTalentLearned() and not A.CommanderoftheDead:IsTalentLearned())) then
            return A.ArmyoftheDead:Show(icon)
        end

        -- actions.garg_setup+=/soul_reaper,if=active_enemies=1&target.time_to_pct_35<5&target.time_to_die>5
        if A.SoulReaper:IsReady(unitID) and activeEnemies <= 1 and Unit(unitID):TimeToDieX(35) < 5 and Unit(unitID):TimeToDie() > 5 then
            return A.SoulReaper:Show(icon)
        end

        -- actions.garg_setup+=/summon_gargoyle,use_off_gcd=1,if=buff.commander_of_the_dead.up|!talent.commander_of_the_dead&runic_power>=40
        if A.SummonGargoyle:IsReady(player, nil, nil, true) and (Unit("player"):HasBuffs(A.CommanderoftheDead.ID) > 0 or not A.CommanderoftheDead:IsTalentLearned() and Player:RunicPower() >= 40) then
            return A.SummonGargoyle:Show(icon)
        end
        
        -- actions.garg_setup+=/empower_rune_weapon,if=pet.gargoyle.active&pet.gargoyle.remains<=23
        if A.EmpowerRuneWeapon:IsReady(player) and gargTime > 0 and gargTime <= 23 then
            return A.EmpowerRuneWeapon:Show(icon)
        end

        -- actions.garg_setup+=/unholy_assault,if=pet.gargoyle.active&pet.gargoyle.remains<=23
        if A.UnholyAssault:IsReady(unitID) and gargTime > 0 and gargTime <= 23 then
            return A.UnholyAssault:Show(icon)
        end

        -- actions.garg_setup+=/potion,if=(30>=pet.gargoyle.remains&pet.gargoyle.active)|(!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>60|cooldown.summon_gargoyle.ready)&(buff.dark_transformation.up&30>=buff.dark_transformation.remains|pet.army_ghoul.active&pet.army_ghoul.remains<=30|pet.apoc_ghoul.active&pet.apoc_ghoul.remains<=30)


        -- actions.garg_setup+=/dark_transformation,if=talent.commander_of_the_dead&runic_power>40|!talent.commander_of_the_dead
        if A.DarkTransformation:IsReady(player) and (A.CommanderoftheDead:IsTalentLearned() and Player:RunicPower() > 40 or not A.CommanderoftheDead:IsTalentLearned()) then
            return A.DarkTransformation:Show(icon)
        end

        -- actions.garg_setup+=/any_dnd,if=!death_and_decay.ticking&debuff.festering_wound.stack>0
        if A.DeathandDecay:IsReady(player) and not isMoving and not A.Defile:IsTalentLearned() and Unit(player):HasBuffs(A.DeathandDecay.ID) == 0 and Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) > 0 then
            return A.DeathandDecay:Show(icon)
        end

        if A.Defile:IsReady(player) and not isMoving and A.Defile:IsTalentLearned() and Unit(player):HasBuffs(A.Defile.ID) == 0 and Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) > 0 then
            return A.Defile:Show(icon)
        end  

        -- actions.garg_setup+=/festering_strike,if=debuff.festering_wound.stack=0|!talent.apocalypse|runic_power<40&!pet.gargoyle.active
        if A.FesteringStrike:IsReady(unitID) and (Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) == 0 or not A.Apocalypse:IsTalentLearned() or Player:RunicPower() < 40 and gargTime == 0) then
            return A.FesteringStrike:Show(icon)
        end

        -- actions.garg_setup+=/death_coil,if=rune<=1
        if A.DeathCoil:IsReady(unitID) and Player:Rune() <= 1 then
            return A.DeathCoil:Show(icon)
        end



    end

    local function cooldowns(unitID)

        -- actions.cooldowns+=/summon_gargoyle,if=buff.commander_of_the_dead.up|!talent.commander_of_the_dead
        if A.SummonGargoyle:IsReady(player) and (Unit(player):HasBuffs(A.CommanderoftheDead.ID) > 0 or not A.CommanderoftheDead:IsTalentLearned()) then
            return A.SummonGargoyle:Show(icon)
        end

        -- actions.cooldowns+=/dark_transformation,if=cooldown.apocalypse.remains<5
        if A.DarkTransformation:IsReady(player) and A.Apocalypse:GetCooldown() < 5 then
            return A.DarkTransformation:Show(icon)
        end

        -- actions.cooldowns+=/apocalypse,target_if=max:debuff.festering_wound.stack,if=variable.st_planning&debuff.festering_wound.stack>=4
        if A.Apocalypse:IsReady(unitID) and stPlanning and Unit(unitID):HasDeBuffsStacks(A.FesteringWound.ID) >= 4 then
            return A.Apocalypse:Show(icon)
        end

        -- actions.cooldowns+=/empower_rune_weapon,if=variable.st_planning&(pet.gargoyle.active&pet.gargoyle.remains<=23|!talent.summon_gargoyle&talent.army_of_the_damned&pet.army_ghoul.active&pet.apoc_ghoul.active|!talent.summon_gargoyle&!talent.army_of_the_damned&buff.dark_transformation.up|!talent.summon_gargoyle&!talent.summon_gargoyle&buff.dark_transformation.up)|fight_remains<=21
        if A.EmpowerRuneWeapon:IsReady(player) and (stPlanning and ((gargTime > 0 and gargTime <= 23) or (not A.SummonGargoyle:IsTalentLearned() and A.ArmyoftheDamned:IsTalentLearned() and armyGhoul > 0 and apocGhoul > 0) or (not A.SummonGargoyle:IsTalentLearned() and not A.ArmyoftheDamned:IsTalentLearned() and Unit(pet):HasBuffs(A.DarkTransformation.ID) > 0) or (not A.SummonGargoyle:IsTalentLearned() and not A.SummonGargoyle:IsTalentLearned() and Unit(pet):HasBuffs(A.DarkTransformation.ID) > 0)) or fightRemains <= 21) then
            return A.EmpowerRuneWeapon:Show(icon)
        end

        -- actions.cooldowns+=/abomination_limb,if=rune<3&variable.st_planning
        if A.AbominationLimb:IsReady(player) and Player:Rune() < 3 and stPlanning then
            return A.AbominationLimb:Show(icon)
        end

        -- actions.cooldowns+=/unholy_assault,target_if=min:debuff.festering_wound.stack,if=variable.st_planning
        if stPlanning and A.UnholyAssault:IsReady(unitID) then
            return A.UnholyAssault:Show(icon)
        end

        -- actions.cooldowns+=/soul_reaper,if=active_enemies=1&target.time_to_pct_35<5&target.time_to_die>5
        if activeEnemies <= 1 and Unit(unitID):TimeToDie() > 5 and Unit(unitID):TimeToDieX(35) < 5 and A.SoulReaper:IsReady(unitID) then
            return A.SoulReaper:Show(icon)
        end

        -- actions.cooldowns+=/soul_reaper,target_if=min:dot.soul_reaper.remains,if=target.time_to_pct_35<5&active_enemies>=2&target.time_to_die>(dot.soul_reaper.remains+5)
        if A.SoulReaper:IsReady(unitID) and Unit(unitID):TimeToDieX(35) < 5 and activeEnemies >= 2 and Unit(unitID):TimeToDie() > (Unit(unitID):HasDeBuffs(A.SoulReaper.ID) + 5) then
            return A.SoulReaper:Show(icon) -- You might want to implement logic to target the unit with the minimum Soul Reaper dot remains.
        end

    end

    local function aoeCooldowns(unitID)

        -- actions.aoe_cooldowns=vile_contagion,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack>=4&cooldown.any_dnd.remains<3
        if A.VileContagion:IsReady(player) and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) >= 4 and ((A.Defile:GetCooldown() < 3 and A.Defile:IsTalentLearned()) or A.DeathandDecay:GetCooldown() < 3 and not A.Defile:IsTalentLearned()) then
            return A.VileContagion:Show(icon)
        end

        -- actions.aoe_cooldowns+=/summon_gargoyle
        if A.SummonGargoyle:IsReady(player) then
            return A.SummonGargoyle:Show(icon)
        end

        -- actions.aoe_cooldowns+=/abomination_limb,if=rune<2|buff.festermight.stack>10|!talent.festermight|buff.festermight.up&buff.festermight.remains<12
        if A.AbominationLimb:IsReady(player) and (rune < 2 or Unit(player):HasBuffs(A.Festermight.ID) > 10 or not A.Festermight:IsTalentLearned() or (Unit(player):HasBuffs(A.Festermight.ID) > 0 and Unit(player):HasBuffs(A.Festermight.ID) < 12)) then
            return A.AbominationLimb:Show(icon)
        end

        -- actions.aoe_cooldowns+=/apocalypse,target_if=min:debuff.festering_wound.stack,if=talent.bursting_sores&debuff.festering_wound.up&(!death_and_decay.ticking&cooldown.death_and_decay.remains&rune<3|death_and_decay.ticking&rune=0)|!talent.bursting_sores&debuff.festering_wound.stack>=4
        if A.Apocalypse:IsReady(unitID) and ((A.BurstingSores:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) > 0 and ((Unit(player):HasBuffs(A.DeathandDecay.ID) == 0 and ((A.DeathandDecay:GetCooldown() > 0 and not A.Defile:IsTalentLearned()) or (A.Defile:GetCooldown() > 0 and A.Defile:IsTalentLearned())) and rune < 3) or (Unit(player):HasBuffs(A.DeathandDecay.ID) > 0 and rune == 0))) or (not A.BurstingSores:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) >= 4)) then
            return A.Apocalypse:Show(icon)
        end

        -- actions.aoe_cooldowns+=/unholy_assault,target_if=min:debuff.festering_wound.stack,if=debuff.festering_wound.stack<=2|buff.dark_transformation.up
        if A.UnholyAssault:IsReady(unitID) and (Unit(unitID):HasDeBuffs(A.FesteringWound.ID) <= 2 or Unit(pet):HasBuffs(A.DarkTransformation.ID) > 0) then
            return A.UnholyAssault:Show(icon)
        end

        -- actions.aoe_cooldowns+=/dark_transformation,if=(cooldown.any_dnd.remains<10&talent.infected_claws&((cooldown.vile_contagion.remains|raid_event.adds.exists&raid_event.adds.in>10)&death_knight.fwounded_targets<active_enemies|!talent.vile_contagion)&(raid_event.adds.remains>5|!raid_event.adds.exists)|!talent.infected_claws)
        if A.DarkTransformation:IsReady(player) and (((A.Defile:GetCooldown() < 10 and A.Defile:IsTalentLearned()) or (A.DeathandDecay:GetCooldown() < 10 and not A.Defile:IsTalentLearned())) and A.InfectedClaws:IsTalentLearned() and ((A.VileContagion:GetCooldown() > 0 and deathKnightFwoundedTargets < activeEnemies) or not A.VileContagion:IsTalentLearned()) or not A.InfectedClaws:IsTalentLearned()) then
            return A.DarkTransformation:Show(icon)
        end

        -- actions.aoe_cooldowns+=/empower_rune_weapon,if=buff.dark_transformation.up
        if A.EmpowerRuneWeapon:IsReady(player) and Unit(pet):HasBuffs(A.DarkTransformation.ID) > 0 then
            return A.EmpowerRuneWeapon:Show(icon)
        end

        -- actions.aoe_cooldowns+=/sacrificial_pact,if=!buff.dark_transformation.up&cooldown.dark_transformation.remains>6|fight_remains<gcd
        if A.SacrificialPact:IsReady(player) and (Unit(pet):HasBuffs(A.DarkTransformation.ID) == 0 and A.DarkTransformation:GetCooldown() > 6) or fightRemains < A.GetGCD() then
            return A.SacrificialPact:Show(icon)
        end

    end

    local function racials(unitID)

        -- actions.racials=arcane_torrent,if=runic_power.deficit>20&(cooldown.summon_gargoyle.remains<gcd|!talent.summon_gargoyle.enabled|pet.gargoyle.active&rune<2&debuff.festering_wound.stack<1)
        -- actions.racials+=/blood_fury,if=(buff.blood_fury.duration+3>=pet.gargoyle.remains&pet.gargoyle.active)|(!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>60)&(pet.army_ghoul.active&pet.army_ghoul.remains<=buff.blood_fury.duration+3|pet.apoc_ghoul.active&pet.apoc_ghoul.remains<=buff.blood_fury.duration+3|active_enemies>=2&death_and_decay.ticking)|fight_remains<=buff.blood_fury.duration+3
        -- actions.racials+=/berserking,if=(buff.berserking.duration+3>=pet.gargoyle.remains&pet.gargoyle.active)|(!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>60)&(pet.army_ghoul.active&pet.army_ghoul.remains<=buff.berserking.duration+3|pet.apoc_ghoul.active&pet.apoc_ghoul.remains<=buff.berserking.duration+3|active_enemies>=2&death_and_decay.ticking)|fight_remains<=buff.berserking.duration+3
        -- actions.racials+=/lights_judgment,if=buff.unholy_strength.up&(!talent.festermight|buff.festermight.remains<target.time_to_die|buff.unholy_strength.remains<target.time_to_die)
        -- actions.racials+=/ancestral_call,if=(18>=pet.gargoyle.remains&pet.gargoyle.active)|(!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>60)&(pet.army_ghoul.active&pet.army_ghoul.remains<=18|pet.apoc_ghoul.active&pet.apoc_ghoul.remains<=18|active_enemies>=2&death_and_decay.ticking)|fight_remains<=18
        -- actions.racials+=/arcane_pulse,if=active_enemies>=2|(rune.deficit>=5&runic_power.deficit>=60)
        -- actions.racials+=/fireblood,if=(buff.fireblood.duration+3>=pet.gargoyle.remains&pet.gargoyle.active)|(!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>60)&(pet.army_ghoul.active&pet.army_ghoul.remains<=buff.fireblood.duration+3|pet.apoc_ghoul.active&pet.apoc_ghoul.remains<=buff.fireblood.duration+3|active_enemies>=2&death_and_decay.ticking)|fight_remains<=buff.fireblood.duration+3
        -- actions.racials+=/bag_of_tricks,if=active_enemies=1&(buff.unholy_strength.up|fight_remains<5)

    end

    local function aoeSetup(unitID)

        -- actions.aoe_setup=any_dnd,if=(!talent.bursting_sores|death_knight.fwounded_targets=active_enemies|death_knight.fwounded_targets>=8|raid_event.adds.exists&raid_event.adds.remains<=11&raid_event.adds.remains>5)
        if A.Defile:IsTalentLearned() then
            if A.Defile:IsReady(player) and not isMoving and (not A.BurstingSores:IsTalentLearned() or deathKnightFwoundedTargets == activeEnemies or deathKnightFwoundedTargets >= 8) then
                return A.Defile:Show(icon)
            end
        else
            if A.DeathandDecay:IsReady(player) and not isMoving and (not A.BurstingSores:IsTalentLearned() or deathKnightFwoundedTargets == activeEnemies or deathKnightFwoundedTargets >= 8) then
                return A.DeathandDecay:Show(icon)
            end
        end

        -- actions.aoe_setup+=/festering_strike,target_if=min:debuff.festering_wound.stack,if=death_knight.fwounded_targets<active_enemies&talent.bursting_sores
        if A.FesteringStrike:IsReady(unitID) and deathKnightFwoundedTargets < activeEnemies and A.BurstingSores:IsTalentLearned() then
            return A.FesteringStrike:Show(icon)
        end

        -- actions.aoe_setup+=/epidemic,if=!variable.pooling_runic_power|fight_remains<10
        if A.Epidemic:IsReady(player) and (not poolingRunicPower or fightRemains < 10) then
            return A.Epidemic:Show(icon)
        end

        -- actions.aoe_setup+=/festering_strike,target_if=min:debuff.festering_wound.stack,if=death_knight.fwounded_targets<active_enemies
        if A.FesteringStrike:IsReady(unitID) and deathKnightFwoundedTargets < activeEnemies then
            return A.FesteringStrike:Show(icon)
        end

        -- actions.aoe_setup+=/festering_strike,target_if=max:debuff.festering_wound.stack,if=cooldown.apocalypse.remains<variable.apoc_timing&debuff.festering_wound.stack<4
        if A.FesteringStrike:IsReady(unitID) and A.Apocalypse:GetCooldown() < apocTiming and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) < 4 then
            return A.FesteringStrike:Show(icon)
        end

        -- actions.aoe_setup+=/death_coil,if=!variable.pooling_runic_power&!talent.epidemic
        if A.DeathCoil:IsReady(unitID) and not poolingRunicPower and not A.Epidemic:IsTalentLearned() then
            return A.DeathCoil:Show(icon)
        end

    end

    local function aoeBurst(unitID)

        -- actions.aoe_burst=epidemic,if=(!talent.bursting_sores|rune<1|talent.bursting_sores&debuff.festering_wound.stack=0)&!variable.pooling_runic_power&(active_enemies>=6|runic_power.deficit<30|buff.festermight.stack=20)
        if A.Epidemic:IsReady(player) and ((not A.BurstingSores:IsTalentLearned() or rune < 1 or (A.BurstingSores:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) == 0)) and not poolingRunicPower and (activeEnemies >= 6 or runicPowerDeficit < 30 or Unit(player):HasBuffs(A.Festermight.ID) == 20)) then
            return A.Epidemic:Show(icon)
        end

        -- actions.aoe_burst+=/wound_spender,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack>=1
        if woundSpender:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) >= 1 then
            return woundSpender:Show(icon)
        end

        -- actions.aoe_burst+=/epidemic,if=!variable.pooling_runic_power|fight_remains<10
        if A.Epidemic:IsReady(player) and (not poolingRunicPower or fightRemains < 10) then
            return A.Epidemic:Show(icon)
        end

        -- actions.aoe_burst+=/death_coil,if=!variable.pooling_runic_power&!talent.epidemic
        if A.DeathCoil:IsReady(unitID) and not poolingRunicPower and not A.Epidemic:IsTalentLearned() then
            return A.DeathCoil:Show(icon)
        end

        -- actions.aoe_burst+=/wound_spender
        if woundSpender:IsReady(unitID) then
            return woundSpender:Show(icon)
        end

    end

    local function aoeRotation(unitID)

        -- actions.aoe=epidemic,if=!variable.pooling_runic_power|fight_remains<10
        if A.Epidemic:IsReady(player) and (not poolingRunicPower or fightRemains < 10) then
            return A.Epidemic:Show(icon)
        end

        -- actions.aoe+=/wound_spender,target_if=max:debuff.festering_wound.stack,if=variable.pop_wounds
        if woundSpender:IsReady(unitID) and popWounds then
            return woundSpender:Show(icon)
        end

        -- actions.aoe+=/festering_strike,target_if=max:debuff.festering_wound.stack,if=!variable.pop_wounds
        if A.FesteringStrike:IsReady(unitID) and not popWounds then
            return A.FesteringStrike:Show(icon)
        end

        -- actions.aoe+=/death_coil,if=!variable.pooling_runic_power&!talent.epidemic
        if A.DeathCoil:IsReady(unitID) and not poolingRunicPower and not A.Epidemic:IsTalentLearned() then
            return A.DeathCoil:Show(icon)
        end


    end

    local function singleTarget(unitID)

        -- actions.st=death_coil,if=!variable.epidemic_priority&(!variable.pooling_runic_power&(rune<3|gargTime>0|Unit(unitID):HasBuffs(A.SuddenDoom.ID) > 0|A.Apocalypse:GetCooldown() < 10 and Unit(unitID):HasDebuffs(A.FesteringWound.ID) > 3|not popWounds and Unit(unitID):HasDebuffs(A.FesteringWound.ID) >= 4)|fight_remains<10)
        if A.DeathCoil:IsReady(unitID) and not epidemicPriority and (not poolingRunicPower and (rune < 3 or gargTime > 0 or Unit(player):HasBuffs(A.SuddenDoom.ID) > 0 or A.Apocalypse:GetCooldown() < 10 and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) > 3 or not popWounds and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) >= 4) or fightRemains < 10) then
            return A.DeathCoil:Show(icon)
        end

        -- actions.st+=/epidemic,if=variable.epidemic_priority&(!variable.pooling_runic_power&(rune<3|gargTime>0|Unit(unitID):HasBuffs(A.SuddenDoom.ID) > 0|A.Apocalypse:GetCooldown() < 10 and Unit(unitID):HasDebuffs(A.FesteringWound.ID) > 3|not popWounds and Unit(unitID):HasDebuffs(A.FesteringWound.ID) >= 4)|fight_remains<10)
        if A.Epidemic:IsReady(player) and epidemicPriority and (not poolingRunicPower and (rune < 3 or gargTime > 0 or Unit(player):HasBuffs(A.SuddenDoom.ID) > 0 or A.Apocalypse:GetCooldown() < 10 and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) > 3 or not popWounds and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) >= 4) or fightRemains < 10) then
            return A.Epidemic:Show(icon)
        end

        -- actions.st+=/any_dnd,if=!A.DeathandDecay:IsTicking(unitID)&(active_enemies>=2|A.UnholyGround:IsTalentLearned()&(apocGhoul >= 13 or gargTime > 8 or armyGhoul > 8 or not popWounds and Unit(unitID):HasDebuffs(A.FesteringWound.ID) >= 4))&(fwoundedTargets = active_enemies or active_enemies=1)
        local anyDnd 
        if A.Defile:IsTalentLearned() then
            anyDnd = A.Defile
        else
            anyDnd = A.DeathandDecay
        end
        if anyDnd:IsReady(player) and not isMoving and Unit(player):HasBuffs(A.DeathandDecay.ID) == 0 and (activeEnemies >= 2 or A.UnholyGround:IsTalentLearned() and (apocGhoul >= 13 or gargTime > 8 or armyGhoul > 8 or not popWounds and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) >= 4)) and (fwoundedTargets == activeEnemies or activeEnemies <= 1) then
            return anyDnd:Show(icon)
        end

        -- actions.st+=/wound_spender,target_if=max:debuff.festering_wound.stack,if=variable.pop_wounds|active_enemies>=2&A.DeathandDecay:IsTicking(unitID)
        if woundSpender:IsReady(unitID) and (popWounds or activeEnemies >= 2 and Unit(player):HasBuffs(A.DeathandDecay.ID) > 0) then
            return woundSpender:Show(icon)
        end

        -- actions.st+=/festering_strike,target_if=min:debuff.festering_wound.stack,if=!variable.pop_wounds&Unit(unitID):HasDebuffs(A.FesteringWound.ID) < 4
        if A.FesteringStrike:IsReady(unitID) and not popWounds and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) < 4 then
            return A.FesteringStrike:Show(icon)
        end

        -- actions.st+=/death_coil
        if A.DeathCoil:IsReady(unitID) then
            return A.DeathCoil:Show(icon)
        end

        -- actions.st+=/wound_spender,target_if=max:debuff.festering_wound.stack,if=!variable.pop_wounds&Unit(unitID):HasDebuffs(A.FesteringWound.ID) >= 4
        if woundSpender:IsReady(unitID) and not popWounds and Unit(unitID):HasDeBuffs(A.FesteringWound.ID) >= 4 then
            return woundSpender:Show(icon)
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
        local highPrioActionsCall = highPrioActions(unitID) 
        if highPrioActionsCall  then
            return highPrioActionsCall 
        end

        -- actions+=/call_action_list,name=trinkets
        local UseTrinket = UseTrinkets(unitID)
        if UseTrinket and InMelee() then
            return UseTrinket:Show(icon)
        end  
        
        -- actions+=/run_action_list,name=garg_setup,if=variable.garg_setup=0
        local gargSetupCall = gargSetup(unitID)
        if gargSetupCall and not gargSetup and useBurst then
            return gargSetupCall
        end 

        -- actions+=/call_action_list,name=cooldowns,if=variable.st_planning
        local cooldownsCall = cooldowns(unitID)
        if cooldownsCall and stPlanning and useBurst then
            return cooldownsCall
        end

        -- actions+=/call_action_list,name=aoe_cooldowns,if=variable.adds_remain
        local aoeCooldownsCall = aoeCooldowns(unitID)
        if aoeCooldownsCall and addsRemain and useBurst then
            return aoeCooldownsCall
        end

        -- actions+=/call_action_list,name=racials
        local racialsCall = racials(unitID)
        if racialsCall and useRacial and useBurst then
            return racialsCall
        end

        local anyDnd 
        if A.Defile:IsTalentLearned() then
            anyDnd = A.Defile
        else
            anyDnd = A.DeathandDecay
        end
        -- actions+=/call_action_list,name=aoe_setup,if=variable.adds_remain&cooldown.any_dnd.remains<10&!death_and_decay.ticking
        local aoeSetupCall = aoeSetup(unitID) 
        if aoeSetupCall and addsRemain and anyDnd:GetCooldown() < 10 and Unit(player):HasBuffs(A.DeathandDecay.ID) == 0 then
            return aoeSetupCall
        end

        -- actions+=/call_action_list,name=aoe_burst,if=active_enemies>=4&death_and_decay.ticking
        local aoeBurstCall = aoeBurst(unitID)
        if aoeBurstCall and activeEnemies >= 4 and Unit(player):HasBuffs(A.DeathandDecay.ID) > 0 then
            return aoeBurstCall
        end

        -- actions+=/call_action_list,name=aoe,if=active_enemies>=4&(cooldown.any_dnd.remains>10&!death_and_decay.ticking|!variable.adds_remain)
        local aoeRotationCall = aoeRotation(unitID)
        if aoeRotationCall and activeEnemies >= 4 and (anyDnd:GetCooldown() > 10 and Unit(player):HasBuffs(A.DeathandDecay.ID) == 0 or not addsRemain) then
            return aoeRotationCall
        end

        -- actions+=/call_action_list,name=st,if=active_enemies<=3
        local singleTargetCall = singleTarget(unitID) 
        if singleTargetCall and activeEnemies <= 3 then
            return singleTargetCall
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