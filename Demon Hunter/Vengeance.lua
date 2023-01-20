--#########################################
--##### TRIP'S VENGEANCE DEMON HUNTER #####
--#########################################

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

Action[ACTION_CONST_DEMONHUNTER_VENGEANCE] = {
	--Racial 
    ArcaneTorrent				= Action.Create({ Type = "Spell", ID = 50613	}),
    Shadowmeld   				= Action.Create({ Type = "Spell", ID = 58984    }),	

    ChaosNova      = Action.Create({ Type = "Spell", ID = 179057 }),
    DisruptingFury = Action.Create({ Type = "Spell", ID = 183782 }),
    Netherwalk     = Action.Create({ Type = "Spell", ID = 196555 }),
    Darkness       = Action.Create({ Type = "Spell", ID = 196718 }),
    EyeBeam        = Action.Create({ Type = "Spell", ID = 198013 }),
    VengefulRetreat= Action.Create({ Type = "Spell", ID = 198793 }),
    SigilofSilence = Action.Create({ Type = "Spell", ID = 202137 }),
    SigilofChains  = Action.Create({ Type = "Spell", ID = 202138 }),
    BlindFury      = Action.Create({ Type = "Spell", ID = 203550 }),
    DemonBlades    = Action.Create({ Type = "Spell", ID = 203555 }),
    FieryBrand     = Action.Create({ Type = "Spell", ID = 204021 }),
    FieryBrandDebuff = Action.Create({ Type = "Spell", ID = 207771 }),
    SigilofFlame   = Action.Create({ Type = "Spell", ID = 204596 }),
    SoulRending    = Action.Create({ Type = "Spell", ID = 204909 }),
    DesperateInstincts= Action.Create({ Type = "Spell", ID = 205411 }),
    FirstBlood     = Action.Create({ Type = "Spell", ID = 206416 }),
    Momentum       = Action.Create({ Type = "Spell", ID = 206476 }),
    UnleashedPower = Action.Create({ Type = "Spell", ID = 206477 }),
    DemonicAppetite= Action.Create({ Type = "Spell", ID = 206478 }),
    AuraofPain     = Action.Create({ Type = "Spell", ID = 207347 }),
    Painbringer    = Action.Create({ Type = "Spell", ID = 207387 }),
    SoulCarver     = Action.Create({ Type = "Spell", ID = 207407 }),
    AgonizingFlames= Action.Create({ Type = "Spell", ID = 207548 }),
    ConcentratedSigils= Action.Create({ Type = "Spell", ID = 207666 }),
    SigilofMisery  = Action.Create({ Type = "Spell", ID = 207684 }),
    FeastofSouls   = Action.Create({ Type = "Spell", ID = 207697 }),
    BurningAlive   = Action.Create({ Type = "Spell", ID = 207739 }),
    LastResort     = Action.Create({ Type = "Spell", ID = 209258 }),
    QuickenedSigils= Action.Create({ Type = "Spell", ID = 209281 }),
    FelEruption    = Action.Create({ Type = "Spell", ID = 211881 }),
    FelDevastation = Action.Create({ Type = "Spell", ID = 212084 }),
    CharredWarblades= Action.Create({ Type = "Spell", ID = 213010 }),
    Demonic        = Action.Create({ Type = "Spell", ID = 213410 }),
    Imprison       = Action.Create({ Type = "Spell", ID = 217832 }),
    FeedtheDemon   = Action.Create({ Type = "Spell", ID = 218612 }),
    Fallout        = Action.Create({ Type = "Spell", ID = 227174 }),
    Felblade       = Action.Create({ Type = "Spell", ID = 232893 }),
    FirstoftheIllidari= Action.Create({ Type = "Spell", ID = 235893 }),
    SpiritBomb     = Action.Create({ Type = "Spell", ID = 247454 }),
    EssenceBreak   = Action.Create({ Type = "Spell", ID = 258860 }),
    InsatiableHunger= Action.Create({ Type = "Spell", ID = 258876 }),
    TrailofRuin    = Action.Create({ Type = "Spell", ID = 258881 }),
    CycleofHatred  = Action.Create({ Type = "Spell", ID = 258887 }),
    FelBarrage     = Action.Create({ Type = "Spell", ID = 258925 }),
    Fracture       = Action.Create({ Type = "Spell", ID = 263642 }),
    SoulBarrier    = Action.Create({ Type = "Spell", ID = 263648 }),
    VoidReaver     = Action.Create({ Type = "Spell", ID = 268175 }),
    ConsumeMagic   = Action.Create({ Type = "Spell", ID = 278326 }),
    SwallowedAnger = Action.Create({ Type = "Spell", ID = 320313 }),
    InfernalArmor  = Action.Create({ Type = "Spell", ID = 320331 }),
    BulkExtraction = Action.Create({ Type = "Spell", ID = 320341 }),
    ImprovedDisrupt= Action.Create({ Type = "Spell", ID = 320361 }),
    BurningHatred  = Action.Create({ Type = "Spell", ID = 320374 }),
    BouncingGlaives= Action.Create({ Type = "Spell", ID = 320386 }),
    PerfectlyBalancedGlaive= Action.Create({ Type = "Spell", ID = 320387 }),
    ChaosFragments = Action.Create({ Type = "Spell", ID = 320412 }),
    CriticalChaos  = Action.Create({ Type = "Spell", ID = 320413 }),
    LooksCanKill   = Action.Create({ Type = "Spell", ID = 320415 }),
    BlazingPath    = Action.Create({ Type = "Spell", ID = 320416 }),
    ImprovedSigilofMisery= Action.Create({ Type = "Spell", ID = 320418 }),
    RushofChaos    = Action.Create({ Type = "Spell", ID = 320421 }),
    VengefulBonds  = Action.Create({ Type = "Spell", ID = 320635 }),
    Pursuit        = Action.Create({ Type = "Spell", ID = 320654 }),
    UnrestrainedFury= Action.Create({ Type = "Spell", ID = 320770 }),
    DeflectingSpikes= Action.Create({ Type = "Spell", ID = 321028 }),
    RuinousBulwark = Action.Create({ Type = "Spell", ID = 326853 }),
    MortalDance    = Action.Create({ Type = "Spell", ID = 328725 }),
    CharredFlesh   = Action.Create({ Type = "Spell", ID = 336639 }),
    GlaiveTempest  = Action.Create({ Type = "Spell", ID = 342817 }),
    RevelinPain    = Action.Create({ Type = "Spell", ID = 343014 }),
    ImprovedFelRush= Action.Create({ Type = "Spell", ID = 343017 }),
    ImprovedChaosStrike= Action.Create({ Type = "Spell", ID = 343206 }),
    FocusedCleave  = Action.Create({ Type = "Spell", ID = 343207 }),
    FuriousGaze    = Action.Create({ Type = "Spell", ID = 343311 }),
    UnboundChaos   = Action.Create({ Type = "Spell", ID = 347461 }),
    TheHunt        = Action.Create({ Type = "Spell", ID = 370965 }),
    Soulrend       = Action.Create({ Type = "Spell", ID = 388106 }),
    Ragefire       = Action.Create({ Type = "Spell", ID = 388107 }),
    Initiative     = Action.Create({ Type = "Spell", ID = 388108 }),
    FelfireHeart   = Action.Create({ Type = "Spell", ID = 388109 }),
    MiseryinDefeat = Action.Create({ Type = "Spell", ID = 388110 }),
    DemonMuzzle    = Action.Create({ Type = "Spell", ID = 388111 }),
    ChaoticTransformation= Action.Create({ Type = "Spell", ID = 388112 }),
    IsolatedPrey   = Action.Create({ Type = "Spell", ID = 388113 }),
    AnyMeansNecessary= Action.Create({ Type = "Spell", ID = 388114 }),
    ShatteredDestiny= Action.Create({ Type = "Spell", ID = 388116 }),
    KnowYourEnemy  = Action.Create({ Type = "Spell", ID = 388118 }),
    FieryDemise    = Action.Create({ Type = "Spell", ID = 389220 }),
    ChaosTheory    = Action.Create({ Type = "Spell", ID = 389687 }),
    TacticalRetreat= Action.Create({ Type = "Spell", ID = 389688 }),
    InnerDemon     = Action.Create({ Type = "Spell", ID = 389693 }),
    FlamesofFury   = Action.Create({ Type = "Spell", ID = 389694 }),
    WilloftheIllidari= Action.Create({ Type = "Spell", ID = 389695 }),
    IllidariKnowledge= Action.Create({ Type = "Spell", ID = 389696 }),
    ExtendedSigils = Action.Create({ Type = "Spell", ID = 389697 }),
    FelFlameFortification= Action.Create({ Type = "Spell", ID = 389705 }),
    DarkglareBoon  = Action.Create({ Type = "Spell", ID = 389708 }),
    Soulmonger     = Action.Create({ Type = "Spell", ID = 389711 }),
    ChainsofAnger  = Action.Create({ Type = "Spell", ID = 389715 }),
    CycleofBinding = Action.Create({ Type = "Spell", ID = 389718 }),
    CalcifiedSpikes= Action.Create({ Type = "Spell", ID = 389720 }),
    ExtendedSpikes = Action.Create({ Type = "Spell", ID = 389721 }),
    MeteoricStrikes= Action.Create({ Type = "Spell", ID = 389724 }),
    Retaliation    = Action.Create({ Type = "Spell", ID = 389729 }),
    DowninFlames   = Action.Create({ Type = "Spell", ID = 389732 }),
    MasteroftheGlaive= Action.Create({ Type = "Spell", ID = 389763 }),
    LongNight      = Action.Create({ Type = "Spell", ID = 389781 }),
    PitchBlack     = Action.Create({ Type = "Spell", ID = 389783 }),
    PreciseSigils  = Action.Create({ Type = "Spell", ID = 389799 }),
    UnnaturalMalice= Action.Create({ Type = "Spell", ID = 389811 }),
    RelentlessPursuit= Action.Create({ Type = "Spell", ID = 389819 }),
    ShatteredRestoration= Action.Create({ Type = "Spell", ID = 389824 }),
    FelfireHaste   = Action.Create({ Type = "Spell", ID = 389846 }),
    LostinDarkness = Action.Create({ Type = "Spell", ID = 389849 }),
    Frailty        = Action.Create({ Type = "Spell", ID = 389958 }),
    FrailtyDebuff  = Action.Create({ Type = "Spell", ID = 247456 }),
    Vulnerability  = Action.Create({ Type = "Spell", ID = 389976 }),
    RelentlessOnslaught= Action.Create({ Type = "Spell", ID = 389977 }),
    DancingwithFate= Action.Create({ Type = "Spell", ID = 389978 }),
    Soulcrush      = Action.Create({ Type = "Spell", ID = 389985 }),
    ShearFury      = Action.Create({ Type = "Spell", ID = 389997 }),
    RestlessHunter = Action.Create({ Type = "Spell", ID = 390142 }),
    CollectiveAnguish= Action.Create({ Type = "Spell", ID = 390152 }),
    SerratedGlaive = Action.Create({ Type = "Spell", ID = 390154 }),
    GrowingInferno = Action.Create({ Type = "Spell", ID = 390158 }),
    ElysianDecree  = Action.Create({ Type = "Spell", ID = 390163 }),
    BurningBlood   = Action.Create({ Type = "Spell", ID = 390213 }),
    VolatileFlameblood= Action.Create({ Type = "Spell", ID = 390808 }),
    SoulFurnace    = Action.Create({ Type = "Spell", ID = 391165 }),
    RoaringFire    = Action.Create({ Type = "Spell", ID = 391178 }),
    BurningWound   = Action.Create({ Type = "Spell", ID = 391189 }),
    AcceleratingBlade= Action.Create({ Type = "Spell", ID = 391275 }),
    ErraticFelheart= Action.Create({ Type = "Spell", ID = 391397 }),
    AldrachiDesign = Action.Create({ Type = "Spell", ID = 391409 }),
    FoddertotheFlame= Action.Create({ Type = "Spell", ID = 391429 }),
    FuriousThrows  = Action.Create({ Type = "Spell", ID = 393029 }),
    InternalStruggle= Action.Create({ Type = "Spell", ID = 393822 }),
    StoketheFlames = Action.Create({ Type = "Spell", ID = 393827 }),
    SoulSigils     = Action.Create({ Type = "Spell", ID = 395446 }),
    Glide          = Action.Create({ Type = "Spell", ID = 131347 }),
    DemonsBite     = Action.Create({ Type = "Spell", ID = 162243 }),
    ChaosStrike    = Action.Create({ Type = "Spell", ID = 162794 }),
    Disrupt        = Action.Create({ Type = "Spell", ID = 183752 }),
    ThrowGlaive    = Action.Create({ Type = "Spell", ID = 185123 }),
    Torment        = Action.Create({ Type = "Spell", ID = 185245 }),
    Metamorphosis  = Action.Create({ Type = "Spell", ID = 187827 }),
    BladeDance     = Action.Create({ Type = "Spell", ID = 188499 }),
    SpectralSight  = Action.Create({ Type = "Spell", ID = 188501 }),
    InfernalStrike = Action.Create({ Type = "Spell", ID = 189110 }),
    FelRush        = Action.Create({ Type = "Spell", ID = 195072 }),
    Blur           = Action.Create({ Type = "Spell", ID = 198589 }),
    DemonSpikes    = Action.Create({ Type = "Spell", ID = 203720 }),
    Shear          = Action.Create({ Type = "Spell", ID = 203782 }),
    SoulCleave     = Action.Create({ Type = "Spell", ID = 228477 }),
    ImmolationAura = Action.Create({ Type = "Spell", ID = 258920 }),
    SoulFragments = Action.Create({ Type = "Spell", ID = 203981 }),       
    
}

