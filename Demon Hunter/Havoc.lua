--#####################################
--##### TRIP'S HAVOC DEMON HUNTER #####
--#####################################

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

Action[ACTION_CONST_DEMONHUNTER_HAVOC] = {
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
    MomentumBuff       = Action.Create({ Type = "Spell", ID = 208628 }),
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
    EssenceBreakDebuff   = Action.Create({ Type = "Spell", ID = 320338 }),
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
    UnboundChaosBuff   = Action.Create({ Type = "Spell", ID = 347462 }),
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
    ChaosTheoryBuff    = Action.Create({ Type = "Spell", ID = 390195 }),
    TacticalRetreat= Action.Create({ Type = "Spell", ID = 389688 }),
    TacticalRetreatBuff= Action.Create({ Type = "Spell", ID = 389890 }),
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
    SerratedGlaiveDebuff = Action.Create({ Type = "Spell", ID = 390155 }),
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

local A = setmetatable(Action[ACTION_CONST_DEMONHUNTER_HAVOC], { __index = Action })

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
    FelRushDelay                            = 0,
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

    local blurHP = A.GetToggle(2, "blurHP")
    if A.Blur:IsReady(player) and Unit(player):HealthPercent() <= blurHP then
        return A.Blur
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

        -- FelEruption
        if useCC and A.FelEruption:IsReady(unitID) and A.FelEruption:AbsentImun(unitID, Temp.TotalAndMagKick, true) and not Unit(unitID):IsBoss() then 
            return A.FelEruption
        end  
        
        -- Sigil of Misery (Disorient)
        if useCC and A.SigilofMisery:IsReady(player) and not Player:IsMoving() and A.SigilofMisery:AbsentImun(unitID, Temp.TotalAndCC, true) and not Unit(unitID):IsBoss() and castRemainsTime > (2 + A.GetLatency()) then 
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

        local furyDeficit = Player:FuryDeficit()
        local fury = Player:Fury()
        local spellTargets = MultiUnits:GetByRange(10, 5)
        local useMovement = A.GetToggle(2, "useMovement")


        if Temp.FelRushDelay == 0 and Unit(player):IsCasting() == A.FelRush:Info() then
            Temp.FelRushDelay = 90
        elseif Temp.FelRushDelay > 0 then
            Temp.FelRushDelay = Temp.FelRushDelay - 1
        end

        if Player:PrevOffGCD(1, A.VengefulRetreat) and A.Felblade:IsReady(unitID, nil, nil, true) then
            return A.Felblade:Show(icon)
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

        local useBladeDance = A.FirstBlood:IsTalentLearned() or A.TrailofRuin:IsTalentLearned() or A.ChaosTheory:IsTalentLearned() and Unit(player):HasBuffs(A.ChaosTheoryBuff.ID) == 0 or spellTargets > 1
        local poolingForBladeDance = useBladeDance and fury < (75 - (num(A.DemonBlades:IsTalentLearned())*20)) and A.BladeDance:GetCooldown() < A.GetGCD()
        local poolingForEyeBeam = A.Demonic:IsTalentLearned() and not A.BlindFury:IsTalentLearned() and A.EyeBeam:GetCooldown() < (A.GetGCD() * 2) and furyDeficit > 20
        local waitingForMomentum = A.Momentum:IsTalentLearned() and Unit(player):HasBuffs(A.MomentumBuff.ID) == 0
        
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

        local function Cooldowns()
            -- # Cast Metamorphosis if we will get a full Eye Beam refresh or if the encounter is almost over
            -- actions.cooldown=metamorphosis,if=!talent.demonic&((!talent.chaotic_transformation|cooldown.eye_beam.remains>20)&active_enemies>desired_targets|raid_event.adds.in>60|fight_remains<25)
            if A.Metamorphosis:IsReady(player) and not A.Demonic:IsTalentLearned() and ((not A.ChaoticTransformation:IsTalentLearned() or A.EyeBeam:GetCooldown() > 20) and spellTargets >= 1) then
                return A.Metamorphosis
            end
            -- actions.cooldown+=/metamorphosis,if=talent.demonic&(!talent.chaotic_transformation|cooldown.eye_beam.remains>20&(!variable.blade_dance|cooldown.blade_dance.remains>gcd.max)|fight_remains<25)
            if A.Metamorphosis:IsReady(player) and A.Demonic:IsTalentLearned() and (not A.ChaoticTransformation:IsTalentLearned() or A.EyeBeam:GetCooldown() > 20 and (not useBladeDance or A.BladeDance:GetCooldown() > A.GetGCD())) then
                return A.Metamorphosis
            end
            -- actions.cooldown+=/potion,if=buff.metamorphosis.remains>25|buff.metamorphosis.up&cooldown.metamorphosis.ready|fight_remains<60

            -- actions.cooldown+=/the_hunt,if=(!talent.momentum|!buff.momentum.up)
            if A.TheHunt:IsReady(unitID) and (not A.Momentum:IsTalentLearned() or Unit(player):HasBuffs(A.MomentumBuff.ID) == 0) then
                return A.TheHunt
            end
            -- actions.cooldown+=/elysian_decree,if=(active_enemies>desired_targets|raid_event.adds.in>30)
            if A.ElysianDecree:IsReady(player) and (spellTargets >= 1) then
                return A.ElysianDecree
            end
        end

        -- actions+=/call_action_list,name=cooldown,if=gcd.remains=0
        local useCooldowns = Cooldowns()
        local useTrinket = UseTrinkets(unitID)
        if BurstIsON(unitID) and (Unit(unitID):TimeToDie() > 10 or Unit(unitID):IsBoss()) then
            if useTrinket then
                return useTrinket:Show(icon)
            end
            if useCooldowns then
                return useCooldowns:Show(icon)
            end
        end
        -- actions+=/vengeful_retreat,use_off_gcd=1,if=talent.initiative&talent.essence_break&time>1&(cooldown.essence_break.remains>15|cooldown.essence_break.remains<gcd.max&(!talent.demonic|buff.metamorphosis.up|cooldown.eye_beam.remains>15+(10*talent.cycle_of_hatred)))
        if A.VengefulRetreat:IsReady(player) and useMovement and spellTargets >= 1 and A.Felblade:GetCooldown() == 0 and A.Initiative:IsTalentLearned() and A.EssenceBreak:IsTalentLearned() and Unit(player):CombatTime() > 1 and (A.EssenceBreak:GetCooldown() > 15 or A.EssenceBreak:GetCooldown() < A.GetGCD() and (not A.Demonic:IsTalentLearned() or Unit(player):HasBuffs(A.Metamorphosis.ID) > 0 or A.EyeBeam:GetCooldown() > 15 + (10*num(A.CycleofHatred:IsTalentLearned())))) then
            return A.VengefulRetreat:Show(icon)
        end
        -- actions+=/vengeful_retreat,use_off_gcd=1,if=talent.initiative&!talent.essence_break&time>1&!buff.momentum.up
        if A.VengefulRetreat:IsReady(player) and useMovement and spellTargets >= 1 and A.Felblade:GetCooldown() == 0 and A.Initiative:IsTalentLearned() and not A.EssenceBreak:IsTalentLearned() and Unit(player):CombatTime() > 1 and not Unit(player):HasBuffs(A.Momentum.ID) then
            return A.VengefulRetreat:Show(icon)
        end
        -- actions+=/fel_rush,if=(buff.unbound_chaos.up|variable.waiting_for_momentum&(!talent.unbound_chaos|!cooldown.immolation_aura.ready))&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
        if A.FelRush:IsReady(player) and Temp.FelRushDelay == 0 and useMovement then
            if (Unit(player):HasBuffs(A.UnboundChaosBuff.ID) > 0 or waitingForMomentum and (not A.UnboundChaos:IsTalentLearned() or A.ImmolationAura:GetCooldown() > 0)) and (A.FelRush:GetSpellCharges() == 2) then
                return A.FelRush:Show(icon)
            end
        end
        -- actions+=/essence_break,if=(active_enemies>desired_targets|raid_event.adds.in>40)&!variable.waiting_for_momentum&fury>40&(cooldown.eye_beam.remains>8|buff.metamorphosis.up)&(!talent.tactical_retreat|buff.tactical_retreat.up)
        if A.EssenceBreak:IsReady(player) then
            if spellTargets >= 1 and not waitingForMomentum and fury > 40 and (A.EyeBeam:GetCooldown() > 8 or Unit(player):HasBuffs(A.Metamorphosis.ID) > 0) and (not A.TacticalRetreat:IsTalentLearned() or Unit(player):HasBuffs(A.TacticalRetreatBuff.ID) > 0) then
                return A.EssenceBreak:Show(icon)
            end
        end
        -- actions+=/death_sweep,if=variable.blade_dance&(!talent.essence_break|cooldown.essence_break.remains>(cooldown.death_sweep.duration-4))
        local BDcooldownMS, DSgcdMS = GetSpellBaseCooldown(A.BladeDance.ID)
        if A.BladeDance:IsReady(player) and Unit(player):HasBuffs(A.Metamorphosis.ID) > 0 and useBladeDance and (not A.EssenceBreak:IsTalentLearned() or A.EssenceBreak:GetCooldown() > ((BDcooldownMS / 1000) - 4)) then
            return A.BladeDance:Show(icon)
        end
        -- actions+=/fel_barrage,if=active_enemies>desired_targets|raid_event.adds.in>30
        if A.FelBarrage:IsReady(player) and spellTargets >= 1 then
            return A.FelBarrage:Show(icon)
        end
        -- actions+=/glaive_tempest,if=active_enemies>desired_targets|raid_event.adds.in>10
        if A.GlaiveTempest:IsReady(player) and spellTargets >= 1 and not Player:IsMoving() then
            return A.GlaiveTempest:Show(icon)
        end
        -- actions+=/eye_beam,if=active_enemies>desired_targets|raid_event.adds.in>(40-talent.cycle_of_hatred*15)&!debuff.essence_break.up
        if A.EyeBeam:IsReady(player) and spellTargets >= 1 then
            return A.EyeBeam:Show(icon)
        end
        -- actions+=/blade_dance,if=variable.blade_dance&(cooldown.eye_beam.remains>5|!talent.demonic|(raid_event.adds.in>cooldown&raid_event.adds.in<25))
        if A.BladeDance:IsReady(player) and useBladeDance and (A.EyeBeam:GetCooldown() > 5 or not A.Demonic:IsTalentLearned()) then
            return A.BladeDance:Show(icon)
        end
        -- actions+=/throw_glaive,if=talent.soulrend&(active_enemies>desired_targets|raid_event.adds.in>full_recharge_time+9)&spell_targets>=(2-talent.furious_throws)&!debuff.essence_break.up
        if A.ThrowGlaive:IsReady(unitID) and A.Soulrend:IsTalentLearned() and spellTargets >= (2 - num(A.FuriousThrows:IsTalentLearned())) and Unit(unitID):HasDeBuffs(A.EssenceBreakDebuff.ID) == 0 then
            return A.ThrowGlaive:Show(icon)
        end
        -- actions+=/annihilation,if=!variable.pooling_for_blade_dance
        if A.ChaosStrike:IsReady(unitID) and Unit(player):HasBuffs(A.Metamorphosis.ID) > 0 and not poolingForBladeDance then
            return A.ChaosStrike:Show(icon)
        end
        -- actions+=/throw_glaive,if=talent.serrated_glaive&cooldown.eye_beam.remains<4&!debuff.serrated_glaive.up&!debuff.essence_break.up
        if A.ThrowGlaive:IsReady(unitID) and A.SerratedGlaive:IsTalentLearned() and A.EyeBeam:GetCooldown() < 4 and Unit(unitID):HasDeBuffs(A.SerratedGlaiveDebuff.ID) == 0 and Unit(unitID):HasDeBuffs(A.EssenceBreakDebuff.ID) == 0 then
            return A.ThrowGlaive:Show(icon)
        end
        -- actions+=/immolation_aura,if=!buff.immolation_aura.up&(!talent.ragefire|active_enemies>desired_targets|raid_event.adds.in>15)
        if A.ImmolationAura:IsReady(player) and Unit(player):HasBuffs(A.ImmolationAura.ID) == 0 and (not A.Ragefire:IsTalentLearned() or spellTargets >= 1) then
            return A.ImmolationAura:Show(icon)
        end
        -- actions+=/felblade,if=fury.deficit>=40
        if A.Felblade:IsReady(unitID) and furyDeficit >= 40 then
            return A.Felblade:Show(icon)
        end
        -- actions+=/sigil_of_flame,if=active_enemies>desired_targets
        if A.SigilofFlame:IsReady(player) and spellTargets >= 1 then
            return A.SigilofFlame:Show(icon)
        end
        -- actions+=/chaos_strike,if=!variable.pooling_for_blade_dance&!variable.pooling_for_eye_beam
        if A.ChaosStrike:IsReady(unitID) and not poolingForBladeDance and not poolingForEyeBeam then
            return A.ChaosStrike:Show(icon)
        end
        -- actions+=/fel_rush,if=!talent.momentum&talent.demon_blades&!cooldown.eye_beam.ready&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
        if A.FelRush:IsReady(player) and useMovement and Temp.FelRushDelay == 0 and not A.Momentum:IsTalentLearned() and A.DemonBlades:IsTalentLearned() and A.EyeBeam:GetCooldown() > 0 and A.FelRush:GetSpellCharges() == 2 then
            return A.FelRush:Show(icon)
        end
        -- actions+=/fel_rush,if=!talent.momentum&!talent.demon_blades&spell_targets>1&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
        if A.FelRush:IsReady(player) and useMovement and Temp.FelRushDelay == 0 and not A.Momentum:IsTalentLearned() and not A.DemonBlades:IsTalentLearned() and spellTargets > 1 and A.FelRush:GetSpellCharges() == 2 then
            return A.FelRush:Show(icon)
        end
        -- actions+=/demons_bite
        if A.DemonsBite:IsReady(unitID) and not A.DemonBlades:IsTalentLearned() then
            return A.DemonsBite:Show(icon)
        end
        -- actions+=/fel_rush,if=movement.distance>15|(buff.out_of_range.up&!talent.momentum)
        -- actions+=/vengeful_retreat,if=!talent.initiative&movement.distance>15
        -- actions+=/throw_glaive,if=(talent.demon_blades|buff.out_of_range.up)&!debuff.essence_break.up
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