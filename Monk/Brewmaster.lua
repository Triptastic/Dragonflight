--##################################
--##### TRIP'S BREWMASTER MONK #####
--##################################

local _G, setmetatable							= _G, setmetatable
local math_random                        		= math.random
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
local HealingEngine                            = Action.HealingEngine
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

Action[ACTION_CONST_MONK_BREWMASTER] = {
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
	
	--General
	TigerPalm      = Action.Create({ Type = "Spell", ID = 100780 }),
	BlackoutKick   = Action.Create({ Type = "Spell", ID = 205523 }),
	SpinningCraneKick= Action.Create({ Type = "Spell", ID = 101546 }),
	Roll           = Action.Create({ Type = "Spell", ID = 109132 }),
	Detox          = Action.Create({ Type = "Spell", ID = 115450 }),
	Provoke        = Action.Create({ Type = "Spell", ID = 115546 }),
	Vivify         = Action.Create({ Type = "Spell", ID = 116670 }),
	CracklingJadeLightning= Action.Create({ Type = "Spell", ID = 117952 }),
	LegSweep       = Action.Create({ Type = "Spell", ID = 119381 }),
	ZenFlight      = Action.Create({ Type = "Spell", ID = 125883 }),
	Reawaken       = Action.Create({ Type = "Spell", ID = 212051 }),
	ExpelHarm      = Action.Create({ Type = "Spell", ID = 322101 }),
	TouchofDeath   = Action.Create({ Type = "Spell", ID = 322109 }),

	--Talents
	Intimidation   = Action.Create({ Type = "Spell", ID = 19577 }),
	FlyingSerpentKick= Action.Create({ Type = "Spell", ID = 101545 }),
	Transcendence  = Action.Create({ Type = "Spell", ID = 101643 }),
	RisingSunKick  = Action.Create({ Type = "Spell", ID = 107428 }),
	FistsofFury    = Action.Create({ Type = "Spell", ID = 113656 }),
	ChiTorpedo     = Action.Create({ Type = "Spell", ID = 115008 }),
	Stagger        = Action.Create({ Type = "Spell", ID = 115069 }),
	Paralysis      = Action.Create({ Type = "Spell", ID = 115078 }),
	ChiWave        = Action.Create({ Type = "Spell", ID = 115098 }),
	RenewingMist   = Action.Create({ Type = "Spell", ID = 115151 }),
	Celerity       = Action.Create({ Type = "Spell", ID = 115173 }),
	SoothingMist   = Action.Create({ Type = "Spell", ID = 115175 }),
	ZenMeditation  = Action.Create({ Type = "Spell", ID = 115176 }),
	BreathofFire   = Action.Create({ Type = "Spell", ID = 115181 }),
	Revival        = Action.Create({ Type = "Spell", ID = 115310 }),
	SummonJadeSerpentStatue= Action.Create({ Type = "Spell", ID = 115313 }),
	SummonBlackOxStatue= Action.Create({ Type = "Spell", ID = 115315 }),
	Ascension      = Action.Create({ Type = "Spell", ID = 115396 }),
	BlackOxBrew    = Action.Create({ Type = "Spell", ID = 115399 }),
	Disable        = Action.Create({ Type = "Spell", ID = 116095 }),
	TeachingsoftheMonastery= Action.Create({ Type = "Spell", ID = 116645 }),
	ThunderFocusTea= Action.Create({ Type = "Spell", ID = 116680 }),
	SpearHandStrike= Action.Create({ Type = "Spell", ID = 116705 }),
	TigersLust     = Action.Create({ Type = "Spell", ID = 116841 }),
	RingofPeace    = Action.Create({ Type = "Spell", ID = 116844 }),
	RushingJadeWind= Action.Create({ Type = "Spell", ID = 116847 }),
	LifeCocoon     = Action.Create({ Type = "Spell", ID = 116849 }),
	PurifyingBrew  = Action.Create({ Type = "Spell", ID = 119582 }),
	KegSmash       = Action.Create({ Type = "Spell", ID = 121253 }),
	PowerStrikes   = Action.Create({ Type = "Spell", ID = 121817 }),
	DampenHarm     = Action.Create({ Type = "Spell", ID = 122278 }),
	HealingElixir  = Action.Create({ Type = "Spell", ID = 122281 }),
	TouchofKarma   = Action.Create({ Type = "Spell", ID = 122470 }),
	DiffuseMagic   = Action.Create({ Type = "Spell", ID = 122783 }),
	InvokeXuentheWhiteTiger= Action.Create({ Type = "Spell", ID = 123904 }),
	ChiBurst       = Action.Create({ Type = "Spell", ID = 123986 }),
	ZenPulse       = Action.Create({ Type = "Spell", ID = 124081 }),
	GiftoftheOx    = Action.Create({ Type = "Spell", ID = 124502 }),
	EnvelopingMist = Action.Create({ Type = "Spell", ID = 124682 }),
	InvokeNiuzaotheBlackOx= Action.Create({ Type = "Spell", ID = 132578 }),
	StormEarthandFire= Action.Create({ Type = "Spell", ID = 137639 }),
	Serenity       = Action.Create({ Type = "Spell", ID = 152173 }),
	WhirlingDragonPunch= Action.Create({ Type = "Spell", ID = 152175 }),
	Windwalking    = Action.Create({ Type = "Spell", ID = 157411 }),
	EssenceFont    = Action.Create({ Type = "Spell", ID = 191837 }),
	InnerPeace     = Action.Create({ Type = "Spell", ID = 195243 }),
	TransferthePower= Action.Create({ Type = "Spell", ID = 195300 }),
	EyeoftheTiger  = Action.Create({ Type = "Spell", ID = 196607 }),
	RefreshingJadeWind= Action.Create({ Type = "Spell", ID = 196725 }),
	SpecialDelivery= Action.Create({ Type = "Spell", ID = 196730 }),
	BlackoutCombo  = Action.Create({ Type = "Spell", ID = 196736 }),
	BlackoutComboBuff  = Action.Create({ Type = "Spell", ID = 228563 }),
	HighTolerance  = Action.Create({ Type = "Spell", ID = 196737 }),
	HitCombo       = Action.Create({ Type = "Spell", ID = 196740 }),
	FocusedThunder = Action.Create({ Type = "Spell", ID = 197895 }),
	MistWrap       = Action.Create({ Type = "Spell", ID = 197900 }),
	ManaTea        = Action.Create({ Type = "Spell", ID = 197908 }),
	Lifecycles     = Action.Create({ Type = "Spell", ID = 197915 }),
	SongofChiJi    = Action.Create({ Type = "Spell", ID = 198898 }),
	SpiritoftheCrane= Action.Create({ Type = "Spell", ID = 210802 }),
	Detox          = Action.Create({ Type = "Spell", ID = 218164 }),
	MarkoftheCrane = Action.Create({ Type = "Spell", ID = 220357 }),
	ImprovedVivify = Action.Create({ Type = "Spell", ID = 231602 }),
	TigerTailSweep = Action.Create({ Type = "Spell", ID = 264348 }),
	InvigoratingMists= Action.Create({ Type = "Spell", ID = 274586 }),
	RisingMist     = Action.Create({ Type = "Spell", ID = 274909 }),
	Upwelling      = Action.Create({ Type = "Spell", ID = 274963 }),
	SpiritualFocus = Action.Create({ Type = "Spell", ID = 280197 }),
	BobandWeave    = Action.Create({ Type = "Spell", ID = 280515 }),
	MasteryofMist  = Action.Create({ Type = "Spell", ID = 281231 }),
	BindingShackles= Action.Create({ Type = "Spell", ID = 321468 }),
	ImprovedTouchofDeath= Action.Create({ Type = "Spell", ID = 322113 }),
	InvokeYulontheJadeSerpent= Action.Create({ Type = "Spell", ID = 322118 }),
	Shuffle        = Action.Create({ Type = "Spell", ID = 322120 }),
	CelestialBrew  = Action.Create({ Type = "Spell", ID = 322507 }),
	ImprovedCelestialBrew= Action.Create({ Type = "Spell", ID = 322510 }),
	ImprovedInvokeNiuzaotheBlackOx= Action.Create({ Type = "Spell", ID = 322740 }),
	FortifyingBrewDetermination= Action.Create({ Type = "Spell", ID = 322960 }),
	EmpoweredTigerLightning= Action.Create({ Type = "Spell", ID = 323999 }),
	Clash          = Action.Create({ Type = "Spell", ID = 324312 }),
	LightBrewing   = Action.Create({ Type = "Spell", ID = 325093 }),
	ExplodingKeg   = Action.Create({ Type = "Spell", ID = 325153 }),
	CelestialFlames= Action.Create({ Type = "Spell", ID = 325177 }),
	InvokeChiJitheRedCrane= Action.Create({ Type = "Spell", ID = 325197 }),
	DanceofChiJi   = Action.Create({ Type = "Spell", ID = 325201 }),
	ImprovedRoll   = Action.Create({ Type = "Spell", ID = 328669 }),
	HastyProvocation= Action.Create({ Type = "Spell", ID = 328670 }),
	FontofLife     = Action.Create({ Type = "Spell", ID = 337209 }),
	EnvelopingBreath= Action.Create({ Type = "Spell", ID = 343655 }),
	ImprovedPurifyingBrew= Action.Create({ Type = "Spell", ID = 343743 }),
	ImprovedParalysis= Action.Create({ Type = "Spell", ID = 344359 }),
	HitScheme      = Action.Create({ Type = "Spell", ID = 383695 }),
	SalsalabimsStrength= Action.Create({ Type = "Spell", ID = 383697 }),
	ScaldingBrew   = Action.Create({ Type = "Spell", ID = 383698 }),
	GaiPlinsImperialBrew= Action.Create({ Type = "Spell", ID = 383700 }),
	StormstoutsLastKeg= Action.Create({ Type = "Spell", ID = 383707 }),
	TrainingofNiuzao= Action.Create({ Type = "Spell", ID = 383714 }),
	Counterstrike  = Action.Create({ Type = "Spell", ID = 383785 }),
	DragonfireBrew = Action.Create({ Type = "Spell", ID = 383994 }),
	BonedustBrew   = Action.Create({ Type = "Spell", ID = 386276 }),
	AnvilStave     = Action.Create({ Type = "Spell", ID = 386937 }),
	Attenuation    = Action.Create({ Type = "Spell", ID = 386941 }),
	BountifulBrew  = Action.Create({ Type = "Spell", ID = 386949 }),
	CharredPassions= Action.Create({ Type = "Spell", ID = 386965 }),
	CharredPassionsBuff = Action.Create({ Type = "Spell", ID = 386963 }),
	FundamentalObservation= Action.Create({ Type = "Spell", ID = 387035 }),
	ElusiveFootwork= Action.Create({ Type = "Spell", ID = 387046 }),
	WeaponsofOrder = Action.Create({ Type = "Spell", ID = 387184 }),
	WalkwiththeOx  = Action.Create({ Type = "Spell", ID = 387219 }),
	FluidityofMotion= Action.Create({ Type = "Spell", ID = 387230 }),
	GracefulExit   = Action.Create({ Type = "Spell", ID = 387256 }),
	StrengthofSpirit= Action.Create({ Type = "Spell", ID = 387276 }),
	StaggeringStrikes= Action.Create({ Type = "Spell", ID = 387625 }),
	ShadowboxingTreads= Action.Create({ Type = "Spell", ID = 387638 }),
	NourishingChi  = Action.Create({ Type = "Spell", ID = 387765 }),
	TearofMorning  = Action.Create({ Type = "Spell", ID = 387991 }),
	ResplendentMist= Action.Create({ Type = "Spell", ID = 388020 }),
	AncientTeachings= Action.Create({ Type = "Spell", ID = 388023 }),
	JadeBond       = Action.Create({ Type = "Spell", ID = 388031 }),
	YulonsWhisper  = Action.Create({ Type = "Spell", ID = 388038 }),
	CloudedFocus   = Action.Create({ Type = "Spell", ID = 388047 }),
	FaelineStomp   = Action.Create({ Type = "Spell", ID = 388193 }),
	GiftoftheCelestials= Action.Create({ Type = "Spell", ID = 388212 }),
	CalmingCoalescence= Action.Create({ Type = "Spell", ID = 388218 }),
	Unison         = Action.Create({ Type = "Spell", ID = 388477 }),
	SecretInfusion = Action.Create({ Type = "Spell", ID = 388491 }),
	QuickSip       = Action.Create({ Type = "Spell", ID = 388505 }),
	MendingProliferation= Action.Create({ Type = "Spell", ID = 388509 }),
	OverflowingMists= Action.Create({ Type = "Spell", ID = 388511 }),
	TeaofPlenty    = Action.Create({ Type = "Spell", ID = 388517 }),
	MistsofLife    = Action.Create({ Type = "Spell", ID = 388548 }),
	UpliftedSpirits= Action.Create({ Type = "Spell", ID = 388551 }),
	AccumulatingMist= Action.Create({ Type = "Spell", ID = 388564 }),
	PeacefulMending= Action.Create({ Type = "Spell", ID = 388593 }),
	EchoingReverberation= Action.Create({ Type = "Spell", ID = 388604 }),
	Restoral       = Action.Create({ Type = "Spell", ID = 388615 }),
	InvokersDelight= Action.Create({ Type = "Spell", ID = 388661 }),
	CalmingPresence= Action.Create({ Type = "Spell", ID = 388664 }),
	FerocityofXuen = Action.Create({ Type = "Spell", ID = 388674 }),
	ElusiveMists   = Action.Create({ Type = "Spell", ID = 388681 }),
	MistyPeaks     = Action.Create({ Type = "Spell", ID = 388682 }),
	SummonWhiteTigerStatue= Action.Create({ Type = "Spell", ID = 388686 }),
	DancingMists   = Action.Create({ Type = "Spell", ID = 388701 }),
	AncientConcordance= Action.Create({ Type = "Spell", ID = 388740 }),
	AwakenedFaeline= Action.Create({ Type = "Spell", ID = 388779 }),
	FastFeet       = Action.Create({ Type = "Spell", ID = 388809 }),
	GraceoftheCrane= Action.Create({ Type = "Spell", ID = 388811 }),
	VivaciousVivification= Action.Create({ Type = "Spell", ID = 388812 }),
	ExpeditiousFortification= Action.Create({ Type = "Spell", ID = 388813 }),
	IronshellBrew  = Action.Create({ Type = "Spell", ID = 388814 }),
	WideningWhirl  = Action.Create({ Type = "Spell", ID = 388846 }),
	RapidDiffusion = Action.Create({ Type = "Spell", ID = 388847 }),
	CraneVortex    = Action.Create({ Type = "Spell", ID = 388848 }),
	RisingStar     = Action.Create({ Type = "Spell", ID = 388849 }),
	FlashingFists  = Action.Create({ Type = "Spell", ID = 388854 }),
	TouchoftheTiger= Action.Create({ Type = "Spell", ID = 388856 }),
	ImprovedDetox  = Action.Create({ Type = "Spell", ID = 388874 }),
	FortifyingBrew = Action.Create({ Type = "Spell", ID = 115203 }),
	ClosetoHeart   = Action.Create({ Type = "Spell", ID = 389574 }),
	GenerousPour   = Action.Create({ Type = "Spell", ID = 389575 }),
	BounceBack     = Action.Create({ Type = "Spell", ID = 389577 }),
	ResonantFists  = Action.Create({ Type = "Spell", ID = 389578 }),
	SaveThemAll    = Action.Create({ Type = "Spell", ID = 389579 }),
	FacePalm       = Action.Create({ Type = "Spell", ID = 389942 }),
	MeridianStrikes= Action.Create({ Type = "Spell", ID = 391330 }),
	DrinkingHornCover= Action.Create({ Type = "Spell", ID = 391370 }),
	HardenedSoles  = Action.Create({ Type = "Spell", ID = 391383 }),
	FaelineHarmony = Action.Create({ Type = "Spell", ID = 391412 }),
	VigorousExpulsion= Action.Create({ Type = "Spell", ID = 392900 }),
	ProfoundRebuttal= Action.Create({ Type = "Spell", ID = 392910 }),
	GloryoftheDawn = Action.Create({ Type = "Spell", ID = 392958 }),
	OpenPalmStrikes= Action.Create({ Type = "Spell", ID = 392970 }),
	JadeIgnition   = Action.Create({ Type = "Spell", ID = 392979 }),
	StrikeoftheWindlord= Action.Create({ Type = "Spell", ID = 392983 }),
	Thunderfist    = Action.Create({ Type = "Spell", ID = 392985 }),
	XuensBond      = Action.Create({ Type = "Spell", ID = 392986 }),
	LastEmperorsCapacitor= Action.Create({ Type = "Spell", ID = 392989 }),
	Skyreach       = Action.Create({ Type = "Spell", ID = 392991 }),
	XuensBattlegear= Action.Create({ Type = "Spell", ID = 392993 }),
	WayoftheFae    = Action.Create({ Type = "Spell", ID = 392994 }),
	ForbiddenTechnique= Action.Create({ Type = "Spell", ID = 393098 }),
	TranquilSpirit = Action.Create({ Type = "Spell", ID = 393357 }),
	ChiSurge       = Action.Create({ Type = "Spell", ID = 393400 }),
	TeaofSerenity  = Action.Create({ Type = "Spell", ID = 393460 }),
	PretenseofInstability= Action.Create({ Type = "Spell", ID = 393516 }),
	DustintheWind  = Action.Create({ Type = "Spell", ID = 394093 }),
	EscapefromReality= Action.Create({ Type = "Spell", ID = 394110 }),
	FatalTouch     = Action.Create({ Type = "Spell", ID = 394123 }),
	FatalFlyingGuillotine= Action.Create({ Type = "Spell", ID = 394923 }),
	FuryofXuen     = Action.Create({ Type = "Spell", ID = 396166 }),
	CalltoArms     = Action.Create({ Type = "Spell", ID = 397251 }),
	HeavyStagger     = Action.Create({ Type = "Spell", ID = 124273 }),
	PurifiedChi     = Action.Create({ Type = "Spell", ID = 325092 }),
	Healthstone     = Action.Create({ Type = "Item", ID = 5512 }),
}

