--###############################
--##### TRIP'S ARMS WARRIOR #####
--###############################

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

Action[ACTION_CONST_WARRIOR_ARMS] = {
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
    WilltoSurvive			= Action.Create({ Type = "Spell", ID = 59752    }),
    LightsJudgment				= Action.Create({ Type = "Spell", ID = 255647   }), 

    Charge         = Action.Create({ Type = "Spell", ID = 100 }),
    Taunt          = Action.Create({ Type = "Spell", ID = 355 }),
    Slam           = Action.Create({ Type = "Spell", ID = 1464 }),
    Whirlwind      = Action.Create({ Type = "Spell", ID = 1680 }),
    Hamstring      = Action.Create({ Type = "Spell", ID = 1715 }),
    ShieldBlock    = Action.Create({ Type = "Spell", ID = 2565 }),
    ShieldBlockBuff    = Action.Create({ Type = "Spell", ID = 132404 }),
    Execute        = Action.Create({ Type = "Spell", ID = 5308 }),
    Pummel         = Action.Create({ Type = "Spell", ID = 6552 }),
    BattleShout    = Action.Create({ Type = "Spell", ID = 6673 }),
    Devastate      = Action.Create({ Type = "Spell", ID = 20243 }),
    ShieldSlam     = Action.Create({ Type = "Spell", ID = 23922 }),
    VictoryRush    = Action.Create({ Type = "Spell", ID = 34428 }),
    HeroicThrow    = Action.Create({ Type = "Spell", ID = 57755 }),
    Attack         = Action.Create({ Type = "Spell", ID = 88163 }),
    Rend           = Action.Create({ Type = "Spell", ID = 772 }),
    RendDebuff           = Action.Create({ Type = "Spell", ID = 388539 }),
    Cleave         = Action.Create({ Type = "Spell", ID = 845 }),
    ShieldWall     = Action.Create({ Type = "Spell", ID = 871 }),
    DemoralizingShout= Action.Create({ Type = "Spell", ID = 1160 }),
    ChallengingShout= Action.Create({ Type = "Spell", ID = 1161 }),
    Recklessness   = Action.Create({ Type = "Spell", ID = 1719 }),
    Intervene      = Action.Create({ Type = "Spell", ID = 3411 }),
    IntimidatingShout= Action.Create({ Type = "Spell", ID = 5246 }),
    ThunderClap    = Action.Create({ Type = "Spell", ID = 6343 }),
    HeroicLeap     = Action.Create({ Type = "Spell", ID = 6544 }),
    Revenge        = Action.Create({ Type = "Spell", ID = 6572 }),
    Overpower      = Action.Create({ Type = "Spell", ID = 7384 }),
    MortalStrike   = Action.Create({ Type = "Spell", ID = 12294 }),
    PiercingHowl   = Action.Create({ Type = "Spell", ID = 12323 }),
    ImprovedWhirlwind= Action.Create({ Type = "Spell", ID = 12950 }),
    LastStand      = Action.Create({ Type = "Spell", ID = 12975 }),
    BerserkerRage  = Action.Create({ Type = "Spell", ID = 18499 }),
    Bloodthirst    = Action.Create({ Type = "Spell", ID = 23881 }),
    SpellReflection= Action.Create({ Type = "Spell", ID = 23920 }),
    SuddenDeath    = Action.Create({ Type = "Spell", ID = 29725 }),
    SuddenDeathBuff    = Action.Create({ Type = "Spell", ID = 52437 }),
    SecondWind     = Action.Create({ Type = "Spell", ID = 29838 }),
    Shockwave      = Action.Create({ Type = "Spell", ID = 46968 }),
    ShatteringThrow= Action.Create({ Type = "Spell", ID = 64382 }),
    SingleMindedFury= Action.Create({ Type = "Spell", ID = 81099 }),
    RagingBlow     = Action.Create({ Type = "Spell", ID = 85288 }),
    RallyingCry    = Action.Create({ Type = "Spell", ID = 97462 }),
    DoubleTime     = Action.Create({ Type = "Spell", ID = 103827 }),
    StormBolt      = Action.Create({ Type = "Spell", ID = 107570 }),
    Avatar         = Action.Create({ Type = "Spell", ID = 107574 }),
    DiebytheSword  = Action.Create({ Type = "Spell", ID = 118038 }),
    AngerManagement= Action.Create({ Type = "Spell", ID = 152278 }),
    ColossusSmash  = Action.Create({ Type = "Spell", ID = 167105 }),
    ColossusSmashDebuff  = Action.Create({ Type = "Spell", ID = 208086 }),
    EnragedRegeneration= Action.Create({ Type = "Spell", ID = 184364 }),
    Rampage        = Action.Create({ Type = "Spell", ID = 184367 }),
    Tactician      = Action.Create({ Type = "Spell", ID = 184783 }),
    IgnorePain     = Action.Create({ Type = "Spell", ID = 190456 }),
    Indomitable    = Action.Create({ Type = "Spell", ID = 202095 }),
    BoundingStride = Action.Create({ Type = "Spell", ID = 202163 }),
    ImpendingVictory= Action.Create({ Type = "Spell", ID = 202168 }),
    FervorofBattle = Action.Create({ Type = "Spell", ID = 202316 }),
    BestServedCold = Action.Create({ Type = "Spell", ID = 202560 }),
    IntotheFray    = Action.Create({ Type = "Spell", ID = 202603 }),
    BoomingVoice   = Action.Create({ Type = "Spell", ID = 202743 }),
    HeavyRepercussions= Action.Create({ Type = "Spell", ID = 203177 }),
    CracklingThunder= Action.Create({ Type = "Spell", ID = 203201 }),
    Massacre       = Action.Create({ Type = "Spell", ID = 206315 }),
    Warpaint       = Action.Create({ Type = "Spell", ID = 208154 }),
    FreshMeat      = Action.Create({ Type = "Spell", ID = 215568 }),
    FrothingBerserker= Action.Create({ Type = "Spell", ID = 215571 }),
    Bladestorm     = Action.Create({ Type = "Spell", ID = 227847 }),
    Ravager        = Action.Create({ Type = "Spell", ID = 228920 }),
    Devastator     = Action.Create({ Type = "Spell", ID = 236279 }),
    InForTheKill   = Action.Create({ Type = "Spell", ID = 248621 }),
    Skullsplitter  = Action.Create({ Type = "Spell", ID = 260643 }),
    SweepingStrikes= Action.Create({ Type = "Spell", ID = 260708 }),
    Dreadnaught    = Action.Create({ Type = "Spell", ID = 262150 }),
    Warbreaker     = Action.Create({ Type = "Spell", ID = 262161 }),
    WarMachine     = Action.Create({ Type = "Spell", ID = 262231 }),
    Punish         = Action.Create({ Type = "Spell", ID = 275334 }),
    UnstoppableForce= Action.Create({ Type = "Spell", ID = 275336 }),
    Menace         = Action.Create({ Type = "Spell", ID = 275338 }),
    RumblingEarth  = Action.Create({ Type = "Spell", ID = 275339 }),
    Bolster        = Action.Create({ Type = "Spell", ID = 280001 }),
    MeatCleaver    = Action.Create({ Type = "Spell", ID = 280392 }),
    Onslaught      = Action.Create({ Type = "Spell", ID = 315720 }),
    ImprovedExecute= Action.Create({ Type = "Spell", ID = 316402 }),
    MartialProwess = Action.Create({ Type = "Spell", ID = 316440 }),
    CollateralDamage= Action.Create({ Type = "Spell", ID = 334779 }),
    Frenzy         = Action.Create({ Type = "Spell", ID = 335077 }),
    SpearofBastion = Action.Create({ Type = "Spell", ID = 376079 }),
    LeechingStrikes= Action.Create({ Type = "Spell", ID = 382258 }),
    FastFootwork   = Action.Create({ Type = "Spell", ID = 382260 }),
    InspiringPresence= Action.Create({ Type = "Spell", ID = 382310 }),
    HonedReflexes  = Action.Create({ Type = "Spell", ID = 382461 }),
    PainandGain    = Action.Create({ Type = "Spell", ID = 382549 }),
    CrushingForce  = Action.Create({ Type = "Spell", ID = 382764 }),
    OverwhelmingRage= Action.Create({ Type = "Spell", ID = 382767 }),
    OneHandedWeaponSpecialization= Action.Create({ Type = "Spell", ID = 382895 }),
    TwoHandedWeaponSpecialization= Action.Create({ Type = "Spell", ID = 382896 }),
    DualWieldSpecialization= Action.Create({ Type = "Spell", ID = 382900 }),
    ReinforcedPlates= Action.Create({ Type = "Spell", ID = 382939 }),
    EnduranceTraining= Action.Create({ Type = "Spell", ID = 382940 }),
    WildStrikes    = Action.Create({ Type = "Spell", ID = 382946 }),
    PiercingVerdict= Action.Create({ Type = "Spell", ID = 382948 }),
    StormofSteel   = Action.Create({ Type = "Spell", ID = 382953 }),
    CacophonousRoar= Action.Create({ Type = "Spell", ID = 382954 }),
    SeismicReverberation= Action.Create({ Type = "Spell", ID = 382956 }),
    BarbaricTraining= Action.Create({ Type = "Spell", ID = 383082 }),
    FueledbyViolence= Action.Create({ Type = "Spell", ID = 383103 }),
    ConcussiveBlows= Action.Create({ Type = "Spell", ID = 383115 }),
    Bloodletting   = Action.Create({ Type = "Spell", ID = 383154 }),
    ExhilaratingBlows= Action.Create({ Type = "Spell", ID = 383219 }),
    Bloodborne     = Action.Create({ Type = "Spell", ID = 383287 }),
    Juggernaut     = Action.Create({ Type = "Spell", ID = 383292 }),
    JuggernautBuff     = Action.Create({ Type = "Spell", ID = 383290 }),
    ReapingSwings  = Action.Create({ Type = "Spell", ID = 383293 }),
    DeftExperience = Action.Create({ Type = "Spell", ID = 383295 }),
    CriticalThinking= Action.Create({ Type = "Spell", ID = 383297 }),
    MercilessBonegrinder= Action.Create({ Type = "Spell", ID = 383317 }),
    MercilessBonegrinderBuff= Action.Create({ Type = "Spell", ID = 383316 }),
    ValorinVictory = Action.Create({ Type = "Spell", ID = 383338 }),
    SharpenedBlades= Action.Create({ Type = "Spell", ID = 383341 }),
    Impale         = Action.Create({ Type = "Spell", ID = 383430 }),
    BluntInstruments= Action.Create({ Type = "Spell", ID = 383442 }),
    SwiftStrikes   = Action.Create({ Type = "Spell", ID = 383459 }),
    InvigoratingFury= Action.Create({ Type = "Spell", ID = 383468 }),
    FocusinChaos   = Action.Create({ Type = "Spell", ID = 383486 }),
    FrenziedFlurry = Action.Create({ Type = "Spell", ID = 383605 }),
    Fatality       = Action.Create({ Type = "Spell", ID = 383703 }),
    BitterImmunity = Action.Create({ Type = "Spell", ID = 383762 }),
    ImprovedEnrage = Action.Create({ Type = "Spell", ID = 383848 }),
    ImprovedBloodthirst= Action.Create({ Type = "Spell", ID = 383852 }),
    ImprovedRagingBlow= Action.Create({ Type = "Spell", ID = 383854 }),
    HackandSlash   = Action.Create({ Type = "Spell", ID = 383877 }),
    ViciousContempt= Action.Create({ Type = "Spell", ID = 383885 }),
    Annihilator    = Action.Create({ Type = "Spell", ID = 383916 }),
    DepthsofInsanity= Action.Create({ Type = "Spell", ID = 383922 }),
    ColdSteelHotBlood= Action.Create({ Type = "Spell", ID = 383959 }),
    BrutalVitality = Action.Create({ Type = "Spell", ID = 384036 }),
    Strategist     = Action.Create({ Type = "Spell", ID = 384041 }),
    UnnervingFocus = Action.Create({ Type = "Spell", ID = 384042 }),
    EnduringAlacrity= Action.Create({ Type = "Spell", ID = 384063 }),
    FocusedVigor   = Action.Create({ Type = "Spell", ID = 384067 }),
    ImpenetrableWall= Action.Create({ Type = "Spell", ID = 384072 }),
    TitanicThrow   = Action.Create({ Type = "Spell", ID = 384090 }),
    BerserkerShout = Action.Create({ Type = "Spell", ID = 384100 }),
    WreckingThrow  = Action.Create({ Type = "Spell", ID = 384110 }),
    ArmoredtotheTeeth= Action.Create({ Type = "Spell", ID = 384124 }),
    BloodandThunder= Action.Create({ Type = "Spell", ID = 384277 }),
    ThunderousRoar = Action.Create({ Type = "Spell", ID = 384318 }),
    Bloodsurge     = Action.Create({ Type = "Spell", ID = 384361 }),
    Sidearm        = Action.Create({ Type = "Spell", ID = 384404 }),
    ThunderousWords= Action.Create({ Type = "Spell", ID = 384969 }),
    TestofMight    = Action.Create({ Type = "Spell", ID = 385008 }),
    TestofMightBuff    = Action.Create({ Type = "Spell", ID = 385013 }),
    OdynsFury      = Action.Create({ Type = "Spell", ID = 385059 }),
    StormofSwords  = Action.Create({ Type = "Spell", ID = 385512 }),
    ImprovedOverpower= Action.Create({ Type = "Spell", ID = 385571 }),
    ImprovedMortalStrike= Action.Create({ Type = "Spell", ID = 385573 }),
    Thunderlord    = Action.Create({ Type = "Spell", ID = 385840 }),
    ShowofForce    = Action.Create({ Type = "Spell", ID = 385843 }),
    ToughasNails   = Action.Create({ Type = "Spell", ID = 385888 }),
    ShieldCharge   = Action.Create({ Type = "Spell", ID = 385952 }),
    ShieldSpecialization= Action.Create({ Type = "Spell", ID = 386011 }),
    EnduringDefenses= Action.Create({ Type = "Spell", ID = 386027 }),
    BraceForImpact = Action.Create({ Type = "Spell", ID = 386030 }),
    ImprovedHeroicThrow= Action.Create({ Type = "Spell", ID = 386034 }),
    DisruptingShout= Action.Create({ Type = "Spell", ID = 386071 }),
    BattleStance   = Action.Create({ Type = "Spell", ID = 386164 }),
    BerserkerStance= Action.Create({ Type = "Spell", ID = 386196 }),
    DefensiveStance= Action.Create({ Type = "Spell", ID = 386208 }),
    ElysianMight   = Action.Create({ Type = "Spell", ID = 386285 }),
    ChampionsBulwark= Action.Create({ Type = "Spell", ID = 386328 }),
    TideofBlood    = Action.Create({ Type = "Spell", ID = 386357 }),
    BattleScarredVeteran= Action.Create({ Type = "Spell", ID = 386394 }),
    ViolentOutburst= Action.Create({ Type = "Spell", ID = 386477 }),
    ViolentOutburstBuff= Action.Create({ Type = "Spell", ID = 38647 }),
    Unhinged       = Action.Create({ Type = "Spell", ID = 386628 }),
    Battlelord     = Action.Create({ Type = "Spell", ID = 386630 }),
    ExecutionersPrecision= Action.Create({ Type = "Spell", ID = 386634 }),
    ExecutionersPrecisionDebuff= Action.Create({ Type = "Spell", ID = 386633 }),
    SlaughteringStrikes= Action.Create({ Type = "Spell", ID = 388004 }),
    RagingArmaments= Action.Create({ Type = "Spell", ID = 388049 }),
    StormWall      = Action.Create({ Type = "Spell", ID = 388807 }),
    Tenderize      = Action.Create({ Type = "Spell", ID = 388933 }),
    UnbridledFerocity= Action.Create({ Type = "Spell", ID = 389603 }),
    BerserkersTorment= Action.Create({ Type = "Spell", ID = 390123 }),
    TitansTorment  = Action.Create({ Type = "Spell", ID = 390135 }),
    BlademastersTorment= Action.Create({ Type = "Spell", ID = 390138 }),
    WarlordsTorment= Action.Create({ Type = "Spell", ID = 390140 }),
    FuriousBlows   = Action.Create({ Type = "Spell", ID = 390354 }),
    Hurricane      = Action.Create({ Type = "Spell", ID = 390563 }),
    HurricaneBuff      = Action.Create({ Type = "Spell", ID = 390581 }),
    DanceofDeath   = Action.Create({ Type = "Spell", ID = 390713 }),
    SonicBoom      = Action.Create({ Type = "Spell", ID = 390725 }),
    Uproar         = Action.Create({ Type = "Spell", ID = 391572 }),
    DancingBlades  = Action.Create({ Type = "Spell", ID = 391683 }),
    AshenJuggernaut= Action.Create({ Type = "Spell", ID = 392536 }),
    CruelStrikes   = Action.Create({ Type = "Spell", ID = 392777 }),
    Cruelty        = Action.Create({ Type = "Spell", ID = 392931 }),
    WrathandFury   = Action.Create({ Type = "Spell", ID = 392936 }),
    SpellBlock     = Action.Create({ Type = "Spell", ID = 392966 }),
    Bloodcraze     = Action.Create({ Type = "Spell", ID = 393950 }),
    ImmovableObject= Action.Create({ Type = "Spell", ID = 394307 }),
    Instigate      = Action.Create({ Type = "Spell", ID = 394311 }),
    BatteringRam   = Action.Create({ Type = "Spell", ID = 394312 }),
    TitanicRage    = Action.Create({ Type = "Spell", ID = 394329 }),
    RecklessAbandon= Action.Create({ Type = "Spell", ID = 396749 }),
    DefendersAegis = Action.Create({ Type = "Spell", ID = 397103 }),
    VanguardsDetermination = Action.Create({ Type = "Spell", ID = 394056 }),   
    DeepWounds = Action.Create({ Type = "Spell", ID = 262115 }),   
    Healthstone     = Action.Create({ Type = "Item", ID = 5512 }),
}

