--######################################
--##### TRIP'S PRESERVATION EVOKER #####
--######################################

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
local HealingEngine                            = Action.HealingEngine
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
local math_random                        		= math.random

--For Toaster
local Toaster									= _G.Toaster
local GetSpellTexture 							= _G.TMW.GetSpellTexture

Action[ACTION_CONST_EVOKER_PRESERVATION] = {
	--Racial 
    TailSwipe   				= Action.Create({ Type = "Spell", ID = 368970	}),
    WingBuffet  				= Action.Create({ Type = "Spell", ID = 357214   }), 	 	
	
    --General
    AzureStrike				    = Action.Create({ Type = "Spell", ID = 362969   }), 
    BlessingoftheBronze		    = Action.Create({ Type = "Spell", ID = 364342   }),	 
    DeepBreath				    = Action.Create({ Type = "Spell", ID = 357210   }),
    Disintegrate    		    = Action.Create({ Type = "Spell", ID = 356995   }),
    EmeraldBlossom			    = Action.Create({ Type = "Spell", ID = 355913   }),
    FireBreath				    = Action.Create({ Type = "Spell", ID = 357208   }),
    FuryoftheAspects		    = Action.Create({ Type = "Spell", ID = 390386   }),
    LivingFlame			        = Action.Create({ Type = "Spell", ID = 361469   }),
    Return  				    = Action.Create({ Type = "Spell", ID = 361227   }),
    VerdantEmbrace			    = Action.Create({ Type = "Spell", ID = 360995   }),
    Landslide				    = Action.Create({ Type = "Spell", ID = 358385   }),
    ObsidianScales			    = Action.Create({ Type = "Spell", ID = 363916   }),
    Quell   				    = Action.Create({ Type = "Spell", ID = 351338   }),
    CauterizingFlame		    = Action.Create({ Type = "Spell", ID = 374251   }),
    TiptheScales			    = Action.Create({ Type = "Spell", ID = 370553   }),
    SleepWalk				    = Action.Create({ Type = "Spell", ID = 360806   }),
    SourceofMagic			    = Action.Create({ Type = "Spell", ID = 369459   }),
    Unravel 				    = Action.Create({ Type = "Spell", ID = 368432   }),
    OppressingRoar			    = Action.Create({ Type = "Spell", ID = 372048   }),
    Rescue			            = Action.Create({ Type = "Spell", ID = 370665   }),
    RenewingBlaze			    = Action.Create({ Type = "Spell", ID = 374348   }),
    TimeSpiral				    = Action.Create({ Type = "Spell", ID = 374968   }),
    Zephyr  				    = Action.Create({ Type = "Spell", ID = 374227   }),
    Hover   			        = Action.Create({ Type = "Spell", ID = 358267   }),

    --Preservation
    LivingFlameDamage	        = Action.Create({ Type = "Spell", ID = 361469, Color = "BLUE" }),
    Echo    				    = Action.Create({ Type = "Spell", ID = 364343   }),
    DreamBreath				    = Action.Create({ Type = "Spell", ID = 355936   }),
    Reversion				    = Action.Create({ Type = "Spell", ID = 366155   }),
    TemporalCompression		    = Action.Create({ Type = "Spell", ID = 362874   }),
    Naturalize 				    = Action.Create({ Type = "Spell", ID = 360823   }),
    MassReturn 				    = Action.Create({ Type = "Spell", ID = 361178   }),
    EssenceBurst			    = Action.Create({ Type = "Spell", ID = 369297, Hidden = true   }),
    EssenceBurstBuff		    = Action.Create({ Type = "Spell", ID = 369299, Hidden = true   }),
    EssenceAttunement		    = Action.Create({ Type = "Spell", ID = 375722, Hidden = true   }),
    Rewind  				    = Action.Create({ Type = "Spell", ID = 363534   }),
    Spiritbloom				    = Action.Create({ Type = "Spell", ID = 367226   }),
    TimeDilation			    = Action.Create({ Type = "Spell", ID = 357170   }),
    EmeraldCommunion		    = Action.Create({ Type = "Spell", ID = 370960   }),
    TemporalAnomaly			    = Action.Create({ Type = "Spell", ID = 373861   }),
    DreamFlight				    = Action.Create({ Type = "Spell", ID = 359816   }),
    Stasis  				    = Action.Create({ Type = "Spell", ID = 370537   }),
    StasisActive			    = Action.Create({ Type = "Spell", ID = 370562, Hidden = true   }),
    CallofYsera				    = Action.Create({ Type = "Spell", ID = 373834, Hidden = true   }),
    Dreamwalker				    = Action.Create({ Type = "Spell", ID = 377082, Hidden = true   }),
    LifeBinder				    = Action.Create({ Type = "Spell", ID = 363510, Hidden = true   }),
    BountifulBloom			    = Action.Create({ Type = "Spell", ID = 370886, Hidden = true   }),
    Panacea 				    = Action.Create({ Type = "Spell", ID = 387761, Hidden = true   }),
    CycleofLife				    = Action.Create({ Type = "Spell", ID = 371832, Hidden = true   }),
    Lifebind				    = Action.Create({ Type = "Spell", ID = 373270, Hidden = true   }),
    ResonatingSphere		    = Action.Create({ Type = "Spell", ID = 376236, Hidden = true   }),
    FieldofDreams   		    = Action.Create({ Type = "Spell", ID = 370062, Hidden = true   }),
}