local A = setmetatable(Action[ACTION_CONST_DEMONHUNTER_VENGEANCE], { __index = Action })

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
    InfernalStrikeDelay                     = 0,
    theHuntRampInProgress                   = false,
    elysianDecreeRampInProgress             = false,
    soulCarverRampInProgress                = false,
    fieryDemiseWithSoulCarverInProgress     = false,
    fieryDemiseWithoutSoulCarverInProgress  = false,
    scaryCasts                              = { 396023, --Incinerating Roar
                                                376279, --Concussive Slam
                                                388290, --Cyclone
                                                375457, --Chilling Tantrum
    },
}

local function InMelee(unitID)
    return A.SoulCleave:IsInRange(unitID)
end 
InMelee = A.MakeFunctionCachedDynamic(InMelee)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end  

    local DemonSpikesHP = A.GetToggle(2, "DemonSpikesHP")
    if A.DemonSpikes:IsReady(player) and Unit(player):HasBuffs(A.DemonSpikes.ID) == 0 then
        if A.DemonSpikes:GetSpellCharges() == 2 or Unit(player):HealthPercent() <= DemonSpikesHP then
            return A.DemonSpikes
        end
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
    EnemiesCasting = MultiUnits:GetByRangeCasting(10, 1, nil, nil)

    if castRemainsTime >= A.GetLatency() then    
 
        -- Disrupt
        if useKick and A.Disrupt:IsReady(unitID) and not notInterruptable and A.Disrupt:AbsentImun(unitID, Temp.TotalAndMagKick, true) then 
            return A.Disrupt
        end  

        -- Sigil of Chains (Snare)
        if useCC and A.SigilofChains:IsReady(player) and not Player:IsMoving() and A.SigilofChains:IsTalentLearned() and MultiUnits:GetByRange(10, 4) >= 3 and not Unit(unitID):IsBoss() then
            return A.SigilofChains              
        end 
        
        -- Sigil of Misery (Disorient)
        if useCC and A.SigilofMisery:IsReady(player) and not Player:IsMoving() and EnemiesCasting > 1 and A.SigilofMisery:AbsentImun(unitID, Temp.TotalAndCC, true) and not Unit(unitID):IsBoss() then 
            return A.SigilofMisery              
        end 
        
        -- Sigil of Silence (Silence)
        if useKick and not A.Disrupt:IsReady(unitID) and A.SigilofSilence:IsReady(player) and not Player:IsMoving() and A.SigilofSilence:AbsentImun(unitID, Temp.TotalAndCC, true) and not Unit(unitID):IsBoss() and castRemainsTime > (2 + A.GetLatency()) then 
            return A.SigilofSilence              
        end 
        
        -- Imprison
        if useCC and A.Imprison:IsReady(unitID, nil, nil, true) and A.Imprison:AbsentImun(unitID, Temp.TotalAndPhysAndCC, true) and Unit(unitID):IsControlAble("incapacitate", 0) and (Unit(unitID):CreatureType() == "Beast" or Unit(unitID):CreatureType() == "Demon" or Unit(unitID):CreatureType() == "Humanoid") then
            return A.Imprison                 
        end   
   
    end
