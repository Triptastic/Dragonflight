--#####################################
--##### TRIP'S ENHANCEMENT SHAMAN #####
--#####################################

local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
local Covenant									= _G.LibStub("Covenant")
local TMW										= _G.TMW
local Listener                                  = Action.Listener
local Create                                    = Action.Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local CovenantIsON								= Action.CovenantIsON
local AuraIsValid                               = Action.AuraIsValid
local AuraIsValidByPhialofSerenity				= A.AuraIsValidByPhialofSerenity
local HealingEngine                             = Action.HealingEngine
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
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TeamCacheFriendly                         = TeamCache.Friendly
local pairs                                     = pairs

--For Toaster
local Toaster									= _G.Toaster
local GetSpellTexture 							= _G.TMW.GetSpellTexture


-- Spells
Action[ACTION_CONST_SHAMAN_ENHANCEMENT] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it


	EarthbindTotem = Action.Create({ Type = "Spell", ID = 2484 }),
	GhostWolf      = Action.Create({ Type = "Spell", ID = 2645 }),
	Bloodlust      = Action.Create({ Type = "Spell", ID = 2825 }),
	FarSight       = Action.Create({ Type = "Spell", ID = 6196 }),
	HealingSurge   = Action.Create({ Type = "Spell", ID = 8004 }),
	Heroism        = Action.Create({ Type = "Spell", ID = 32182 }),
	AngeredEarth   = Action.Create({ Type = "Spell", ID = 36213 }),
	FireBlast      = Action.Create({ Type = "Spell", ID = 57984 }),
	PrimalStrike   = Action.Create({ Type = "Spell", ID = 73899 }),
	PurifySpirit   = Action.Create({ Type = "Spell", ID = 77130 }),
	LavaBeam       = Action.Create({ Type = "Spell", ID = 114074 }),
	Meteor         = Action.Create({ Type = "Spell", ID = 117588 }),
	Immolate       = Action.Create({ Type = "Spell", ID = 118297 }),
	HardenSkin     = Action.Create({ Type = "Spell", ID = 118337 }),
	Pulverize      = Action.Create({ Type = "Spell", ID = 118345 }),
	WindGust       = Action.Create({ Type = "Spell", ID = 157331 }),
	CallLightning  = Action.Create({ Type = "Spell", ID = 157348 }),
	Tempest        = Action.Create({ Type = "Spell", ID = 157375 }),
	LightningBolt  = Action.Create({ Type = "Spell", ID = 188196 }),
	FlameShock     = Action.Create({ Type = "Spell", ID = 188389 }),
	LightningShield= Action.Create({ Type = "Spell", ID = 192106 }),
	AncestralVision= Action.Create({ Type = "Spell", ID = 212048 }),
	FlametongueWeapon= Action.Create({ Type = "Spell", ID = 318038 }),
	Purge          = Action.Create({ Type = "Spell", ID = 370 }),
	EarthShield    = Action.Create({ Type = "Spell", ID = 974 }),
	ChainHeal      = Action.Create({ Type = "Spell", ID = 1064 }),
	EarthShock     = Action.Create({ Type = "Spell", ID = 8042 }),
	TremorTotem    = Action.Create({ Type = "Spell", ID = 8143 }),
	WindfuryTotem  = Action.Create({ Type = "Spell", ID = 8512 }),
	WindfuryTotemBuff  = Action.Create({ Type = "Spell", ID = 327942 }),
	MasteroftheElements= Action.Create({ Type = "Spell", ID = 16166 }),
	ManaTideTotem  = Action.Create({ Type = "Spell", ID = 16191 }),
	Resurgence     = Action.Create({ Type = "Spell", ID = 16196 }),
	Stormstrike    = Action.Create({ Type = "Spell", ID = 17364 }),
	Windstrike    = Action.Create({ Type = "Spell", ID = 115356 }),
	NaturesGuardian= Action.Create({ Type = "Spell", ID = 30884 }),
	WindfuryWeapon = Action.Create({ Type = "Spell", ID = 33757 }),
	EarthgrabTotem = Action.Create({ Type = "Spell", ID = 51485 }),
	Thunderstorm   = Action.Create({ Type = "Spell", ID = 51490 }),
	LavaBurst      = Action.Create({ Type = "Spell", ID = 51505 }),
	HexdescFrog    = Action.Create({ Type = "Spell", ID = 51514 }),
	FeralSpirit    = Action.Create({ Type = "Spell", ID = 51533 }),
	FeralSpiritBuff    = Action.Create({ Type = "Spell", ID = 333957 }),
	TidalWaves     = Action.Create({ Type = "Spell", ID = 51564 }),
	CleanseSpirit  = Action.Create({ Type = "Spell", ID = 51886 }),
	WaterShield    = Action.Create({ Type = "Spell", ID = 52127 }),
	WindShear      = Action.Create({ Type = "Spell", ID = 57994 }),
	SpiritWalk     = Action.Create({ Type = "Spell", ID = 58875 }),
	LavaLash       = Action.Create({ Type = "Spell", ID = 60103 }),
	ElementalFury  = Action.Create({ Type = "Spell", ID = 60188 }),
	Riptide        = Action.Create({ Type = "Spell", ID = 61295 }),
	Earthquake     = Action.Create({ Type = "Spell", ID = 61882 }),
	UnleashLife    = Action.Create({ Type = "Spell", ID = 73685 }),
	HealingRain    = Action.Create({ Type = "Spell", ID = 73920 }),
	HealingWave    = Action.Create({ Type = "Spell", ID = 77472 }),
	LavaSurge      = Action.Create({ Type = "Spell", ID = 77756 }),
	SpiritwalkersGrace= Action.Create({ Type = "Spell", ID = 79206 }),
	SpiritLinkTotem= Action.Create({ Type = "Spell", ID = 98008 }),
	AstralShift    = Action.Create({ Type = "Spell", ID = 108271 }),
	HealingTideTotem= Action.Create({ Type = "Spell", ID = 108280 }),
	AncestralGuidance= Action.Create({ Type = "Spell", ID = 108281 }),
	TotemicRecall  = Action.Create({ Type = "Spell", ID = 108285 }),
	TotemicProjection= Action.Create({ Type = "Spell", ID = 108287 }),
	Ascendance     = Action.Create({ Type = "Spell", ID = 114050 }),
	PrimalElementalist= Action.Create({ Type = "Spell", ID = 117013 }),
	ElementalBlast = Action.Create({ Type = "Spell", ID = 117014 }),
	CloudburstTotem= Action.Create({ Type = "Spell", ID = 157153 }),
	HighTide       = Action.Create({ Type = "Spell", ID = 157154 }),
	CrashLightning = Action.Create({ Type = "Spell", ID = 187874 }),
	CrashLightningBuff = Action.Create({ Type = "Spell", ID = 187878 }),
	CLCrashLightningBuff = Action.Create({ Type = "Spell", ID = 333964 }),
	MaelstromWeapon= Action.Create({ Type = "Spell", ID = 187880 }),
	ChainLightning = Action.Create({ Type = "Spell", ID = 188443 }),
	PoweroftheMaelstrom= Action.Create({ Type = "Spell", ID = 191861 }),
	CapacitorTotem = Action.Create({ Type = "Spell", ID = 192058 }),
	GustofWind     = Action.Create({ Type = "Spell", ID = 192063 }),
	WindRushTotem  = Action.Create({ Type = "Spell", ID = 192077 }),
	GracefulSpirit = Action.Create({ Type = "Spell", ID = 192088 }),
	LiquidMagmaTotem= Action.Create({ Type = "Spell", ID = 192222 }),
	StormElemental = Action.Create({ Type = "Spell", ID = 192249 }),
	FrostShock     = Action.Create({ Type = "Spell", ID = 196840 }),
	FeralLunge     = Action.Create({ Type = "Spell", ID = 196884 }),
	Sundering      = Action.Create({ Type = "Spell", ID = 197214 }),
	Wellspring     = Action.Create({ Type = "Spell", ID = 197995 }),
	FireElemental  = Action.Create({ Type = "Spell", ID = 198067 }),
	EarthElemental = Action.Create({ Type = "Spell", ID = 198103 }),
	AlphaWolf      = Action.Create({ Type = "Spell", ID = 198434 }),
	EarthenWallTotem= Action.Create({ Type = "Spell", ID = 198838 }),
	Undulation     = Action.Create({ Type = "Spell", ID = 200071 }),
	Torrent        = Action.Create({ Type = "Spell", ID = 200072 }),
	Deluge         = Action.Create({ Type = "Spell", ID = 200076 }),
	HotHand        = Action.Create({ Type = "Spell", ID = 201900 }),
	HotHandBuff       = Action.Create({ Type = "Spell", ID = 215785 }),
	VoodooMastery  = Action.Create({ Type = "Spell", ID = 204268 }),
	AncestralProtectionTotem= Action.Create({ Type = "Spell", ID = 207399 }),
	AncestralVigor = Action.Create({ Type = "Spell", ID = 207401 }),
	Downpour       = Action.Create({ Type = "Spell", ID = 207778 }),
	LightningRod   = Action.Create({ Type = "Spell", ID = 210689 }),
	Icefury        = Action.Create({ Type = "Spell", ID = 210714 }),
	ElementalAssault= Action.Create({ Type = "Spell", ID = 210853 }),
	SpiritWolf     = Action.Create({ Type = "Spell", ID = 260878 }),
	SurgeofPower   = Action.Create({ Type = "Spell", ID = 262303 }),
	ElementalSpirits= Action.Create({ Type = "Spell", ID = 262624 }),
	ForcefulWinds  = Action.Create({ Type = "Spell", ID = 262647 }),
	StaticCharge   = Action.Create({ Type = "Spell", ID = 265046 }),
	Aftershock     = Action.Create({ Type = "Spell", ID = 273221 }),
	FlashFlood     = Action.Create({ Type = "Spell", ID = 280614 }),
	LightningLasso = Action.Create({ Type = "Spell", ID = 305483 }),
	Stormblast     = Action.Create({ Type = "Spell", ID = 319930 }),
	EchooftheElements= Action.Create({ Type = "Spell", ID = 333919 }),
	FireNova       = Action.Create({ Type = "Spell", ID = 333974 }),
	MoltenAssault  = Action.Create({ Type = "Spell", ID = 334033 }),
	LashingFlames  = Action.Create({ Type = "Spell", ID = 334046 }),
	Hailstorm      = Action.Create({ Type = "Spell", ID = 334195 }),
	HailstormBuff      = Action.Create({ Type = "Spell", ID = 334196 }),
	CrashingStorms = Action.Create({ Type = "Spell", ID = 334308 }),
	IceStrike      = Action.Create({ Type = "Spell", ID = 342240 }),
	Stormflurry    = Action.Create({ Type = "Spell", ID = 344357 }),
	PrimordialWave= Action.Create({ Type = "Spell", ID = 375982 }),
	PrimordialWaveBuff= Action.Create({ Type = "Spell", ID = 375986 }),
	AstralBulwark  = Action.Create({ Type = "Spell", ID = 377933 }),
	ThunderousPaws = Action.Create({ Type = "Spell", ID = 378075 }),
	SpiritwalkersAegis= Action.Create({ Type = "Spell", ID = 378077 }),
	Enfeeblement   = Action.Create({ Type = "Spell", ID = 378079 }),
	NaturesSwiftness= Action.Create({ Type = "Spell", ID = 378081 }),
	SwirlingCurrents= Action.Create({ Type = "Spell", ID = 378094 }),
	PrimordialFury = Action.Create({ Type = "Spell", ID = 378193 }),
	RefreshingWaters= Action.Create({ Type = "Spell", ID = 378211 }),
	CallofThunder  = Action.Create({ Type = "Spell", ID = 378241 }),
	CallofFire     = Action.Create({ Type = "Spell", ID = 378255 }),
	FlamesoftheCauldron= Action.Create({ Type = "Spell", ID = 378266 }),
	WindspeakersLavaResurgence= Action.Create({ Type = "Spell", ID = 378268 }),
	DeeplyRootedElements= Action.Create({ Type = "Spell", ID = 378270 }),
	ElementalEquilibrium= Action.Create({ Type = "Spell", ID = 378271 }),
	SkybreakersFieryDemise= Action.Create({ Type = "Spell", ID = 378310 }),
	AcidRain       = Action.Create({ Type = "Spell", ID = 378443 }),
	GreaterPurge   = Action.Create({ Type = "Spell", ID = 378773 }),
	Inundate       = Action.Create({ Type = "Spell", ID = 378776 }),
	Thundershock   = Action.Create({ Type = "Spell", ID = 378779 }),
	PlanesTraveler = Action.Create({ Type = "Spell", ID = 381647 }),
	ElementalWarding= Action.Create({ Type = "Spell", ID = 381650 }),
	NaturesFury    = Action.Create({ Type = "Spell", ID = 381655 }),
	FocusedInsight = Action.Create({ Type = "Spell", ID = 381666 }),
	ImprovedLightningBolt= Action.Create({ Type = "Spell", ID = 381674 }),
	GowiththeFlow  = Action.Create({ Type = "Spell", ID = 381678 }),
	BrimmingwithLife= Action.Create({ Type = "Spell", ID = 381689 }),
	SwellingMaelstrom= Action.Create({ Type = "Spell", ID = 381707 }),
	EyeoftheStorm  = Action.Create({ Type = "Spell", ID = 381708 }),
	MountainsWillFall= Action.Create({ Type = "Spell", ID = 381726 }),
	TumultuousFissures= Action.Create({ Type = "Spell", ID = 381743 }),
	PrimordialBond = Action.Create({ Type = "Spell", ID = 381764 }),
	FluxMelting    = Action.Create({ Type = "Spell", ID = 381776 }),
	SearingFlames  = Action.Create({ Type = "Spell", ID = 381782 }),
	OathoftheFarSeer= Action.Create({ Type = "Spell", ID = 381785 }),
	FurtherBeyond  = Action.Create({ Type = "Spell", ID = 381787 }),
	GuardiansCudgel= Action.Create({ Type = "Spell", ID = 381819 }),
	TotemicSurge   = Action.Create({ Type = "Spell", ID = 381867 }),
	ManaSpringTotem= Action.Create({ Type = "Spell", ID = 381930 }),
	MagmaChamber   = Action.Create({ Type = "Spell", ID = 381932 }),
	FlashofLightning= Action.Create({ Type = "Spell", ID = 381936 }),
	WavespeakersBlessing= Action.Create({ Type = "Spell", ID = 381946 }),
	NaturesFocus   = Action.Create({ Type = "Spell", ID = 382019 }),
	EarthenHarmony = Action.Create({ Type = "Spell", ID = 382020 }),
	EarthlivingWeapon= Action.Create({ Type = "Spell", ID = 382021 }),
	ImprovedFlametongueWeapon= Action.Create({ Type = "Spell", ID = 382027 }),
	EverRisingTide = Action.Create({ Type = "Spell", ID = 382029 }),
	WaterTotemMastery= Action.Create({ Type = "Spell", ID = 382030 }),
	EchoChamber    = Action.Create({ Type = "Spell", ID = 382032 }),
	SurgingShields = Action.Create({ Type = "Spell", ID = 382033 }),
	FlowoftheTides = Action.Create({ Type = "Spell", ID = 382039 }),
	TumblingWaves  = Action.Create({ Type = "Spell", ID = 382040 }),
	SplinteredElements= Action.Create({ Type = "Spell", ID = 382042 }),
	SplinteredElementsBuff= Action.Create({ Type = "Spell", ID = 382043 }),
	PrimalTideCore = Action.Create({ Type = "Spell", ID = 382045 }),
	ContinuousWaves= Action.Create({ Type = "Spell", ID = 382046 }),
	ElectrifiedShocks= Action.Create({ Type = "Spell", ID = 382086 }),
	ImprovedPrimordialWave= Action.Create({ Type = "Spell", ID = 382191 }),
	Undercurrent   = Action.Create({ Type = "Spell", ID = 382194 }),
	AncestralWolfAffinity= Action.Create({ Type = "Spell", ID = 382197 }),
	TotemicFocus   = Action.Create({ Type = "Spell", ID = 382201 }),
	WindsofAlAkir  = Action.Create({ Type = "Spell", ID = 382215 }),
	AncestralAwakening= Action.Create({ Type = "Spell", ID = 382309 }),
	ImprovedEarthlivingWeapon= Action.Create({ Type = "Spell", ID = 382315 }),
	LivingStream   = Action.Create({ Type = "Spell", ID = 382482 }),
	UnrelentingCalamity= Action.Create({ Type = "Spell", ID = 382685 }),
	AncestralReach = Action.Create({ Type = "Spell", ID = 382732 }),
	FireandIce     = Action.Create({ Type = "Spell", ID = 382886 }),
	Flurry         = Action.Create({ Type = "Spell", ID = 382888 }),
	AncestralDefense= Action.Create({ Type = "Spell", ID = 382947 }),
	Stormkeeper    = Action.Create({ Type = "Spell", ID = 383009 }),
	ElementalOrbit = Action.Create({ Type = "Spell", ID = 383010 }),
	CalloftheElements= Action.Create({ Type = "Spell", ID = 383011 }),
	CreationCore   = Action.Create({ Type = "Spell", ID = 383012 }),
	PoisonCleansingTotem= Action.Create({ Type = "Spell", ID = 383013 }),
	ImprovedPurifySpirit= Action.Create({ Type = "Spell", ID = 383016 }),
	StoneskinTotem = Action.Create({ Type = "Spell", ID = 383017 }),
	TranquilAirTotem= Action.Create({ Type = "Spell", ID = 383019 }),
	OverflowingShores= Action.Create({ Type = "Spell", ID = 383222 }),
	ImprovedMaelstromWeapon= Action.Create({ Type = "Spell", ID = 383303 }),
	EchoesofGreatSundering= Action.Create({ Type = "Spell", ID = 384087 }),
	RagingMaelstrom= Action.Create({ Type = "Spell", ID = 384143 }),
	OverflowingMaelstrom= Action.Create({ Type = "Spell", ID = 384149 }),
	DoomWinds      = Action.Create({ Type = "Spell", ID = 384352 }),
	ElementalWeapons= Action.Create({ Type = "Spell", ID = 384355 }),
	SwirlingMaelstrom= Action.Create({ Type = "Spell", ID = 384359 }),
	ConvergingStorms= Action.Create({ Type = "Spell", ID = 384363 }),
	ConvergingStormsBuff= Action.Create({ Type = "Spell", ID = 198300 }),
	PrimalMaelstrom= Action.Create({ Type = "Spell", ID = 384405 }),
	StaticAccumulation= Action.Create({ Type = "Spell", ID = 384411 }),
	ThorimsInvocation= Action.Create({ Type = "Spell", ID = 384444 }),
	WitchDoctorsAncestry= Action.Create({ Type = "Spell", ID = 384447 }),
	LegacyoftheFrostWitch= Action.Create({ Type = "Spell", ID = 384450 }),
	LegacyoftheFrostWitchBuff= Action.Create({ Type = "Spell", ID = 384451 }),
	FlowofPower    = Action.Create({ Type = "Spell", ID = 385923 }),
	RollingMagma   = Action.Create({ Type = "Spell", ID = 386443 }),
	PrimordialSurge= Action.Create({ Type = "Spell", ID = 386474 }),
	UnrulyWinds    = Action.Create({ Type = "Spell", ID = 390288 }),
	AshenCatalyst  = Action.Create({ Type = "Spell", ID = 390370 }),
	AshenCatalystBuff  = Action.Create({ Type = "Spell", ID = 390371 }),
	StormsWrath    = Action.Create({ Type = "Spell", ID = 392352 }),
	HealingStreamTotem= Action.Create({ Type = "Spell", ID = 392915 }),
	MaelstromWeaponBuff= Action.Create({ Type = "Spell", ID = 344179 }),	
	MaelstromofElements= Action.Create({ Type = "Spell", ID = 394677 }),
	EarthenWeapon= Action.Create({ Type = "Spell", ID = 392375 }),
	
    -- Misc
    Channeling                      = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                     = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                        = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
    PoolResource                    = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),

	GrievousWounds					= Action.Create({ Type = "Spell", ID = 240559, Hidden = true   }),
	SpiritoftheRedeemer				= Action.Create({ Type = "Spell", ID = 215982   }),
	InescapableTorment				= Action.Create({ Type = "Spell", ID = 373427, Hidden = true   }),	
	Quaking                         = Action.Create({ Type = "Spell", ID = 240447, Hidden = true  }),
	AeratedManaPotion1				= Action.Create({ Type = "Potion", ID = 191384, Texture = 176108, Hidden = true  }),
	AeratedManaPotion2				= Action.Create({ Type = "Potion", ID = 191385, Texture = 176108, Hidden = true  }),
	AeratedManaPotion3				= Action.Create({ Type = "Potion", ID = 191386, Texture = 176108, Hidden = true  }),
	ArcaneBravery					= Action.Create({ Type = "Spell", ID = 385841, Hidden = true   }),	
	SpiritofRedemption				= Action.Create({ Type = "Spell", ID = 27827, Hidden = true   }),	
	
};