local A = setmetatable(Action[ACTION_CONST_EVOKER_PRESERVATION], { __index = Action })

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
    LastSpellCast                           = nil,
    BigGreen                                = false,
    BlossomTrio                             = false,
    Dispel                                  = {145206}, --test
    incomingDangerCast                      = {145200}, --test
}

TMW:RegisterCallback("TMW_ACTION_HEALINGENGINE_UNIT_UPDATE", function(callbackEvent, thisUnit, db, QueueOrder)
	local unitID  = thisUnit.Unit
	local unitHP  = thisUnit.realHP
	local Role    = thisUnit.Role
    local Cleanse = A.GetToggle(2, "Cleanse")
	-- Dispel
	if A.Naturalize:IsReady(unitID) and Cleanse then
		if thisUnit.useDispel and not QueueOrder.useDispel[Role] and A.Naturalize:IsReady(unitID) and ((AuraIsValid(unitID, "UseDispel", "Dispel")) or (Unit(unitID):HasDeBuffs(Temp.Dispel) > 0)) then
			QueueOrder.useDispel[Role] = true
		
			if thisUnit.isSelf then
				thisUnit:SetupOffsets(db.OffsetSelfDispel, - 40)
			elseif Role == "HEALER" then
				thisUnit:SetupOffsets(db.OffsetHealersDispel, - 35)
			elseif Role == "TANK" then
				thisUnit:SetupOffsets(db.OffsetTanksDispel, - 25)
			else
				thisUnit:SetupOffsets(db.OffsetDamagersDispel, - 30)
			end
		
			return
		end
	end
    --Echo
    if MultiUnits:GetByRangeCasting(nil, nil, nil, Temp.incomingDangerCast) >= 1 then
		if thisUnit.useHoTs and not QueueOrder.useHoTs[Role] and A.Echo:IsReady(unitID) and Unit(unitID):HasBuffs(A.Echo.ID, true) == 0 then 
			QueueOrder.useHoTs[Role] = true 
			local default = unitHP - 10
				
			if Role == "HEALER" then
				thisUnit:SetupOffsets(db.OffsetHealersHoTs, default)
			elseif Role == "TANK" then 
				thisUnit:SetupOffsets(db.OffsetTanksHoTs, default)
			else 
				thisUnit:SetupOffsets(db.OffsetDamagersHoTs, default)
			end     
			return
		end 
	end
end)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy(target) then 
        unitID = target
    end  
	
    local ObsidianScalesHP = A.GetToggle(2, "ObsidianScalesHP")
    if A.ObsidianScales:IsReady(player) and inCombat and Player:HealthPercent() <= ObsidianScalesHP and Unit(player):HasBuffs(A.ObsidianScales.ID) == 0 then
        return A.ObsidianScales
    end

    local EmeraldCommunionHP = A.GetToggle(2, "EmeraldCommunionHP")
    if A.EmeraldCommunion:IsReady(player) and inCombat and Player:HealthPercent() <= EmeraldCommunionHP and (not Player:IsMoving() or A.Dreamwalker:IsTalentLearned()) then
        return A.EmeraldCommunion
    end

    if A.RenewingBlaze:IsReady(player) and Unit(player):HealthPercentLosePerSecond() > 25 then
        return A.RenewingBlaze
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        -- Quell
        if useKick and not notInterruptable and A.Quell:IsReady(unitID) then 
            return A.Quell
        end
		    
   	    if useRacial and A.TailSwipe:AutoRacial(unitID) then 
   	        return A.TailSwipe
   	    end 

        if useRacial and A.WingBuffet:AutoRacial(unitID) then 
            return A.WingBuffet
        end 
    end