end

local function Purge(unitID)
    if A.ConsumeMagic:IsReady(unitID) and (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) then 
		return A.ConsumeMagic
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

local function DarknessCheck()

    local darknessHP = A.GetToggle(2, "darknessHP")
    local darknessUnits = A.GetToggle(2, "darknessUnits")

    local darknessTotal = 0
    if A.Darkness:IsReady(player) then
        for _, darknessUnit in pairs(TeamCache.Friendly.GUIDs) do
            if Unit(darknessUnit):HealthPercent() <= darknessHP and Unit(darknessUnit):GetRange() <= 10 then
                darknessTotal = darknessTotal + 1
            end
            if darknessTotal >= darknessUnits then
                darknessTotal = 0
                return A.Darkness
            end 
        end
    end

end


A[3] = function(icon, isMulti)
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)


    local function DamageRotation(unitID)

        local soulFragments = Unit(player):HasBuffs(A.SoulFragments.ID)
        local furyDeficit = Player:FuryDeficit()
        local fury = Player:Fury()
        local debuffFrailty = Unit(unitID):HasDeBuffs(A.Frailty.ID)
        local debuffFrailtyStack = Unit(unitID):HasDeBuffsStacks(A.Frailty.ID)
        local spellTargets = MultiUnits:GetByRange(10, 5)
        local fieryBrandTicking = Player:GetDeBuffsUnitCount(A.FieryBrandDebuff.ID) >= 1
        local fieryBrandRemains = Unit(unitID):HasDeBuffs(A.FieryBrandDebuff.ID)
        local buffMetamorphosisUp = Unit(player):HasBuffs(A.Metamorphosis.ID) > 0


        if Temp.InfernalStrikeDelay == 0 and Unit(player):IsCasting() == A.InfernalStrike:Info() then
            Temp.InfernalStrikeDelay = 90
        elseif Temp.InfernalStrikeDelay > 0 then
            Temp.InfernalStrikeDelay = Temp.InfernalStrikeDelay - 1
        end

        if A.TheHunt:GetCooldown() == 0 and A.TheHunt:IsTalentLearned() then
            Temp.theHuntRampInProgress = true
        else
            Temp.theHuntRampInProgress = false
        end

        if A.ElysianDecree:GetCooldown() == 0 and A.ElysianDecree:IsTalentLearned() then
            Temp.elysianDecreeRampInProgress = true
        else
            Temp.elysianDecreeRampInProgress = false
        end

        if A.SoulCarver:GetCooldown() == 0 and A.SoulCarver:IsTalentLearned() and (not A.FieryDemise:IsTalentLearned() or A.FieryBrand:GetCooldown() > 0) then
            Temp.soulCarverRampInProgress = true
        else
            Temp.soulCarverRampInProgress = false
        end

        if A.FieryDemise:IsTalentLearned() and A.SoulCarver:IsTalentLearned() and A.SoulCarver:GetCooldown() == 0 and A.FieryBrand:GetCooldown() == 0 and A.FelDevastation:GetCooldown() == 0 then
            Temp.fieryDemiseWithSoulCarverInProgress = true
        elseif A.SoulCarver:GetCooldown() > 0 and A.FieryBrand:GetCooldown() > 0 then
            Temp.fieryDemiseWithSoulCarverInProgress = false
        end
        
        if A.FieryDemise:IsTalentLearned() and A.FieryBrand:GetCooldown() == 0 and A.FelDevastation:GetCooldown() == 0 then
            Temp.fieryDemiseWithoutSoulCarverInProgress = true
        elseif A.FieryBrand:GetCooldown() > 0 then
            Temp.fieryDemiseWithoutSoulCarverInProgress = false
        end

        -- Defensive
        local SelfDefensive = SelfDefensives()
        if SelfDefensive then 
            return SelfDefensive:Show(icon)
        end 

        -- Defensive
        local useDarkness = DarknessCheck()
        if useDarkness then 
            return useDarkness:Show(icon)
        end 

        -- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end 

        -- Interrupts
        local usePurge = Purge(unitID)
        if usePurge then 
            return usePurge:Show(icon)
        end 

        fractureFuryGainNotInMeta, fractureFuryGainInMeta = 25, 45
        if T29has2P then
            fractureFuryGainNotInMeta, fractureFuryGainInMeta = 30, 54
            else fractureFuryGainNotInMeta, fractureFuryGainInMeta = 25, 45
        end

        if A.Torment:IsReady(unitID, true) and not Unit(unitID):IsBoss() and not Unit(unitID):IsDummy() and Unit(targettarget):InfoGUID() ~= Unit(player):InfoGUID() and Unit(targettarget):InfoGUID() ~= nil and A.IsUnitFriendly(targettarget) then 
            return A.Torment:Show(icon)
        end 

        -- actions+=/infernal_strike
        if A.InfernalStrike:IsReady(player) and Temp.InfernalStrikeDelay == 0 and A.InfernalStrike:GetSpellCharges() > 1 and A.SoulCleave:IsInRange(unitID) and not Unit(player):InVehicle() and A.LossOfControl:Get("ROOT") == 0 then 
            return A.InfernalStrike:Show(icon)
        end
        -- actions+=/fiery_brand,if=!talent.fiery_demise.enabled&!dot.fiery_brand.ticking
        if A.FieryBrand:IsReady(unitID) and not A.FieryDemise:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.FieryBrandDebuff.ID) == 0 then
            return A.FieryBrand:Show(icon)
        end
        -- actions+=/bulk_extraction
        if A.BulkExtraction:IsReady(player) and spellTargets >= 1 and Unit(unitID):TimeToDie() >= 8 then
            return A.BulkExtraction:Show(icon)
        end

        local UseTrinket = UseTrinkets(unitID)
        if UseTrinket then
            return UseTrinket:Show(icon)
        end  

        --actions+=/variable,name=fracture_fury_gain,op=setif,value=variable.fracture_fury_gain_in_meta,value_else=variable.fracture_fury_gain_not_in_meta,condition=buff.metamorphosis.up
            fractureFuryGain = fractureFuryGainNotInMeta
        if Unit(player):HasBuffs(A.Metamorphosis.ID) > 0 then
            fractureFuryGain = fractureFuryGainInMeta
            else fractureFuryGain = fractureFuryGainNotInMeta
        end

        local function ElysianDecreeRamp()
            -- actions.elysian_decree_ramp+=/fracture,if=fury.deficit>=variable.fracture_fury_gain&debuff.frailty.stack<=5
            if A.Fracture:IsReady(unitID) and furyDeficit >= fractureFuryGain and debuffFrailtyStack <= 5 then
                return A.Fracture:Show(icon)
            end
            -- actions.elysian_decree_ramp+=/sigil_of_flame,if=fury.deficit>=30
            if A.SigilofFlame:IsReady(player) and furyDeficit >= 30 and spellTargets >= 1 and not Player:IsMoving() then
                return A.SigilofFlame:Show(icon)
            end
            -- actions.elysian_decree_ramp+=/shear,if=fury.deficit<=90&debuff.frailty.stack>=0
            if A.Shear:IsReady(unitID) and not A.Fracture:IsTalentLearned() and furyDeficit <= 90 and debuffFrailtyStack >= 0 then
                return A.Shear:Show(icon)
            end
            -- actions.elysian_decree_ramp+=/spirit_bomb,if=soul_fragments>=4&spell_targets>1
            if A.SpiritBomb:IsReady(player) and soulFragments >= 4 and spellTargets > 1 then
                return A.SpiritBomb:Show(icon)
            end
            -- actions.elysian_decree_ramp+=/soul_cleave,if=(soul_fragments<=1&spell_targets>1)|(spell_targets<2)|debuff.frailty.stack>=0
            if A.SoulCleave:IsReady(unitID) then
                if (soulFragments <= 1 and spellTargets > 1) or (spellTargets < 2) or (debuffFrailtyStack >= 0) then
                    return A.SoulCleave:Show(icon)
                end
            end
            -- actions.elysian_decree_ramp+=/elysian_decree
            if A.ElysianDecree:IsReady(player) and spellTargets >= 1 and not Player:IsMoving() then
                return A.ElysianDecree:Show(icon)
            end
        end
     
        local function FieryDemiseWindowWithSoulCarver()
            if A.Fracture:IsReady(unitID) and furyDeficit >= fractureFuryGain and not fieryBrandTicking then
                return A.Fracture:Show(icon)
            end
            if A.FieryBrand:IsReady(unitID) and not fieryBrandTicking and fury >= 30 then
                return A.FieryBrand:Show(icon)
            end
            if A.ImmolationAura:IsReady(player) and fieryBrandTicking then
                return A.ImmolationAura:Show(icon)
            end
            if A.FelDevastation:IsReady(player) and fieryBrandRemains <= 3 and spellTargets >= 1 and not Player:IsMoving() then
                return A.FelDevastation:Show(icon)
            end
            if A.SpiritBomb:IsReady(player) then
                if ((buffMetamorphosisUp and A.Fracture:IsTalentLearned() and soulFragments >= 3) or soulFragments >= 4) and fieryBrandRemains >= 4 then
                    return A.SpiritBomb:Show(icon)
                end
            end
            if A.SoulCleave:IsReady(unitID) then
                if (soulFragments <= 1 and spellTargets > 1) or (spellTargets < 2) and fieryBrandRemains >= 4 then
                    return A.SoulCleave:Show(icon)
                end
            end
            if A.SoulCarver:IsReady(unitID) and soulFragments <= 3 and fieryBrandRemains > 0 then
                return A.SoulCarver:Show(icon)
            end
            if A.Fracture:IsReady(unitID) and soulFragments <= 3 and fieryBrandRemains >= 5 or fieryBrandRemains <= 5 and fury < 50 then
                return A.Fracture:Show(icon)
            end
            if A.SigilofFlame:IsReady(player) and fieryBrandRemains <= 3 and fury < 50 and spellTargets >= 1 and not Player:IsMoving() then
                return A.SigilofFlame:Show(icon)
            end
            if A.ThrowGlaive:IsReady(unitID) then
                return A.ThrowGlaive:Show(icon)
            end
        end

        local function FieryDemiseWindowWithoutSoulCarver()
            if A.Fracture:IsReady(unitID) and furyDeficit >= fractureFuryGain and not fieryBrandTicking then
                return A.Fracture:Show(icon)
            end
            if A.FieryBrand:IsReady(unitID) and not fieryBrandTicking and fury >= 30 then
                return A.FieryBrand:Show(icon)
            end
            if A.ImmolationAura:IsReady(player) and fieryBrandTicking then
                return A.ImmolationAura:Show(icon)
            end
            if A.SpiritBomb:IsReady(player) then
                if ((buffMetamorphosisUp and A.Fracture:IsTalentLearned() and soulFragments >= 3) or soulFragments >= 4) and fieryBrandRemains >= 4 then
                    return A.SpiritBomb:Show(icon)
                end
            end
            if A.SoulCleave:IsReady(unitID) then
                if (soulFragments <= 1 and spellTargets > 1) or (spellTargets < 2) and fieryBrandRemains >= 4 then
                    return A.SoulCleave:Show(icon)
                end
            end
            if A.Fracture:IsReady(unitID) and soulFragments <= 3 and fieryBrandRemains >= 5 or fieryBrandRemains <= 5 and fury < 50 then
                return A.Fracture:Show(icon)
            end
            if A.FelDevastation:IsReady(player) and fieryBrandRemains <= 3 and spellTargets >= 1 and not Player:IsMoving() then
                return A.FelDevastation:Show(icon)
            end
            if A.SigilofFlame:IsReady(player) and fieryBrandRemains <= 3 and fury < 50 and spellTargets >= 1 and not Player:IsMoving() then
                return A.SigilofFlame:Show(icon)
            end
        end

        local function SoulCarverWithoutFieryDemiseRamp() 
            if A.Fracture:IsReady(unitID) and furyDeficit >= fractureFuryGain and debuffFrailtyStack <= 5 then
                return A.Fracture:Show(icon)
            end
            if A.SigilofFlame:IsReady(player) and furyDeficit >= 30 and spellTargets >= 1 and not Player:IsMoving() then
                return A.SigilofFlame:Show(icon)
            end
            if A.Shear:IsReady(unitID) and not A.Fracture:IsTalentLearned() and furyDeficit <= 90 and debuffFrailtyStack >= 0 then
                return A.Shear:Show(icon)
            end
            if A.SpiritBomb:IsReady(player) and soulFragments >= 4 and spellTargets > 1 then
                return A.SpiritBomb:Show(icon)
            end
            if A.SoulCleave:IsReady(unitID) then
                if (soulFragments <= 1 and spellTargets > 1) or (spellTargets < 2) or debuffFrailtyStack >= 0 then
                    return A.SoulCleave:Show(icon)
                end
            end
            if A.SoulCarver:IsReady(unitID) then
                return A.SoulCarver:Show(icon)
            end            
        end

        local function TheHuntRamp()         
            if A.Fracture:IsReady(unitID) and furyDeficit >= fractureFuryGain and debuffFrailtyStack <= 5 then
                return A.Fracture:Show(icon)
            end
            if A.SigilofFlame:IsReady(player) and furyDeficit >= 30 and spellTargets >= 1 and not Player:IsMoving() then
                return A.SigilofFlame:Show(icon)
            end
            if A.Shear:IsReady(unitID) and not A.Fracture:IsTalentLearned() and furyDeficit <= 90 then
                return A.Shear:Show(icon)
            end
            if A.SpiritBomb:IsReady(player) and soulFragments >= 4 and spellTargets > 1 then
                return A.SpiritBomb:Show(icon)
            end
            if A.SoulCleave:IsReady(unitID) then
                if (soulFragments <= 1 and spellTargets > 1) or (spellTargets < 2) or debuffFrailtyStack >= 0 then
                    return A.SoulCleave:Show(icon)
                end
            end
            if A.TheHunt:IsReady(unitID) then
                return A.TheHunt:Show(icon)
            end
        end

        -- actions+=/run_action_list,name=the_hunt_ramp,if=variable.the_hunt_ramp_in_progress|talent.the_hunt.enabled&cooldown.the_hunt.remains<5&!dot.fiery_brand.ticking
        if Temp.theHuntRampInProgress or A.TheHunt:IsTalentLearned() and A.TheHunt:GetCooldown() < 5 and not fieryBrandTicking then
            return TheHuntRamp()
        end        
        -- actions+=/run_action_list,name=elysian_decree_ramp,if=variable.elysian_decree_ramp_in_progress|talent.elysian_decree.enabled&cooldown.elysian_decree.remains<5&!dot.fiery_brand.ticking
        if Temp.elysianDecreeRampInProgress or A.ElysianDecree:IsTalentLearned() and A.ElysianDecree:GetCooldown() < 5 and not fieryBrandTicking then
            return ElysianDecreeRamp()
        end        
        -- actions+=/run_action_list,name=soul_carver_without_fiery_demise_ramp,if=variable.soul_carver_ramp_in_progress|talent.soul_carver.enabled&cooldown.soul_carver.remains<5&!talent.fiery_demise.enabled&!dot.fiery_brand.ticking
        if Temp.soulCarverRampInProgress or (A.SoulCarver:IsTalentLearned() and A.SoulCarver:GetCooldown() < 5 and not A.FieryDemise:IsTalentLearned() and not fieryBrandTicking) then
            return SoulCarverWithoutFieryDemiseRamp()
        end
        -- actions+=/run_action_list,name=fiery_demise_window_with_soul_carver,if=variable.fiery_demise_with_soul_carver_in_progress|talent.fiery_demise.enabled&talent.soul_carver.enabled&cooldown.soul_carver.up&cooldown.fiery_brand.up&cooldown.immolation_aura.up&cooldown.fel_devastation.remains<10
        if Temp.fieryDemiseWithSoulCarverInProgress or A.FieryDemise:IsTalentLearned() and A.SoulCarver:IsTalentLearned() and A.SoulCarver:GetCooldown() == 0 and A.FieryBrand:GetCooldown() == 0 and A.ImmolationAura:GetCooldown() == 0 and A.FelDevastation:GetCooldown() < 10 then
            return FieryDemiseWindowWithSoulCarver()
        end
        -- actions+=/run_action_list,name=fiery_demise_window_without_soul_carver,if=variable.fiery_demise_without_soul_carver_in_progress|talent.fiery_demise.enabled&((talent.soul_carver.enabled&!cooldown.soul_carver.up)|!talent.soul_carver.enabled)&cooldown.fiery_brand.up&cooldown.immolation_aura.up&cooldown.fel_devastation.remains<10&((talent.darkglare_boon.enabled&darkglare_boon_cdr_high_roll)|!talent.darkglare_boon.enabled|!talent.soul_carver.enabled)        
        if Temp.fieryDemiseWithoutSoulCarverInProgress or A.FieryDemise:IsTalentLearned() and ((A.SoulCarver:IsTalentLearned() and A.SoulCarver:GetCooldown() > 0) or not A.SoulCarver:IsTalentLearned()) and A.FieryBrand:GetCooldown() == 0 and A.ImmolationAura:GetCooldown() == 0 and A.FelDevastation:GetCooldown() < 10 then
            return FieryDemiseWindowWithoutSoulCarver()
        end

        if A.Metamorphosis:IsReady(player) and not buffMetamorphosisUp and not fieryBrandTicking and BurstIsON(unitID) then
            return A.Metamorphosis:Show(icon)
        end
        if A.FelDevastation:IsReady(player) and not A.DowninFlames:IsTalentLearned() and spellTargets >= 1 and not Player:IsMoving() then
            return A.FelDevastation:Show(icon)
        end
        if A.SpiritBomb:IsReady(player) then
            if (buffMetamorphosisUp and A.Fracture:IsTalentLearned() and soulFragments >= 3 and spellTargets > 1) or (soulFragments >= 4 and spellTargets > 1) then
                return A.SpiritBomb:Show(icon)
            end
        end
        if A.SoulCleave:IsReady(unitID) then
            if (A.SpiritBomb:IsTalentLearned() and soulFragments <= 1 and spellTargets > 1) or (spellTargets < 2 and ((A.Fracture:IsTalentLearned() and fury >= 55) or (not A.Fracture:IsTalentLearned() and fury >= 70) or (buffMetamorphosisUp and ((A.Fracture:IsTalentLearned() and fury >= 35) or (not A.Fracture:IsTalentLearned() and fury >= 50))))) or (not A.SpiritBomb:IsTalentLearned() and ((A.Fracture:IsTalentLearned() and fury >= 55) or (not A.Fracture:IsTalentLearned() and fury >= 70) or (buffMetamorphosisUp and ((A.Fracture:IsTalentLearned() and fury >= 35) or (not A.Fracture:IsTalentLearned() and fury >= 50))))) then
                return A.SoulCleave:Show(icon)
            end
        end
        if A.ImmolationAura:IsReady(player) then
            if (A.FieryDemise:IsTalentLearned() and furyDeficit >= 10 and (A.SoulCarver:GetCooldown() > 15 or not A.SoulCarver:IsTalentLearned())) or (not A.FieryDemise:IsTalentLearned() and furyDeficit >= 10) then
                return A.ImmolationAura:Show(icon)
            end
        end
        if A.Felblade:IsReady(unitID) and furyDeficit >= 40 then
            return A.Felblade:Show(icon)
        end
        if A.Fracture:IsReady(unitID) then
            if (A.SpiritBomb:IsTalentLearned() and (soulFragments <= 3 and spellTargets > 1 or spellTargets < 2 and furyDeficit >= fractureFuryGain)) or (not A.SpiritBomb:IsTalentLearned()  and furyDeficit >= fractureFuryGain) then
                return A.Fracture:Show(icon)
            end
        end
        if A.SigilofFlame:IsReady(player) and furyDeficit >= 30 and spellTargets >= 1 and not Player:IsMoving() then
            return A.SigilofFlame:Show(icon)
        end
        if A.Shear:IsReady(unitID) and not A.Fracture:IsTalentLearned() then
            return A.Shear:Show(icon)
        end
        if A.ThrowGlaive:IsReady(unitID) then
            return A.ThrowGlaive:Show(icon)    
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