local A = setmetatable(Action[ACTION_CONST_WARRIOR_ARMS], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
local target = "target"
local pet = "pet"

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
    incomingAoEDamage                       = { 
                                                192305, -- Eye of the Storm (mini-boss)
                                                200901, -- Eye of the Storm (boss)
                                                153804, -- Inhale
                                                175988, -- Omen of Death
                                                106228, -- Nothingness
                                                388008, -- Absolute Zero
                                                191284, -- Horn of Valor (HoV)
    },
    incAoEMagic                             = { 372735, -- Tectonic Slam (RLP)
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
    },
}

local function InMelee(unitID)
    return A.Slam:IsInRange(unitID)
end 
InMelee = A.MakeFunctionCachedDynamic(InMelee)

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

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end  

	if A.CanUseHealthstoneOrHealingPotion() then
		return A.Healthstone
	end

    local noDefensiveActive = Unit(player):HasBuffs(A.DiebytheSword.ID) == 0 and Unit(player):HasBuffs(A.RallyingCry.ID) == 0 and Unit(player):HasBuffs(A.DefensiveStance.ID) == 0 and Unit(player):HasBuffs(A.SpellReflection.ID) == 0

    local useRacial = A.GetToggle(1, "Racial")

    if noDefensiveActive then
        if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incAoEMagic) >= 1 then
            if A.SpellReflection:IsReady(player) then
                return A.SpellReflection
            end
            if A.DiebytheSword:IsReady(player) then
                return A.EscapeArtist
            end
            if A.RallyingCry:IsReady(player) then
                return A.RallyingCry:Show(icon)
            end
            if A.DefensiveStance:IsReady(player) then
                return A.DefensiveStance:Show(icon)
            end
        end
        if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1 then
            if A.DiebytheSword:IsReady(player) then
                return A.EscapeArtist
            end
            if A.RallyingCry:IsReady(player) then
                return A.RallyingCry:Show(icon)
            end
            if A.DefensiveStance:IsReady(player) then
                return A.DefensiveStance:Show(icon)
            end
        end
    end

	if A.BerserkerRage:IsReady(player) and (LoC:Get("FEAR") > 0 or LoC:Get("INCAPACITATE") > 0) then
		return A.BerserkerRage
	end

	if A.WilltoSurvive:IsReady(player) and useRacial and LoC:Get("STUN") > 0 then
		return A.WilltoSurvive
	end

    local BitterImmunityHP = A.GetToggle(2, "BitterImmunityHP")
    if A.BitterImmunity:IsReady(player) and Unit(player):HealthPercent() <= BitterImmunityHP then
        return A.BitterImmunity
    end

    local DiebytheSwordHP = A.GetToggle(2, "DiebytheSwordHP")
    if A.DiebytheSword:IsReady(player) and Unit(player):HealthPercent() <= DiebytheSwordHP then
        return A.EscapeArtist
    end

    local VictoryRushHP = A.GetToggle(2, "VictoryRushHP")
    if A.VictoryRush:IsReady(player) and Unit(player):HealthPercent() <= VictoryRushHP then
        return A.VictoryRush
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        if useKick and not notInterruptable and A.Pummel:IsReady(unitID, nil, nil, true) then 
            return A.Pummel
        end
        if useCC and A.StormBolt:IsReady(unitID) then 
            return A.StormBolt
        end
        if useCC and A.IntimidatingShout:IsReady(unitID) then 
            return A.IntimidatingShout
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