end

local function Cleanse(unitID)

    local Cleanse = A.GetToggle(2, "Cleanse")

    if A.Naturalize:IsReady(unitID) and Cleanse and (AuraIsValid(unitID, "UseDispel", "Dispel") or Unit(unitID):HasDeBuffs(Temp.Dispel) > 0) then
        return A.Naturalize
    end


    if A.CauterizingFlame:IsReady(unitID) and Cleanse and AuraIsValid(unitID, "UseDispel", "Dispel") then
        return A.CauterizingFlame
    end
end


local function HealCalc(heal)

	local healamount = 0
	local globalhealmod = A.GetToggle(2, "globalhealmod")
    local lifebindermod = 1 + (A.LifeBinder:GetSpellDescription()[1] / 100)
	
	if heal == A.Spiritbloom then
		healamount = A.Spiritbloom:GetSpellDescription()[2]
	elseif heal == A.Echo then
		healamount = A.Echo:GetSpellDescription()[2]
    elseif heal == A.EmeraldBlossom then
		healamount = A.EmeraldBlossom:GetSpellDescription()[3]
    elseif heal == A.VerdantEmbrace then
		healamount = A.VerdantEmbrace:GetSpellDescription()[1]
    elseif heal == A.LivingFlame then
		healamount = A.LivingFlame:GetSpellDescription()[1]
	end

	return (healamount * 1000) * globalhealmod * lifebindermod

end

--Trinkets
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

local function EmpowerStage()
    local totalCastTime, _, percentRemaining, spellID, spellName, _, isChannel = Unit(player):CastTime(spellID)
    local duration = GetUnitEmpowerStageDuration(player, 2)
    local currentStage = 0

    if isChannel then
        if percentRemaining >= 60 and percentRemaining < 80 then
            currentStage = 1
        elseif percentRemaining >= 80 and percentRemaining < 100 then
            currentStage = 2
        end
    end

    if percentRemaining == 0 and duration > 0 then
        currentStage = 3
    end

    return currentStage

end

local function CurrentCast()

    if Player:IsChanneling() == A.DreamBreath:Info() then
        Temp.LastSpellCast = A.DreamBreath
    elseif Player:IsChanneling() == A.Spiritbloom:Info() then
        Temp.LastSpellCast = A.Spiritbloom
    elseif Player:IsChanneling() == A.FireBreath:Info() then
        Temp.LastSpellCast = A.FireBreath
    end

    return Temp.LastSpellCast

end

local function DangerIncoming() -- MUST be boolean otherwise will have to re-write other functions

    local danger = false
    if MultiUnits:GetByRangeCasting(nil, nil, nil, Temp.incomingDangerCast) >= 1 then
        danger = true
        else danger = false
    end

    return danger

end


local function DreamBreath()
  
    local empowerCastActive = GetUnitEmpowerStageDuration(player, 2) > 0
    local bypassCasting = A.LivingFlame:IsReady(unitID, true, true, true, true)
    local currentCast = CurrentCast()
    local empowerStage = EmpowerStage()    

    local DreamBreathHP = A.GetToggle(2, "DreamBreathHP")
    local DreamBreathUnits = A.GetToggle(2, "DreamBreathUnits")
    if A.DreamBreath:IsReady(player) and not isMoving and HealingEngine.GetBelowHealthPercentUnits(DreamBreathHP, 30) >= DreamBreathUnits then
        if A.VerdantEmbrace:IsReady(unitID) and A.CallofYsera:IsTalentLearned() then
            return A.VerdantEmbrace
        end
        return A.DreamBreath
    end

    if bypassCasting and empowerCastActive and currentCast == A.DreamBreath then
        if empowerStage >= 1 then
            return A.DreamBreath
        end
    end

end