local A = setmetatable(Action[ACTION_CONST_SHAMAN_ENHANCEMENT], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

local player = "player"
local target = "target"
local targettarget = "targettarget"
local mouseover = "mouseover"
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
    chainLightningTI                  		= false,
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
	StoneskinTotem							= { 209676, -- Slicing Maelstrom

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


local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end 

    local astralShiftHP = A.GetToggle(2, "astralShiftHP")
    if A.AstralShift:IsReady(player, nil, nil, true) and (Unit(player):HealthPercent() <= astralShiftHP or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1) then
        return A.AstralShift
    end

	if A.StoneskinTotem:IsReady(player, nil, nil, true) and MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1 then
		return A.StoneskinTotem
	end

	local healingSurgeHP = A.GetToggle(2, "healingSurgeHP")
    if A.HealingSurge:IsReady(player, nil, nil, true) and Unit(player):HealthPercent() <= healingSurgeHP and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 5 then
        return A.HealingSurge
    end

	if A.SpiritWalk:IsReady(player) and (LoC:Get("ROOT") > 0 or Unit(player):HasDeBuffs(207278) > 0) then --Arcane Lockdown
        return A.SpiritWalk
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then

        if A.WindShear:IsReady(unitID, nil, nil, true) and useKick and not notInterruptable then
			return A.WindShear
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

local function Cleanse(unitID)
    
    local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
    local unitGUID = UnitGUID(unitID)  

    if A.PurifySpirit:IsReady(unitID) and useDispel and AuraIsValid(unitID, "UseDispel", "Dispel") then
        return A.PurifySpirit
    end 


end

local function Purge(unitID)

    if A.Purge:IsReady(unitID) and (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) then 
		return A.Purge
	end 
    if A.GreaterPurge:IsReady(unitID) and (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) then 
		return A.GreaterPurge
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
	local quakingTime = 99
	if Unit(player):HasDeBuffs(A.Quaking.ID) > 0 then
		quakingTime = Unit(player):HasDeBuffs(A.Quaking.ID)
	end

    Player:AddTier("Tier29", { 200399, 200401, 200396, 200398, 200400, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

	local usePotion = A.GetToggle(1, "Potion")
	local useRacial = A.GetToggle(1, "Racial")
	local activeEnemies = MultiUnits:GetByRange(10, 5)


	if Unit(player):IsCastingRemains() > quakingTime + 0.5 then
		return A:Show(icon, ACTION_CONST_STOPCAST)	
	end

	if A.ThorimsInvocation:IsTalentLearned() then
		if Player:PrevGCD(1, A.LightningBolt) or not inCombat then
			Temp.chainLightningTI = false
		elseif Player:PrevGCD(1, A.ChainLightning) then
			Temp.chainLightningTI = true
		end
	end
	local TILightningBolt = not Temp.chainLightningTI
	local TIChainLightning = Temp.chainLightningTI

	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
	if not hasMainHandEnchant or (not inCombat and mainHandExpiration < 300000) then
		if A.WindfuryWeapon:IsReady(player) then
			return A.WindfuryWeapon:Show(icon)
		end
	end

	if not hasOffHandEnchant or (not inCombat and offHandExpiration < 300000) then
		if A.FlametongueWeapon:IsReady(player) then
			return A.FlametongueWeapon:Show(icon)
		end
	end

	if A.EarthShield:IsReady(player) and (Unit(player):HasBuffs(A.EarthShield.ID) == 0 or (not inCombat and Unit(player):HasBuffsStacks(A.EarthShield.ID) < 9)) then
		return A.EarthShield:Show(icon)
	elseif A.LightningShield:IsReady(player) and Unit(player):HasBuffs(A.LightningShield.ID) == 0 and (Unit(player):HasBuffs(A.EarthShield.ID) == 0 or A.ElementalOrbit:IsTalentLearned()) then
		return A.LightningShield:Show(icon)
	end

	local AoEKick = {396812, 388392, 388863, 377389, 396640, 387843, 209413, 207980, 208165, 214692, 210261, 211401, 198595, 215433, 192288, 199726, 198750, 372749, 372735, 373803, 373017, 392451, 385310, 152818, 152814, 156776, 156722, 156718, 153524, 397888, 397889, 395859, 396073, 397914, 375602, 387564, 370225, 386546}
	if A.Thunderstorm:IsReady(player, nil, nil, true) and MultiUnits:GetByRangeCasting(10, nil, nil, AoEKick) > 0 then
		return A.Thunderstorm:Show(icon)
	end

    local function EnemyRotation(unitID)

		if A.WindfuryTotem:IsReady(player) then
			local wftActive = false
			for i = 1, MAX_TOTEMS do
				local _, name, startTime = GetTotemInfo(i)
				if name == "Windfury Totem" and startTime > 0 then
					wftActive = true
					break
				end
			end
			if not wftActive and A.TotemicProjection:IsTalentLearned() then
				return A.WindfuryTotem:Show(icon)
			end
			if not A.TotemicProjection:IsTalentLearned() and Unit(player):HasBuffs(A.WindfuryTotemBuff.ID) == 0 and A.Stormstrike:IsInRange(unitID) then
				return A.WindfuryTotem:Show(icon)
			end
		end

		local useBurst = inCombat and BurstIsON(unitID) and (Unit(unitID):TimeToDie() > 20 or Unit(unitID):IsBoss()) and A.Stormstrike:IsInRange(unitID)
        -- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end

		if A.AncestralGuidance:IsReady(player) and (MultiUnits:GetByRangeCasting(60, 1, nil, Temp.scaryCasts) >= 1 or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1) then
			return A.AncestralGuidance:Show(icon)
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
            if A.FrostShock:IsReady(unitID) then
                return A.FrostShock:Show(icon)
            end
		end

		-- # Executed every time the actor is available.
		-- actions=bloodlust,line_cd=600
		-- actions+=/potion,if=(talent.ascendance.enabled&raid_event.adds.in>=90&cooldown.ascendance.remains<10)|(talent.doom_winds.enabled&buff.doom_winds.up)|(!talent.doom_winds.enabled&!talent.ascendance.enabled&talent.feral_spirit.enabled&buff.feral_spirit.up)|(!talent.doom_winds.enabled&!talent.ascendance.enabled&!talent.feral_spirit.enabled)|active_enemies>1|fight_remains<30
		-- actions+=/auto_attack
		-- actions+=/use_item,name=the_first_sigil,if=(talent.ascendance.enabled&raid_event.adds.in>=90&cooldown.ascendance.remains<10)|(talent.hot_hand.enabled&buff.molten_weapon.up)|buff.icy_edge.up|(talent.stormflurry.enabled&buff.crackling_surge.up)|active_enemies>1|fight_remains<30
		-- actions+=/use_item,name=cache_of_acquired_treasures,if=buff.acquired_sword.up|fight_remains<25
		-- actions+=/use_item,name=scars_of_fraternal_strife,if=!buff.scars_of_fraternal_strife_4.up|fight_remains<31|raid_event.adds.in<16|active_enemies>1
		-- actions+=/use_items,slots=trinket1,if=!variable.trinket1_is_weird
		-- actions+=/use_items,slots=trinket2,if=!variable.trinket2_is_weird

		if useBurst then
			if useRacial then
				-- actions+=/blood_fury,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
				if A.BloodFury:IsReady(player) and (not A.Ascendance:IsTalentLearned() or Unit(player):HasBuffs(A.Ascendance.ID) > 0 or A.Ascendance:GetCooldown() > 50) then
					return A.BloodFury:Show(icon)
				end
				-- actions+=/berserking,if=!talent.ascendance.enabled|buff.ascendance.up
				if A.Berserking:IsReady(player) and (not A.Ascendance:IsTalentLearned() or Unit(player):HasBuffs(A.Ascendance.ID) > 0) then
					return A.Berserking:Show(icon)
				end
				-- actions+=/fireblood,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
				if A.Fireblood:IsReady(player) and (not A.Ascendance:IsTalentLearned() or Unit(player):HasBuffs(A.Ascendance.ID) > 0 or A.Ascendance:GetCooldown() > 50) then
					return A.Fireblood:Show(icon)
				end
				-- actions+=/ancestral_call,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
				if A.AncestralCall:IsReady(player) and (not A.Ascendance:IsTalentLearned() or Unit(player):HasBuffs(A.Ascendance.ID) > 0 or A.Ascendance:GetCooldown() > 50) then
					return A.AncestralCall:Show(icon)
				end
			end
			-- actions+=/ascendance,if=(ti_lightning_bolt&active_enemies=1&raid_event.adds.in>=90)|(ti_chain_lightning&active_enemies>1)
			if A.Ascendance:IsReady(player) then
				if (TILightningBolt and activeEnemies == 1) or (TIChainLightning and activeEnemies > 1) then
					return A.Ascendance:Show(icon)
				end
			end
			-- actions+=/doom_winds,if=raid_event.adds.in>=90|active_enemies>1
			if A.DoomWinds:IsReady(unitID) then
				return A.DoomWinds:Show(icon)
			end
		end
		-- actions+=/feral_spirit
		if A.FeralSpirit:IsReady(unitID) and Unit(unitID):GetRange() <= 15 then
			return A.FeralSpirit:Show(icon)
		end
		-- # If_only_one_enemy,_priority_follows_the_'single'_action_list.
		-- actions+=/call_action_list,name=single,if=active_enemies=1
		-- # On_multiple_enemies,_the_priority_follows_the_'aoe'_action_list.
		-- actions+=/call_action_list,name=aoe,if=active_enemies>1
		if activeEnemies > 1 then
			-- actions.aoe=crash_lightning,if=buff.doom_winds.up|!buff.crash_lightning.up
			if A.CrashLightning:IsReady(player) and (Unit(player):HasBuffs(A.DoomWinds.ID) > 0 or Unit(player):HasBuffs(A.CrashLightningBuff.ID) > 0) then
				return A.CrashLightning:Show(icon)
			end
			-- actions.aoe+=/lightning_bolt,if=(active_dot.flame_shock=active_enemies|active_dot.flame_shock=6)&buff.primordial_wave.up&buff.maelstrom_weapon.stack>=(5+5*talent.overflowing_maelstrom.enabled)&(!buff.splintered_elements.up|fight_remains<=12|raid_event.adds.remains<=gcd)
			if A.LightningBolt:IsReady(unitID) then
				if (Player:GetDeBuffsUnitCount(A.FlameShock.ID) >= (activeEnemies) or Player:GetDeBuffsUnitCount(A.FlameShock.ID) >= 6) and Unit(player):HasBuffs(A.PrimordialWaveBuff.ID) > 0 and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= (5+(5*num(A.OverflowingMaelstrom:IsTalentLearned()))) and Unit(player):HasBuffs(A.SplinteredElementsBuff.ID) == 0 then
					return A.LightningBolt:Show(icon)
				end
			end
			-- actions.aoe+=/sundering,if=buff.doom_winds.up
			if A.Sundering:IsReady(player) and Unit(player):HasBuffs(A.DoomWinds.ID) > 0 then
				return A.Sundering:Show(icon)
			end
			-- actions.aoe+=/fire_nova,if=active_dot.flame_shock=6|(active_dot.flame_shock>=4&active_dot.flame_shock=active_enemies)
			if A.FireNova:IsReady(player) and (Player:GetDeBuffsUnitCount(A.FlameShock.ID) >= 6 or (Player:GetDeBuffsUnitCount(A.FlameShock.ID) >= 4 and Player:GetDeBuffsUnitCount(A.FlameShock.ID) >= activeEnemies)) then
				return A.FireNova:Show(icon)
			end
			-- actions.aoe+=/primordial_wave,target_if=min:dot.flame_shock.remains,cycle_targets=1,if=!buff.primordial_wave.up
			if A.PrimordialWave:IsReady(unitID) and Unit(player):HasBuffs(A.PrimordialWaveBuff.ID) == 0 then
				return A.PrimordialWave:Show(icon)
			end
			-- actions.aoe+=/windstrike,if=talent.thorims_invocation.enabled&ti_chain_lightning&buff.maelstrom_weapon.stack>1
			if A.Windstrike:IsReady(unitID) and Unit(player):HasBuffs(A.Ascendance.ID) > 0 and A.ThorimsInvocation:IsTalentLearned() and TIChainLightning and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) > 1 then
				return A.Windstrike:Show(icon)
			end
			-- actions.aoe+=/lava_lash,target_if=min:debuff.lashing_flames.remains,cycle_targets=1,if=talent.lashing_flames.enabled&dot.flame_shock.ticking&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
			if A.LavaLash:IsReady(unitID) and A.LashingFlames:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) > 0 and (Player:GetDeBuffsUnitCount(A.FlameShock.ID) < activeEnemies) and Player:GetDeBuffsUnitCount(A.FlameShock.ID) < 6 then
				return A.LavaLash:Show(icon)
			end
			-- actions.aoe+=/lava_lash,if=talent.molten_assault.enabled&dot.flame_shock.ticking&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
			if A.LavaLash:IsReady(unitID) and A.MoltenAssault:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) > 0 and Player:GetDeBuffsUnitCount(A.FlameShock.ID) < activeEnemies and Player:GetDeBuffsUnitCount(A.FlameShock.ID) < 6 then
				return A.LavaLash:Show(icon)
			end
			--[[ actions.aoe+=/flame_shock,if=!ticking
			if A.FlameShock:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) == 0 then
				return A.FlameShock:Show(icon)
			end]]
			-- actions.aoe+=/flame_shock,target_if=min:dot.flame_shock.remains,cycle_targets=1,if=talent.fire_nova.enabled&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
			if A.FlameShock:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) == 0 and A.FireNova:IsTalentLearned() and Player:GetDeBuffsUnitCount(A.FlameShock.ID) < activeEnemies and Player:GetDeBuffsUnitCount(A.FlameShock.ID) < 6 then
				return A.FlameShock:Show(icon)
			end
			-- actions.aoe+=/ice_strike,if=talent.hailstorm.enabled
			if A.IceStrike:IsReady(unitID) and A.Hailstorm:IsTalentLearned() then
				return A.IceStrike:Show(icon)
			end
			-- actions.aoe+=/frost_shock,if=talent.hailstorm.enabled&buff.hailstorm.up
			if A.FrostShock:IsReady(unitID) and A.Hailstorm:IsTalentLearned() and Unit(player):HasBuffs(A.HailstormBuff.ID) > 0 then
				return A.FrostShock:Show(icon)
			end
			-- actions.aoe+=/sundering
			if A.Sundering:IsReady(player) then
				return A.Sundering:Show(icon)
			end
			--[[ actions.aoe+=/fire_nova,if=active_dot.flame_shock>=4
			if A.FireNova:IsReady(player) and Player:GetDeBuffsUnitCount(A.FlameShock.ID) >= 4 then
				return A.FireNova:Show(icon)
			end]]
			-- actions.aoe+=/lava_lash,target_if=min:debuff.lashing_flames.remains,cycle_targets=1,if=talent.lashing_flames.enabled
			-- actions.aoe+=/fire_nova,if=active_dot.flame_shock>=3
			if A.FireNova:IsReady(player) and Player:GetDeBuffsUnitCount(A.FlameShock.ID) >= 3 then
				return A.FireNova:Show(icon)
			end
			-- actions.aoe+=/elemental_blast,if=(!talent.elemental_spirits.enabled|(talent.elemental_spirits.enabled&(charges=max_charges|buff.feral_spirit.up)))&buff.maelstrom_weapon.stack=10&(!talent.crashing_storms.enabled|active_enemies<=3)
			if A.ElementalBlast:IsReady(unitID) then
				if (not A.ElementalSpirits:IsTalentLearned() or (A.ElementalSpirits:IsTalentLearned() and (A.ElementalBlast:GetSpellCharges() == A.ElementalBlast:GetSpellChargesMax() or Unit(player):HasBuffs(A.FeralSpiritBuff.ID) > 0))) and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) == 10 and (not A.CrashingStorms:IsTalentLearned() or activeEnemies <= 3) then
					return A.ElementalBlast:Show(icon)
				end
			end
			-- actions.aoe+=/chain_lightning,if=buff.maelstrom_weapon.stack=10
			if A.ChainLightning:IsReady(unitID) and Unit(player):HasBuffsStacks(A.MaelstromWeapon.ID) == 10 then
				return A.ChainLightning:Show(icon)
			end
			-- actions.aoe+=/crash_lightning,if=buff.cl_crash_lightning.up
			if A.CrashLightning:IsReady(player) and Unit(player):HasBuffs(A.CLCrashLightningBuff.ID) > 0 then
				return A.CrashLightning:Show(icon)
			end
			-- actions.aoe+=/lava_lash,if=buff.crash_lightning.up&buff.ashen_catalyst.stack=8
			if A.LavaLash:IsReady(unitID) and Unit(player):HasBuffs(A.CrashLightningBuff.ID) > 0 and Unit(player):HasBuffsStacks(A.AshenCatalystBuff.ID) >= 8 then
				return A.LavaLash:Show(icon)
			end
			-- actions.aoe+=/windstrike,if=buff.crash_lightning.up
			if A.Windstrike:IsReady(unitID) and Unit(player):HasBuffs(A.Ascendance.ID) > 0 and Unit(player):HasBuffs(A.CrashLightningBuff.ID) > 0 then
				return A.Windstrike:Show(icon)
			end
			-- actions.aoe+=/stormstrike,if=buff.crash_lightning.up&(buff.converging_storms.stack=6|(set_bonus.tier29_2pc&buff.maelstrom_of_elements.down&buff.maelstrom_weapon.stack<=5))
			if A.Stormstrike:IsReady(unitID) then
				if Unit(player):HasBuffs(A.CrashLightningBuff.ID) > 0 and (Unit(player):HasBuffsStacks(A.ConvergingStormsBuff.ID) >= 6 or (T29has2P and Unit(player):HasBuffs(A.MaelstromofElements.ID) == 0 and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) <= 5)) then
					return A.Stormstrike:Show(icon)
				end
			end
			if Unit(player):HasBuffs(A.CrashLightningBuff.ID) then
				-- actions.aoe+=/lava_lash,if=buff.crash_lightning.up,if=talent.molten_assault.enabled
				if A.LavaLash:IsReady(unitID) and A.MoltenAssault:IsTalentLearned() then
					return A.LavaLash:Show(icon)
				end
				-- actions.aoe+=/ice_strike,if=buff.crash_lightning.up,if=talent.swirling_maelstrom.enabled
				if A.IceStrike:IsReady(unitID) and A.SwirlingMaelstrom:IsTalentLearned() then
					return A.IceStrike:Show(icon)
				end
				-- actions.aoe+=/stormstrike,if=buff.crash_lightning.up
				if A.Stormstrike:IsReady(unitID) then
					return A.Stormstrike:Show(icon)
				end
				-- actions.aoe+=/ice_strike,if=buff.crash_lightning.up
				if A.IceStrike:IsReady(unitID) then
					return A.IceStrike:Show(icon)
				end
				-- actions.aoe+=/lava_lash,if=buff.crash_lightning.up
				if A.LavaLash:IsReady(unitID) then
					return A.LavaLash:Show(icon)
				end
			end
			-- actions.aoe+=/elemental_blast,if=(!talent.elemental_spirits.enabled|(talent.elemental_spirits.enabled&(charges=max_charges|buff.feral_spirit.up)))&buff.maelstrom_weapon.stack>=5&(!talent.crashing_storms.enabled|active_enemies<=3)
			if A.ElementalBlast:IsReady(unitID) then
				if (not A.ElementalSpirits:IsTalentLearned() or (A.ElementalSpirits:IsTalentLearned() and (A.ElementalBlast:GetSpellCharges() == A.ElementalBlast:GetSpellChargesMax() or Unit(player):HasBuffs(A.FeralSpiritBuff.ID) > 0))) and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 5 and (not A.CrashingStorms:IsTalentLearned() or activeEnemies <= 3) then
					return A.ElementalBlast:Show(icon)
				end
			end
			-- actions.aoe+=/fire_nova,if=active_dot.flame_shock>=2
			if A.FireNova:IsReady(player) and Player:GetDeBuffsUnitCount(A.FlameShock.ID) >= 2 then
				return A.FireNova:Show(icon)
			end
			-- actions.aoe+=/crash_lightning
			if A.CrashLightning:IsReady(player) then
				return A.CrashLightning:Show(icon)
			end
			-- actions.aoe+=/windstrike
			if A.Windstrike:IsReady(unitID) and Unit(player):HasBuffs(A.Ascendance.ID) > 0 then
				return A.Windstrike:Show(icon)
			end
			-- actions.aoe+=/lava_lash,if=talent.molten_assault.enabled
			if A.LavaLash:IsReady(unitID) and A.MoltenAssault:IsTalentLearned() then
				return A.LavaLash:Show(icon)
			end
			-- actions.aoe+=/ice_strike,if=talent.swirling_maelstrom.enabled
			if A.IceStrike:IsReady(unitID) and A.SwirlingMaelstrom:IsTalentLearned() then
				return A.IceStrike:Show(icon)
			end
			-- actions.aoe+=/stormstrike
			if A.Stormstrike:IsReady(unitID) then
				return A.Stormstrike:Show(icon)
			end
			-- actions.aoe+=/ice_strike
			if A.IceStrike:IsReady(unitID) then
				return A.IceStrike:Show(icon)
			end
			-- actions.aoe+=/lava_lash
			if A.LavaLash:IsReady(unitID) then
				return A.LavaLash:Show(icon)
			end
			-- actions.aoe+=/flame_shock,target_if=refreshable,cycle_targets=1
			if A.FlameShock:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) < A.FlameShock:GetSpellPandemicThreshold() then
				return A.FlameShock:Show(icon)
			end
			-- actions.aoe+=/frost_shock
			if A.FrostShock:IsReady(unitID) then
				return A.FrostShock:Show(icon)
			end
			-- actions.aoe+=/chain_lightning,if=buff.maelstrom_weapon.stack>=5
			if A.ChainLightning:IsReady(unitID) and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 5 then
				return A.ChainLightning:Show(icon)
			end
			-- actions.aoe+=/earth_elemental
			-- actions.aoe+=/windfury_totem,if=buff.windfury_totem.remains<30
			
		end	
		
		-- actions.single=windstrike,if=talent.thorims_invocation.enabled&buff.maelstrom_weapon.stack>=1
		if A.Windstrike:IsReady(unitID) and Unit(player):HasBuffs(A.Ascendance.ID) > 0 and A.ThorimsInvocation:IsTalentLearned() and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 1 then
			return A.Windstrike:Show(icon)
		end
		-- actions.single+=/lava_lash,if=buff.hot_hand.up|buff.ashen_catalyst.stack=8|(buff.ashen_catalyst.stack>=5&buff.maelstrom_of_elements.up&buff.maelstrom_weapon.stack<=6)
		if A.LavaLash:IsReady(unitID) then
			if Unit(player):HasBuffs(A.HotHandBuff.ID) > 0 or Unit(player):HasBuffsStacks(A.AshenCatalystBuff.ID) >= 8 or (Unit(player):HasBuffsStacks(A.AshenCatalystBuff.ID) >= 5 and Unit(player):HasBuffs(A.MaelstromofElements.ID) > 0 and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) <= 6) then
				return A.LavaLash:Show(icon)
			end
		end
		-- actions.single+=/windfury_totem,if=!buff.windfury_totem.up
		if A.WindfuryTotem:IsReady(player) and Unit(player):HasBuffs(A.WindfuryTotem.ID) == 0 and A.Stormstrike:IsInRange(unitID) then
			return A.WindfuryTotem:Show(icon)
		end
		-- actions.single+=/stormstrike,if=buff.doom_winds.up
		if Unit(player):HasBuffs(A.DoomWinds.ID) > 0 and A.Stormstrike:IsInRange(unitID) then
			if A.Stormstrike:IsReady(unitID) then
				return A.Stormstrike:Show(icon)
			end
			-- actions.single+=/crash_lightning,if=buff.doom_winds.up
			if A.CrashLightning:IsReady(player) then
				return A.CrashLightning:Show(icon)
			end
			-- actions.single+=/ice_strike,if=buff.doom_winds.up
			if A.IceStrike:IsReady(unitID) then
				return A.IceStrike:Show(icon)
			end
			-- actions.single+=/sundering,if=buff.doom_winds.up
			if A.Sundering:IsReady(player) then
				return A.Sundering:Show(icon)
			end
		end
		-- actions.single+=/primordial_wave,if=buff.primordial_wave.down&(raid_event.adds.in>42|raid_event.adds.in<6)
		if A.PrimordialWave:IsReady(unitID) and Unit(player):HasBuffs(A.PrimordialWaveBuff.ID) == 0 then
			return A.PrimordialWave:Show(icon)
		end
		-- actions.single+=/flame_shock,if=!ticking
		if A.FlameShock:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.FlameShock.ID) == 0 then
			return A.FlameShock:Show(icon)
		end
		-- actions.single+=/lightning_bolt,if=buff.maelstrom_weapon.stack>=5&buff.primordial_wave.up&raid_event.adds.in>buff.primordial_wave.remains&(!buff.splintered_elements.up|fight_remains<=12)
		if A.LightningBolt:IsReady(unitID) and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 5 and Unit(player):HasBuffs(A.PrimordialWaveBuff.ID) > 0 and Unit(player):HasBuffs(A.SplinteredElementsBuff.ID) == 0 then
			return A.LightningBolt:Show(icon)
		end
		-- actions.single+=/elemental_blast,if=talent.elemental_spirits.enabled&(charges=max_charges|buff.feral_spirit.up)&buff.maelstrom_weapon.stack>=8
		if A.ElementalBlast:IsReady(unitID) and A.ElementalSpirits:IsTalentLearned() and (A.ElementalBlast:GetSpellCharges() == A.ElementalBlast:GetSpellChargesMax() or Unit(player):HasBuffs(A.FeralSpiritBuff.ID) > 0) and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 8 then
			return A.ElementalBlast:Show(icon)
		end
		-- actions.single+=/ice_strike,if=talent.hailstorm.enabled
		if A.IceStrike:IsReady(unitID) and A.Hailstorm:IsTalentLearned() then
			return A.IceStrike:Show(icon)
		end
		-- actions.single+=/stormstrike,if=set_bonus.tier29_2pc&buff.maelstrom_of_elements.down&buff.maelstrom_weapon.stack<=5
		if A.Stormstrike:IsReady(unitID) and T29has2P and Unit(player):HasBuffs(A.MaelstromofElements.ID) == 0 and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) <= 5 then
			return A.Stormstrike:Show(icon)
		end
		-- actions.single+=/frost_shock,if=buff.hailstorm.up
		if A.FrostShock:IsReady(unitID) and Unit(player):HasBuffs(A.HailstormBuff.ID) > 0 then
			return A.FrostShock:Show(icon)
		end
		-- actions.single+=/lava_lash,if=talent.molten_assault.enabled&dot.flame_shock.refreshable
		if A.LavaLash:IsReady(unitID) and A.MoltenAssault:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) <= A.FlameShock:GetSpellPandemicThreshold() then
			return A.LavaLash:Show(icon)
		end
		-- actions.single+=/windstrike,if=talent.deeply_rooted_elements.enabled|buff.earthen_weapon.up|buff.legacy_of_the_frost_witch.up
		if A.Windstrike:IsReady(unitID) and Unit(player):HasBuffs(A.Ascendance.ID) > 0 and (A.DeeplyRootedElements:IsTalentLearned() or Unit(player):HasBuffs(A.EarthenWeapon.ID) > 0 or Unit(player):HasBuffs(A.LegacyoftheFrostWitchBuff.ID) > 0) then
			return A.Windstrike:Show(icon)
		end
		-- actions.single+=/stormstrike,if=talent.deeply_rooted_elements.enabled|buff.earthen_weapon.up|buff.legacy_of_the_frost_witch.up
		if A.Stormstrike:IsReady(unitID) and (A.DeeplyRootedElements:IsTalentLearned() or Unit(player):HasBuffs(A.EarthenWeapon.ID) > 0 or Unit(player):HasBuffs(A.LegacyoftheFrostWitchBuff.ID) > 0) then
			return A.Stormstrike:Show(icon)
		end
		-- actions.single+=/elemental_blast,if=(talent.elemental_spirits.enabled&buff.maelstrom_weapon.stack=10)|(!talent.elemental_spirits.enabled&buff.maelstrom_weapon.stack>=5)
		if A.ElementalBlast:IsReady(unitID) then
			if (A.ElementalSpirits:IsTalentLearned() and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 10) or (not A.ElementalSpirits:IsTalentLearned() and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 5) then
				return A.ElementalBlast:Show(icon)
			end
		end
		-- actions.single+=/lava_burst,if=buff.maelstrom_weapon.stack>=5
		if A.LavaBurst:IsReady(unitID) and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 5 then
			return A.LavaBurst:Show(icon)
		end
		-- actions.single+=/lightning_bolt,if=buff.maelstrom_weapon.stack=10&buff.primordial_wave.down
		if A.LightningBolt:IsReady(unitID) and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 10 and Unit(player):HasBuffs(A.PrimordialWaveBuff.ID) == 0 then
			return A.LightningBolt:Show(icon)
		end
		-- actions.single+=/windstrike
		if A.Windstrike:IsReady(unitID) and Unit(player):HasBuffs(A.Ascendance.ID) > 0 then
			return A.Windstrike:Show(icon)
		end
		-- actions.single+=/stormstrike
		if A.Stormstrike:IsReady(unitID) then
			return A.Stormstrike:Show(icon)
		end
		-- actions.single+=/windfury_totem,if=buff.windfury_totem.remains<10
		if A.WindfuryTotem:IsReady(player) and A.Stormstrike:IsInRange(unitID) and Unit(player):HasBuffs(A.WindfuryTotemBuff.ID) == 0 then
			return A.WindfuryTotem:Show(icon)
		end
		-- actions.single+=/ice_strike
		if A.IceStrike:IsReady(unitID) then
			return A.IceStrike:Show(icon)
		end
		-- actions.single+=/lava_lash
		if A.LavaLash:IsReady(unitID) then
			return A.LavaLash:Show(icon)
		end
		-- actions.single+=/elemental_blast,if=talent.elemental_spirits.enabled&(charges=max_charges|buff.feral_spirit.up)&buff.maelstrom_weapon.stack>=5
		if A.ElementalBlast:IsReady(unitID) then
			if A.ElementalSpirits:IsTalentLearned() and A.ElementalBlast:GetSpellCharges() == A.ElementalBlast:GetSpellChargesMax() and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 5 then
				return A.ElementalBlast:Show(icon)
			end
		end
		-- actions.single+=/bag_of_tricks
		-- actions.single+=/lightning_bolt,if=buff.maelstrom_weapon.stack>=5&buff.primordial_wave.down
		if A.LightningBolt:IsReady(unitID) and Unit(player):HasBuffsStacks(A.MaelstromWeaponBuff.ID) >= 5 and Unit(player):HasBuffs(A.PrimordialWaveBuff.ID) == 0 then
			return A.LightningBolt:Show(icon)
		end
		-- actions.single+=/sundering,if=raid_event.adds.in>=40
		if A.Sundering:IsReady(unitID) and A.Stormstrike:IsInRange(unitID) then
			return A.Sundering:Show(icon)
		end
		-- actions.single+=/fire_nova,if=talent.swirling_maelstrom.enabled&active_dot.flame_shock
		if A.FireNova:IsReady(player) and A.SwirlingMaelstrom:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) > 0 then
			return A.FireNova:Show(icon)
		end
		-- actions.single+=/frost_shock
		if A.FrostShock:IsReady(unitID) then
			return A.FrostShock:Show(icon)
		end
		-- actions.single+=/crash_lightning
		if A.CrashLightning:IsReady(player) and A.Stormstrike:IsInRange(unitID) then
			return A.CrashLightning:Show(icon)
		end
		-- actions.single+=/fire_nova,if=active_dot.flame_shock
		if A.FireNova:IsReady(player) and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) > 0 then
			return A.FireNova:Show(icon)
		end
		-- actions.single+=/earth_elemental
		-- actions.single+=/flame_shock
		if A.FlameShock:IsReady(unitID) then
			return A.FlameShock:Show(icon)
		end
		-- actions.single+=/windfury_totem,if=buff.windfury_totem.remains<30		

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