--##################################
--##### TRIP'S WINDWALKER MONK #####
--##################################

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

Action[ACTION_CONST_MONK_WINDWALKER] = {
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
    TeachingsoftheMonasteryBuff= Action.Create({ Type = "Spell", ID = 202090 }),
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
    DanceofChiJiBuff   = Action.Create({ Type = "Spell", ID = 325202 }),
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
	FortifyingBrew = Action.Create({ Type = "Spell", ID = 388917 }),
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
    PowerStrikesBuff     = Action.Create({ Type = "Spell", ID = 129914 }),
    FaeExposure     = Action.Create({ Type = "Spell", ID = 395414 }),
	Healthstone     = Action.Create({ Type = "Spell", ID = 5512 }),
}

local A = setmetatable(Action[ACTION_CONST_MONK_WINDWALKER], { __index = Action })

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
	useDiffuseMagic							= { 371984 -- Ice Bolt

	},
	useDampenHarm							= {

	},
	useFortifyingBrew						= {

	},
	useZenMeditation						= {

	},
}

local function SelfDefensives()
	local HealingElixirHP = A.GetToggle(2, "HealingElixirHP")	

	if Unit(player):CombatTime() == 0 then 
        return 
    end 

	if A.CanUseHealthstoneOrHealingPotion() then
		return A.Healthstone
	end

	if A.HealingElixir:IsReady(player) and Unit(player):HealthPercent() <= HealingElixirHP then
		return A.HealingElixir
	end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        if useKick and not notInterruptable and A.SpearHandStrike:IsReady(unitID) then 
            return A.SpearHandStrike
        end
		
        if useCC and A.LegSweep:IsReady(unitID) then 
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

local function InMelee(unitID)
	-- @return boolean 
	return A.TigerPalm:IsInRange(unitID)
end 

local function ToK(unitID)