local A = setmetatable(Action[ACTION_CONST_MONK_BREWMASTER], { __index = Action })

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

local function SelfDefensives()
    local AllowOverlap = A.GetToggle(2, "AllowOverlap")
	local HealingElixirHP = A.GetToggle(2, "HealingElixirHP")	
	local ExpelHarmHP = A.GetToggle(2, "ExpelHarmHP")	
	local HealingSphereCount = A.GetToggle(2, "HealingSphereCount")	
	local FortifyingBrewHP = A.GetToggle(2, "FortifyingBrewHP")
    local DampenHarmHP = A.GetToggle(2, "DampenHarmHP")	
    local HealthstoneHP = A.GetToggle(1, "HealthStone")		
	local areaTTD = MultiUnits:GetByRangeAreaTTD(20) > 50
	local useDefensive = A.FortifyingBrew:GetSpellTimeSinceLastCast() > 20 and A.DampenHarm:GetSpellTimeSinceLastCast() > 15 and A.DiffuseMagic:GetSpellTimeSinceLastCast() > 10 and areaTTD

	if Unit(player):CombatTime() == 0 then 
        return 
    end 

	if A.CanUseHealthstoneOrHealingPotion() then
		return A.Healthstone
	end

	if A.PurifyingBrew:IsReady(player) and Unit(player):HasBuffs(A.BlackoutComboBuff.ID) == 0 and Player:StaggerPercentage() >= 10 then
		if A.PurifyingBrew:GetSpellChargesFullRechargeTime() <= A.GetGCD() * 2 or Player:StaggerPercentage() >= 70  then
			return A.PurifyingBrew
		end
	end

	if A.CelestialBrew:IsReady(player) and Unit(player):HasBuffsStacks(A.PurifiedChi.ID) > (A.InstanceInfo.KeyStone or 9) then
		return A.CelestialBrew
	end

	if A.HealingElixir:IsReady(player) and Unit(player):HealthPercent() <= HealingElixirHP then
		return A.HealingElixir
	end

	if A.ExpelHarm:IsReady(player) and Unit(player):HealthPercent() <= ExpelHarmHP and A.ExpelHarm:GetCount() >= HealingSphereCount then
		return A.ExpelHarm
	end
	
	if A.FortifyingBrew:IsReady(player) and (Unit(player):HealthPercent() <= FortifyingBrewHP) and (Unit(player):HasBuffs(A.DampenHarm.ID) == 0 or AllowOverlap) then
		return A.FortifyingBrew
	end
	
	if A.DampenHarm:IsReady(player) and (Unit(player):HealthPercent() <= DampenHarmHP) and (Unit(player):HasBuffs(A.FortifyingBrew.ID) == 0 or AllowOverlap) then
		return A.DampenHarm
	end

	if A.TigersLust:IsReady(player) and (LoC:Get("SNARE") > 0 or LoC:Get("ROOT") > 0) then
		return A.TigersLust
	end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        if useKick and not notInterruptable and A.SpearHandStrike:IsReady(unitID) then 
            return A.SpearHandStrike
        end
		
        if useCC and A.LegSweep:IsReady(unitID) and A.TigerPalm:IsInRange(unitID) then 
            return A.LegSweep
        end		

		if useCC and A.Paralysis:IsReady(unitID) then 
            return A.Paralysis
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

	if A.Trinket1:IsReady(unitID) then
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

	if A.Trinket2:IsReady(unitID) then
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

