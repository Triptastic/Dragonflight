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
                                                381694, -- Decayed Senses (BH)
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
                                                377864, -- Infectious Spit (BH)
                                                374389, -- Gulp Swong Toxin (HoI)
                                                374812, -- Blazing Aegis (Neltharus)
                                                374842, -- Blazing Aegis (Neltharus)
    },
    blockMovementDebuff                     = {

    },
}

local function InMelee(unitID)
    return A.ChaosStrike:IsInRange(unitID)
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
    if A.Blur:IsReady(player) and (Unit(player):HealthPercent() <= blurHP or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1 or Unit(player):HasDeBuffs(Temp.useDefensiveDebuff) > 1) then
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
        if useCC and A.SigilofMisery:IsReady(player) and ((Unit(unitID):GetRange() <= 7 and not Player:IsMoving() and not A.PreciseSigils:IsTalentLearned()) or A.PreciseSigils:IsTalentLearned()) and A.SigilofMisery:AbsentImun(unitID, Temp.TotalAndCC, true) and not Unit(unitID):IsBoss() and castRemainsTime > (2 + A.GetLatency()) then 
            return A.SigilofMisery              
        end 
        
        -- Sigil of Silence (Silence)
        if useKick and not A.Disrupt:IsReady(unitID) and A.SigilofSilence:IsReady(player) and ((Unit(unitID):GetRange() <= 7 and not Player:IsMoving() and not A.PreciseSigils:IsTalentLearned()) or A.PreciseSigils:IsTalentLearned()) and A.SigilofSilence:AbsentImun(unitID, Temp.TotalAndCC, true) and not Unit(unitID):IsBoss() and castRemainsTime > (2 + A.GetLatency()) then 
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

function ThreeMinuteTrinketCheck()
    -- Get the IDs for the trinkets in slot 13 and 14
    local trinket1ID = GetInventoryItemID("player", 13)
    local trinket2ID = GetInventoryItemID("player", 14)
    
    -- Check the cooldown for trinket 1
    if trinket1ID then
        local _, trinket1Duration, _ = GetItemCooldown(trinket1ID)
        if trinket1Duration == 180 then
            return true
        end
    end
    
    -- Check the cooldown for trinket 2
    if trinket2ID then
        local _, trinket2Duration, _ = GetItemCooldown(trinket2ID)
        if trinket2Duration == 180 then
            return true
        end
    end
    
    -- If neither trinket has a 3-minute cooldown, return false
    return false
end