end

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
	local fightRemains = MultiUnits:GetByRangeAreaTTD(20)
    local ChiMax = Player:ChiMax()
    local Chi = Player:Chi()
    local Energy = Player:Energy()
    local EnergyDeficit = Player:EnergyDeficit()
    local EnergyMax = Player:EnergyMax()
	local spellTargets = MultiUnits:GetByRange(10, 5)
    local areaTTD = MultiUnits:GetByRangeAreaTTD(20) > 50
    local spinningCraneKickMax = MultiUnits:GetByRangeAppliedDoTs(10, 5, A.MarkoftheCrane.ID) >= (spellTargets or 5)
    local UseRacial = A.GetToggle(1, "Racial")

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unitID)

        if BurstIsON(unitID) and InMelee() then
            if A.InvokeXuentheWhiteTiger:IsReady(player) then
                return A.InvokeXuentheWhiteTiger:Show(icon)
            end
            if A.StormEarthandFire:IsReady(player) and Unit(player):HasBuffs(A.StormEarthandFire.ID) == 0 then
                return A.StormEarthandFire:Show(icon)
            end
            if A.Serenity:IsReady(player) then
                return A.Serenity:Show(icon)
            end
            if A.SummonWhiteTigerStatue:IsReady(player) and not isMoving then
                return A.SummonWhiteTigerStatue:Show(icon)
            end

        end

        if A.StormEarthandFire:IsReady(player) and InMelee() and A.StormEarthandFire:GetSpellChargesFullRechargeTime() < 1.5 and Unit(player):HasBuffs(A.StormEarthandFire.ID) == 0 then
            return A.StormEarthandFire:Show(icon)
        end

        if spellTargets >= 5 then
            if A.BonedustBrew:IsReady(player) and not isMoving then
                return A.BonedustBrew:Show(icon)
            end

            if A.TouchofDeath:IsReady(unitID) and Unit(unitID):Health() >= Unit(player):Health() / 2 then
                return A.TouchofDeath:Show(icon)
            end

            if A.ExpelHarm:IsReady(player) and Chi < 6 and EnergyDeficit <= 15 then
                return A.ExpelHarm:Show(icon)
            end

            if A.BlackoutKick:IsReady(player) and Unit(player):HasBuffsStacks(A.TeachingsoftheMonasteryBuff.ID) == 3 then
                return A.BlackoutKick:Show(icon)
            end

            if A.TigerPalm:IsReady(unitID) and Chi < 5 and EnergyDeficit <= 15 then
                return A.TigerPalm:Show(icon)
            end

            if A.FaelineStomp:IsReady(player) and A.FaelineHarmony:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FaeExposure.ID) < 1 then
                return A.FaelineStomp:Show(icon)
            end

            if A.StrikeoftheWindlord:IsReady(player) then
                return A.StrikeoftheWindlord:Show(icon)
            end

            if A.SpinningCraneKick:IsReady(player) and Unit(player):HasBuffs(A.DanceofChiJiBuff.ID) > 0 then
                return A.SpinningCraneKick:Show(icon)
            end

            if A.FistsofFury:IsReady(player) then
                return A.FistsofFury:Show(icon)
            end

            if A.WhirlingDragonPunch:IsReady(player) and not isMoving then
                return A.WhirlingDragonPunch:Show(icon)
            end

            if A.RisingSunKick:IsReady(unitID) then
                return A.RisingSunKick:Show(icon)
            end

            if A.RushingJadeWind:IsReady(player) then
                return A.RushingJadeWind:Show(icon)
            end

            if A.SpinningCraneKick:IsReady(player) then
                return A.SpinningCraneKick:Show(icon)
            end

            if A.FaelineStomp:IsReady(player) then
                return A.FaelineStomp:Show(icon)
            end

            if A.ChiBurst:IsReady(player) and not isMoving then
                return A.ChiBurst:Show(icon)
            end

            if A.ChiWave:IsReady(unitID) then
                return A.ChiWave:Show(icon)
            end
            
        end

        if spellTargets >= 2 and spellTargets <= 4 then
            if A.BonedustBrew:IsReady(player) and not isMoving then
                return A.BonedustBrew:Show(icon)
            end

            if BurstIsON(unitID) and A.InvokeXuentheWhiteTiger:IsReady(player) then
                return A.InvokeXuentheWhiteTiger:Show(icon)
            end

            if A.TouchofDeath:IsReady(unitID) and Unit(unitID):Health() >= Unit(player):Health() / 2 then
                return A.TouchofDeath:Show(icon)
            end

            if A.ExpelHarm:IsReady(player) and Chi < 6 and EnergyDeficit <= 15 then
                return A.ExpelHarm:Show(icon)
            end

            if A.BlackoutKick:IsReady(player) and Unit(player):HasBuffsStacks(A.TeachingsoftheMonasteryBuff.ID) == 3 then
                return A.BlackoutKick:Show(icon)
            end

            if A.TigerPalm:IsReady(unitID) and Chi < 5 and EnergyDeficit <= 15 then
                return A.TigerPalm:Show(icon)
            end

            if A.FaelineStomp:IsReady(player) and A.FaelineHarmony:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FaeExposure.ID) < 1 then
                return A.FaelineStomp:Show(icon)
            end

            if A.StrikeoftheWindlord:IsReady(player) then
                return A.StrikeoftheWindlord:Show(icon)
            end

            if A.SpinningCraneKick:IsReady(player) and Unit(player):HasBuffs(A.DanceofChiJiBuff.ID) > 0 then
                return A.SpinningCraneKick:Show(icon)
            end

            if A.FistsofFury:IsReady(player) then
                return A.FistsofFury:Show(icon)
            end

            if A.WhirlingDragonPunch:IsReady(player) and not isMoving then
                return A.WhirlingDragonPunch:Show(icon)
            end

            if A.SpinningCraneKick:IsReady(player) and Unit(player):HasBuffs(A.BonedustBrew.ID) > 0 then
                return A.SpinningCraneKick:Show(icon)
            end

            if A.RisingSunKick:IsReady(unitID) then
                return A.RisingSunKick:Show(icon)
            end

            if A.RushingJadeWind:IsReady(player) then
                return A.RushingJadeWind:Show(icon)
            end

            if A.SpinningCraneKick:IsReady(player) then
                return A.SpinningCraneKick:Show(icon)
            end

            if A.FaelineStomp:IsReady(player) then
                return A.FaelineStomp:Show(icon)
            end

            if A.ChiBurst:IsReady(player) and not isMoving then
                return A.ChiBurst:Show(icon)
            end

            if A.ChiWave:IsReady(unitID) then
                return A.ChiWave:Show(icon)
            end

        end

        if A.BonedustBrew:IsReady(player) and InMelee() and Unit(unitID):IsBoss() and not isMoving then
            return A.BonedustBrew:Show(icon)
        end

        if BurstIsON(unitID) and A.InvokeXuentheWhiteTiger:IsReady(player) and InMelee() then
            return A.InvokeXuentheWhiteTiger:Show(icon)
        end

        if A.TouchofDeath:IsReady(unitID) and Unit(unitID):Health() >= Unit(player):Health() / 2 then
            return A.TouchofDeath:Show(icon)
        end

        if A.ExpelHarm:IsReady(player) and Chi < 6 and EnergyDeficit <= 15 then
            return A.ExpelHarm:Show(icon)
        end

        if A.BlackoutKick:IsReady(player) and InMelee() and Unit(player):HasBuffsStacks(A.TeachingsoftheMonasteryBuff.ID) == 3 then
            return A.BlackoutKick:Show(icon)
        end

        if A.TigerPalm:IsReady(unitID) and Chi < 5 and EnergyDeficit <= 15 then
            return A.TigerPalm:Show(icon)
        end

        if A.FaelineStomp:IsReady(player) and InMelee() and A.FaelineHarmony:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FaeExposure.ID) < 1 then
            return A.FaelineStomp:Show(icon)
        end

        if A.StrikeoftheWindlord:IsReady(player) and InMelee() then
            return A.StrikeoftheWindlord:Show(icon)
        end

        if A.WhirlingDragonPunch:IsReady(player) and InMelee() and not isMoving then
            return A.WhirlingDragonPunch:Show(icon)
        end

        if A.RisingSunKick:IsReady(unitID) and Unit(player):HasBuffs(A.XuensBattlegear.ID) > 0 then
            return A.RisingSunKick:Show(icon)
        end
        
        if A.FistsofFury:IsReady(player) and InMelee() then
            return A.FistsofFury:Show(icon)
        end

        if A.RisingSunKick:IsReady(unitID) then
            return A.RisingSunKick:Show(icon)
        end        

        if A.SpinningCraneKick:IsReady(player) and InMelee() and Unit(player):HasBuffs(A.DanceofChiJiBuff.ID) > 0 then
            return A.SpinningCraneKick:Show(icon)
        end

        if A.BlackoutKick:IsReady(player) and InMelee() then
            return A.BlackoutKick:Show(icon)
        end

        if A.RushingJadeWind:IsReady(player) and Unit(unitID):GetRange() < 20 then
            return A.RushingJadeWind:Show(icon)
        end

        if A.ChiWave:IsReady(unitID) then
            return A.ChiWave:Show(icon)
        end     

        if A.FaelineStomp:IsReady(player) then
            return A.FaelineStomp:Show(icon)
        end

        if A.ChiBurst:IsReady(player) and not isMoving then
            return A.ChiBurst:Show(icon)
        end   

    end
    
    local function SimCEnemyRotation(unitID)
	
        -- actions+=/variable,name=hold_xuen,op=set,value=!talent.invoke_xuen_the_white_tiger|cooldown.invoke_xuen_the_white_tiger.remains>fight_remains|fight_remains-cooldown.invoke_xuen_the_white_tiger.remains<120&((talent.serenity&fight_remains>cooldown.serenity.remains&cooldown.serenity.remains>10)|(cooldown.storm_earth_and_fire.full_recharge_time<fight_remains&cooldown.storm_earth_and_fire.full_recharge_time>15)|(cooldown.storm_earth_and_fire.charges=0&cooldown.storm_earth_and_fire.remains<fight_remains))
        holdXuen = not A.InvokeXuentheWhiteTiger:IsTalentLearned() or A.InvokeXuentheWhiteTiger:GetCooldown() > fightRemains or fightRemains - A.InvokeXuentheWhiteTiger:GetCooldown() < 120 and ((A.Serenity:IsTalentLearned() and fightRemains > A.Serenity:GetCooldown() and A.Serenity:GetCooldown() > 10) or (A.StormEarthandFire:GetSpellChargesFullRechargeTime() < fightRemains and A.StormEarthandFire:GetSpellChargesFullRechargeTime() > 15) or (A.StormEarthandFire:GetSpellCharges() == 0 and A.StormEarthandFire:GetCooldown() < fightRemains))
        -- # Potion
        -- actions+=/potion,if=(buff.serenity.up|buff.storm_earth_and_fire.up)&pet.xuen_the_white_tiger.active|fight_remains<=60
        -- # Build Chi at the start of combat
        -- actions+=/call_action_list,name=opener,if=time<4&chi<5&!pet.xuen_the_white_tiger.active&!talent.serenity
        if combatTime < 4 and Player:Chi() < 5 and not Unit(pet):IsExists() and not A.Serenity:IsTalentLearned() then
            -- # Opener
            -- actions.opener=expel_harm,if=talent.chi_burst.enabled&chi.max-chi>=3
            if A.ExpelHarm:IsReady(player) and A.ChiBurst:IsTalentLearned() and ChiMax - Chi >= 3 then
                return A.ExpelHarm:Show(icon)
            end
            -- actions.opener+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.skyreach_exhaustion.up*20),if=combo_strike&chi.max-chi>=(2+buff.power_strikes.up)
            -- actions.opener+=/chi_wave,if=chi.max-chi=2
            if A.ChiWave:IsReady(unitID) and ChiMax - Chi == 2 then
                return A.ChiWave:Show(icon)
            end
            -- actions.opener+=/expel_harm
            if A.ExpelHarm:IsReady(player) then
                return A.ExpelHarm:Show(icon)
            end
            -- actions.opener+=/tiger_palm,if=chi.max-chi>=(2+buff.power_strikes.up)
            if A.TigerPalm:IsReady(unitID) and ChiMax - Chi >= (2 + num(Unit(player):HasBuffs(A.PowerStrikesBuff.ID) > 0)) then
                return A.TigerPalm:Show(icon)
            end

        end
        -- # Prioritize Faeline Stomp if playing with Faeline Harmony
        -- actions+=/faeline_stomp,if=combo_strike&talent.faeline_harmony&debuff.fae_exposure_damage.remains<1
        if A.FaelineStomp:IsReady(player) and InMelee() and not Player:PrevGCD(1, A.FaelineStomp:Info()) and A.FaelineHarmony:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FaeExposure.ID, true) < 1 then
            return A.FaelineStomp:Show(icon)
        end
        -- # TP if not overcapping Chi or TotM
        -- actions+=/tiger_palm,if=!buff.serenity.up&buff.teachings_of_the_monastery.stack<3&combo_strike&chi.max-chi>=(2+buff.power_strikes.up)&(!talent.invoke_xuen_the_white_tiger&!talent.serenity|(!talent.skyreach|time>5|pet.xuen_the_white_tiger.active))
        if A.TigerPalm:IsReady(unitID) and Unit(player):HasBuffs(A.Serenity.ID) == 0 and Unit(player):HasBuffsStacks(A.TeachingsoftheMonasteryBuff.ID) < 3 and not Player:PrevGCD(1, A.TigerPalm:Info()) and ChiMax - Chi >= (2 + num(Unit(player):HasBuffs(A.PowerStrikesBuff.ID) > 0)) and (not A.InvokeXuentheWhiteTiger:IsTalentLearned() and not A.Serenity:IsTalentLearned() or (not A.Skyreach:IsTalentLearned() or combatTime > 5 or Unit(pet):IsExists())) then
            return A.TigerPalm:Show(icon)
        end        
        -- actions+=/chi_burst,if=talent.faeline_stomp&cooldown.faeline_stomp.remains&(chi.max-chi>=1&active_enemies=1|chi.max-chi>=2&active_enemies>=2)
        if A.ChiBurst:IsReady(player) and A.FaelineStomp:IsTalentLearned() and A.FaelineStomp:GetCooldown() > 0 and ( (ChiMax - Chi >= 1 and spellTargets == 1) or (ChiMax - Chi >= 2 and spellTargets >= 2) ) then
            return A.ChiBurst:Show(icon)
        end
        -- # Cooldowns
        if BurstIsON(unitID) and areaTTD then
            -- actions+=/call_action_list,name=cd_sef,if=!talent.serenity
            if not A.Serenity:IsTalentLearned() then
                -- # Storm, Earth and Fire Cooldowns
                -- actions.cd_sef=summon_white_tiger_statue,if=pet.xuen_the_white_tiger.active
                if A.SummonWhiteTigerStatue:IsReady(player) and Unit(pet):IsExists() then
                    return A.SummonWhiteTigerStatue:Show(icon)
                end
                -- actions.cd_sef+=/invoke_xuen_the_white_tiger,if=!variable.hold_xuen&talent.bonedust_brew&cooldown.bonedust_brew.remains<=5&(active_enemies<3&chi>=3|active_enemies>=3&chi>=2)|fight_remains<25
                if A.InvokeXuentheWhiteTiger:IsReady(player) then
                    if not holdXuen and A.BonedustBrew:IsTalentLearned() and A.BonedustBrew:GetCooldown() <= 5 and (spellTargets < 3 and Chi >= 3 or spellTargets >= 3 and Chi >= 2) or fightRemains < 25 then
                        return A.InvokeXuentheWhiteTiger:Show(icon)
                    end
                end
                -- actions.cd_sef+=/invoke_xuen_the_white_tiger,if=!variable.hold_xuen&!talent.bonedust_brew&(cooldown.rising_sun_kick.remains<2)&chi>=3
                if A.InvokeXuentheWhiteTiger:IsReady(player) and not HoldXuen and not A.BonedustBrew:IsTalentLearned() and A.RisingSunKick:GetCooldown() < 2 and Chi >= 3 then
                    return A.InvokeXuentheWhiteTiger:Show(icon)
                end
                -- actions.cd_sef+=/storm_earth_and_fire,if=talent.bonedust_brew&(fight_remains<30&cooldown.bonedust_brew.remains<4&chi>=4|buff.bonedust_brew.up|!spinning_crane_kick.max&active_enemies>=3&cooldown.bonedust_brew.remains<=2&chi>=2)&(pet.xuen_the_white_tiger.active|cooldown.invoke_xuen_the_white_tiger.remains>cooldown.storm_earth_and_fire.full_recharge_time)
                if A.StormEarthandFire:IsReady(player) and A.BonedustBrew:IsTalentLearned() and ((fightRemains < 30 and A.BonedustBrew:GetCooldown() < 4 and Chi >= 4) or Unit(player):HasBuffs(A.BonedustBrew.ID) > 0 or (not spinningCraneKickMax and spellTargets >= 3 and A.BonedustBrew:GetCooldown() <= 2 and Chi >= 2)) and (Unit(pet):IsExists() or A.InvokeXuentheWhiteTiger:GetCooldown() >= A.StormEarthandFire:GetSpellChargesFullRechargeTime()) then
                    return A.StormEarthandFire:Show(icon)
                end
                -- actions.cd_sef+=/bonedust_brew,if=(!buff.bonedust_brew.up&buff.storm_earth_and_fire.up&buff.storm_earth_and_fire.remains<11&spinning_crane_kick.max)|(!buff.bonedust_brew.up&fight_remains<30&fight_remains>10&spinning_crane_kick.max&chi>=4)|fight_remains<10
                if A.BonedustBrew:IsReady(player) and ((Unit(player):HasBuffs(A.BonedustBrew.ID) == 0 and Unit(player):HasBuffs(A.StormEarthandFire.ID) > 0 and Unit(player):HasBuffs(A.StormEarthandFire.ID) < 11 and spinningCraneKickMax) or (Unit(player):HasBuffs(A.BonedustBrew.ID) == 0 and fightRemains < 30 and fightRemains > 10 and spinningCraneKickMax and Chi >= 4) or fightRemains < 10) then
                    return A.BonedustBrew:Show(icon)
                end
                -- actions.cd_sef+=/call_action_list,name=bdb_setup,if=!buff.bonedust_brew.up&talent.bonedust_brew&cooldown.bonedust_brew.remains<=2&(fight_remains>60&(cooldown.storm_earth_and_fire.charges>0|cooldown.storm_earth_and_fire.remains>10)&(pet.xuen_the_white_tiger.active|cooldown.invoke_xuen_the_white_tiger.remains>10|variable.hold_xuen)|((pet.xuen_the_white_tiger.active|cooldown.invoke_xuen_the_white_tiger.remains>13)&(cooldown.storm_earth_and_fire.charges>0|cooldown.storm_earth_and_fire.remains>13|buff.storm_earth_and_fire.up)))
                if Unit(player):HasBuffs(A.BonedustBrew.ID) == 0 and A.BonedustBrew:IsTalentLearned() and A.BonedustBrew:GetCooldown() <= 2 
                and ((fightRemains > 60 and (A.StormEarthandFire:GetSpellCharges() > 0 or A.StormEarthandFire:GetCooldown() > 10) and (Unit(pet):IsExists() or A.InvokeXuentheWhiteTiger:GetCooldown() > 10 or holdXuen)) or ((Unit(pet):IsExists() or A.InvokeXuentheWhiteTiger:GetCooldown() > 13) and (A.StormEarthandFire:GetSpellCharges() > 0 or A.StormEarthandFire:GetCooldown() > 13 or Unit(player):HasBuffs(A.StormEarthandFire.ID) > 0))) then

                    -- # Bonedust Brew Setup
                    -- actions.bdb_setup=bonedust_brew,if=spinning_crane_kick.max&chi>=4
                    if A.BonedustBrew:IsReady(player) and spinningCraneKickMax and Chi >= 4 then
                        return A.BonedustBrew:Show(icon)
                    end
                    -- actions.bdb_setup+=/blackout_kick,if=combo_strike&!talent.whirling_dragon_punch
                    if A.BlackoutKick:IsReady(unitID) and not Player:PrevGCD(1, A.BlackoutKick:Info()) and not A.WhirlingDragonPunch:IsTalentLearned() then
                        return A.BlackoutKick:Show(icon)
                    end
                    -- actions.bdb_setup+=/rising_sun_kick,if=combo_strike&chi>=5
                    if A.RisingSunKick:IsReady(unitID) and not Player:PrevGCD(1, A.RisingSunKick:Info()) and Chi >= 5 then
                        return A.RisingSunKick:Show(icon)
                    end
                    -- actions.bdb_setup+=/tiger_palm,if=combo_strike&chi.max-chi>=2
                    if A.TigerPalm:IsReady(unitID) and not Player:PrevGCD(1, A.RisingSunKick:Info()) and (ChiMax-Chi >= 2) then
                        return A.TigerPalm:Show(icon)
                    end
                    -- actions.bdb_setup+=/rising_sun_kick,if=combo_strike&active_enemies>=2
                    if A.RisingSunKick:IsReady(unitID) and not Player:PrevGCD(1, A.RisingSunKick:Info()) and spellTargets >= 2 then
                        return A.RisingSunKick:Show(icon)
                    end
                end

                -- actions.cd_sef+=/storm_earth_and_fire,if=fight_remains<20|(cooldown.storm_earth_and_fire.charges=2&cooldown.invoke_xuen_the_white_tiger.remains>cooldown.storm_earth_and_fire.full_recharge_time)&cooldown.fists_of_fury.remains<=9&chi>=2&cooldown.whirling_dragon_punch.remains<=12
                if A.StormEarthandFire:IsReady(player) and InMelee() and (fightRemains < 20 or (A.StormEarthandFire:GetSpellCharges() == 2 and A.InvokeXuentheWhiteTiger:GetCooldown() > A.StormEarthandFire:GetSpellChargesFullRechargeTime()) and A.FistsofFury:GetCooldown() <= 9 and Chi >= 2 and A.WhirlingDragonPunch:GetCooldown() <= 12) then
                    return A.StormEarthandFire:Show(icon)
                end                
                -- actions.cd_sef+=/touch_of_death,cycle_targets=1,if=combo_strike
                if A.TouchofDeath:IsReady(unitID) and Unit(unitID):Health() >= Unit(player):Health() / 2 and not Player:PrevGCD(1, A.TouchofDeath:Info()) then
                    return A.TouchofDeath:Show(icon)
                end
                -- actions.cd_sef+=/use_item,name=windscar_whetstone,if=cooldown.invoke_xuen_the_white_tiger.remains>cooldown%%120|cooldown<=60&variable.hold_xuen|!talent.invoke_xuen_the_white_tiger|fight_remains<6
                -- actions.cd_sef+=/use_item,name=manic_grieftorch,if=!pet.xuen_the_white_tiger.active&!buff.serenity.up|fight_remains<5
                -- actions.cd_sef+=/touch_of_karma,target_if=max:target.time_to_die,if=fight_remains>90|pet.xuen_the_white_tiger.active|variable.hold_xuen|fight_remains<16
                local useToK = ToK()
                if useToK then
                    return useToK:Show(icon)
                end
                if UseRacial and InMelee() then
                    -- actions.cd_sef+=/blood_fury,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<20
                    if A.BloodFury:IsReady(player) and (A.InvokeXuentheWhiteTiger:GetCooldown() > 30 or holdXuen or fightRemains < 20) then
                        return A.BloodFury:Show(icon)
                    end
                    -- actions.cd_sef+=/berserking,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<15
                    if A.Berserking:IsReady(player) and (A.InvokeXuentheWhiteTiger:GetCooldown() > 30 or holdXuen or fightRemains < 15) then
                        return A.Berserking:Show(icon)
                    end
                    -- actions.cd_sef+=/lights_judgment
                    if A.LightsJudgment:IsReady(unitID) then
                        return A.LightsJudgment:Show(icon)
                    end
                    -- actions.cd_sef+=/fireblood,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<10
                    if A.Fireblood:IsReady(player) and (A.InvokeXuentheWhiteTiger:GetCooldown() > 30 or holdXuen or fightRemains < 10) then
                        return A.Fireblood:Show(icon)
                    end
                    -- actions.cd_sef+=/ancestral_call,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<20
                    if A.AncestralCall:IsReady(player) and (A.InvokeXuentheWhiteTiger:GetCooldown() > 30 or holdXuen or fightRemains < 20) then
                        return A.AncestralCall:Show(icon)
                    end
                    -- actions.cd_sef+=/bag_of_tricks,if=buff.storm_earth_and_fire.down
                    if A.BagofTricks:IsReady(player) and Unit(player):HasBuffs(A.StormEarthandFire.ID) == 0 then
                        return A.BagofTricks:Show(icon)
                    end
                end
            elseif A.Serenity:IsTalentLearned() then
                -- # Serenity Cooldowns
                -- actions.cd_serenity=summon_white_tiger_statue,if=pet.xuen_the_white_tiger.active
                if A.SummonWhiteTigerStatue:IsReady(player) and InMelee() and Unit(pet):IsExists() then
                    return A.SummonWhiteTigerStatue:Show(icon)
                end
                -- actions.cd_serenity+=/invoke_xuen_the_white_tiger,if=!variable.hold_xuen&talent.bonedust_brew&cooldown.bonedust_brew.remains<=5|fight_remains<25
                if A.InvokeXuentheWhiteTiger:IsReady(player) and InMelee() and (not holdXuen and A.BonedustBrew:IsTalentLearned() and A.BonedustBrew:GetCooldown() <= 5 or fightRemains < 25) then
                    return A.InvokeXuentheWhiteTiger:Show(icon)
                end
                -- actions.cd_serenity+=/invoke_xuen_the_white_tiger,if=!variable.hold_xuen&!talent.bonedust_brew&(cooldown.rising_sun_kick.remains<2)|fight_remains<25
                if A.InvokeXuentheWhiteTiger:IsReady(player) and InMelee() and (not holdXuen and not A.BonedustBrew:IsTalentLearned() and A.RisingSunKick:GetCooldown() < 2 or fightRemains < 25) then
                    return A.InvokeXuentheWhiteTiger:Show(icon)
                end
                -- actions.cd_serenity+=/bonedust_brew,if=!buff.bonedust_brew.up&(cooldown.serenity.up|cooldown.serenity.remains>15|fight_remains<30&fight_remains>10)|fight_remains<10
                if A.BonedustBrew:IsReady(player) and InMelee() and (Unit(player):HasBuffs(A.BonedustBrew.ID) == 0 and (A.Serenity:GetCooldown() == 0 or A.Serenity:GetCooldown() > 15 or fightRemains < 30 and fightRemains > 10) or fightRemains < 10) then
                    return A.BonedustBrew:Show(icon)
                end
                -- actions.cd_serenity+=/serenity,if=pet.xuen_the_white_tiger.active|cooldown.invoke_xuen_the_white_tiger.remains>10|!talent.invoke_xuen_the_white_tiger|fight_remains<15
                
                -- actions.cd_serenity+=/touch_of_death,cycle_targets=1,if=combo_strike
                -- actions.cd_serenity+=/touch_of_karma,if=fight_remains>90|fight_remains<10
                -- actions.cd_serenity+=/blood_fury,if=buff.serenity.up|fight_remains<20
                -- actions.cd_serenity+=/berserking,if=buff.serenity.up|fight_remains<20
                -- actions.cd_serenity+=/lights_judgment
                -- actions.cd_serenity+=/fireblood,if=buff.serenity.up|fight_remains<20
                -- actions.cd_serenity+=/ancestral_call,if=buff.serenity.up|fight_remains<20
                -- actions.cd_serenity+=/bag_of_tricks,if=buff.serenity.up|fight_remains<20
                -- actions.cd_serenity+=/use_item,name=windscar_whetstone,if=cooldown.invoke_xuen_the_white_tiger.remains>cooldown%%120|cooldown<=60&variable.hold_xuen|!talent.invoke_xuen_the_white_tiger|fight_remains<6
                -- actions.cd_serenity+=/use_item,name=manic_grieftorch,if=!pet.xuen_the_white_tiger.active&!buff.serenity.up|fight_remains<5
            end
        end


            -- # Serenity / Default Priority
        -- actions+=/call_action_list,name=serenity,if=buff.serenity.up
        -- actions+=/call_action_list,name=aoe,if=active_enemies>=3
        -- actions+=/call_action_list,name=st_cleave,if=active_enemies<3
        -- actions+=/call_action_list,name=fallthru
        
        -- # AoE Priority (3+ Targets)
        -- actions.aoe=spinning_crane_kick,if=combo_strike&buff.dance_of_chiji.up&active_enemies>3
        -- actions.aoe+=/strike_of_the_windlord,if=talent.thunderfist&active_enemies>3
        -- actions.aoe+=/whirling_dragon_punch,if=active_enemies>8
        -- actions.aoe+=/spinning_crane_kick,if=buff.bonedust_brew.up&combo_strike&active_enemies>5&spinning_crane_kick.modifier>=3.2
        -- actions.aoe+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=buff.teachings_of_the_monastery.stack=3&talent.shadowboxing_treads
        -- actions.aoe+=/spinning_crane_kick,if=combo_strike&buff.dance_of_chiji.up
        -- actions.aoe+=/strike_of_the_windlord,if=talent.thunderfist
        -- actions.aoe+=/whirling_dragon_punch,if=active_enemies>5
        -- actions.aoe+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=buff.teachings_of_the_monastery.up&(buff.teachings_of_the_monastery.stack=2|active_enemies<5)&talent.shadowboxing_treads
        -- actions.aoe+=/whirling_dragon_punch
        -- actions.aoe+=/spinning_crane_kick,if=buff.bonedust_brew.up&combo_strike
        -- actions.aoe+=/fists_of_fury,if=active_enemies>3
        -- actions.aoe+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=buff.teachings_of_the_monastery.stack=3
        -- actions.aoe+=/rushing_jade_wind,if=!buff.rushing_jade_wind.up&active_enemies>3
        -- actions.aoe+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=buff.teachings_of_the_monastery.up&active_enemies>=5&talent.shadowboxing_treads
        -- actions.aoe+=/spinning_crane_kick,if=combo_strike&(active_enemies>=7|active_enemies=6&spinning_crane_kick.modifier>=2.7|active_enemies=5&spinning_crane_kick.modifier>=2.9)
        -- actions.aoe+=/strike_of_the_windlord
        -- actions.aoe+=/spinning_crane_kick,if=combo_strike&active_enemies>=5|active_enemies=4&spinning_crane_kick.modifier>=2.5|!talent.shadowboxing_treads
        -- actions.aoe+=/fists_of_fury
        -- actions.aoe+=/faeline_stomp,if=combo_strike
        -- actions.aoe+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike
        -- actions.aoe+=/rushing_jade_wind,if=!buff.rushing_jade_wind.up
        -- actions.aoe+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
        -- actions.aoe+=/whirling_dragon_punch
    
        
        -- # Fallthru
        -- actions.fallthru=crackling_jade_lightning,if=buff.the_emperors_capacitor.stack>19&energy.time_to_max>execute_time-1&cooldown.rising_sun_kick.remains>execute_time|buff.the_emperors_capacitor.stack>14&(cooldown.serenity.remains<5&talent.serenity|fight_remains<5)
        -- actions.fallthru+=/faeline_stomp,if=combo_strike
        -- actions.fallthru+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.skyreach_exhaustion.up*20),if=combo_strike&chi.max-chi>=(2+buff.power_strikes.up)
        -- actions.fallthru+=/expel_harm,if=chi.max-chi>=1&active_enemies>2
        -- actions.fallthru+=/chi_burst,if=chi.max-chi>=1&active_enemies=1&raid_event.adds.in>20|chi.max-chi>=2&active_enemies>=2
        -- actions.fallthru+=/chi_wave
        -- actions.fallthru+=/expel_harm,if=chi.max-chi>=1
        -- actions.fallthru+=/spinning_crane_kick,if=combo_strike&buff.chi_energy.stack>30-5*active_enemies&buff.storm_earth_and_fire.down&(cooldown.rising_sun_kick.remains>2&cooldown.fists_of_fury.remains>2|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>3|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>4|chi.max-chi<=1&energy.time_to_max<2)|buff.chi_energy.stack>10&fight_remains<7
        -- actions.fallthru+=/arcane_torrent,if=chi.max-chi>=1
        -- actions.fallthru+=/flying_serpent_kick,interrupt=1
        -- actions.fallthru+=/tiger_palm
        

        
        -- # Serenity Priority
        -- actions.serenity=strike_of_the_windlord,if=active_enemies<3
        -- actions.serenity+=/fists_of_fury,if=buff.serenity.remains<1
        -- actions.serenity+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&buff.teachings_of_the_monastery.stack=3&buff.teachings_of_the_monastery.remains<1
        -- actions.serenity+=/fists_of_fury_cancel
        -- actions.serenity+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&active_enemies=3&buff.teachings_of_the_monastery.stack=2
        -- actions.serenity+=/spinning_crane_kick,if=combo_strike&(active_enemies>3|active_enemies>2&spinning_crane_kick.modifier>=2.3)
        -- actions.serenity+=/strike_of_the_windlord,if=active_enemies>=3
        -- actions.serenity+=/spinning_crane_kick,if=combo_strike&active_enemies>1
        -- actions.serenity+=/whirling_dragon_punch,if=active_enemies>1
        -- actions.serenity+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=active_enemies>=3&cooldown.fists_of_fury.remains&talent.shadowboxing_treads
        -- actions.serenity+=/rushing_jade_wind,if=!buff.rushing_jade_wind.up&active_enemies>=3
        -- actions.serenity+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
        -- actions.serenity+=/spinning_crane_kick,if=combo_strike&buff.dance_of_chiji.up
        -- actions.serenity+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike
        -- actions.serenity+=/whirling_dragon_punch
        -- actions.serenity+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=talent.teachings_of_the_monastery&buff.teachings_of_the_monastery.stack<3
        
        -- # ST Priority (<3 Targets)
        -- actions.st_cleave=blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=buff.teachings_of_the_monastery.stack=3&talent.shadowboxing_treads
        -- actions.st_cleave+=/spinning_crane_kick,if=combo_strike&buff.dance_of_chiji.up
        -- actions.st_cleave+=/strike_of_the_windlord,if=talent.thunderfist
        -- actions.st_cleave+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=active_enemies=1&buff.kicks_of_flowing_momentum.up|buff.pressure_point.up
        -- actions.st_cleave+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=buff.teachings_of_the_monastery.stack=2&talent.shadowboxing_treads
        -- actions.st_cleave+=/strike_of_the_windlord
        -- actions.st_cleave+=/fists_of_fury
        -- actions.st_cleave+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=buff.teachings_of_the_monastery.up&(talent.shadowboxing_treads&active_enemies>1|cooldown.rising_sun_kick.remains>1)
        -- actions.st_cleave+=/whirling_dragon_punch,if=active_enemies=2
        -- actions.st_cleave+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=buff.teachings_of_the_monastery.stack=3
        -- actions.st_cleave+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(active_enemies=1|!talent.shadowboxing_treads)&cooldown.fists_of_fury.remains>4&talent.xuens_battlegear
        -- actions.st_cleave+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&active_enemies=2&cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains
        -- actions.st_cleave+=/rushing_jade_wind,if=!buff.rushing_jade_wind.up&active_enemies=2
        -- actions.st_cleave+=/spinning_crane_kick,if=buff.bonedust_brew.up&combo_strike&(active_enemies>1|spinning_crane_kick.modifier>=2.7)
        -- actions.st_cleave+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
        -- actions.st_cleave+=/whirling_dragon_punch
        -- actions.st_cleave+=/rushing_jade_wind,if=!buff.rushing_jade_wind.up
        -- actions.st_cleave+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike
        
    end

    -- End on EnemyRotation()

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