local function DungeonDefensives()

	local DiffuseMagicActive = Unit(player):HasBuffs(A.DiffuseMagic.ID) > 0
	local DampenHarmActive = Unit(player):HasBuffs(A.DampenHarm.ID) > 0
	local FortifyingBrewActive = Unit(player):HasBuffs(A.FortifyingBrew.ID) > 0
	local noDefensiveActive = not DiffuseMagicActive and not DampenHarmActive and not FortifyingBrewActive
	local healerStressed = HealerStressed()
	local massPull = MassPull()

	if noDefensiveActive then
		if healerStressed then
			if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.healerStressedIncMagic) >= 1 then
				if A.DiffuseMagic:IsReady(player) then
					return A.DiffuseMagic
				elseif A.DampenHarm:IsReady(player) then
					return A.DampenHarm
				elseif A.FortifyingBrew:IsReady(player) then
					return A.FortifyingBrew
				end
			end
			if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.healerStressedIncPhys) >= 1 then
				if A.DampenHarm:IsReady(player) then
					return A.DampenHarm
				elseif A.FortifyingBrew:IsReady(player) then
					return A.FortifyingBrew
				end
			end
		end
		--[[if massPull then
			if A.DampenHarm:IsReady(player) then
				return A.DampenHarm
			elseif A.FortifyingBrew:IsReady(player) then
				return A.FortifyingBrew
			end
		end
		if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.IncMagic) >= 1 then
			if A.DiffuseMagic:IsReady(player) then
				return A.DiffuseMagic
			elseif A.DampenHarm:IsReady(player) then
				return A.DampenHarm
			elseif A.FortifyingBrew:IsReady(player) then
				return A.FortifyingBrew
			end
		end]]
		if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.IncPhys) >= 1 then
			if A.DampenHarm:IsReady(player) then
				return A.DampenHarm
			elseif A.FortifyingBrew:IsReady(player) then
				return A.FortifyingBrew
			end
		end
	end