local function Spiritbloom(unitID)

    local empowerCastActive = GetUnitEmpowerStageDuration(player, 2) > 0
    local bypassCasting = A.LivingFlame:IsReady(unitID, true, true, true, true)
    local currentCast = CurrentCast()
    local empowerStage = EmpowerStage()

    local echoActiveUnit = num(Unit(unitID):HasBuffs(A.Echo.ID) > A.Spiritbloom:GetSpellCastTime()) + 1

    local SpiritbloomHP = A.GetToggle(2, "SpiritbloomHP")
    local SBcount = 0
    
    if SpiritbloomHP >= 100 then
        for _, ally in pairs(TeamCache.Friendly.GUIDs) do
            local echoActiveAlly = num(Unit(ally):HasBuffs(A.Echo.ID) > A.Spiritbloom:GetSpellCastTime()) + 1
            if Unit(ally):HealthDeficit() >= (HealCalc(A.Spiritbloom) * echoActiveAlly) and A.Spiritbloom:IsInRange(ally) then
                SBcount = SBcount + 1
                if bypassCasting and empowerCastActive and currentCast == A.Spiritbloom then
                    if SBcount <= empowerStage and SBcount > 0 then
                        SBcount = 0
                        return A.Spiritbloom
                    end
                end
            end
        end
        if A.Spiritbloom:IsReady(unitID) and not Player:IsMoving() then
            if Unit(unitID):HealthDeficit() >= (HealCalc(A.Spiritbloom) * echoActiveUnit) then
                return A.Spiritbloom
            end
        end
    elseif SpiritbloomHP <= 99 then
        if A.Spiritbloom:IsReady(unitID) and not Player:IsMoving() then
            if Unit(unitID):HealthPercent() <= (SpiritbloomHP * (echoActiveUnit / 1.5)) then
                return A.Spiritbloom
            end
        end
        if bypassCasting and empowerCastActive and currentCast == A.Spiritbloom then
            if HealingEngine.GetBelowHealthPercentUnits(SpiritbloomHP, 30) <= empowerStage then
                return A.Spiritbloom
            end
        end
    end

end

local function Echo(unitID)

    local EchoHP = A.GetToggle(2, "EchoHP")
    local dangerIncoming = DangerIncoming()

    if A.Echo:IsReady(unitID) and Unit(unitID):HasBuffs(A.Echo.ID) == 0 then 
        if EchoHP >= 100 then
            if Unit(unitID):HealthDeficit() >= HealCalc(A.Echo) then
                return A.Echo
            end
        elseif EchoHP <= 99 then
            if Unit(unitID):HealthPercent() <= EchoHP then
                return A.Echo
            end
        end
    end

    if dangerIncoming then
        if A.Echo:IsReady(unitID) and (A.Stasis:GetCooldown() <= A.GetGCD() or not A.Stasis:IsTalentLearned()) and Unit(unitID):HasBuffs(A.Echo.ID, true) == 0 then
            return A.Echo:Show(icon)
        end
    end

end

local function VerdantEmbrace(unitID)

    local VerdantEmbraceHP = A.GetToggle(2, "VerdantEmbraceHP")
    local echoActive = num(Unit(unitID):HasBuffs(A.Echo.ID) > 0) + 1

    if A.VerdantEmbrace:IsReady(unitID) then 
        if VerdantEmbraceHP >= 100 then
            if Unit(unitID):HealthDeficit() >= (HealCalc(A.VerdantEmbrace) * echoActive) then
                return A.VerdantEmbrace
            end
        elseif VerdantEmbraceHP <= 99 then
            if Unit(unitID):HealthPercent() <= (VerdantEmbraceHP * (echoActive / 1.5)) then
                return A.VerdantEmbrace
            end
        end
    end

    --With Lifebind talent:
    --Get out as many Echo buffs as possible before using Verdant Embrace. Echo also comes from Temporal Anomaly when talented into Resonating Sphere.

end

local function Reversion(unitID)

    if A.Reversion:IsReady(unitID) and Unit(unitID):IsTank() and Unit(unitID):HasBuffs(A.Reversion.ID, true) == 0 then
        return A.Reversion
    end

end

local function Rewind(unitID)

    if A.Rewind:IsReady(player) and Unit(player):CombatTime() > 0 then
        if HealingEngine.GetHealthFrequency(4) < -50 then
            return A.Rewind
        end
    end

end

local function DreamFlight()

    local DungeonGroup = TeamCache.Friendly.Size >= 2 and TeamCache.Friendly.Size <= 5
    local RaidGroup = TeamCache.Friendly.Size >= 5 	
    local DreamFlightHP = A.GetToggle(2, "DreamFlightHP")
    local DreamFlightUnits = A.GetToggle(2, "DreamFlightUnits")
    if A.DreamFlight:IsReady(player) and Unit(player):CombatTime() > 0 then
        if DungeonGroup then
            if DreamBreathUnits > 5 then
                DreamBreathUnits = 5 
            end
            if HealingEngine.GetBelowHealthPercentUnits(DreamFlightHP, 40) >= DreamFlightUnits then
                return A.DreamFlight
            end
        elseif RaidGroup then
            if HealingEngine.GetBelowHealthPercentUnits(DreamFlightHP, 40) >= DreamFlightUnits then
                return A.DreamFlight
            end
        end
    end

    
