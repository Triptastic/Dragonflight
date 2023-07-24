--####################################
--##### TRIP'S RESTORATION DRUID #####
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

Action[ACTION_CONST_DRUID_RESTORATION] = {
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
	Regeneratin					= Action.Create({ Type = "Spell", ID = 291944   }), 
	
	--General
    EntanglingRoots= Action.Create({ Type = "Spell", ID = 339 }),
	CatForm		= Action.Create({ Type = "Spell", ID = 768 }),
	TravelForm		= Action.Create({ Type = "Spell", ID = 783 }),
	MarkoftheWild  = Action.Create({ Type = "Spell", ID = 1126 }),
	Dash           = Action.Create({ Type = "Spell", ID = 1850 }),
	Wrath          = Action.Create({ Type = "Spell", ID = 5176 }),
	Prowl          = Action.Create({ Type = "Spell", ID = 5215 }),
	Shred          = Action.Create({ Type = "Spell", ID = 5221 }),
	BearForm		= Action.Create({ Type = "Spell", ID = 5487 }),
	Growl          = Action.Create({ Type = "Spell", ID = 6795 }),
	Moonfire       = Action.Create({ Type = "Spell", ID = 8921 }),
	MoonfireDebuff       = Action.Create({ Type = "Spell", ID = 164812 }),
	Regrowth       = Action.Create({ Type = "Spell", ID = 8936 }),
	Rebirth        = Action.Create({ Type = "Spell", ID = 20484 }),
	FerociousBite  = Action.Create({ Type = "Spell", ID = 22568 }),
	Barkskin       = Action.Create({ Type = "Spell", ID = 22812 }),
	Mangle         = Action.Create({ Type = "Spell", ID = 33917 }),
	NaturesCure    = Action.Create({ Type = "Spell", ID = 88423 }),
	Revitalize     = Action.Create({ Type = "Spell", ID = 212040 }),
	IncapacitatingRoar= Action.Create({ Type = "Spell", ID = 99 }),
	Tranquility    = Action.Create({ Type = "Spell", ID = 740 }),
	Rejuvenation   = Action.Create({ Type = "Spell", ID = 774 }),
	Rip            = Action.Create({ Type = "Spell", ID = 1079 }),
	Rake           = Action.Create({ Type = "Spell", ID = 1822 }),
	RakeDebuff           = Action.Create({ Type = "Spell", ID = 155722 }),
	Hibernate      = Action.Create({ Type = "Spell", ID = 2637 }),
	RemoveCorruption= Action.Create({ Type = "Spell", ID = 2782 }),
	Soothe         = Action.Create({ Type = "Spell", ID = 2908 }),
	MightyBash     = Action.Create({ Type = "Spell", ID = 5211 }),
	TigersFury     = Action.Create({ Type = "Spell", ID = 5217 }),
	Maul           = Action.Create({ Type = "Spell", ID = 6807 }),
	OmenofClarity  = Action.Create({ Type = "Spell", ID = 16864 }),
	ClearCasting  = Action.Create({ Type = "Spell", ID = 16870 }),
	ThickHide      = Action.Create({ Type = "Spell", ID = 16931 }),
	PredatorySwiftness= Action.Create({ Type = "Spell", ID = 16974 }),
	Swiftmend      = Action.Create({ Type = "Spell", ID = 18562 }),
	Maim           = Action.Create({ Type = "Spell", ID = 22570 }),
	FrenziedRegeneration= Action.Create({ Type = "Spell", ID = 22842 }),
	MoonkinForm    = Action.Create({ Type = "Spell", ID = 24858 }),
	Innervate      = Action.Create({ Type = "Spell", ID = 29166 }),
	Lifebloom      = Action.Create({ Type = "Spell", ID = 33763 }),
	Cyclone        = Action.Create({ Type = "Spell", ID = 33786 }),
	NurturingInstinct= Action.Create({ Type = "Spell", ID = 33873 }),
	IncarnationTreeofLife= Action.Create({ Type = "Spell", ID = 33891 }),
	WildGrowth     = Action.Create({ Type = "Spell", ID = 48438 }),
	InfectedWounds = Action.Create({ Type = "Spell", ID = 48484 }),
	Nourish        = Action.Create({ Type = "Spell", ID = 50464 }),
	SurvivalInstincts= Action.Create({ Type = "Spell", ID = 61336 }),
	Starsurge      = Action.Create({ Type = "Spell", ID = 78674 }),
	SolarBeam      = Action.Create({ Type = "Spell", ID = 78675 }),
	Eclipse        = Action.Create({ Type = "Spell", ID = 79577 }),
	Pulverize      = Action.Create({ Type = "Spell", ID = 80313 }),
	WildMushroom   = Action.Create({ Type = "Spell", ID = 88747 }),
	Sunfire        = Action.Create({ Type = "Spell", ID = 93402 }),
	SunfireDebuff        = Action.Create({ Type = "Spell", ID = 164815 }),
	Ironbark       = Action.Create({ Type = "Spell", ID = 102342 }),
	CenarionWard   = Action.Create({ Type = "Spell", ID = 102351 }),
	MassEntanglement= Action.Create({ Type = "Spell", ID = 102359 }),
	WildCharge     = Action.Create({ Type = "Spell", ID = 102401 }),
	IncarnationAvatarofAshamane= Action.Create({ Type = "Spell", ID = 102543 }),
	UrsolsVortex   = Action.Create({ Type = "Spell", ID = 102793 }),
	Thrash         = Action.Create({ Type = "Spell", ID = 106830 }),
	ThrashBear = Action.Create({ Type = "Spell", ID = 77758 }),
	ThrashBearDebuff = Action.Create({ Type = "Spell", ID = 192090 }),
	SkullBash      = Action.Create({ Type = "Spell", ID = 106839 }),
	StampedingRoar = Action.Create({ Type = "Spell", ID = 106898 }),
	Renewal        = Action.Create({ Type = "Spell", ID = 108238 }),
	KillerInstinct = Action.Create({ Type = "Spell", ID = 108299 }),
	SouloftheForest= Action.Create({ Type = "Spell", ID = 114107 }),
	NaturesVigil   = Action.Create({ Type = "Spell", ID = 124974 }),
	FelineSwiftness= Action.Create({ Type = "Spell", ID = 131768 }),
	NaturesSwiftness= Action.Create({ Type = "Spell", ID = 132158 }),
	Typhoon        = Action.Create({ Type = "Spell", ID = 132469 }),
	ToothandClaw   = Action.Create({ Type = "Spell", ID = 135288 }),
	YserasGift     = Action.Create({ Type = "Spell", ID = 145108 }),
	Efflorescence  = Action.Create({ Type = "Spell", ID = 145205 }),
	GuardianofElune= Action.Create({ Type = "Spell", ID = 155578 }),
	LunarInspiration= Action.Create({ Type = "Spell", ID = 155580 }),
	Germination    = Action.Create({ Type = "Spell", ID = 155675 }),
	WildSynthesis    = Action.Create({ Type = "Spell", ID = 400533 }),
	WildSynthesisBuff    = Action.Create({ Type = "Spell", ID = 400534 }),
	BristlingFur   = Action.Create({ Type = "Spell", ID = 155835 }),
	PrimalFury     = Action.Create({ Type = "Spell", ID = 159286 }),
	Starfall       = Action.Create({ Type = "Spell", ID = 191034 }),
	Ironfur        = Action.Create({ Type = "Spell", ID = 192081 }),
	Starfire       = Action.Create({ Type = "Spell", ID = 194153 }),
	Stonebark      = Action.Create({ Type = "Spell", ID = 197061 }),
	InnerPeace     = Action.Create({ Type = "Spell", ID = 197073 }),
	AstralInfluence= Action.Create({ Type = "Spell", ID = 197524 }),
	Flourish       = Action.Create({ Type = "Spell", ID = 197721 }),
	Cultivation    = Action.Create({ Type = "Spell", ID = 200390 }),
	RageoftheSleeper= Action.Create({ Type = "Spell", ID = 200851 }),
	GoryFur        = Action.Create({ Type = "Spell", ID = 200854 }),
	Predator       = Action.Create({ Type = "Spell", ID = 202021 }),
	BrutalSlash    = Action.Create({ Type = "Spell", ID = 202028 }),
	Sabertooth     = Action.Create({ Type = "Spell", ID = 202031 }),
	ShootingStars  = Action.Create({ Type = "Spell", ID = 202342 }),
	Starlord       = Action.Create({ Type = "Spell", ID = 202345 }),
	StellarFlare   = Action.Create({ Type = "Spell", ID = 202347 }),
	AstralCommunion= Action.Create({ Type = "Spell", ID = 202359 }),
	WarriorofElune = Action.Create({ Type = "Spell", ID = 202425 }),
	NaturesBalance = Action.Create({ Type = "Spell", ID = 202430 }),
	FuryofElune    = Action.Create({ Type = "Spell", ID = 202770 }),
	LightoftheSun  = Action.Create({ Type = "Spell", ID = 202918 }),
	Overgrowth     = Action.Create({ Type = "Spell", ID = 203651 }),
	Brambles       = Action.Create({ Type = "Spell", ID = 203953 }),
	BloodFrenzy    = Action.Create({ Type = "Spell", ID = 203962 }),
	GalacticGuardian= Action.Create({ Type = "Spell", ID = 203964 }),
	SurvivaloftheFittest= Action.Create({ Type = "Spell", ID = 203965 }),
	Earthwarden    = Action.Create({ Type = "Spell", ID = 203974 }),
	RendandTear    = Action.Create({ Type = "Spell", ID = 204053 }),
	ForceofNature= Action.Create({ Type = "Spell", ID = 205636 }),
	Abundance      = Action.Create({ Type = "Spell", ID = 207383 }),
	SpringBlossoms = Action.Create({ Type = "Spell", ID = 207385 }),
	Gore           = Action.Create({ Type = "Spell", ID = 210706 }),
	Swipe          = Action.Create({ Type = "Spell", ID = 213764 }),
	ImprovedRegrowth= Action.Create({ Type = "Spell", ID = 231032 }),
	ImprovedRejuvenation= Action.Create({ Type = "Spell", ID = 231040 }),
	ImprovedSunfire= Action.Create({ Type = "Spell", ID = 231050 }),
	MercilessClaws = Action.Create({ Type = "Spell", ID = 231063 }),
	Mangle         = Action.Create({ Type = "Spell", ID = 231064 }),
	MomentofClarity= Action.Create({ Type = "Spell", ID = 236068 }),
	ScintillatingMoonlight= Action.Create({ Type = "Spell", ID = 238049 }),
	TigerDash      = Action.Create({ Type = "Spell", ID = 252216 }),
	NewMoon        = Action.Create({ Type = "Spell", ID = 274281 }),
	FeralFrenzy    = Action.Create({ Type = "Spell", ID = 274837 }),
	Photosynthesis = Action.Create({ Type = "Spell", ID = 274902 }),
	RampantGrowth  = Action.Create({ Type = "Spell", ID = 278515 }),
	TwinMoons      = Action.Create({ Type = "Spell", ID = 279620 }),
	PrimalWrath    = Action.Create({ Type = "Spell", ID = 285381 }),
	ImprovedStampedingRoar= Action.Create({ Type = "Spell", ID = 288826 }),
	UrsineAdept    = Action.Create({ Type = "Spell", ID = 300346 }),
	VerdantHeart   = Action.Create({ Type = "Spell", ID = 301768 }),
	Bloodtalons    = Action.Create({ Type = "Spell", ID = 319439 }),
	HeartoftheWild = Action.Create({ Type = "Spell", ID = 319454 }),
	NaturalWisdom  = Action.Create({ Type = "Spell", ID = 326228 }),
	AetherialKindling= Action.Create({ Type = "Spell", ID = 327541 }),
	ImprovedBarkskin= Action.Create({ Type = "Spell", ID = 327993 }),
	ImprovedWildGrowth= Action.Create({ Type = "Spell", ID = 328025 }),
	ImprovedSurvivalInstincts= Action.Create({ Type = "Spell", ID = 328767 }),
	Berserk        = Action.Create({ Type = "Spell", ID = 343223 }),
	BerserkRavage  = Action.Create({ Type = "Spell", ID = 343240 }),
	Solstice       = Action.Create({ Type = "Spell", ID = 343647 }),
	ElunesFavored  = Action.Create({ Type = "Spell", ID = 370586 }),
	FuryofNature   = Action.Create({ Type = "Spell", ID = 370695 }),
	AftertheWildfire= Action.Create({ Type = "Spell", ID = 371905 }),
	ViciousCycle   = Action.Create({ Type = "Spell", ID = 371999 }),
	DreamofCenarius= Action.Create({ Type = "Spell", ID = 372119 }),
	TwinMoonfire   = Action.Create({ Type = "Spell", ID = 372567 }),
	VulnerableFlesh= Action.Create({ Type = "Spell", ID = 372618 }),
	UntamedSavagery= Action.Create({ Type = "Spell", ID = 372943 }),
	Reinvigoration = Action.Create({ Type = "Spell", ID = 372945 }),
	UrsocsFury     = Action.Create({ Type = "Spell", ID = 377210 }),
	BerserkUncheckedAggression= Action.Create({ Type = "Spell", ID = 377623 }),
	BerserkPersistence= Action.Create({ Type = "Spell", ID = 377779 }),
	NaturalRecovery= Action.Create({ Type = "Spell", ID = 377796 }),
	TirelessPursuit= Action.Create({ Type = "Spell", ID = 377801 }),
	InnateResolve  = Action.Create({ Type = "Spell", ID = 377811 }),
	FrontofthePack = Action.Create({ Type = "Spell", ID = 377835 }),
	UrsineVigor    = Action.Create({ Type = "Spell", ID = 377842 }),
	WellHonedInstincts= Action.Create({ Type = "Spell", ID = 377847 }),
	ProtectorofthePack= Action.Create({ Type = "Spell", ID = 378986 }),
	LycarasTeachings= Action.Create({ Type = "Spell", ID = 378988 }),
	PassingSeasons = Action.Create({ Type = "Spell", ID = 382550 }),
	ImprovedIronbark= Action.Create({ Type = "Spell", ID = 382552 }),
	UnstoppableGrowth= Action.Create({ Type = "Spell", ID = 382559 }),
	Regenesis      = Action.Create({ Type = "Spell", ID = 383191 }),
	GroveTending   = Action.Create({ Type = "Spell", ID = 383192 }),
	UmbralIntensity= Action.Create({ Type = "Spell", ID = 383195 }),
	OrbitBreaker   = Action.Create({ Type = "Spell", ID = 383197 }),
	TirelessEnergy = Action.Create({ Type = "Spell", ID = 383352 }),
	TasteforBlood  = Action.Create({ Type = "Spell", ID = 384665 }),
	SuddenAmbush   = Action.Create({ Type = "Spell", ID = 384667 }),
	BerserkFrenzy  = Action.Create({ Type = "Spell", ID = 384668 }),
	LayeredMane    = Action.Create({ Type = "Spell", ID = 384721 }),
	MattedFur      = Action.Create({ Type = "Spell", ID = 385786 }),
	CatsCuriosity  = Action.Create({ Type = "Spell", ID = 386318 }),
	OrbitalStrike  = Action.Create({ Type = "Spell", ID = 390378 }),
	PouncingStrikes= Action.Create({ Type = "Spell", ID = 390772 }),
	WildSlashes    = Action.Create({ Type = "Spell", ID = 390864 }),
	CarnivorousInstinct= Action.Create({ Type = "Spell", ID = 390902 }),
	PrimalClaws    = Action.Create({ Type = "Spell", ID = 391037 }),
	DreadfulBleeding= Action.Create({ Type = "Spell", ID = 391045 }),
	RagingFury     = Action.Create({ Type = "Spell", ID = 391078 }),
	BerserkHeartoftheLion= Action.Create({ Type = "Spell", ID = 391174 }),
	RipandTear     = Action.Create({ Type = "Spell", ID = 391347 }),
	ConvoketheSpirits= Action.Create({ Type = "Spell", ID = 391528 }),
	AshamanesGuidance= Action.Create({ Type = "Spell", ID = 391548 }),
	DoubleClawedRake= Action.Create({ Type = "Spell", ID = 391700 }),
	RampantFerocity= Action.Create({ Type = "Spell", ID = 391709 }),
	TearOpenWounds = Action.Create({ Type = "Spell", ID = 391785 }),
	TigersTenacity = Action.Create({ Type = "Spell", ID = 391872 }),
	FranticMomentum= Action.Create({ Type = "Spell", ID = 391875 }),
	ApexPredatorsCraving= Action.Create({ Type = "Spell", ID = 391881 }),
	AdaptiveSwarm= Action.Create({ Type = "Spell", ID = 391888 }),
	ProtectiveGrowth= Action.Create({ Type = "Spell", ID = 391947 }),
	UnbridledSwarm = Action.Create({ Type = "Spell", ID = 391951 }),
	CircleofLifeandDeath= Action.Create({ Type = "Spell", ID = 391969 }),
	LionsStrength  = Action.Create({ Type = "Spell", ID = 391972 }),
	Veinripper     = Action.Create({ Type = "Spell", ID = 391978 }),
	NurturingDormancy= Action.Create({ Type = "Spell", ID = 392099 }),
	RegenerativeHeartwood= Action.Create({ Type = "Spell", ID = 392116 }),
	EmbraceoftheDream= Action.Create({ Type = "Spell", ID = 392124 }),
	Invigorate     = Action.Create({ Type = "Spell", ID = 392160 }),
	Dreamstate     = Action.Create({ Type = "Spell", ID = 392162 }),
	BuddingLeaves  = Action.Create({ Type = "Spell", ID = 392167 }),
	FlashofClarity = Action.Create({ Type = "Spell", ID = 392220 }),
	WakingDream    = Action.Create({ Type = "Spell", ID = 392221 }),
	HarmoniousBlooming= Action.Create({ Type = "Spell", ID = 392256 }),
	NaturesSplendor= Action.Create({ Type = "Spell", ID = 392288 }),
	Undergrowth    = Action.Create({ Type = "Spell", ID = 392301 }),
	PoweroftheArchdruid= Action.Create({ Type = "Spell", ID = 392302 }),
	LuxuriantSoil  = Action.Create({ Type = "Spell", ID = 392315 }),
	Verdancy       = Action.Create({ Type = "Spell", ID = 392325 }),
	Reforestation  = Action.Create({ Type = "Spell", ID = 392356 }),
	ReforestationBuff  = Action.Create({ Type = "Spell", ID = 392360 }),
	ImprovedNaturesCure= Action.Create({ Type = "Spell", ID = 392378 }),
	VerdantInfusion= Action.Create({ Type = "Spell", ID = 392410 }),
	FungalGrowth   = Action.Create({ Type = "Spell", ID = 392999 }),
	CenariusGuidance= Action.Create({ Type = "Spell", ID = 393371 }),
	UrsocsGuidance = Action.Create({ Type = "Spell", ID = 393414 }),
	FlashingClaws  = Action.Create({ Type = "Spell", ID = 393427 }),
	UrsocsEndurance= Action.Create({ Type = "Spell", ID = 393611 }),
	ReinforcedFur  = Action.Create({ Type = "Spell", ID = 393618 }),
	UmbralEmbrace  = Action.Create({ Type = "Spell", ID = 393760 }),
	RelentlessPredator= Action.Create({ Type = "Spell", ID = 393771 }),
	LunarShrapnel  = Action.Create({ Type = "Spell", ID = 393868 }),
	Starweaver     = Action.Create({ Type = "Spell", ID = 393940 }),
	RattletheStars = Action.Create({ Type = "Spell", ID = 393954 }),
	WaningTwilight = Action.Create({ Type = "Spell", ID = 393956 }),
	NaturesGrace   = Action.Create({ Type = "Spell", ID = 393958 }),
	PrimordialArcanicPulsar= Action.Create({ Type = "Spell", ID = 393960 }),
	ElunesGuidance = Action.Create({ Type = "Spell", ID = 393991 }),
	IncarnationChosenofElune= Action.Create({ Type = "Spell", ID = 394013 }),
	PowerofGoldrinn= Action.Create({ Type = "Spell", ID = 394046 }),
	BalanceofAllThings= Action.Create({ Type = "Spell", ID = 394048 }),
	AstralSmolder  = Action.Create({ Type = "Spell", ID = 394058 }),
	DenizenoftheDream= Action.Create({ Type = "Spell", ID = 394065 }),
	FriendoftheFae = Action.Create({ Type = "Spell", ID = 394081 }),
	SunderedFirmament= Action.Create({ Type = "Spell", ID = 394094 }),
	StellarInnervation= Action.Create({ Type = "Spell", ID = 394115 }),
	RadiantMoonlight= Action.Create({ Type = "Spell", ID = 394121 }),
	IncarnationGuardianofUrsoc= Action.Create({ Type = "Spell", ID = 394786 }),
	CelestialAlignment= Action.Create({ Type = "Spell", ID = 395022 }),
    RejuvenationGermination               = Create({ Type = "Spell", ID = 155777, }),

	GrievousWounds					= Action.Create({ Type = "Spell", ID = 240559, Hidden = true   }),
	SpiritoftheRedeemer				= Action.Create({ Type = "Spell", ID = 215982   }),
	InescapableTorment				= Action.Create({ Type = "Spell", ID = 373427, Hidden = true   }),	
	Quaking                         = Action.Create({ Type = "Spell", ID = 240447, Hidden = true  }),
	AeratedManaPotion1				= Action.Create({ Type = "Potion", ID = 191384, Texture = 176108, Hidden = true  }),
	AeratedManaPotion2				= Action.Create({ Type = "Potion", ID = 191385, Texture = 176108, Hidden = true  }),
	AeratedManaPotion3				= Action.Create({ Type = "Potion", ID = 191386, Texture = 176108, Hidden = true  }),
	ArcaneBravery					= Action.Create({ Type = "Spell", ID = 385841, Hidden = true   }),	
	SpiritofRedemption				= Action.Create({ Type = "Spell", ID = 27827, Hidden = true   }),
}