A[3] = function(icon, isMulti)
    unitID = "target"

    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    Player:AddTier("Tier30", { 202524, 202525, 202527, 202523, 202522, })
    local T30has2P = Player:HasTier("Tier30", 2)
    local T30has4P = Player:HasTier("Tier30", 4)
    local useBurst = BurstIsON(unitID) and shouldBurst(unitID) and InMelee()
    local threeMinuteTrinket = ThreeMinuteTrinketCheck()
    local fightRemains = MultiUnits.GetByRangeAreaTTD(20)


    local function DamageRotation(unitID)

        local furyDeficit = Player:FuryDeficit()
        local fury = Player:Fury()
        local spellTargets = MultiUnits:GetByRange(10, 5)
        local activeEnemies = MultiUnits:GetByRange(10, 5)
        if Unit(target):IsEnemy() and Unit(unitID):GetRange() <= 15 and activeEnemies == 0 then
            activeEnemies = 1
        end
        local desiredTargets = activeEnemies
        local useMovement = A.GetToggle(2, "useMovement")

        if Temp.FelRushDelay == 0 and Unit(player):IsCasting() == A.FelRush:Info() then
            Temp.FelRushDelay = 90
        elseif Temp.FelRushDelay > 0 then
            Temp.FelRushDelay = Temp.FelRushDelay - 1
        end

        local isBackflip = false
        if Player:PrevOffGCD(1, A.VengefulRetreat) then
            isBackflip = true
        end
        if A.VengefulRetreat:GetSpellTimeSinceLastCast() > 2 then
            isBackflip = false
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
        local poolingForEyeBeam = A.Demonic:IsTalentLearned() and not A.BlindFury:IsTalentLearned() and A.EyeBeam:GetCooldown() < (A.GetGCD() * 2) and fury < 60
        local waitingForMomentum = A.Momentum:IsTalentLearned() and Unit(player):HasBuffs(A.MomentumBuff.ID) == 0
        local holdingMeta = (A.Demonic:IsTalentLearned() and A.EssenceBreak:IsTalentLearned()) and threeMinuteTrinket and fightRemains > (A.Metamorphosis:GetCooldown() + 30 + num(A.ShatteredDestiny:IsTalentLearned()) * 60) and A.Metamorphosis:GetCooldown() < 20 and A.Metamorphosis:GetCooldown() > (A.EyeBeam:GetSpellCastTime() + GetGCD() * (num(A.InnerDemon:IsTalentLearned()) + 2))


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
            if A.Metamorphosis:IsReady(player) and not A.Demonic:IsTalentLearned() and ((not A.ChaoticTransformation:IsTalentLearned() or A.EyeBeam:GetCooldown() > 20) and spellTargets >= desiredTargets or Unit(unitID):IsBoss()) then
                return A.Metamorphosis
            end
            -- actions.cooldown+=/metamorphosis,if=talent.demonic&(!talent.chaotic_transformation|cooldown.eye_beam.remains>20&(!variable.blade_dance|cooldown.blade_dance.remains>gcd.max)|fight_remains<25)
            if A.Metamorphosis:IsReady(player) and A.Demonic:IsTalentLearned() and (not A.ChaoticTransformation:IsTalentLearned() or A.EyeBeam:GetCooldown() > 20 and (not useBladeDance or A.BladeDance:GetCooldown() > A.GetGCD()) or fightRemains < 25 and Unit(unitID):IsBoss()) then
                return A.Metamorphosis
            end
            -- actions.cooldown+=/potion,if=buff.metamorphosis.remains>25|buff.metamorphosis.up&cooldown.metamorphosis.ready|fight_remains<60

            -- actions.cooldown+=/the_hunt,if=(!talent.momentum|!buff.momentum.up)
            if A.TheHunt:IsReady(unitID) and (not A.Momentum:IsTalentLearned() or Unit(player):HasBuffs(A.MomentumBuff.ID) == 0) then
                return A.TheHunt
            end
            -- actions.cooldown+=/elysian_decree,if=(active_enemies>desired_targets|raid_event.adds.in>30)
            if A.ElysianDecree:IsReady(player) and (spellTargets >= desiredTargets or Unit(unitID):IsBoss()) then
                return A.ElysianDecree
            end
        end

        -- actions+=/immolation_aura,if=talent.ragefire&active_enemies>=3&(cooldown.blade_dance.remains|debuff.essence_break.down)
        if A.ImmolationAura:IsReady(player) and A.Ragefire:IsTalentLearned() and activeEnemies >= 3 and (A.BladeDance:GetCooldown() > 0 or Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0) then
            return A.ImmolationAura:Show(icon)
        end

        -- actions+=/throw_glaive,if=talent.serrated_glaive&(buff.metamorphosis.remains>gcd.max*6&(debuff.serrated_glaive.down|debuff.serrated_glaive.remains<cooldown.essence_break.remains+5&cooldown.essence_break.remains<gcd.max*2)&(cooldown.blade_dance.remains|cooldown.essence_break.remains<gcd.max*2)|time<0.5)&debuff.essence_break.down&target.time_to_die>gcd.max*8
        if A.ThrowGlaive:IsReady(unitID) and A.SerratedGlaive:IsTalentLearned() and (Unit(player):HasBuffs(A.Metamorphosis.ID) > A.GetGCD() * 6 and (Unit(unitID):HasDeBuffs(A.SerratedGlaive.ID) == 0 or Unit(unitID):HasDeBuffs(A.SerratedGlaive.ID) < (A.EssenceBreak:GetCooldown() + 5) and A.EssenceBreak:GetCooldown() < A.GetGCD() * 2) and (A.BladeDance:GetCooldown() > 0 or A.EssenceBreak:GetCooldown() < A.GetGCD() * 2) or combatTime < 0.5) and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 and Unit(unitID):TimeToDie() > A.GetGCD() * 8 then
            return A.ThrowGlaive:Show(icon)
        end

        -- actions+=/throw_glaive,if=talent.serrated_glaive&cooldown.eye_beam.remains<gcd.max*2&debuff.serrated_glaive.remains<(2+buff.metamorphosis.down*6)&(cooldown.blade_dance.remains|buff.metamorphosis.down)&debuff.essence_break.down&target.time_to_die>gcd.max*8
        if A.ThrowGlaive:IsReady(player) and A.SerratedGlaive:IsTalentLearned() and A.EyeBeam:GetCooldown() < A.GetGCD() * 2 and Unit(unitID):HasDeBuffs(A.SerratedGlaive.ID) < (2 + num(Unit(player):HasBuffs(A.Metamorphosis.ID) == 0) * 6) and (A.BladeDance:GetCooldown() > 0 or Unit(player):HasBuffs(A.Metamorphosis.ID) == 0) and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 and Unit(unitID):TimeToDie() > A.GetGCD() * 8 then
            return A.ThrowGlaive:Show(icon)
        end

        -- actions+=/call_action_list,name=cooldown,if=gcd.remains=0
        local useCooldowns = Cooldowns() 
        local useTrinket = UseTrinkets(unitID)
        if useBurst then
            if useTrinket then
                return useTrinket:Show(icon)
            end
            if useCooldowns then
                return useCooldowns:Show(icon)
            end
        end

        -- actions+=/annihilation,if=buff.inner_demon.up&cooldown.metamorphosis.remains<=gcd*3
        if A.ChaosStrike:IsReady(unitID) and Unit(player):HasBuffs(A.InnerDemon.ID) > 0 and A.Metamorphosis:GetCooldown() <= GetGCD() * 3 then
            return A.ChaosStrike:Show(icon)
        end

        -- actions+=/vengeful_retreat,use_off_gcd=1,if=talent.initiative&talent.essence_break&time>1&(cooldown.essence_break.remains>15|cooldown.essence_break.remains<gcd.max&(!talent.demonic|buff.metamorphosis.up|cooldown.eye_beam.remains>15+(10*talent.cycle_of_hatred)))&(time<30|gcd.remains-1<0)&!talent.any_means_necessary&(!talent.initiative|buff.initiative.remains<gcd.max|time>4)
        -- actions+=/vengeful_retreat,use_off_gcd=1,if=talent.initiative&talent.essence_break&time>1&(cooldown.essence_break.remains>15|cooldown.essence_break.remains<gcd.max*2&(buff.initiative.remains<gcd.max&!variable.holding_meta&cooldown.eye_beam.remains=gcd.remains&(raid_event.adds.in>(40-talent.cycle_of_hatred*15))&fury>30|!talent.demonic|buff.metamorphosis.up|cooldown.eye_beam.remains>15+(10*talent.cycle_of_hatred)))&talent.any_means_necessary
        if A.VengefulRetreat:IsReady(player) and useMovement and A.Initiative:IsTalentLearned() and A.EssenceBreak:IsTalentLearned() and combatTime > 1 and InMelee() and A.GetCurrentGCD() < 0.1 then
            if (A.EssenceBreak:GetCooldown() > 15 or (A.EssenceBreak:GetCooldown() < A.GetCurrentGCD() and (not A.Demonic:IsTalentLearned() or Unit(player):HasBuffs(A.Metamorphosis.ID) > 0 or A.EyeBeam:GetCooldown() > 15 + 10 * num(A.CycleofHatred:IsTalentLearned()))) and (combatTime < 30 or A.GetCurrentGCD() - 1 < 0) and not A.AnyMeansNecessary:IsTalentLearned() and (not A.Initiative:IsTalentLearned() or Unit(player):HasBuffs(A.Initiative.ID) < A.GetCurrentGCD() or combatTime > 4)) then
                return A.VengefulRetreat:Show(icon)
            elseif (A.EssenceBreak:GetCooldown() > 15 or (A.EssenceBreak:GetCooldown() < A.GetCurrentGCD() * 2 and (Unit(player):HasBuffs(A.Initiative.ID) < A.GetCurrentGCD() and not holdingMeta and A.EyeBeam:GetCooldown() == A.GetCurrentGCD() and fury > 30 or not A.Demonic:IsTalentLearned() or Unit(player):HasBuffs(A.Metamorphosis.ID) > 0 or A.EyeBeam:GetCooldown() > 15 + 10 * num(A.CycleofHatred:IsTalentLearned()))) and A.AnyMeansNecessary:IsTalentLearned()) then
                return A.VengefulRetreat:Show(icon)
            end
        end

        -- actions+=/vengeful_retreat,use_off_gcd=1,if=talent.initiative&!talent.essence_break&time>1&!buff.momentum.up
        if A.VengefulRetreat:IsReady(player) and useMovement and InMelee() and A.GetCurrentGCD() < 0.1 and A.Initiative:IsTalentLearned() and not A.EssenceBreak:IsTalentLearned() and combatTime > 1 and Unit(player):HasBuffs(A.Momentum.ID) == 0 then
            return A.VengefulRetreat:Show(icon)
        end

        -- actions+=/fel_rush,if=talent.momentum.enabled&buff.momentum.remains<gcd.max*2&(charges_fractional>1.8|cooldown.eye_beam.remains<3)&debuff.essence_break.down&cooldown.blade_dance.remains
        if A.FelRush:IsReady(player) and useMovement and Unit(unitID):GetRange() < 15 and A.Momentum:IsTalentLearned() and Unit(player):HasBuffs(A.Momentum.ID) < A.GetGCD() * 2 and (A.FelRush:GetSpellChargesFrac() > 1.8 or A.EyeBeam:GetCooldown() < 3) and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 and A.BladeDance:GetCooldown() > 0 then
            return A.FelRush:Show(icon)
        end

        -- actions+=/essence_break,if=(active_enemies>desired_targets|raid_event.adds.in>40)&!variable.waiting_for_momentum&(buff.metamorphosis.remains>gcd.max*3|cooldown.eye_beam.remains>10)&(!talent.tactical_retreat|buff.tactical_retreat.up|time<10)&buff.vengeful_retreat_movement.remains<gcd.max*0.5&cooldown.blade_dance.remains<=3.1*gcd.max|fight_remains<6
        if A.EssenceBreak:IsReady(player) and (activeEnemies >= desiredTargets or Unit(unitID):IsBoss()) and not waitingForMomentum and (Unit(player):HasBuffs(A.Metamorphosis.ID) > A.GetGCD() * 3 or A.EyeBeam:GetCooldown() > 10) and (not A.TacticalRetreat:IsTalentLearned() or Unit(player):HasBuffs(A.TacticalRetreat.ID) > 0 or combatTime < 10) and isBackflip and A.BladeDance:GetCooldown() <= A.GetGCD() * 3.1 or (fightRemains < 6 and Unit(unitID):IsBoss()) then
            return A.EssenceBreak:Show(icon)
        end

        -- actions+=/death_sweep,if=variable.blade_dance&(!talent.essence_break|cooldown.essence_break.remains>gcd.max*2)
        if A.BladeDance:IsReady(player) and InMelee() and useBladeDance and (not A.EssenceBreak:IsTalentLearned() or A.EssenceBreak:GetCooldown() > A.GetGCD() * 2) then
            return A.BladeDance:Show(icon)
        end

        -- actions+=/fel_barrage,if=active_enemies>desired_targets|raid_event.adds.in>30
        if A.FelBarrage:IsReady(player) and activeEnemies >= desiredTargets then
            return A.FelBarrage:Show(icon)
        end

        -- actions+=/glaive_tempest,if=(active_enemies>desired_targets|raid_event.adds.in>10)&(debuff.essence_break.down|active_enemies>1)
        if A.GlaiveTempest:IsReady(player) and InMelee() and (activeEnemies >= desiredTargets or Unit(unitID):IsBoss()) and (Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 or activeEnemies > 1) then
            return A.GlaiveTempest:Show(icon)
        end

        -- actions+=/annihilation,if=buff.inner_demon.up&cooldown.eye_beam.remains<=gcd
        if A.ChaosStrike:IsReady(unitID) and Unit(player):HasBuffs(A.InnerDemon.ID) > 0 and A.EyeBeam:GetCooldown() <= A.GetGCD() then
            return A.ChaosStrike:Show(icon)
        end

        -- actions+=/fel_rush,if=talent.momentum.enabled&cooldown.eye_beam.remains<gcd.max*3&buff.momentum.remains<5&buff.metamorphosis.down
        if A.FelRush:IsReady(player) and A.Momentum:IsTalentLearned() and A.EyeBeam:GetCooldown() < A.GetGCD() * 3 and Unit(player):HasBuffs(A.Momentum.ID) < 5 and Unit(player):HasBuffs(A.Metamorphosis.ID) == 0 then
            return A.FelRush:Show(icon)
        end

        -- actions+=/the_hunt,if=debuff.essence_break.down&(time<10|cooldown.metamorphosis.remains>10|!equipped.algethar_puzzle_box)&(raid_event.adds.in>90|active_enemies>3|time_to_die<10)&(time>6&debuff.essence_break.down&(!talent.furious_gaze|buff.furious_gaze.up)|!set_bonus.tier30_2pc)
        if A.TheHunt:IsReady(unitID) and useBurst and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 and (combatTime < 10 or A.Metamorphosis:GetCooldown() > 10) and (activeEnemies > 3 or Unit(unitID):TimeToDie() < 10 and Unit(unitID):IsBoss()) and (combatTime > 6 and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 and (not A.FuriousGaze:IsTalentLearned() or Unit(player):HasBuffs(A.FuriousGaze.ID) > 0) or not T30has2P) then
            return A.TheHunt:Show(icon)
        end

        -- actions+=/eye_beam,if=active_enemies>desired_targets|raid_event.adds.in>(40-talent.cycle_of_hatred*15)&!debuff.essence_break.up&(cooldown.metamorphosis.remains>40-talent.cycle_of_hatred*15|!variable.holding_meta)&(buff.metamorphosis.down|buff.metamorphosis.remains>gcd.max|!talent.restless_hunter)|fight_remains<15
        if A.EyeBeam:IsReady(player) and (activeEnemies >= desiredTargets) and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 and (A.Metamorphosis:GetCooldown() > (40 - num(A.CycleofHatred:IsTalentLearned()) * 15) or not holdingMeta) and (Unit(player):HasBuffs(A.Metamorphosis.ID) == 0 or Unit(player):HasBuffs(A.Metamorphosis.ID) > A.GetGCD() or not A.RestlessHunter:IsTalentLearned()) or (fightRemains < 15 and Unit(unitID):IsBoss()) then
            return A.EyeBeam:Show(icon)
        end        
        -- actions+=/blade_dance,if=variable.blade_dance&(cooldown.eye_beam.remains>5|equipped.algethar_puzzle_box&cooldown.metamorphosis.remains>(cooldown.blade_dance.duration)|!talent.demonic|(raid_event.adds.in>cooldown&raid_event.adds.in<25))
        if A.BladeDance:IsReady(player) and InMelee() and bladeDance and (A.EyeBeam:GetCooldown() > 5 or not A.Demonic:IsTalentLearned()) then
            return A.BladeDance:Show(icon)
        end        
        -- actions+=/sigil_of_flame,if=talent.any_means_necessary&debuff.essence_break.down&active_enemies>=4
        if A.SigilofFlame:IsReady(player) and (InMelee() or A.PreciseSigils:IsTalentLearned()) and A.AnyMeansNecessary:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 and activeEnemies >= 4 then
            return A.SigilofFlame:Show(icon)
        end

        -- actions+=/throw_glaive,if=talent.soulrend&(active_enemies>desired_targets|raid_event.adds.in>full_recharge_time+9)&spell_targets>=(2-talent.furious_throws)&!debuff.essence_break.up&(full_recharge_time<gcd.max*3|active_enemies>1)
        if A.ThrowGlaive:IsReady(unitID) and A.Soulrend:IsTalentLearned() and (activeEnemies >= desiredTargets) and spellTargets >= (2 - num(A.FuriousThrows:IsTalentLearned())) and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 and (A.ThrowGlaive:GetSpellChargesFullRechargeTime() < A.GetGCD() * 3 or activeEnemies > 1) then
            return A.ThrowGlaive:Show(icon)
        end
        
        -- actions+=/sigil_of_flame,if=talent.any_means_necessary&debuff.essence_break.down
        if A.SigilofFlame:IsReady(player) and (InMelee() or A.PreciseSigils:IsTalentLearned()) and A.AnyMeansNecessary:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 then
            return A.SigilofFlame:Show(icon)
        end        

        -- actions+=/immolation_aura,if=active_enemies>=2&fury<70&debuff.essence_break.down
        if A.ImmolationAura:IsReady(player) and InMelee() and activeEnemies >= 2 and fury < 70 and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 then
            return A.ImmolationAura:Show(icon)
        end

        -- actions+=/annihilation,if=!variable.pooling_for_blade_dance|set_bonus.tier30_2pc
        if A.ChaosStrike:IsReady(unitID) and (not poolingForBladeDance or T30has2P) then
            return A.ChaosStrike:Show(icon)
        end

        -- actions+=/throw_glaive,if=talent.soulrend&(active_enemies>desired_targets|raid_event.adds.in>full_recharge_time+9)&spell_targets>=(2-talent.furious_throws)&!debuff.essence_break.up
        if A.ThrowGlaive:IsReady(unitID) and A.Soulrend:IsTalentLearned() and (activeEnemies >= desiredTargets or Unit(unitID):IsBoss()) and spellTargets >= (2 - num(A.FuriousThrows:IsTalentLearned())) and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) == 0 then
            return A.ThrowGlaive:Show(icon)
        end

        -- actions+=/immolation_aura,if=!buff.immolation_aura.up&(!talent.ragefire|active_enemies>desired_targets|raid_event.adds.in>15)&buff.out_of_range.down
        if A.ImmolationAura:IsReady(player) and InMelee() and Unit(player):HasBuffs(A.ImmolationAura.ID) == 0 and (not A.Ragefire:IsTalentLearned() or activeEnemies >= desiredTargets) then
            return A.ImmolationAura:Show(icon)
        end

        -- actions+=/fel_rush,if=talent.isolated_prey&active_enemies=1&fury.deficit>=35
        if A.FelRush:IsReady(player) and useMovement and A.IsolatedPrey:IsTalentLearned() and activeEnemies == 1 and furyDeficit >= 35 then
            return A.FelRush:Show(icon)
        end
        
        -- actions+=/chaos_strike,if=!variable.pooling_for_blade_dance&!variable.pooling_for_eye_beam
        if A.ChaosStrike:IsReady(unitID) and not poolingForBladeDance and not poolingForEyeBeam then
            return A.ChaosStrike:Show(icon)
        end

        -- actions+=/sigil_of_flame,if=raid_event.adds.in>15&fury.deficit>=30&buff.out_of_range.down
        if A.SigilofFlame:IsReady(player) and InMelee() and furyDeficit >= 30 then
            return A.SigilofFlame:Show(icon)
        end

        -- actions+=/felblade,if=fury.deficit>=40&buff.out_of_range.down
        if A.Felblade:IsReady(unitID) and furyDeficit >= 40 then
            return A.Felblade:Show(icon)
        end

        -- actions+=/fel_rush,if=!talent.momentum&talent.demon_blades&!cooldown.eye_beam.ready&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
        if A.FelRush:IsReady(player) and useMovement and not A.Momentum:IsTalentLearned() and A.DemonBlades:IsTalentLearned() and A.EyeBeam:GetCooldown() > 0 and A.FelRush:GetSpellCharges() == 2 then
            return A.FelRush:Show(icon)
        end

        -- actions+=/demons_bite,target_if=min:debuff.burning_wound.remains,if=talent.burning_wound&debuff.burning_wound.remains<4&active_dot.burning_wound<(spell_targets>?3)


        -- actions+=/fel_rush,if=!talent.momentum&!talent.demon_blades&spell_targets>1&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
        if A.FelRush:IsReady(player) and useMovement and not A.Momentum:IsTalentLearned() and not A.DemonBlades:IsTalentLearned() and spellTargets > 1 and A.FelRush:GetSpellCharges() == 2 then
            return A.FelRush:Show(icon)
        end

        -- actions+=/sigil_of_flame,if=raid_event.adds.in>15&fury.deficit>=30&buff.out_of_range.down
        if A.SigilofFlame:IsReady(player) and furyDeficit >= 30 and InMelee() then
            return A.SigilofFlame:Show(icon)
        end

        -- actions+=/demons_bite
        if A.DemonsBite:IsReady(unitID) and not A.DemonBlades:IsTalentLearned() then
            return A.DemonsBite:Show(icon)
        end




        --[[ actions+=/vengeful_retreat,use_off_gcd=1,if=talent.initiative&talent.essence_break&time>1&(cooldown.essence_break.remains>15|cooldown.essence_break.remains<gcd.max&(!talent.demonic|buff.metamorphosis.up|cooldown.eye_beam.remains>15+(10*talent.cycle_of_hatred)))
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
        end]]

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