end

local function Stasis(unitID)

    local stasisBuilding = Unit(player):HasBuffsStacks(A.Stasis.ID) > 0
    local stasisActive = Unit(player):HasBuffs(A.Stasis.ID) > 0 and Unit(player):HasBuffs(A.Stasis.ID) <= 30
    local dangerIncoming = DangerIncoming()

    if stasisBuilding and not stasisActive then
        if A.VerdantEmbrace:IsReadyByPassCastGCD(unitID) and A.DreamBreath:GetCooldown() < A.GetGCD() then
            Temp.BigGreen = true
        end
        
        if A.EmeraldBlossom:IsReadyByPassCastGCD(unitID) and A.FieldofDreams:IsTalentLearned() then
            Temp.BlossomTrio = true
        end
    end

    if A.Stasis:IsReady(player) and ((dangerIncoming and not stasisActive and (Temp.BigGreen or Temp.BlossomTrio)) or ((HealingEngine.GetHealthAVG() <= 70 or Unit(player):HasBuffs(A.Stasis.ID) < 2) and stasisActive)) then
        Temp.BigGreen = false
        Temp.BlossomTrio = false
        return A.Stasis
    end

    if stasisBuilding and not stasisActive then
        if A.VerdantEmbrace:IsReadyByPassCastGCD(unitID) and A.DreamBreath:GetCooldown() < A.GetGCD() then
            Temp.BigGreen = true
        end
        
        if A.EmeraldBlossom:IsReadyByPassCastGCD(unitID) and A.FieldofDreams:IsTalentLearned() then
            Temp.BlossomTrio = true
        end
    end

    local function BigGreen(unitID)
        if A.VerdantEmbrace:IsReady(unitID) then
            return A.VerdantEmbrace
        end
        if A.DreamBreath:IsReady(player) then
            return A.DreamBreath
        end
        if A.Spiritbloom:IsReady(unitID) then
            return A.Spiritbloom
        end
        if A.EmeraldBlossom:IsReady(unitID) then
            return A.EmeraldBlossom
        end
        if A.LivingFlame:IsReady(unitID) then
            return A.LivingFlame
        end
    end

    local function MassDispel(unitID)

    end

    local function BlossomTrio(unitID)
        if A.EmeraldBlossom:IsReady(unitID) then
            return A.EmeraldBlossom
        end
        if A.LivingFlameDamage:IsReady(unitID) and stasisBuilding and Unit(player):HasBuffs(A.EssenceBurstBuff.ID) == 0 and A.EssenceBurst:IsTalentLearned() then
            return A.LivingFlameDamage
        end
    end

    local useBigGreen = BigGreen(unitID) 
    local useMassDispel = MassDispel(unitID)
    local useBlossomTrio = BlossomTrio(unitID)

    if useBigGreen and Temp.BigGreen then
        return useBigGreen
    end

    if useBlossomTrio and Temp.BlossomTrio then
        return useBlossomTrio
    end

end

local function EmeraldBlossom(unitID)

    local EmeraldBlossomHP = A.GetToggle(2, "EmeraldBlossomHP")
    local echoActive = num(Unit(unitID):HasBuffs(A.Echo.ID) > 0) + 1
    dangerIncoming = DangerIncoming()

    if A.EmeraldBlossom:IsReady(unitID) then 
        if EmeraldBlossomHP >= 100 then
            if Unit(unitID):HealthDeficit() >= (HealCalc(A.EmeraldBlossom) * echoActive) then
                return A.EmeraldBlossom
            end
        elseif EmeraldBlossomHP <= 99 then
            if Unit(unitID):HealthPercent() <= (EmeraldBlossomHP * (echoActive / 1.5)) then
                return A.EmeraldBlossom
            end
        end
    end

    --Fish for 2 stacks of Essence Burst before incoming damage.
    --When damage incoming 6-10 seconds, spam Emerald Blossom.
    --Don't spend Essence on anything else if doing this.

end

local function TemporalAnomaly()

    local dangerIncoming = DangerIncoming()
    if A.TemporalAnomaly:IsReady(player) and inCombat and (not Player:IsMoving() or Unit(player):HasBuffs(A.Hover.ID) > 0) and (HealingEngine.GetBelowHealthPercentUnits(90, 20) >= 2 or (dangerIncoming and A.ResonatingSphere:IsTalentLearned())) then
        return A.TemporalAnomaly
    end