local A = setmetatable(Action[ACTION_CONST_DRUID_RESTORATION], { __index = Action })

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
    VampiricTouchDelay                      = 0,
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
	PWSDebuffs								= { 381461, --Savage Charge
												378229, --Marked for Butchery
	}
}

TMW:RegisterCallback("TMW_ACTION_HEALINGENGINE_UNIT_UPDATE", function(callbackEvent, thisUnit, db, QueueOrder)
	local unitID  = thisUnit.Unit
	local unitHP  = thisUnit.realHP
	local Role    = thisUnit.Role
    local Cleanse = A.GetToggle(2, "Cleanse")
	-- Dispel
	if A.NaturesCure:IsReady(unitID) and Cleanse then
		if thisUnit.useDispel and not QueueOrder.useDispel[Role] and AuraIsValid(unitID, "UseDispel", "Dispel") then
			QueueOrder.useDispel[Role] = true
		
			if thisUnit.isSelf then
				thisUnit:SetupOffsets(db.OffsetSelfDispel, 10)
			elseif Role == "HEALER" then
				thisUnit:SetupOffsets(db.OffsetHealersDispel, 20)
			elseif Role == "TANK" then
				thisUnit:SetupOffsets(db.OffsetTanksDispel, 15)
			else
				thisUnit:SetupOffsets(db.OffsetDamagersDispel, 15)
			end
			return
		end
	end
	--[[Rapture
	if A.PowerWordShield:IsReady(unitID) and Unit(player):HasBuffs(A.Rapture.ID) > 0 and not QueueOrder.useShields[Role] then
		if thisUnit.useShields and Unit(unitID):HasBuffs(A.PowerWordShield.ID) == 0 then 
			QueueOrder.useShields[Role] = true

			local default = thisUnit.HP + ( 100 * Unit(unitID):GetAbsorb(A.PowerWordShield.ID) / thisUnit.MHP )
			
			if Role == "HEALER" then
				thisUnit:SetupOffsets(db.OffsetHealersShields, default)
			elseif Role == "TANK" then 
				thisUnit:SetupOffsets(db.OffsetTanksShields, default)
			else 
				thisUnit:SetupOffsets(db.OffsetDamagersShields, default)
			end 					
			return 
		end 
	end]]
	if Unit(unitID):HasBuffs(A.SpiritoftheRedeemer.ID) > 0 or Unit(unitID):HasBuffs(A.SpiritofRedemption.ID) > 0 or Unit(unitID):HasBuffs(A.ArcaneBravery.ID) > 0 then
		thisUnit.Enabled = false
	else thisUnit.Enabled = true
	end

end)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end 

	local autoShift = A.GetToggle(2, "autoShift")
    if A.BearForm:IsReady(player) and autoShift and LoC:Get("ROOT") > 0 and Player:GetStance() ~= 1 then
        return A.BearForm
    end

    local BarkskinHP = A.GetToggle(2, "BarkskinHP")
	if A.Barkskin:IsReady(player) and (MultiUnits:GetByRangeCasting(60, 1, nil, Temp.scaryCasts) >= 1 or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1 or Unit(player):HealthPercent() <= BarkskinHP) then
		return A.Barkskin
	end

	local RenewalHP = A.GetToggle(2, "RenewalHP")
	if A.Renewal:IsReady(player) and Unit(player):HealthPercent() <= RenewalHP then
		return A.Renewal
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

        if A.SkullBash:IsReady(unitID) and useKick then
			return A.SkullBash
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

    if A.NaturesCure:IsReady(unitID) and useDispel and AuraIsValid(unitID, "UseDispel", "Dispel") then
        return A.NaturesCure
    end 