end


A[3] = function(icon, isMulti)
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
	local UseAoE = A.GetToggle(2, "AoE")
	local UseRacial = A.GetToggle(1, "Racial")
	local spellTargets = MultiUnits:GetByRange(10, 5)
	local areaTTD = MultiUnits:GetByRangeAreaTTD(10) > 50
	local inRange = A.TigerPalm:IsInRange(unitID)

	local function EnemyRotation(unitID)
		
		-- actions.precombat+=/variable,name=boc_count,op=set,value=0
		bocCount = 0
		if not inCombat then bocCount = 0 end
		-- actions.rotation_fom_boc=variable,name=boc_count,op=add,value=1,if=prev.blackout_kick
		if Player:PrevGCD(1, A.BlackoutKick) then bocCount = bocCount + 1 end
		-- actions.rotation_fom_boc+=/variable,name=time_to_scheduled_ks,op=set,value=cooldown.blackout_kick.duration_expected*(1-(variable.boc_count)%%3)+cooldown.blackout_kick.remains+1
		timetoScheduledKS = A.BlackoutKick:GetCooldown() * (1-(bocCount)%3) + A.BlackoutKick:GetCooldown() + 1

		-- # Executed every time the actor is available.
		-- # Rotation Selection
		-- actions=variable,op=set,name=rotation_selection,value=0
		rotationSelection = 0
		-- actions+=/variable,op=set,name=rotation_selection,value=1,if=(talent.charred_passions.enabled|talent.dragonfire_brew.enabled)&talent.salsalabims_strength.enabled
		-- actions+=/variable,op=set,name=rotation_selection,value=2,if=(talent.charred_passions.enabled|talent.dragonfire_brew.enabled)&talent.salsalabims_strength.enabled&talent.blackout_combo.enabled
		-- actions+=/variable,op=set,name=rotation_selection,value=3-variable.rotation_selection
		if (A.CharredPassions:IsTalentLearned() or A.DragonfireBrew:IsTalentLearned()) and A.SalsalabimsStrength:IsTalentLearned() then
			rotationSelection = 1
		end
		if (A.CharredPassions:IsTalentLearned() or A.DragonfireBrew:IsTalentLearned()) and A.SalsalabimsStrength:IsTalentLearned() and A.BlackoutCombo:IsTalentLearned() then
			rotationSelection = 2
		end
		rotationSelection = 3 - rotationSelection

		if not inCombat and A.RushingJadeWind:IsReady(player) and Unit(unitID):GetRange() <= 40 then
			return A.RushingJadeWind:Show(icon)
		end

        if A.Provoke:IsReady(unitID, true) and not Unit(unitID):IsBoss() and not Unit(unitID):IsDummy() and Unit(targettarget):InfoGUID() ~= Unit(player):InfoGUID() and Unit(targettarget):InfoGUID() ~= nil and A.IsUnitFriendly(targettarget) then 
            return A.Provoke:Show(icon)
        end 

		-- actions+=/spear_hand_strike,if=target.debuff.casting.react
		local Interrupt = Interrupts(unitID)
		if Interrupt then 
			return Interrupt:Show(icon)
		end

		-- actions+=/touch_of_death
		if A.TouchofDeath:IsReady(unitID) and Unit(unitID):Health() >= Unit(player):Health() / 2 then
			return A.TouchofDeath:Show(icon)
		end

		-- # Cooldown Action Lists
		if BurstIsON(unitID) and inRange and areaTTD then

				-- # Base DPS Cooldowns
			-- actions+=/summon_white_tiger_statue,if=talent.summon_white_tiger_statue.enabled
			if A.SummonWhiteTigerStatue:IsReady(player) and not isMoving and (spellTargets >= 3 or Unit(unitID):IsBoss()) then
				return A.SummonWhiteTigerStatue:Show(icon)
			end

			-- actions+=/bonedust_brew,if=!debuff.bonedust_brew_debuff.up&talent.bonedust_brew.enabled
			if A.BonedustBrew:IsReady(player) and not isMoving and (spellTargets >= 3 or Unit(unitID):IsBoss()) then
				return A.BonedustBrew:Show(icon)
			end
			-- actions+=/blood_fury
			if UseRacial then
				if A.BloodFury:IsReady(player) then
					return A.BloodFury:Show(icon)
				end
				-- actions+=/berserking
				if A.Berserking:IsReady(player) then
					return A.Berserking:Show(icon)
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

			local UseTrinket = UseTrinkets(unitID)
			if UseTrinket then
				return UseTrinket:Show(icon)
			end  

			-- actions+=/call_action_list,name=cooldowns_improved_niuzao_woo,if=(talent.invoke_niuzao_the_black_ox.enabled+talent.improved_invoke_niuzao_the_black_ox.enabled)=2&(talent.weapons_of_order.enabled+talent.call_to_arms.enabled)<=1
			if (num(A.InvokeNiuzaotheBlackOx:IsTalentLearned()) + num(A.ImprovedInvokeNiuzaotheBlackOx:IsTalentLearned())) == 2 and (num(A.WeaponsofOrder:IsTalentLearned()) + num(A.CalltoArms:IsTalentLearned()) <= 1) then

				-- # Name: Improved Niuzao + Weapons of Order
				-- actions.cooldowns_improved_niuzao_woo=variable,name=pb_in_window,op=set,value=floor(cooldown.purifying_brew.charges_fractional+(20+4*0.05)%cooldown.purifying_brew.duration%0.65),if=prev.invoke_niuzao_the_black_ox
				local pbInWindow = math.floor(A.PurifyingBrew:GetSpellChargesFrac() + (20.4*0.05) % A.PurifyingBrew:GetSpellCooldown() % 0.65)  

				--[[ actions.cooldowns_improved_niuzao_woo+=/purifying_brew,if=talent.purifying_brew.enabled&(time-action.purifying_brew.last_used>=20+4*0.05-time+action.invoke_niuzao_the_black_ox.last_used%variable.pb_in_window&time-action.invoke_niuzao_the_black_ox.last_used<=20+4*0.05)
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and (A.PurifyingBrew:GetSpellTimeSinceLastCast() >= (20+4*0.05 + A.InvokeNiuzaotheBlackOx:GetSpellTimeSinceLastCast() % pbInWindow) and A.InvokeNiuzaotheBlackOx:GetSpellTimeSinceLastCast() <= 20+4*0.05) then
					return A.PurifyingBrew:Show(icon)
				end
				-- actions.cooldowns_improved_niuzao_woo+=/purifying_brew,use_off_gcd=1,if=talent.purifying_brew.enabled&(variable.pb_in_window=0&20+4*0.05-time+action.invoke_niuzao_the_black_ox.last_used<1&20+4*0.05-time+action.invoke_niuzao_the_black_ox.last_used>0)
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and pbInWindow == 0 and (20 + 4 * 0.05 + A.InvokeNiuzaotheBlackOx:GetSpellTimeSinceLastCast() < 1 and 20 + 4 * 0.05 + A.InvokeNiuzaotheBlackOx:GetSpellTimeSinceLastCast() > 0) then
					return A.PurifyingBrew:Show(icon)
				end]]

				-- actions.cooldowns_improved_niuzao_woo+=/weapons_of_order,if=talent.weapons_of_order.enabled
				if A.WeaponsofOrder:IsReady(player) then
					return A.WeaponsofOrder:Show(icon)
				end
				--[[ actions.cooldowns_improved_niuzao_woo+=/purifying_brew,if=talent.purifying_brew.enabled&cooldown.invoke_niuzao_the_black_ox.remains<=3.5&time-action.purifying_brew.last_used>=3.5+cooldown.invoke_niuzao_the_black_ox.remains
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and A.InvokeNiuzaotheBlackOx:GetCooldown() <= 3.5 and A.PurifyingBrew:GetSpellTimeSinceLastCast() >= (3.5 + A.InvokeNiuzaotheBlackOx:GetCooldown()) then
					return A.PurifyingBrew:Show(icon)
				end]]
				-- actions.cooldowns_improved_niuzao_woo+=/invoke_niuzao_the_black_ox,if=talent.invoke_niuzao_the_black_ox.enabled&time-action.purifying_brew.last_used<=5
				if A.InvokeNiuzaotheBlackOx:IsReady(player) and A.PurifyingBrew:GetSpellTimeSinceLastCast() <= 5 then
					return A.InvokeNiuzaotheBlackOx:Show(icon)
				end
				--[[ actions.cooldowns_improved_niuzao_woo+=/purifying_brew,if=talent.purifying_brew.enabled&cooldown.purifying_brew.full_recharge_time*2<=cooldown.invoke_niuzao_the_black_ox.remains-3.5
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and A.PurifyingBrew:GetSpellChargesFullRechargeTime() * 2 <= A.InvokeNiuzaotheBlackOx:GetCooldown() - 3.5 then
					return A.PurifyingBrew:Show(icon)
				end]]
			end

			-- actions+=/call_action_list,name=cooldowns_improved_niuzao_cta,if=(talent.invoke_niuzao_the_black_ox.enabled+talent.improved_invoke_niuzao_the_black_ox.enabled)=2&(talent.weapons_of_order.enabled+talent.call_to_arms.enabled)=2
			if (num(A.InvokeNiuzaotheBlackOx:IsTalentLearned()) + num(A.ImprovedInvokeNiuzaotheBlackOx:IsTalentLearned())) == 2 and (num(A.WeaponsofOrder:IsTalentLearned()) + num(A.CalltoArms:IsTalentLearned()) == 2) then

							-- # Name: Improved Niuzao + Call to Arms
				-- actions.cooldowns_improved_niuzao_cta=variable,name=pb_in_window,op=set,value=floor(cooldown.purifying_brew.charges_fractional+(10+2*0.05)%cooldown.purifying_brew.duration%0.65),if=prev.weapons_of_order
				-- actions.cooldowns_improved_niuzao_cta+=/variable,name=pb_in_window,op=set,value=floor(cooldown.purifying_brew.charges_fractional+(20+4*0.05)%cooldown.purifying_brew.duration%0.65),if=prev.invoke_niuzao_the_black_ox
				-- actions.cooldowns_improved_niuzao_cta+=/variable,name=pb_in_window,op=sub,value=1,if=prev.purifying_brew&(time-action.weapons_of_order.last_used<=10+2*0.05|time-action.invoke_niuzao_the_black_ox.last_used<=20+4*0.05)
				local pbInWindow = 0 
				if Player:PrevGCD(1, A.WeaponsofOrder) then
					pbInWindow = math.floor(A.PurifyingBrew:GetSpellChargesFrac() + (10+2*0.05) % A.PurifyingBrew:GetSpellCooldown() % 0.65) 
				elseif Player:PrevGCD(1, A.InvokeNiuzaotheBlackOx) then
					pbInWindow = math.floor(A.PurifyingBrew:GetSpellChargesFrac() + (20.4*0.05) % A.PurifyingBrew:GetSpellCooldown() % 0.65)
				elseif Player:PrevOffGCD(1, A.PurifyingBrew) and (A.WeaponsofOrder:GetSpellTimeSinceLastCast() <= 10 + 2 * 0.05 or A.InvokeNiuzaotheBlackOx:GetSpellTimeSinceLastCast() <= 20 + 4 * 0.05) then
					pbInWindow = 1
				end

				--[[ actions.cooldowns_improved_niuzao_cta+=/purifying_brew,if=talent.purifying_brew.enabled&(time-action.purifying_brew.last_used>=10+2*0.05-time+action.weapons_of_order.last_used%variable.pb_in_window&time-action.weapons_of_order.last_used<=10+2*0.05)
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and (A.PurifyingBrew:GetSpellTimeSinceLastCast() >= (10 + 2 * 0.05 + A.WeaponsOfOrder:GetSpellTimeSinceLastCast() % pbInWindow) and A.WeaponsofOrder:GetSpellTimeSinceLastCast() <= 10 + 2* 0.05) then
					return A.PurifyingBrew:Show(icon)
				end
				-- actions.cooldowns_improved_niuzao_cta+=/purifying_brew,if=talent.purifying_brew.enabled&(time-action.purifying_brew.last_used>=20+4*0.05-time+action.invoke_niuzao_the_black_ox.last_used%variable.pb_in_window&time-action.invoke_niuzao_the_black_ox.last_used<=20+4*0.05)
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and (A.PurifyingBrew:GetSpellTimeSinceLastCast() >= (20 + 4 * 0.05 + A.InvokeNiuzaotheBlackOx:GetSpellTimeSinceLastCast() % pbInWindow) and A.InvokeNiuzaotheBlackOx:GetSpellTimeSinceLastCast() <= 20 + 4 * 0.05) then
					return A.PurifyingBrew:Show(icon)
				end
				-- actions.cooldowns_improved_niuzao_cta+=/purifying_brew,use_off_gcd=1,if=talent.purifying_brew.enabled&(variable.pb_in_window=0&20+4*0.05-time+action.invoke_niuzao_the_black_ox.last_used<1&20+4*0.05-time+action.invoke_niuzao_the_black_ox.last_used>0)
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and pbInWindow == 0 and (20 + 4 * 0.05 + A.InvokeNiuzaotheBlackOx:GetSpellTimeSinceLastCast() < 1 and 20 + 4 * 0.05 + A.InvokeNiuzaotheBlackOx:GetSpellTimeSinceLastCast() > 0) then
					return A.PurifyingBrew:Show(icon)
				end
				-- actions.cooldowns_improved_niuzao_cta+=/purifying_brew,if=talent.purifying_brew.enabled&cooldown.weapons_of_order.remains<=3.5&time-action.purifying_brew.last_used>=3.5+cooldown.weapons_of_order.remains
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and A.WeaponsofOrder:GetCooldown() <= 3.5 and A.PurifyingBrew:GetSpellTimeSinceLastCast() >= 3.5 and A.WeaponsofOrder:GetCooldown() > 0 then
					return A.PurifyingBrew:Show(icon)
				end]]
				-- actions.cooldowns_improved_niuzao_cta+=/weapons_of_order,if=talent.weapons_of_order.enabled&time-action.purifying_brew.last_used<=5
				if A.WeaponsofOrder:IsReady(player) and A.PurifyingBrew:GetSpellTimeSinceLastCast() <= 5 then
					return A.WeaponsofOrder:Show(icon)
				end
				--[[ actions.cooldowns_improved_niuzao_cta+=/purifying_brew,if=talent.purifying_brew.enabled&cooldown.invoke_niuzao_the_black_ox.remains<=3.5&time-action.purifying_brew.last_used>=3.5+cooldown.invoke_niuzao_the_black_ox.remains&buff.weapons_of_order.remains<=30-17
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and A.InvokeNiuzaotheBlackOx:GetCooldown() <= 3.5 and (A.PurifyingBrew:GetSpellTimeSinceLastCast() >= 3.5 + A.InvokeNiuzaotheBlackOx:GetCooldown()) and A.WeaponsOfOrder:GetBuffRemainingTime() <= 30 - 17 then
					return A.PurifyingBrew:Show(icon)
				end]]
				-- actions.cooldowns_improved_niuzao_cta+=/invoke_niuzao_the_black_ox,if=talent.invoke_niuzao_the_black_ox.enabled&buff.weapons_of_order.remains<=30-17&action.purifying_brew.last_used>action.weapons_of_order.last_used+10+2*0.05
				if A.InvokeNiuzaotheBlackOx:IsReady(player) and Unit(player):HasBuffs(A.WeaponsofOrder.ID) <= 30 - 17 and A.PurifyingBrew:GetSpellTimeSinceLastCast() > A.WeaponsOfOrder:GetSpellTimeSinceLastCast() + 10 + 2 * 0.05 then
					return A.InvokeNiuzaotheBlackOx:Show(icon)
				end
				--[[actions.cooldowns_improved_niuzao_cta+=/purifying_brew,if=talent.purifying_brew.enabled&cooldown.purifying_brew.full_recharge_time*2<=cooldown.weapons_of_order.remains-3.5&cooldown.purifying_brew.full_recharge_time*2<=cooldown.invoke_niuzao_the_black_ox.remains-3.5
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and A.PurifyingBrew:GetSpellChargesFullRechargeTime() * 2 <= A.WeaponsofOrder:GetCooldown() - 3.5 and A.PurifyingBrew:GetSpellChargesFullRechargeTime() * 2 <= A.InvokeNiuzaotheBlackOx:GetCooldown() - 3.5 then
					return A.PurifyingBrew:Show(icon)
				end]]

			end

			-- actions+=/call_action_list,name=cooldowns_niuzao_woo,if=(talent.invoke_niuzao_the_black_ox.enabled+talent.improved_invoke_niuzao_the_black_ox.enabled)<=1
			if (num(A.InvokeNiuzaotheBlackOx:IsTalentLearned()) + num(A.ImprovedInvokeNiuzaotheBlackOx:IsTalentLearned())) <= 1 then

				-- # Name: Niuzao + Weapons of Order / Niuzao + Call to Arms
				-- actions.cooldowns_niuzao_woo=weapons_of_order,if=talent.weapons_of_order.enabled
				if A.WeaponsofOrder:IsReady(player) then
					return A.WeaponsofOrder:Show(icon)
				end
				-- actions.cooldowns_niuzao_woo+=/invoke_niuzao_the_black_ox,if=talent.invoke_niuzao_the_black_ox.enabled&buff.weapons_of_order.remains<=16&talent.weapons_of_order.enabled
				if A.InvokeNiuzaotheBlackOx:IsReady(player) and Unit(player):HasBuffs(A.WeaponsofOrder.ID) <= 16 then
					return A.InvokeNiuzaotheBlackOx:Show(icon)
				end

				--[[ actions.cooldowns_niuzao_woo+=/purifying_brew,if=talent.purifying_brew.enabled&cooldown.purifying_brew.remains_expected<5&!buff.blackout_combo.up
				if A.PurifyingBrew:IsReady(player) and Player:Stagger() > 0 and A.PurifyingBrew:GetCooldown() < 5 and Unit(player):HasBuffs(A.BlackoutComboBuff.ID) == 0 then
					return A.PurifyingBrew:Show(icon)
				end]]
			end
		end

		-- # Rotation Action Lists
		-- actions+=/call_action_list,name=rotation_boc,if=variable.rotation_selection=1&(((1%spell_haste-1)*100>=1%3&talent.fluidity_of_motion.enabled)|!talent.fluidity_of_motion.enabled)
		if rotationSelection == 1 and (((1 % Player:SpellHaste() - 1 ) * 100 >= 1 % 3 and A.FluidityofMotion:IsTalentLearned()) or not A.FluidityofMotion:IsTalentLearned()) then
			-- # Name: Blackout Combo Salsalabim's Strength Charred Passions [Shadowboxing Treads or high haste Fluidity of Motion]
			-- actions.rotation_boc=blackout_kick
			if A.BlackoutKick:IsReady(unitID) then
				return A.BlackoutKick:Show(icon)
			end
			-- actions.rotation_boc+=/rising_sun_kick,if=talent.rising_sun_kick.enabled
			if A.RisingSunKick:IsReady(unitID) then
				return A.RisingSunKick:Show(icon)
			end
			-- actions.rotation_boc+=/breath_of_fire,if=buff.blackout_combo.up
			if A.BreathofFire:IsReady(player) and inRange and Unit(player):HasBuffs(A.BlackoutComboBuff.ID) > 0 then
				return A.BreathofFire:Show(icon)
			end
			-- actions.rotation_boc+=/keg_smash,if=buff.blackout_combo.up
			if A.KegSmash:IsReady(unitID) and Unit(player):HasBuffs(A.BlackoutComboBuff.ID) > 0 then
				return A.KegSmash:Show(icon)
			end
			-- actions.rotation_boc+=/exploding_keg,if=talent.exploding_keg.enabled
			if A.ExplodingKeg:IsReady(player) and inRange and not isMoving then
				return A.ExplodingKeg:Show(icon)
			end
			-- actions.rotation_boc+=/rushing_jade_wind,if=buff.rushing_jade_wind.down&talent.rushing_jade_wind.enabled
			if A.RushingJadeWind:IsReady(player) and Unit(player):HasBuffs(A.RushingJadeWind.ID) == 0 and inRange then
				return A.RushingJadeWind:Show(icon)
			end
			-- actions.rotation_boc+=/black_ox_brew,if=energy+energy.regen*(variable.time_to_scheduled_ks+execute_time)>=65&talent.black_ox_brew.enabled
			if A.BlackOxBrew:IsReady(player) and Player:Energy() + Player:EnergyRenge() * (timetoScheduledKS) >= 65 then
				return A.BlackOxBrew:Show(icon)
			end
			-- actions.rotation_boc+=/keg_smash,if=cooldown.keg_smash.charges_fractional>1.5
			if A.KegSmash:IsReady(unitID) and (A.KegSmash:GetSpellChargesFrac() > 1.5 or A.KegSmash:GetSpellChargesMax() == 1) then
				return A.KegSmash:Show(icon)
			end
			-- actions.rotation_boc+=/spinning_crane_kick,if=energy+energy.regen*(variable.time_to_scheduled_ks+execute_time)>=65&active_enemies>1
			if A.SpinningCraneKick:IsReady(player) and Player:Energy() + Player:EnergyRegen() * (timetoScheduledKS) >= 65 and spellTargets > 1 then
				return A.SpinningCraneKick:Show(icon)
			end
			-- actions.rotation_boc+=/tiger_palm,if=energy+energy.regen*(variable.time_to_scheduled_ks+execute_time)>=65&active_enemies=1&!buff.blackout_combo.up
			if A.TigerPalm:IsReady(unitID) and Player:Energy() + Player:EnergyRegen() * (timetoScheduledKS) >= 65 and Unit(player):HasBuffs(A.BlackoutComboBuff.ID) == 0 then
				return A.TigerPalm:Show(icon)
			end
			-- actions.rotation_boc+=/celestial_brew,if=talent.celestial_brew.enabled&!buff.blackout_combo.up
			if A.CelestialBrew:IsReady(player) and Unit(player):HasBuffs(A.BlackoutComboBuff.ID) == 0 then
				return A.CelestialBrew:Show(icon)
			end
			-- actions.rotation_boc+=/chi_wave,if=talent.chi_wave.enabled
			if A.ChiWave:IsReady(unitID) then
				return A.ChiWave:Show(icon)
			end
			-- actions.rotation_boc+=/chi_burst,if=talent.chi_burst.enabled
			if A.ChiBurst:IsReady(player) and inRange then
				return A.ChiBurst:Show(icon)
			end
		end
		
		-- actions+=/call_action_list,name=rotation_fom_boc,if=variable.rotation_selection=1&((1%spell_haste-1)*100<1%3&talent.fluidity_of_motion.enabled)
		if rotationSelection == 1 and ((1 % Player:SpellHaste() -1) * 100 < 1 % 3 and A.FluidityofMotion:IsTalentLearned()) then

			-- actions.rotation_fom_boc+=/blackout_kick
			if A.BlackoutKick:IsReady(unitID) then
				return A.BlackoutKick:Show(icon)
			end
			-- actions.rotation_fom_boc+=/rising_sun_kick,if=variable.boc_count%%3=1&talent.rising_sun_kick.enabled
			if A.RisingSunKick:IsReady(unitID) and bocCount % 3 == 1 then
				return A.RisingSunKick:Show(icon)
			end
			-- actions.rotation_fom_boc+=/breath_of_fire,if=buff.blackout_combo.up&variable.boc_count%%3=1
			if A.BreathofFire:IsReady(player) and inRange and Unit(player):HasBuffs(A.BlackoutCombo.ID) > 0 and bocCount % 3 == 1 then
				return A.BreathofFire:Show(icon)
			end
			-- actions.rotation_fom_boc+=/keg_smash,if=buff.blackout_combo.up&variable.boc_count%%3=2
			if A.KegSmash:IsReady(unitID) and Unit(player):HasBuffs(A.BlackoutCombo.ID) > 0 and bocCount % 3 == 2 then
				return A.KegSmash:Show(icon)
			end
			-- actions.rotation_fom_boc+=/keg_smash,if=buff.blackout_combo.up&variable.boc_count%%3=0&cooldown.keg_smash.charges_fractional>1&cooldown.keg_smash.full_recharge_time<=variable.time_to_scheduled_ks&energy+energy.regen*(variable.time_to_scheduled_ks+execute_time)>=80
			if A.KegSmash:IsReady(unitID) and Unit(player):HasBuffs(A.BlackoutCombo.ID) > 0 and bocCount % 3 == 0 and A.KegSmash:GetSpellChargesFrac() > 1 and A.KegSmash:GetSpellChargesFullRechargeTime() <= timetoScheduledKS and Player:Energy() + Player:EnergyRegen() * (timetoScheduledKS) >= 80 then
				return A.KegSmash:Show(icon)
			end
			-- actions.rotation_fom_boc+=/cancel_buff,name=blackout_combo,if=variable.boc_count%%3=0
			
			-- actions.rotation_fom_boc+=/exploding_keg,if=talent.exploding_keg.enabled
			if A.ExplodingKeg:IsReady(player) and inRange and not isMoving then
				return A.ExplodingKeg:Show(icon)
			end
			-- actions.rotation_fom_boc+=/rushing_jade_wind,if=buff.rushing_jade_wind.down&talent.rushing_jade_wind.enabled
			if A.RushingJadeWind:IsReady(player) and Unit(player):HasBuffs(A.RushingJadeWind.ID) == 0 and inRange then
				return A.RushingJadeWind:Show(icon)
			end
			-- actions.rotation_fom_boc+=/black_ox_brew,if=energy+energy.regen*(variable.time_to_scheduled_ks+execute_time)>=65&talent.black_ox_brew.enabled
			if A.BlackOxBrew:IsReady(player) and Player:Energy() + Player:EnergyRenge() * (timetoScheduledKS) >= 65 then
				return A.BlackOxBrew:Show(icon)
			end
			-- actions.rotation_fom_boc+=/rising_sun_kick,if=talent.rising_sun_kick.enabled
			if A.RisingSunKick:IsReady(unitID) then
				return A.RisingSunKick:Show(icon)
			end
			-- actions.rotation_fom_boc+=/spinning_crane_kick,if=energy+energy.regen*(variable.time_to_scheduled_ks+execute_time)>=65&buff.charred_passions.up&active_enemies>1
			if A.SpinningCraneKick:IsReady(player) and Player:Energy() + Player:EnergyRegen() * (timetoScheduledKS) >= 65 and Unit(player):HasBuffs(A.CharredPassionsBuff.ID) > 0 and spellTargets > 1 then
				return A.SpinningCraneKick:Show(icon)
			end
			-- actions.rotation_boc+=/tiger_palm,if=energy+energy.regen*(variable.time_to_scheduled_ks+execute_time)>=65&active_enemies=1&!buff.blackout_combo.up
			if A.TigerPalm:IsReady(unitID) and Player:Energy() + Player:EnergyRegen() * (timetoScheduledKS) >= 65 and Unit(player):HasBuffs(A.BlackoutComboBuff.ID) == 0 then
				return A.TigerPalm:Show(icon)
			end
			-- actions.rotation_boc+=/celestial_brew,if=talent.celestial_brew.enabled&!buff.blackout_combo.up
			if A.CelestialBrew:IsReady(player) and Unit(player):HasBuffs(A.BlackoutComboBuff.ID) == 0 then
				return A.CelestialBrew:Show(icon)
			end
			-- actions.rotation_boc+=/chi_wave,if=talent.chi_wave.enabled
			if A.ChiWave:IsReady(unitID) then
				return A.ChiWave:Show(icon)
			end
			-- actions.rotation_boc+=/chi_burst,if=talent.chi_burst.enabled
			if A.ChiBurst:IsReady(player) and inRange then
				return A.ChiBurst:Show(icon)
			end
		end 

		-- actions+=/call_action_list,name=rotation_chp_dfb,if=variable.rotation_selection=2
		if rotationSelection == 2 then

			-- # Name: Salsalabim's Strength Charred Passions / Dragonfire Brew
			-- actions.rotation_chp_dfb=breath_of_fire,if=talent.charred_passions.enabled&buff.charred_passions.remains<1.5|talent.dragonfire_brew.enabled
			if A.BreathofFire:IsReady(player) and inRange and (A.CharredPassions:IsTalentLearned() and Unit(player):HasBuffs(A.CharredPassionsBuff.ID) < 1.5 or A.DragonfireBrew:IsTalentLearned()) then
				return A.BreathofFire:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/rushing_jade_wind,if=buff.rushing_jade_wind.down&talent.rushing_jade_wind.enabled
			if A.RushingJadeWind:IsReady(player) and inRange and Unit(player):HasBuffs(A.RushingJadeWind.ID) == 0 then
				return A.RushingJadeWind:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/blackout_kick
			if A.BlackoutKick:IsReady(unitID) then
				return A.BlackoutKick:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/keg_smash
			if A.KegSmash:IsReady(unitID) then
				return A.KegSmash:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/exploding_keg,if=talent.exploding_keg.enabled
			if A.ExplodingKeg:IsReady(player) and inRange and not isMoving then
				return A.ExplodingKeg:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/black_ox_brew,if=energy+energy.regen*(variable.time_to_scheduled_ks+execute_time)>=65&talent.black_ox_brew.enabled
			if A.BlackOxBrew:IsReady(player) and Player:Energy() + Player:EnergyRenge() * (timetoScheduledKS) >= 65 then
				return A.BlackOxBrew:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/rising_sun_kick
			if A.RisingSunKick:IsReady(unitID) then
				return A.RisingSunKick:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/spinning_crane_kick,if=energy+energy.regen*(cooldown.keg_smash.remains+execute_time)>=65&active_enemies>1
			if A.SpinningCraneKick:IsReady(player) and (Player:Energy() + Player:EnergyRegen() * (A.KegSmash:GetCooldown()) >= 65) and spellTargets > 1 then
				return A.SpinningCraneKick:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/tiger_palm,if=energy+energy.regen*(cooldown.keg_smash.remains+execute_time)>=65&active_enemies=1
			if A.TigerPalm:IsReady(unitID) and (Player:Energy() + Player:EnergyRegen() * (A.KegSmash:GetCooldown()) >= 65) then
				return A.TigerPalm:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/chi_wave,if=talent.chi_wave.enabled
			if A.ChiWave:IsReady(unitID) then
				return A.ChiWave:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/chi_burst,if=talent.chi_burst.enabled
			if A.ChiBurst:IsReady(player) and inRange then
				return A.ChiBurst:Show(icon)
			end
			-- actions.rotation_chp_dfb+=/celestial_brew
			if A.CelestialBrew:IsReady(player) and inRange then
				return A.CelestialBrew:Show(icon)
			end

		end

		-- # Fallback Rotation
		-- actions+=/call_action_list,name=rotation_fallback,if=variable.rotation_selection=3
		if rotationSelection == 3 then
			-- # Name: Fallback
			-- actions.rotation_fallback=rising_sun_kick,if=talent.rising_sun_kick.enabled
			if A.RisingSunKick:IsReady(unitID) then
				return A.RisingSunKick:Show(icon)
			end
			-- actions.rotation_fallback+=/keg_smash
			if A.KegSmash:IsReady(unitID) then
				return A.KegSmash:Show(icon)
			end
			-- actions.rotation_fallback+=/breath_of_fire,if=talent.breath_of_fire.enabled
			if A.BreathofFire:IsReady(player) and inRange then
				return A.BreathofFire:Show(icon)
			end
			-- actions.rotation_fallback+=/blackout_kick
			if A.BlackoutKick:IsReady(unitID) then
				return A.BlackoutKick:Show(icon)
			end
			-- actions.rotation_fallback+=/exploding_keg,if=talent.exploding_keg.enabled
			if A.ExplodingKeg:IsReady(player) and inRange and not isMoving then
				return A.ExplodingKeg:Show(icon)
			end
			-- actions.rotation_fallback+=/black_ox_brew,if=energy+energy.regen*(cooldown.keg_smash.remains+execute_time)>=65&talent.black_ox_brew.enabled
			if A.BlackOxBrew:IsReady(player) and Player:Energy() + Player:EnergyRenge() * (timetoScheduledKS) >= 65 then
				return A.BlackOxBrew:Show(icon)
			end
			-- actions.rotation_fallback+=/rushing_jade_wind,if=talent.rushing_jade_wind.enabled
			if A.RushingJadeWind:IsReady(player) and inRange then
				return A.RushingJadeWind:Show(icon)
			end
			-- actions.rotation_fallback+=/spinning_crane_kick,if=energy+energy.regen*(cooldown.keg_smash.remains+execute_time)>=65
			if A.SpinningCraneKick:IsReady(player) and Player:Energy() + Player:EnergyRegen() * (A.KegSmash:GetCooldown()) >= 65 and spellTargets > 1 then
				return A.SpinningCraneKick:Show(icon)
			end
			if A.TigerPalm:IsReady(unitID) and (Player:Energy() + Player:EnergyRegen() * (A.KegSmash:GetCooldown()) >= 65) then
				return A.TigerPalm:Show(icon)
			end
			-- actions.rotation_fallback+=/celestial_brew,if=!buff.blackout_combo.up&talent.celestial_brew.enabled
			if A.CelestialBrew:IsReady(player) and Unit(player):HasBuffs(A.BlackoutComboBuff.ID) == 0 and inRange then
				return A.CelestialBrew:Show(icon)
			end
			-- actions.rotation_fallback+=/chi_wave,if=talent.chi_wave.enabled
			if A.ChiWave:IsReady(unitID) then
				return A.ChiWave:Show(icon)
			end
			-- actions.rotation_fallback+=/chi_burst,if=talent.chi_burst.enabled
			if A.ChiBurst:IsReady(player) and inRange then
				return A.ChiBurst:Show(icon)
			end
		end


		
	end

    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
	local dungeonDefensive = DungeonDefensives()
    if dungeonDefensive then 
        return dungeonDefensive:Show(icon)
    end 

    if A.IsUnitEnemy("target") then 
        unitID = "target"
        if EnemyRotation(unitID) then 
            return true
        end 
    end
end

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil