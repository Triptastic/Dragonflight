--####################################
--##### TRIP'S BLOOD DEATHKNIGHT #####
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

Action[ACTION_CONST_DEATHKNIGHT_BLOOD] = {
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

local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_BLOOD], { __index = Action })

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
    cooldownTimer                           = 0,
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
	return A.HeartStrike:IsInRange(unitID)
end 



--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local runicPower = Player:RunicPower()
    local runicPowerDeficit = Player:RunicPowerDeficit()
    local runicPowerMax = Player:RunicPowerMax()
    local rune = Player:Rune()
    local noCooldownsActive = Unit("player"):HasBuffs(A.DancingRuneWeapon.ID) == 0 and Unit("player"):HasBuffs(A.IceboundFortitude.ID) == 0 and Unit("player"):HasBuffs(A.VampiricBlood.ID) == 0 and Unit("player"):HasBuffs(A.VampiricStrength.ID) == 0
    local UseRacial = A.GetToggle(1, "Racial")
    local useAoE = A.GetToggle(2, "AoE")
    local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID = GetWeaponEnchantInfo()
    local hasRazerice = mainHandEnchantID == 3370
    local hasFallenCrusader = mainHandEnchantID == 3368
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local fightRemains = MultiUnits:GetByRangeAreaTTD(20)
    local activeEnemies = MultiUnits:GetByRange(10, 5)
    local petTime = Player:GetTotemTimeLeft(1)
    Player:AddTier("Tier30", { 205810, 202462, 202461, 202460, 202459, })
    local T30has2P = Player:HasTier("Tier30", 2)
    local T30has4P = Player:HasTier("Tier30", 4)

    if Temp.cooldownTimer > 0 then
        Temp.cooldownTimer = Temp.cooldownTimer - 1
    end


    if activeEnemies >= 2 then
        spellTargetsHeartStrike = 2
    else
        spellTargetsHeartStrike = 1
    end
    

    -- actions+=/variable,name=death_strike_dump_amount,value=65
    deathStrikeDumpAmount = 65

    -- actions.drw_up+=/variable,name=heart_strike_rp_drw,value=(25+spell_targets.heart_strike*talent.heartbreaker.enabled*2)
    heartStrikeRpDrw = (25 + spellTargetsHeartStrike * num(A.Heartbreaker:IsTalentLearned()) * 2)

    -- actions.standard+=/variable,name=heart_strike_rp,value=(10+spell_targets.heart_strike*talent.heartbreaker.enabled*2)
    heartStrikeRp = 10 + spellTargetsHeartStrike * num(A.Heartbreaker:IsTalentLearned()) * 2

    -- actions+=/variable,name=bone_shield_refresh_value,value=4,op=setif,condition=!talent.deaths_caress.enabled|talent.consumption.enabled|talent.blooddrinker.enabled,value_else=5
    if not A.DeathsCaress:IsTalentLearned() or A.Consumption:IsTalentLearned() or A.Blooddrinker:IsTalentLearned() then
        boneShieldRefreshValue = 4
    else
        boneShieldRefreshValue = 5
    end

    local function drwUp(unitID)
        -- actions.drw_up=blood_boil,if=!dot.blood_plague.ticking
        if A.BloodBoil:IsReady(player) and Unit(unitID):HasDeBuffs(A.BloodPlague.ID) == 0 and InMelee() then
            return A.BloodBoil:Show(icon)
        end

        -- actions.drw_up+=/tombstone,if=buff.bone_shield.stack>5&rune>=2&runic_power.deficit>=30&!talent.shattering_bone|(talent.shattering_bone.enabled&death_and_decay.ticking)
        if A.Tombstone:IsReady(player) and Unit("player"):HasBuffsStacks(A.BoneShield.ID) > 5 and rune >= 2 and runicPowerDeficit >= 30 and (not A.ShatteringBone:IsTalentLearned() or (A.ShatteringBone:IsTalentLearned() and A.DeathandDecay:GetCooldown() > 0)) then
            return A.Tombstone:Show(icon)
        end

        -- actions.drw_up+=/death_strike,if=buff.coagulopathy.remains<=gcd|buff.icy_talons.remains<=gcd
        if A.DeathStrike:IsReady(unitID) and (Unit("player"):HasBuffs(A.Coagulopathy.ID) <= A.GetGCD() or Unit("player"):HasBuffs(A.IcyTalons.ID) <= A.GetGCD()) then
            return A.DeathStrike:Show(icon)
        end

        -- actions.drw_up+=/marrowrend,if=(buff.bone_shield.remains<=4|buff.bone_shield.stack<variable.bone_shield_refresh_value)&runic_power.deficit>20
        if A.Marrowrend:IsReady(unitID) and (Unit("player"):HasBuffs(A.BoneShield.ID) <= 4 or Unit("player"):HasBuffsStacks(A.BoneShield.ID) < boneShieldRefreshValue) and runicPowerDeficit > 20 then
            return A.Marrowrend:Show(icon)
        end

        -- actions.drw_up+=/soul_reaper,if=active_enemies=1&target.time_to_pct_35<5&target.time_to_die>(dot.soul_reaper.remains+5)
        if A.SoulReaper:IsReady(unitID) and Unit(unitID):TimeToDieX(35) < 5 and Unit(unitID):TimeToDie() > (Unit(unitID):HasDeBuffs(A.SoulReaperDebuff.ID) + 5) then
            return A.SoulReaper:Show(icon)
        end

        -- actions.drw_up+=/death_and_decay,if=!death_and_decay.ticking&(talent.sanguine_ground|talent.unholy_ground)
        if A.DeathandDecay:IsReady(player) and Unit(player):HasBuffs(A.DeathandDecayBuff.ID) == 0 and InMelee() and (A.SanguineGround:IsTalentLearned() or A.UnholyGround:IsTalentLearned()) then
            return A.DeathandDecay:Show(icon)
        end

        -- actions.drw_up+=/blood_boil,if=spell_targets.blood_boil>2&charges_fractional>=1.1
        if A.BloodBoil:IsReady(player) and activeEnemies > 2 and A.BloodBoil:GetSpellChargesFrac() >= 1.1 then
            return A.BloodBoil:Show(icon)
        end

        -- actions.drw_up+=/death_strike,if=runic_power.deficit<=variable.heart_strike_rp_drw|runic_power>=variable.death_strike_dump_amount
        if A.DeathStrike:IsReady(unitID) and (runicPowerDeficit <= heartStrikeRpDrw or runicPower >= deathStrikeDumpAmount) then
            return A.DeathStrike:Show(icon)
        end

        -- actions.drw_up+=/consumption
        if A.Consumption:IsReady(player) and InMelee() then
            return A.Consumption:Show(icon)
        end
        -- actions.drw_up+=/blood_boil,if=charges_fractional>=1.1&buff.hemostasis.stack<5
        if A.BloodBoil:IsReady(player) and A.BloodBoil:GetSpellChargesFrac() >= 1.1 and Unit(player):HasBuffsStacks(A.Hemostasis.ID) < 5 then
            return A.BloodBoil:Show(icon)
        end
        -- actions.drw_up+=/heart_strike,if=rune.time_to_2<gcd|runic_power.deficit>=variable.heart_strike_rp_drw
        if A.HeartStrike:IsReady(unitID) and (Player:RuneTimeToX(2) < A.GetGCD() or runicPowerDeficit >= heartStrikeRpDrw) then
            return A.HeartStrike:Show(icon)
        end

    end

    local function racials(unitID)
        -- actions.racials=blood_fury,if=cooldown.dancing_rune_weapon.ready&(!cooldown.blooddrinker.ready|!talent.blooddrinker.enabled)
        if A.BloodFury:IsReady(player) and A.DancingRuneWeapon:GetCooldown() == 0 and (A.Blooddrinker:GetCooldown() > 0 or not A.Blooddrinker:IsTalentLearned()) then
            return A.BloodFury:Show(icon)
        end

        -- actions.racials+=/berserking
        if A.Berserking:IsReady(player) then
            return A.Berserking:Show(icon)
        end

        -- actions.racials+=/arcane_pulse,if=active_enemies>=2|rune<1&runic_power.deficit>60
        if A.ArcanePulse:IsReady(player) and (activeEnemies >= 2 or rune < 1 and runicPowerDeficit > 60) then
            return A.ArcanePulse:Show(icon)
        end

        -- actions.racials+=/lights_judgment,if=buff.unholy_strength.up
        if A.LightsJudgment:IsReady(unitID) and Unit("player"):HasBuffs(A.UnholyStrength.ID) > 0 then
            return A.LightsJudgment:Show(icon)
        end

        -- actions.racials+=/ancestral_call
        if A.AncestralCall:IsReady(player) then
            return A.AncestralCall:Show(icon)
        end

        -- actions.racials+=/fireblood
        if A.Fireblood:IsReady(player) then
            return A.Fireblood:Show(icon)
        end

        -- actions.racials+=/bag_of_tricks
        if A.BagofTricks:IsReady(unitID) then
            return A.BagOfTricks:Show(icon)
        end

        -- actions.racials+=/arcane_torrent,if=runic_power.deficit>20
        if A.ArcaneTorrent:IsReady(player) and runicPowerDeficit > 20 then
            return A.ArcaneTorrent:Show(icon)
        end

    end

    local function standard(unitID)
        -- actions.standard=tombstone,if=buff.bone_shield.stack>5&rune>=2&runic_power.deficit>=30&!talent.shattering_bone|(talent.shattering_bone.enabled&death_and_decay.ticking)&cooldown.dancing_rune_weapon.remains>=25
        if A.Tombstone:IsReady(player) and Unit("player"):HasBuffsStacks(A.BoneShield.ID) > 5 and rune >= 2 and runicPowerDeficit >= 30 and (not A.ShatteringBone:IsTalentLearned() or (A.ShatteringBone:IsTalentLearned() and Unit(player):HasBuffs(A.DeathandDecayBuff.ID) > 0)) and A.DancingRuneWeapon:GetCooldown() >= 25 then
            return A.Tombstone:Show(icon)
        end

        -- actions.standard+=/death_strike,if=buff.coagulopathy.remains<=gcd|buff.icy_talons.remains<=gcd|runic_power>=variable.death_strike_dump_amount|runic_power.deficit<=variable.heart_strike_rp|target.time_to_die<10
        if A.DeathStrike:IsReady(unitID) and (Unit("player"):HasBuffs(A.Coagulopathy.ID) <= A.GetGCD() or Unit("player"):HasBuffs(A.IcyTalons.ID) <= A.GetGCD() or runicPower >= deathStrikeDumpAmount or runicPowerDeficit <= heartStrikeRp or Unit(unitID):TimeToDie() < 10) then
            return A.DeathStrike:Show(icon)
        end

        -- actions.standard+=/deaths_caress,if=(buff.bone_shield.remains<=4|(buff.bone_shield.stack<variable.bone_shield_refresh_value+1))&runic_power.deficit>10&!(talent.insatiable_blade&cooldown.dancing_rune_weapon.remains<buff.bone_shield.remains)&!talent.consumption.enabled&!talent.blooddrinker.enabled&rune.time_to_3>gcd
        if A.DeathsCaress:IsReady(unitID) and (Unit("player"):HasBuffs(A.BoneShield.ID) <= 4 or Unit("player"):HasBuffsStacks(A.BoneShield.ID) < boneShieldRefreshValue + 1) and runicPowerDeficit > 10 and not (A.InsatiableBlade:IsTalentLearned() and A.DancingRuneWeapon:GetCooldown() < Unit("player"):HasBuffs(A.BoneShield.ID)) and not A.Consumption:IsTalentLearned() and not A.Blooddrinker:IsTalentLearned() and Player:RuneTimeToX(3) > A.GetGCD() then
            return A.DeathsCaress:Show(icon)
        end

        -- actions.standard+=/marrowrend,if=(buff.bone_shield.remains<=4|buff.bone_shield.stack<variable.bone_shield_refresh_value)&runic_power.deficit>20&!(talent.insatiable_blade&cooldown.dancing_rune_weapon.remains<buff.bone_shield.remains)
        if A.Marrowrend:IsReady(unitID) and (Unit("player"):HasBuffs(A.BoneShield.ID) <= 4 or Unit("player"):HasBuffsStacks(A.BoneShield.ID) < boneShieldRefreshValue) and runicPowerDeficit > 20 and not (A.InsatiableBlade:IsTalentLearned() and A.DancingRuneWeapon:GetCooldown() < Unit("player"):HasBuffs(A.BoneShield.ID)) then
            return A.Marrowrend:Show(icon)
        end
        -- actions.standard+=/consumption
        if A.Consumption:IsReady(player) then
            return A.Consumption:Show(icon)
        end
        -- actions.standard+=/soul_reaper,if=active_enemies=1&target.time_to_pct_35<5&target.time_to_die>(dot.soul_reaper.remains+5)
        if A.SoulReaper:IsReady(unitID) and Unit(unitID):TimeToDieX(35) < 5 and Unit(unitID):TimeToDie() > (Unit(unitID):HasDeBuffs(A.SoulReaperDebuff.ID) + 5) then
            return A.SoulReaper:Show(icon)
        end

        -- actions.standard+=/bonestorm,if=runic_power>=100
        if A.Bonestorm:IsReady(player) and runicPower >= 100 then
            return A.Bonestorm:Show(icon)
        end

        -- actions.standard+=/blood_boil,if=charges_fractional>=1.8&(buff.hemostasis.stack<=(5-spell_targets.blood_boil)|spell_targets.blood_boil>2)
        if A.BloodBoil:IsReady(player) and InMelee() and A.BloodBoil:GetSpellChargesFrac() >= 1.8 and (Unit(player):HasBuffsStacks(A.Hemostasis.ID) <= (5 - activeEnemies) or activeEnemies > 2) then
            return A.BloodBoil:Show(icon)
        end

        -- actions.standard+=/heart_strike,if=rune.time_to_4<gcd
        if A.HeartStrike:IsReady(unitID) and Player:RuneTimeToX(4) < A.GetGCD() then
            return A.HeartStrike:Show(icon)
        end

        -- actions.standard+=/blood_boil,if=charges_fractional>=1.1
        if A.BloodBoil:IsReady(player) and InMelee() and A.BloodBoil:GetSpellChargesFrac() >= 1.1 then
            return A.BloodBoil:Show(icon)
        end

        -- actions.standard+=/heart_strike,if=(rune>1&(rune.time_to_3<gcd|buff.bone_shield.stack>7))
        if A.HeartStrike:IsReady(unitID) and rune > 1 and (Player:RuneTimeToX(3) < A.GetGCD() or Unit("player"):HasBuffsStacks(A.BoneShield.ID) > 7) then
            return A.HeartStrike:Show(icon)
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

        -- actions+=/raise_dead
        if A.RaiseDead:IsReady(player) then
            return A.RaiseDead:Show(icon)
        end

        -- actions+=/icebound_fortitude,if=!(buff.dancing_rune_weapon.up|buff.vampiric_blood.up)&(target.cooldown.pause_action.remains>=8|target.cooldown.pause_action.duration>0)
        if A.IceboundFortitude:IsReady(player) and (Unit("player"):HasBuffs(A.DancingRuneWeapon.ID) == 0 or Unit("player"):HasBuffs(A.VampiricBlood.ID) == 0) then
            Temp.cooldownTimer = 40
            return A.IceboundFortitude:Show(icon)
        end

        -- actions+=/vampiric_blood,if=!buff.vampiric_blood.up&!buff.vampiric_strength.up
        if A.VampiricBlood:IsReady(player) and Unit("player"):HasBuffs(A.VampiricBlood.ID) == 0 and Unit("player"):HasBuffs(A.VampiricStrength.ID) == 0 then
            Temp.cooldownTimer = 40
            return A.VampiricBlood:Show(icon)
        end

        -- actions+=/vampiric_blood,if=!(buff.dancing_rune_weapon.up|buff.icebound_fortitude.up|buff.vampiric_blood.up|buff.vampiric_strength.up)&(target.cooldown.pause_action.remains>=13|target.cooldown.pause_action.duration>0)
        if A.VampiricBlood:IsReady(player) and noCooldownsActive then
            Temp.cooldownTimer = 40
            return A.VampiricBlood:Show(icon)
        end

        -- actions+=/deaths_caress,if=!buff.bone_shield.up
        if A.DeathsCaress:IsReady(unitID) and Unit("player"):HasBuffs(A.BoneShield.ID) == 0 then
            return A.DeathsCaress:Show(icon)
        end

        -- actions+=/death_and_decay,if=!death_and_decay.ticking&(talent.unholy_ground|talent.sanguine_ground|spell_targets.death_and_decay>3|buff.crimson_scourge.up)
        if A.DeathandDecay:IsReady(player) and InMelee() and Unit(player):HasBuffs(A.DeathandDecayBuff.ID) == 0 and (A.UnholyGround:IsTalentLearned() or A.SanguineGround:IsTalentLearned() or activeEnemies > 3 or Unit(player):HasBuffs(A.CrimsonScourge.ID) > 0) then
            return A.DeathandDecay:Show(icon)
        end

        -- actions+=/death_strike,if=buff.coagulopathy.remains<=gcd|buff.icy_talons.remains<=gcd|runic_power>=variable.death_strike_dump_amount|runic_power.deficit<=variable.heart_strike_rp|target.time_to_die<10
        if A.DeathStrike:IsReady(unitID) and (Unit(player):HasBuffs(A.Coagulopathy.ID) <= A.GetGCD() or Unit(player):HasBuffs(A.IcyTalons.ID) <= A.GetGCD() or runicPower >= deathStrikeDumpAmount or runicPowerDeficit <= heartStrikeRp or Unit(unitID):TimeToDie() < 10) then
            return A.DeathStrike:Show(icon)
        end

        -- actions+=/blooddrinker,if=!buff.dancing_rune_weapon.up
        if A.Blooddrinker:IsReady(unitID) and Unit("player"):HasBuffs(A.DancingRuneWeapon.ID) == 0 then
            return A.Blooddrinker:Show(icon)
        end

        -- actions+=/call_action_list,name=racials
        if useRacial then
            return racials(unitID)
        end

        -- actions+=/sacrificial_pact,if=!buff.dancing_rune_weapon.up&(pet.ghoul.remains<2|target.time_to_die<gcd)
        if A.SacrificialPact:IsReady(player) and Unit("player"):HasBuffs(A.DancingRuneWeapon.ID) == 0 and (petTime < 2 or Unit(unitID):TimeToDie() < A.GetGCD()) then
            return A.SacrificialPact:Show(icon)
        end

        -- actions+=/blood_tap,if=(rune<=2&rune.time_to_4>gcd&charges_fractional>=1.8)|rune.time_to_3>gcd
        if A.BloodTap:IsReady(player) and ((rune <= 2 and Player:RuneTimeToX(4) > A.GetGCD() and A.BloodTap:GetSpellChargesFrac() >= 1.8) or Player:RuneTimeToX(3) > A.GetGCD()) then
            return A.BloodTap:Show(icon)
        end

        -- actions+=/gorefiends_grasp,if=talent.tightening_grasp.enabled
        if A.GorefiendsGrasp:IsReady(player) and A.TighteningGrasp:IsTalentLearned() then
            return A.GorefiendsGrasp:Show(icon)
        end

        -- actions+=/empower_rune_weapon,if=rune<6&runic_power.deficit>5
        if A.EmpowerRuneWeapon:IsReady(player) and rune < 6 and runicPowerDeficit > 5 then
            return A.EmpowerRuneWeapon:Show(icon)
        end

        -- actions+=/abomination_limb
        if A.AbominationLimb:IsReady(player) then
            return A.AbominationLimb:Show(icon)
        end

        -- actions+=/dancing_rune_weapon,if=!buff.dancing_rune_weapon.up
        if A.DancingRuneWeapon:IsReady(player) and Unit("player"):HasBuffs(A.DancingRuneWeapon.ID) == 0 then
            Temp.cooldownTimer = 40
            return A.DancingRuneWeapon:Show(icon)
        end

        -- actions+=/run_action_list,name=drw_up,if=buff.dancing_rune_weapon.up
        if Unit(player):HasBuffs(A.DancingRuneWeapon.ID) > 0 then
            return drwUp(unitID)
        end

        -- actions+=/call_action_list,name=standard
        return standard(unitID)


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