end

local function Purge(unitID)

    if A.Soothe:IsReady(unitID) and (AuraIsValid(unitID, "UseExpelEnrage", "Enrage")) then 
		return A.Soothe
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

local function HealCalc(heal)

	local healamount = 0
	local globalhealmod = A.GetToggle(2, "globalhealmod")
	
	if heal == A.Swiftmend then
		healamount = A.Swiftmend:GetSpellDescription()[1]
	end

	return (healamount * 1000) * globalhealmod

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
	local getmembersAll = HealingEngine.GetMembersAll()
	local petActive = Player:GetTotemTimeLeft(1) > 0
	local stopCasting = MultiUnits:GetByRangeCasting(60, 1, nil, Temp.stopCasting) >= 1
	local quakingTime = 99
	if Unit(player):HasDeBuffs(A.Quaking.ID) > 0 then
		quakingTime = Unit(player):HasDeBuffs(A.Quaking.ID)
	end

    Player:AddTier("Tier29", { 200354, 200356, 200351, 200353, 200355, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

	local usePotion = A.GetToggle(1, "Potion")
	local ManaPotion = A.GetToggle(2, "ManaPotion")
	local ManaPotionObject = A.DetermineUsableObject(player, nil, nil, true, nil, A.AeratedManaPotion1, A.AeratedManaPotion2, A.AeratedManaPotion3)
	
	if Player:ManaPercentage() < ManaPotion and usePotion and not A.IsInPvP and ManaPotionObject then
		return ManaPotionObject:Show(icon)
	end

	if Unit(player):IsCastingRemains() > quakingTime + 0.5 then
		return A:Show(icon, ACTION_CONST_STOPCAST)	
	end

	if A.IsInPvP then
		if A.MassEntanglement:IsReady(unitID) then
			local namePlateUnitID
			for namePlateUnitID in pairs(ActiveUnitPlates) do                 
				if Unit(namePlateUnitID):IsPlayer() and not Unit(namePlateUnitID):IsNPC() and not Unit(namePlateUnitID):IsTotem() and A.IsUnitEnemy(namePlateUnitID) and Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 8 and A.PsychicScream:AbsentImun(namePlateUnitID, Temp.DisableMag) then 
					return A.MassEntanglement:Show(icon)
				end 
			end
		end
	end

	local function HealingRotation(unitID)

		local useCleanse = A.GetToggle(2, "Cleanse")
		local unitHasHoT = Unit(unitID):HasBuffs(A.Rejuvenation.ID, true) > 0 or Unit(unitID):HasBuffs(A.Regrowth.ID, true) > 0 or Unit(unitID):HasBuffs(A.WildGrowth.ID, true) > 0 or Unit(unitID):HasBuffs(A.RejuvenationGermination.ID, true) > 0
		local _, currGUID = HealingEngine.GetTarget()
		local getmembersAll = HealingEngine.GetMembersAll()	
		local canCastRegrowth = A.Regrowth:IsReady(unitID) and A.Regrowth:GetSpellCastTime() < quakingTime and (not isMoving or Unit(player):HasBuffs(A.IncarnationTreeofLife.ID) > 0 or Unit(player):HasBuffs(A.NaturesSwiftness.ID) > 0) and ((Unit(unitID):HasBuffs(A.Regrowth.ID, true) == 0 and A.Nourish:IsTalentLearned()) or not A.Nourish:IsTalentLearned())

		local IronbarkHP = A.GetToggle(2, "IronbarkHP")
		if A.Ironbark:IsReady(unitID) and Unit(unitID):HealthPercent() <= IronbarkHP and inCombat and Unit(unitID):HasBuffs(A.Ironbark.ID) == 0 then
			return A.Ironbark:Show(icon)
		end

        local Cleanses = Cleanse(unitID)
        if Cleanses then 
            return Cleanses:Show(icon)
        end 

		local UseTrinket = UseTrinkets(unitID)
		if UseTrinket then
			return UseTrinket:Show(icon)
		end  

		local emergency = Unit(unitID):HealthPercent() <= A.GetToggle(2, "EmergencyHP")
		if emergency then
			if A.Overgrowth:IsReady(unitID) then
				return A.Overgrowth:Show(icon)
			end
			if A.NaturesSwiftness:IsReady(player) then
				return A.NaturesSwiftness:Show(icon)
			end
			if canCastRegrowth and Unit(unitID):HasBuffs(A.Regrowth.ID, true) == 0 and Unit(unitID):HasBuffs(A.Lifebloom.ID, true) == 0 then
				return A.Regrowth:Show(icon)
			end
		end

		if A.Invigorate:IsReady(player) and HealingEngine.GetIncomingDMGAVG() > 15 and HealingEngine.GetBuffsCount(A.Rejuvenation.ID, 5, player) >= 5 then
			return A.Invigorate:Show(icon)
		end

		local canLifebloom = A.Lifebloom:IsReady(unitID) and ((HealingEngine.GetBuffsCount(A.Lifebloom.ID, 4, player) < 1 and not A.Undergrowth:IsTalentLearned()) or (HealingEngine.GetBuffsCount(A.Lifebloom.ID, 4, player) < 2 and A.Undergrowth:IsTalentLearned()))
		if canLifebloom then
			if (Unit(unitID):IsTanking() or Unit(unitID):IsTank()) and Unit(unitID):HasBuffs(A.Lifebloom.ID, true) <= 4 and (not A.Photosynthesis:IsTalentLearned() or A.Undergrowth:IsTalentLearned()) then
				return A.Lifebloom:Show(icon)
			end
			if A.Photosynthesis:IsTalentLearned() and Unit(player):HasBuffs(A.Lifebloom.ID, true) <= 4 then
				if UnitGUID(player) ~= currGUID then
					HealingEngine.SetTarget(player, 1)
				end
				return A.Lifebloom:Show(icon)
			end
		end

		local AdaptiveSwarmHP = A.GetToggle(2, "AdaptiveSwarmHP")
		if A.AdaptiveSwarm:IsReady(unitID) and Unit(unitID):HealthPercent() <= AdaptiveSwarmHP then
			return A.Regeneratin:Show(icon)
		end

		local RejuvenationHP = A.GetToggle(2, "RejuvenationHP")
		if A.Rejuvenation:IsReady(unitID) and Unit(unitID):HasBuffs(A.Rejuvenation.ID, true) < 2 and ((Unit(unitID):HasBuffs(A.RejuvenationGermination.ID) < 2 and A.Germination:IsTalentLearned()) or not A.Germination:IsTalentLearned()) and Unit(unitID):HealthPercent() <= (RejuvenationHP - 10 * (num(Unit(player):HasBuffs(A.CatForm.ID) > 0))) then
			return A.Rejuvenation:Show(icon)
		end

		local SwiftmendNoReforestation = A.GetToggle(2, "SwiftmendNoReforestation")
		if A.Swiftmend:IsReady(unitID) and unitHasHoT and Unit(player):HasBuffsStacks(A.ReforestationBuff.ID) < 2 then
			if SwiftmendNoReforestation >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.Swiftmend) then
					return A.Swiftmend:Show(icon)
				end
			elseif SwiftmendNoReforestation <= 99 then
				if Unit(unitID):HealthPercent() <= SwiftmendNoReforestation then
					return A.Swiftmend:Show(icon)
				end
			end
		end		

		local SwiftmendReforestation = A.GetToggle(2, "SwiftmendReforestation")
		if A.Swiftmend:IsReady(unitID) and Unit(player):HasBuffsStacks(A.ReforestationBuff.ID) == 2 and Unit(unitID):HealthPercent() < SwiftmendReforestation then
			return A.Swiftmend:Show(icon)
		end

		local convokeHP = A.GetToggle(2, "convokeHP")
		local convokeUnits = A.GetToggle(2, "convokeUnits")
		if A.ConvoketheSpirits:IsReady(unitID) and Unit(player):HasBuffs(A.CatForm.ID) == 0 and Unit(player):HasBuffs(A.BearForm.ID) == 0 and not isMoving and HealingEngine.GetBelowHealthPercentUnits(convokeHP) >= convokeUnits then
			return A.ConvoketheSpirits:Show(icon)
		end

		local wildGrowthHP = A.GetToggle(2, "wildGrowthHP")
		local wildGrowthUnits = A.GetToggle(2, "wildGrowthUnits")
		if A.WildGrowth:IsReady(unitID) and not isMoving and HealingEngine.GetBelowHealthPercentUnits(wildGrowthHP) >= wildGrowthUnits then
			return A.WildGrowth:Show(icon)
		end

		local RegrowthHP = A.GetToggle(2, "RegrowthHP")
		local RegrowthHPOOC = A.GetToggle(2, "RegrowthHPOOC")
		if canCastRegrowth then
			if Unit(unitID):HealthPercent() < RegrowthHP or (Unit(unitID):HealthPercent() < RegrowthHPOOC and Unit(player):HasBuffs(A.ClearCasting.ID) > 0) then
				return A.Regrowth:Show(icon)
			end
		end

		if A.Nourish:IsReady(unitID) and (not isMoving or Unit(player):HasBuffsStacks(A.WildSynthesisBuff.ID, true, true) == 3) and Unit(unitID):HealthPercent() < RegrowthHP then
			return A.Nourish:Show(icon)
		end

		if A.CenarionWard:IsReady(unitID) then
			if (Unit(unitID):IsTanking() or Unit(unitID):IsTank()) then
				return A.CenarionWard:Show(icon)
			end
		end
		
		if inCombat and (MultiUnits:GetByRangeCasting(60, 1, nil, Temp.scaryCasts) >= 1 or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1) then
			if A.Swiftmend:IsReadyByPassCastGCD(player) and Unit(player):HasBuffsStacks(A.ReforestationBuff.ID) == 2 then
				for i = 1, #getmembersAll do
					if Unit(getmembersAll[i].Unit):GetRange() <= 40 and (Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID) >= A.GetGCD() or Unit(getmembersAll[i].Unit):HasBuffs(A.Regrowth.ID) >= A.GetGCD() or Unit(getmembersAll[i].Unit):HasBuffs(A.WildGrowth.ID) >= A.GetGCD()) then
						if UnitGUID(getmembersAll[i].Unit) ~= currGUID then
							HealingEngine.SetTarget(getmembersAll[i].Unit, 1)
						end
						return A.Swiftmend:Show(icon) 
					end
				end
			end
			if A.Rejuvenation:IsReadyByPassCastGCD(player) then
				for i = 1, #getmembersAll do 
					local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(getmembersAll[i].Unit)
					if not IsUnitEnemy(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):GetRange() <= 40 and useHoTs and Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID) <= A.GetGCD() and HealingEngine.GetIncomingDMGAVG() < 10 then
						if UnitGUID(getmembersAll[i].Unit) ~= currGUID then
							HealingEngine.SetTarget(getmembersAll[i].Unit, 1)
						end
						return A.Rejuvenation:Show(icon)  
					end                
				end 
			end
			if A.Florish:IsReady(player) and Unit(unitID):HasBuffs(A.WildGrowth.ID) then
				return A.Flourish:Show(icon)
			end
		end

		if emergency then
			if canCastRegrowth then
				return A.Regrowth:Show(icon)
			end
		end

	end

    local function EnemyRotation(unitID)

		local activeEnemies = MultiUnits:GetActiveEnemies()
		local missingBleeds = {A.Rip.ID, A.RakeDebuff.ID}
		local meleeMissingDoT = MultiUnits:GetByRangeMissedDoTs(8, 4, missingBleeds) >= 1 and A.Rip:IsTalentLearned() and A.Rake:IsTalentLearned()
		local autoShift = A.GetToggle(2, "autoShift")

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

		if Unit(unitID):IsExplosives() then
			if A.Moonfire:IsReady(unitID) then
				return A.Moonfire:Show(icon)
			end
		end
        
		if A.NaturesVigil:IsReady(player) and Unit(unitID):TimeToDie() > 20 then
			return A.NaturesVigil:Show(icon)
		end

		if A.HeartoftheWild:IsReady(player) and BurstIsON(unitID) and HealingEngine.GetBelowHealthPercentUnits(95) == 0 then
			return A.HeartoftheWild:Show(icon)
		end

		if A.AdaptiveSwarm:IsReady(unitID) then
			return A.AdaptiveSwarm:Show(icon)
		end

		if A.Sunfire:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.SunfireDebuff.ID, true) < A.SunfireDebuff:GetSpellPandemicThreshold() then
			return A.Sunfire:Show(icon)
		end

		if A.Moonfire:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.MoonfireDebuff.ID, true) < A.MoonfireDebuff:GetSpellPandemicThreshold() then
			return A.Moonfire:Show(icon)
		end

		if A.Starsurge:IsReady(unitID) and Unit(player):HasBuffs(A.CatForm.ID) == 0 then
			return A.Starsurge:Show(icon)
		end

		if meleeMissingDoT then
			if A.CatForm:IsReady(player) and autoShift and Unit(player):HasBuffs(A.CatForm.ID) == 0 then
				return A.CatForm:Show(icon)
			end
			if A.Thrash:IsReady(player) and MultiUnits:GetByRangeMissedDoTs(10, 4, A.Thrash.ID, 15) >= 3 then
				return A.Thrash:Show(icon)
			end
			if A.Rake:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true) < A.RakeDebuff:GetSpellPandemicThreshold() then
				return A.Rake:Show(icon)
			end
			if A.Rip:IsReady(unitID) and Player:ComboPoints() >= 4 and Unit(unitID):HasDeBuffs(A.Rip.ID) < 3 then
				return A.Rip:Show(icon)
			end
			if A.FerociousBite:IsReady(unitID) and Player:ComboPoints() >= 4 then
				return A.FerociousBite:Show(icon)
			end
			if A.Shred:IsReady(unitID) then
				return A.Shred:Show(icon)
			end
		end

		if A.Starfire:IsReady(unitID) and not isMoving and activeEnemies >= 2 and Unit(player):HasBuffs(A.CatForm.ID) == 0 then
			return A.Starfire:Show(icon)
		end

		if A.Wrath:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.CatForm.ID) == 0 then
			return A.Wrath:Show(icon)
		end

    end

	-- Defensive
	local SelfDefensive = SelfDefensives()
	if SelfDefensive then 
		return SelfDefensive:Show(icon)
	end 

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