end


local function LivingFlameHeal(unitID)

    local LivingFlameHP = A.GetToggle(2, "LivingFlameHP")
    local echoActive = num(Unit(unitID):HasBuffs(A.Echo.ID) > 0) + 1

    if A.LivingFlame:IsReady(unitID) then 
        if LivingFlameHP >= 100 then
            if Unit(unitID):HealthDeficit() >= (HealCalc(A.LivingFlame) * echoActive) then
                return A.LivingFlame
            end
        elseif LivingFlameHP <= 99 then
            if Unit(unitID):HealthPercent() <= (LivingFlameHP * (echoActive / 1.5)) then
                return A.LivingFlame
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
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()

    local empowerCastActive = GetUnitEmpowerStageDuration(player, 2) > 0
    local bypassCasting = A.LivingFlame:IsReady(unitID, true, true, true, true)
    local currentCast = CurrentCast()
    local empowerStage = EmpowerStage()
    local dangerIncoming = DangerIncoming()
    local poolForStasis = A.Stasis:IsTalentLearned() and A.Stasis:GetCooldown() < A.GetGCD() and dangerIncoming
    local poolForEmeraldBlossom = A.FieldofDreams:IsTalentLearned() and dangerIncoming

    if A.BlessingoftheBronze:IsReady(player) and not inCombat and (HealingEngine.GetBuffsCount(A.BlessingoftheBronze.ID) < TeamCache.Friendly.Size or Unit(player):HasBuffs(A.BlessingoftheBronze.ID) == 0) then
        return A.BlessingoftheBronze:Show(icon)
    end

    local function HealingRotation(unitID)

        local useStasis = Stasis(unitID)
        if useStasis then
            return useStasis:Show(icon)
        end

        local useRewind = Rewind(unitID)
        if useRewind then
            return useRewind:Show(icon)
        end

        local Cleanses = Cleanse(unitID)
        if Cleanses then 
            return Cleanses:Show(icon)
        end 

        local useTrinket = UseTrinkets()
        if useTrinket then
            return useTrinket:Show(icon)
        end

        local useTemporalAnomoly = TemporalAnomaly()
        if useTemporalAnomoly then
            return useTemporalAnomoly:Show(icon)
        end

        local useDreamFlight = DreamFlight()
        if useDreamFlight then
            return useDreamFlight:Show(icon)
        end      

        local useDreamBreath = DreamBreath()
        if useDreamBreath and not poolForStasis then
            return useDreamBreath:Show(icon)
        end

        local useSpiritBloom = Spiritbloom(unitID)
        if useSpiritBloom then
            return useSpiritBloom:Show(icon)
        end

        local useEcho = Echo(unitID)
        if useEcho and not poolForEmeraldBlossom then
            return useEcho:Show(icon)
        end

        local useVerdantEmbrace = VerdantEmbrace(unitID)
        if useVerdantEmbrace and (not poolForStasis or A.DreamBreath:GetCooldown() > 16) then
            return useVerdantEmbrace:Show(icon)
        end

        local useEmeraldBlossom = EmeraldBlossom(unitID)
        if useEmeraldBlossom then
            return useEmeraldBlossom:Show(icon)
        end

        local useReversion = Reversion(unitID)
        if useReversion then
            return useReversion:Show(icon)
        end

        local useLivingFlameHeal = LivingFlameHeal(unitID)
        if useLivingFlameHeal then
            return useLivingFlameHeal:Show(icon)
        end

    end

    local function EnemyRotation(unitID)
	
        if A.Unravel:IsReady(unitID) and Unit(unitID):GetAbsorb() > 0 then
            return A.Unravel:Show(icon)
        end

        if A.FireBreath:IsReady(player) and not isMoving and A.LivingFlame:IsInRange(unitID) then
            return A.FireBreath:Show(icon)
        end

        if A.LivingFlameDamage:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.Hover.ID) > 0) then
            return A.LivingFlameDamage:Show(icon)
        end

        if A.AzureStrike:IsReady(unitID) then
            return A.AzureStrike:Show(icon)
        end
        
    end

    --Show icon to use max rank empower ASAP.
    if bypassCasting then
        if currentCast ~= nil and empowerCastActive and empowerStage == 3 then
            return currentCast:Show(icon)
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