A[3] = function(icon, isMulti)
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local TTD = MultiUnits.GetByRangeAreaTTD(10)
    local useRacial = A.GetToggle(1, "Racial")
    local rage = Player:Rage()
    local rageDeficit = Player:RageDeficit()
    local activeEnemies = MultiUnits:GetByRange(10, 4)

    Player:AddTier("Tier29", { 200426, 200428, 200423, 200425, 200427, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

    local function DamageRotation(unitID)

        local inMelee = A.Slam:IsInRange(unitID)
        local useBurst = BurstIsON(unitID) and (Unit(unitID):TimeToDie() > 15 or TTD > 15)
        local executeRange = Unit(unitID):HealthPercent() < 25 or Unit(unitID):HealthPercent() < 35 and A.Massacre:IsTalentLearned()

        -- Defensive
        local SelfDefensive = SelfDefensives()
        if SelfDefensive then 
            return SelfDefensive:Show(icon)
        end 

        -- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end 

        local UseTrinket = UseTrinkets(unitID)
        if UseTrinket and Unit(unitID):GetRange() <= 10 then
            return UseTrinket:Show(icon)
        end    

        -- actions+=/potion,if=gcd.remains=0&debuff.colossus_smash.remains>8|target.time_to_die<25
        -- actions+=/pummel,if=target.debuff.casting.react
        -- actions+=/use_item,name=manic_grieftorch,if=!buff.avatar.up&!debuff.colossus_smash.up

        if useRacial and useBurst and inMelee then
            -- actions+=/blood_fury,if=debuff.colossus_smash.up
            if A.BloodFury:IsReady(player) and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 then
                return A.BloodFury:Show(icon)
            end
            -- actions+=/berserking,if=debuff.colossus_smash.remains>6
            if A.Berserking:IsReady(player) and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 6 then
                return A.Berserking:Show(icon)
            end
            -- actions+=/arcane_torrent,if=cooldown.mortal_strike.remains>1.5&rage<50
            if A.ArcaneTorrent:IsReady(player) and A.MortalStrike:GetCooldown() > 1.5 and rage < 50 then
                return A.ArcaneTorrent:Show(icon)
            end
            -- actions+=/lights_judgment,if=debuff.colossus_smash.down&cooldown.mortal_strike.remains
            if A.LightsJudgment:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 and A.MortalStrike:GetCooldown() > 0 then
                return A.LightsJudgment:Show(icon)
            end
            -- actions+=/fireblood,if=debuff.colossus_smash.up
            if A.Fireblood:IsReady(player) and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 then
                return A.Fireblood:Show(icon)
            end
            -- actions+=/ancestral_call,if=debuff.colossus_smash.up
            if A.AncestralCall:IsReady(player) and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 then
                return A.AncestralCall:Show(icon)
            end
            -- actions+=/bag_of_tricks,if=debuff.colossus_smash.down&cooldown.mortal_strike.remains
            if A.BagofTricks:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 and A.MortalStrike:GetCooldown() > 0 then
                return A.BagofTricks:Show(icon)
            end
        end
        -- actions+=/use_item,name=manic_grieftorch

        local function Execute(unitID)

            -- actions.execute=sweeping_strikes,if=spell_targets.whirlwind>1
            if A.SweepingStrikes:IsReady(player) and inMelee and activeEnemies > 1 then
                return A.SweepingStrikes:Show(icon)
            end
            -- actions.execute+=/rend,if=remains<=gcd&(!talent.warbreaker&cooldown.colossus_smash.remains<4|talent.warbreaker&cooldown.warbreaker.remains<4)&target.time_to_die>12
            if A.Rend:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.RendDebuff.ID) <= A.GetGCD() and (not A.Warbreaker:IsTalentLearned() and A.ColossusSmash:GetCooldown() < 4 or A.Warbreaker:IsTalentLearned() and A.Warbreaker:GetCooldown() < 4) and Unit(unitID):TimeToDie() > 12 then
                return A.Rend:Show(icon)
            end
            -- actions.execute+=/avatar,if=cooldown.colossus_smash.ready|debuff.colossus_smash.up|target.time_to_die<20
            if A.Avatar:IsReady(player) and inMelee and useBurst and (A.ColossusSmash:GetCooldown() == 0 or Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0) then
                return A.Avatar:Show(icon)
            end
            -- actions.execute+=/warbreaker
            if A.Warbreaker:IsReady(player) and inMelee then
                return A.Warbreaker:Show(icon)
            end
            -- actions.execute+=/colossus_smash
            if A.ColossusSmash:IsReady(unitID) and not A.Warbreaker:IsTalentLearned() then
                return A.ColossusSmash:Show(icon)
            end
            -- actions.execute+=/thunderous_roar,if=buff.test_of_might.up|!talent.test_of_might&debuff.colossus_smash.up
            if A.ThunderousRoar:IsReady(player) and inMelee and useBurst and (Unit(player):HasBuffs(A.TestofMightBuff.ID) or not A.TestofMight:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0) then
                return A.ThunderousRoar:Show(icon)
            end
            -- actions.execute+=/spear_of_bastion,if=debuff.colossus_smash.up|buff.test_of_might.up
            if A.SpearofBastion:IsReady(player) and inMelee and useBurst and (Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 or Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0) then
                return A.SpearofBastion:Show(icon)
            end
            -- actions.execute+=/skullsplitter,if=rage<40
            if A.Skullsplitter:IsReady(unitID) and rage < 40 then
                return A.Skullsplitter:Show(icon)
            end
            -- actions.execute+=/cleave,if=spell_targets.whirlwind>2&dot.deep_wounds.remains<gcd
            if A.Cleave:IsReady(player) and inMelee and activeEnemies > 2 and Unit(unitID):HasDeBuffs(A.DeepWounds.ID, true) < A.GetGCD() then
                return A.Cleave:Show(icon)
            end
            -- actions.execute+=/overpower,if=rage<40&buff.martial_prowess.stack<2
            if A.Overpower:IsReady(unitID) and rage < 40 and Unit(player):HasBuffsStacks(A.Overpower.ID) < 2 then
                return A.Overpower:Show(icon)
            end
            -- actions.execute+=/mortal_strike,if=debuff.executioners_precision.stack=2|dot.deep_wounds.remains<=gcd
            if A.MortalStrike:IsReady(unitID) and (Unit(unitID):HasDeBuffsStacks(A.ExecutionersPrecisionDebuff.ID) == 2 or Unit(unitID):HasDeBuffs(A.DeepWounds.ID, true) <= A.GetGCD()) then
                return A.Execute:Show(icon)
            end
            -- actions.execute+=/execute
            if A.Execute:IsReady(unitID) then
                return A.Execute:Show(icon)
            end
            -- actions.execute+=/shockwave,if=talent.sonic_boom
            if A.Shockwave:IsReady(unitID) and inMelee and A.SonicBoom:IsTalentLearned() then
                return A.Shockwave:Show(icon)
            end
            -- actions.execute+=/overpower
            if A.Overpower:IsReady(unitID) then
                return A.Overpower:Show(icon)
            end
            -- actions.execute+=/bladestorm
            if A.Bladestorm:IsReady(player) and inMelee and useBurst then
                return A.Bladestorm:Show(icon)
            end

        end

        local function HAC(unitID)
            -- actions.hac=execute,if=buff.juggernaut.up&buff.juggernaut.remains<gcd
            if A.Execute:IsReady(unitID) and Unit(player):HasBuffs(A.JuggernautBuff.ID) > 0 and Unit(player):HasBuffs(A.JuggernautBuff.ID) < A.GetGCD() then
                return A.Execute:Show(icon)
            end
            -- actions.hac+=/thunder_clap,if=active_enemies>2&talent.thunder_clap&talent.blood_and_thunder&talent.rend&dot.rend.remains<=dot.rend.duration*0.3
            if A.ThunderClap:IsReady(player) and activeEnemies > 2 and A.BloodandThunder:IsTalentLearned() and A.Rend:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.Rend.ID, true) <= A.Rend:GetSpellPandemicThreshold() then
                return A.ThunderClap:Show(icon)
            end
            -- actions.hac+=/sweeping_strikes,if=active_enemies>=2&(cooldown.bladestorm.remains>15|!talent.bladestorm)
            if A.SweepingStrikes:IsReady(player) and activeEnemies >= 2 and (A.Bladestorm:GetCooldown() > 15 or not BurstIsON(unitID) or not A.Bladestorm:IsTalentLearned()) then
                return A.SweepingStrikes:Show(icon)
            end
            -- actions.hac+=/rend,if=active_enemies=1&remains<=gcd&(target.health.pct>20|talent.massacre&target.health.pct>35)|talent.tide_of_blood&cooldown.skullsplitter.remains<=gcd&(cooldown.colossus_smash.remains<=gcd|debuff.colossus_smash.up)&dot.rend.remains<dot.rend.duration*0.85
            if A.Rend:IsReady(unitID) and activeEnemies == 1 and Unit(unitID):HasDeBuffs(A.Rend.ID, true) <= A.GetGCD() then
                if not executeRange or A.TideofBlood:IsTalentLearned() and A.Skullsplitter:GetCooldown() <= A.GetGCD() and (A.ColossusSmash:GetCooldown() <= A.GetGCD() or Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0) and Unit(unitID):HasDeBuffs(A.Rend.ID, true) < A.Rend:GetSpellBaseDuration() * 0.85 then
                    return A.Rend:Show(icon)
                end
            end
            -- actions.hac+=/avatar,if=raid_event.adds.in>15|talent.blademasters_torment&active_enemies>1|target.time_to_die<20
            if A.Avatar:IsReady(player) and inMelee and useBurst then
                return A.Avatar:Show(icon)
            end
            -- actions.hac+=/warbreaker,if=raid_event.adds.in>22|active_enemies>1
            if A.Warbreaker:IsReady(player) and inMelee then
                return A.Warbreaker:Show(icon)
            end
            -- actions.hac+=/colossus_smash,cycle_targets=1,if=(target.health.pct<20|talent.massacre&target.health.pct<35)
            -- actions.hac+=/colossus_smash
            if A.ColossusSmash:IsReady(unitID) and not A.Warbreaker:IsTalentLearned() then
                return A.ColossusSmash:Show(icon)
            end
            -- actions.hac+=/thunderous_roar,if=(buff.test_of_might.up|!talent.test_of_might&debuff.colossus_smash.up)&raid_event.adds.in>15|active_enemies>1&dot.deep_wounds.remains
            if A.ThunderousRoar:IsReady(player) and inMelee and useBurst then
                if (Unit(player):HasBuffs(A.TestofMightBuff.ID) or not A.TestofMight:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0) or Unit(unitID):HasDeBuffs(A.DeepWounds.ID, true) > 0 then
                    return A.ThunderousRoar:Show(icon)
                end
            end
            -- actions.hac+=/spear_of_bastion,if=(buff.test_of_might.up|!talent.test_of_might&debuff.colossus_smash.up)&raid_event.adds.in>15
            if A.SpearofBastion:IsReady(player) and inMelee and useBurst then
                if Unit(player):HasBuffs(A.TestofMightBuff.ID) or not A.TestofMight:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 then
                    return A.SpearofBastion:Show(icon)
                end
            end
            -- actions.hac+=/bladestorm,if=talent.unhinged&(buff.test_of_might.up|!talent.test_of_might&debuff.colossus_smash.up)
            -- actions.hac+=/bladestorm,if=active_enemies>1&(buff.test_of_might.up|!talent.test_of_might&debuff.colossus_smash.up)&raid_event.adds.in>30|active_enemies>1&dot.deep_wounds.remains
            if A.Bladestorm:IsReady(player) and inMelee and useBurst then
                if Unit(player):HasBuffs(A.TestofMightBuff.ID) or not A.TestofMight:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 or Unit(unitID):HasDeBuffs(A.DeepWounds.ID, true) then
                    return A.Bladestorm:Show(icon)
                end
            end
            -- actions.hac+=/cleave,if=active_enemies>2|!talent.battlelord&buff.merciless_bonegrinder.up&cooldown.mortal_strike.remains>gcd
            if A.Cleave:IsReady(player) and not A.Battlelord:IsTalentLearned() and Unit(player):HasBuffs(A.MercilessBonegrinderBuff.ID) > 0 and A.MortalStrike:GetCooldown() > A.GetGCD() then
                return A.Cleave:Show(icon)
            end
            -- actions.hac+=/whirlwind,if=active_enemies>2|talent.storm_of_swords&(buff.merciless_bonegrinder.up|buff.hurricane.up)
            if A.Whirlwind:IsReady(player) and A.StormofSwords:IsTalentLearned() and (Unit(player):HasBuffs(A.MercilessBonegrinderBuff.ID) > 0 or Unit(player):HasBuffs(A.HurricaneBuff.ID) > 0) then
                return A.Whirlwind:Show(icon)
            end
            -- actions.hac+=/skullsplitter,if=rage<40|talent.tide_of_blood&dot.rend.remains&(buff.sweeping_strikes.up&active_enemies>=2|debuff.colossus_smash.up|buff.test_of_might.up)
            if A.Skullsplitter:IsReady(unitID) then
                if rage < 40 or A.TideofBlood:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.Rend.ID, true) > 0 and (Unit(player):HasBuffs(A.SweepingStrikes.ID) > 0 or Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 or Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0) then
                    return A.Skullsplitter:Show(icon)
                end
            end
            -- actions.hac+=/overpower,if=buff.sweeping_strikes.up&talent.dreadnaught
            if A.Overpower:IsReady(unitID) and Unit(player):HasBuffs(A.SweepingStrikes.ID) > 0 and A.Dreadnaught:IsTalentLearned() then
                return A.Overpower:Show(icon)
            end
            -- actions.hac+=/mortal_strike,cycle_targets=1,if=debuff.executioners_precision.stack=2|dot.deep_wounds.remains<=gcd|talent.dreadnaught&talent.battlelord&active_enemies<=2
            if A.MortalStrike:IsReady(unitID) then
                if Unit(unitID):HasDeBuffsStacks(A.ExecutionersPrecisionDebuff.ID, true) == 2 or Unit(unitID):HasDeBuffs(A.DeepWounds.ID, true) <= A.GetGCD() or A.Dreadnaught:IsTalentLearned() and A.Battlelord:IsTalentLearned() and activeEnemies <= 2 then
                    return A.MortalStrike:Show(icon)
                end
            end
            -- actions.hac+=/execute,cycle_targets=1,if=buff.sudden_death.react|active_enemies<=2&(target.health.pct<20|talent.massacre&target.health.pct<35)|buff.sweeping_strikes.up
            if A.Execute:IsReady(unitID) then
                if Unit(player):HasBuffs(A.SuddenDeathBuff.ID) > 0 or activeEnemies <= 2 and executeRange or Unit(player):HasBuffs(A.SweepingStrikes.ID) > 0 then
                    return A.Execute:Show(icon)
                end
            end
            -- actions.hac+=/thunderous_roar,if=raid_event.adds.in>15
            if A.ThunderousRoar:IsReady(player) and inMelee and useBurst then
                return A.ThunderousRoar:Show(icon)
            end
            -- actions.hac+=/shockwave,if=active_enemies>2&talent.sonic_boom
            if A.Shockwave:IsReady(player) and inMelee and A.SonicBoom:IsTalentLearned() then
                return A.Shockwave:Show(icon)
            end
            -- actions.hac+=/overpower,if=active_enemies=1&(charges=2&!talent.battlelord&(debuff.colossus_smash.down|rage.pct<25)|talent.battlelord)
            if A.Overpower:IsReady(unitID) and activeEnemies == 1 and (A.Overpower:GetSpellCharges() == 2 and not A.Battlelord:IsTalentLearned() and (Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 or Player:RagePercentage() < 25) or A.Battlelord:IsTalentLearned()) then
                return A.Overpower:Show(icon)
            end
            -- actions.hac+=/slam,if=active_enemies=1&!talent.battlelord&rage.pct>70
            if A.Slam:IsReady(unitID) and activeEnemies == 1 and not A.Battlelord:IsTalentLearned() and Player:RagePercentage() > 70 then
                return A.Slam:Show(icon)
            end
            -- actions.hac+=/overpower,if=charges=2&(!talent.test_of_might|talent.test_of_might&debuff.colossus_smash.down|talent.battlelord)|rage<70
            if A.Overpower:IsReady(unitID) and A.Overpower:GetSpellCharges() == 2 then
                if (not A.TestofMight:IsTalentLearned() or A.TestofMight:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 or A.Battlelord:IsTalentLearned()) or rage < 70 then
                    return A.Overpower:Show(icon)
                end
            end
            -- actions.hac+=/thunder_clap,if=active_enemies>2
            if A.ThunderClap:IsReady(player) then
                return A.ThunderClap:Show(icon)
            end
            -- actions.hac+=/mortal_strike
            if A.MortalStrike:IsReady(unitID) then
                return A.MortalStrike:Show(icon)
            end
            -- actions.hac+=/rend,if=active_enemies=1&dot.rend.remains<duration*0.3
            if A.Rend:IsReady(unitID) and activeEnemies == 1 and Unit(unitID):HasDeBuffs(A.Rend.ID, true) < A.Rend:GetSpellPandemicThreshold() then
                return A.Rend:Show(icon)
            end
            -- actions.hac+=/whirlwind,if=talent.storm_of_swords|talent.fervor_of_battle&active_enemies>1
            if A.Whirlwind:IsReady(player) and (A.StormofSwords:IsTalentLearned() or A.FervorofBattle:IsTalentLearned()) then
                return A.Whirlwind:Show(icon)
            end
            -- actions.hac+=/cleave,if=!talent.crushing_force
            if A.Cleave:IsReady(player) and not A.CrushingForce:IsTalentLearned() then
                return A.Cleave:Show(icon)
            end
            -- actions.hac+=/ignore_pain,if=talent.battlelord&talent.anger_management&rage>30&(target.health.pct>20|talent.massacre&target.health.pct>35)
            if A.IgnorePain:IsReady(player) and A.Battlelord:IsTalentLearned() and A.AngerManagement:IsTalentLearned() and rage > 30 and not executeRange then
                return A.Shadowmeld:Show(icon)
            end
            -- actions.hac+=/slam,if=talent.crushing_force&rage>30&(talent.fervor_of_battle&active_enemies=1|!talent.fervor_of_battle)
            if A.Slam:IsReady(unitID) and A.CrushingForce:IsTalentLearned() and rage > 30 and (A.FervorofBattle:IsTalentLearned() and activeEnemies == 1 or not A.FervorofBattle:IsTalentLearned()) then
                return A.Slam:Show(icon)
            end
            -- actions.hac+=/shockwave,if=talent.sonic_boom
            if A.Shockwave:IsReady(player) and A.SonicBoom:IsTalentLearned() then
                return A.Shockwave:Show(icon)
            end
            -- actions.hac+=/bladestorm,if=raid_event.adds.in>30
            if A.Bladestorm:IsReady(player) and useBurst and inMelee then
                return A.Bladestorm:Show(icon)
            end
            -- actions.hac+=/wrecking_throw
            if A.WreckingThrow:IsReady(unitID) then
                return A.WreckingThrow:Show(icon)
            end

        end

        local function SingleTarget(unitID)
            -- actions.single_target=sweeping_strikes,if=spell_targets.whirlwind>1
            if A.SweepingStrikes:IsReady(player) and activeEnemies > 1 then
                return A.SweepingStrikes:Show(icon)
            end
            -- actions.single_target+=/mortal_strike
            if A.MortalStrike:IsReady(unitID) then
                return A.MortalStrike:Show(icon)
            end
            -- actions.single_target+=/rend,if=remains<=gcd|talent.tide_of_blood&cooldown.skullsplitter.remains<=gcd&(cooldown.colossus_smash.remains<=gcd|debuff.colossus_smash.up)&dot.rend.remains<dot.rend.duration*0.85
            if A.Rend:IsReady(unitID) then
                if Unit(unitID):HasDeBuffs(A.Rend.ID, true) <= A.GetGCD() or A.TideofBlood:IsTalentLearned() and A.Skullsplitter:GetCooldown() <= A.GetGCD() and (A.ColossusSmash:GetCooldown() <= A.GetGCD() or Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0) and Unit(unitID):HasDeBuffs(A.Rend.ID, true) < A.Rend:GetSpellBaseDuration() * 0.85 then
                    return A.Rend:Show(icon)
                end
            end
            -- actions.single_target+=/avatar,if=talent.warlords_torment&rage.pct<33&(cooldown.colossus_smash.ready|debuff.colossus_smash.up|buff.test_of_might.up)|!talent.warlords_torment&(cooldown.colossus_smash.ready|debuff.colossus_smash.up)
            if A.Avatar:IsReady(player) and inMelee and useBurst then
                if A.WarlordsTorment:IsTalentLearned() and Player:RagePercentage() < 33 and (A.ColossusSmash:GetCooldown() == 0 or Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 or Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0) or not A.WarlordsTorment:IsTalentLearned() and (A.ColossusSmash:GetCooldown() == 0 or Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0) then
                    return A.Avatar:Show(icon)
                end
            end
            -- actions.single_target+=/spear_of_bastion,if=cooldown.colossus_smash.remains<=gcd|cooldown.warbreaker.remains<=gcd
            if A.SpearofBastion:IsReady(player) and inMelee and useBurst then
                if A.ColossusSmash:GetCooldown() <= A.GetGCD() or A.Warbreaker:GetCooldown() <= A.GetGCD() then
                    return A.SpearofBastion:Show(icon)
                end
            end
            -- actions.single_target+=/warbreaker
            if A.Warbreaker:IsReady(player) and inMelee then
                return A.Warbreaker:Show(icon)
            end
            -- actions.single_target+=/colossus_smash
            if A.ColossusSmash:IsReady(unitID) and not A.Warbreaker:IsTalentLearned() then
                return A.ColossusSmash:Show(icon)
            end
            -- actions.single_target+=/thunderous_roar,if=buff.test_of_might.up|talent.test_of_might&debuff.colossus_smash.up&rage.pct<33|!talent.test_of_might&debuff.colossus_smash.up
            if A.ThunderousRoar:IsReady(player) and inMelee and useBurst then
                if Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0 or A.TestofMight:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 and Player:RagePercentage() < 33 or not A.TestofMight:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 then
                    return A.ThunderousRoar:Show(icon)
                end
            end
            -- actions.single_target+=/bladestorm,if=talent.hurricane&(buff.test_of_might.up|!talent.test_of_might&debuff.colossus_smash.up)|talent.unhinged&(buff.test_of_might.up|!talent.test_of_might&debuff.colossus_smash.up)
            if A.Bladestorm:IsReady(player) and inMelee and useBurst then
                if A.Hurricane:IsTalentLearned() and (Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0 or not A.TestofMight:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0) or A.Unhinged:IsTalentLearned() and (Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0 or not A.TestofMight:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0) then
                    return A.Bladestorm:Show(icon)
                end
            end
            -- actions.single_target+=/skullsplitter,if=talent.tide_of_blood&dot.rend.remains&(debuff.colossus_smash.up|cooldown.colossus_smash.remains>gcd*4&buff.test_of_might.up|!talent.test_of_might&cooldown.colossus_smash.remains>gcd*4)|rage<30
            if A.Skullsplitter:IsReady(unitID) then
                if A.TideofBlood:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.Rend.ID, true) > A.GetGCD() and (Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 or A.ColossusSmash:GetCooldown() > A.GetGCD() * 4 and Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0 or not A.TestofMight:IsTalentLearned() and A.ColossusSmash:GetCooldown() > A.GetGCD() * 4) or rage < 30 then
                    return A.Skullsplitter:Show(icon)
                end
            end
            -- actions.single_target+=/execute,if=buff.sudden_death.react
            if A.Execute:IsReady(unitID) and Unit(player):HasBuffs(A.SuddenDeathBuff.ID) > 0 then
                return A.Execute:Show(icon)
            end
            -- actions.single_target+=/shockwave,if=talent.sonic_boom.enabled
            if A.Shockwave:IsReady(player) and A.SonicBoom:IsTalentLearned() then
                return A.Shockwave:Show(icon)
            end
            -- actions.single_target+=/ignore_pain,if=talent.anger_management|talent.test_of_might&debuff.colossus_smash.up
            if A.IgnorePain:IsReady(player) and inMelee then 
                if A.AngerManagement:IsTalentLearned() or A.TestofMight:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 then
                    return A.Shadowmeld:Show(icon)
                end
            end
            -- actions.single_target+=/whirlwind,if=talent.storm_of_swords&talent.battlelord&rage.pct>80&debuff.colossus_smash.up
            if A.Whirlwind:IsReady(player) and inMelee and A.StormofSwords:IsTalentLearned() and A.Battlelord:IsTalentLearned() and Player:RagePercentage() > 80 and Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 then
                return A.Whirlwind:Show(icon)
            end
            -- actions.single_target+=/overpower,if=charges=2&!talent.battlelord&(debuff.colossus_smash.down|rage.pct<25)|talent.battlelord
            if A.Overpower:IsReady(unitID) then
                if A.Overpower:GetSpellCharges() == 2 and not A.Battlelord:IsTalentLearned() and (Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 or Player:RagePercentage() < 25) or A.Battlelord:IsTalentLearned() then
                    return A.Overpower:Show(icon)
                end
            end
            -- actions.single_target+=/whirlwind,if=talent.storm_of_swords|talent.fervor_of_battle&active_enemies>1
            if A.Whirlwind:IsReady(player) and inMelee and (A.StormofSwords:IsTalentLearned() or A.FervorofBattle:IsTalentLearned() and activeEnemies > 1) then 
                return A.Whirlwind:Show(icon)
            end
            -- actions.single_target+=/thunder_clap,if=talent.battlelord&talent.blood_and_thunder
            if A.ThunderClap:IsReady(player) and inMelee and A.Battlelord:IsTalentLearned() and A.BloodandThunder:IsTalentLearned() then
                return A.ThunderClap:Show(icon)
            end
            -- actions.single_target+=/overpower,if=debuff.colossus_smash.down&rage.pct<50&!talent.battlelord|rage.pct<25
            if A.Overpower:IsReady(unitID) then
                if Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 and Player:RagePercentage() < 50 and not A.Battlelord:IsTalentLearned() or Player:RagePercentage() < 25 then
                    return A.Overpower:Show(icon)
                end
            end
            -- actions.single_target+=/whirlwind,if=buff.merciless_bonegrinder.up
            if A.Whirlwind:IsRacialReady(player) and inMelee and Unit(player):HasBuffs(A.MercilessBonegrinderBuff.ID) > 0 then
                return A.Whirlwind:Show(icon)
            end
            -- actions.single_target+=/cleave,if=set_bonus.tier29_2pc&!talent.crushing_force
            if A.Cleave:IsReady(player) and T29has2P and not A.CrushingForce:IsTalentLearned() then
                return A.Cleave:Show(icon)
            end
            -- actions.single_target+=/slam,if=rage>30&(!talent.fervor_of_battle|talent.fervor_of_battle&active_enemies=1)
            if A.Slam:IsReady(unitID) and rage > 30 and (not A.FervorofBattle:IsTalentLearned() or A.FervorofBattle:IsTalentLearned() and activeEnemies == 1) then
                return A.Slam:Show(icon)
            end
            -- actions.single_target+=/bladestorm
            if A.Bladestorm:IsReady(player) and inMelee and useBurst then
                return A.Bladestorm:Show(icon)
            end
            -- actions.single_target+=/cleave
            if A.Cleave:IsReady(player) and inMelee then
                return A.Cleave:Show(icon)
            end
            -- actions.single_target+=/wrecking_throw
            if A.WreckingThrow:IsReady(unitID) then
                return A.WreckingThrow:Show(icon)
            end
            -- actions.single_target+=/rend,if=remains<duration*0.3
            if A.Rend:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Rend.ID, true) < A.Rend:GetSpellPandemicThreshold() then
                return A.Rend:Show(icon)
            end

        end


        if activeEnemies > 2 then
            return HAC(unitID)  
        end

        if (A.Massacre:IsTalentLearned() and Unit(unitID):HealthPercent() < 35) or Unit(unitID):HealthPercent() < 20 then
            return Execute(unitID)
            else return SingleTarget(unitID)
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