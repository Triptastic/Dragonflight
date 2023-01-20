--#####################################
--##### TRIP'S DEVASTATION EVOKER #####
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

--For Toaster
local Toaster									= _G.Toaster
local GetSpellTexture 							= _G.TMW.GetSpellTexture

Action[ACTION_CONST_EVOKER_DEVASTATION] = {
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
    FireBreathDebuff		    = Action.Create({ Type = "Spell", ID = 357209   }),
    FuryoftheAspects		    = Action.Create({ Type = "Spell", ID = 390386   }),
    LivingFlame	                = Action.Create({ Type = "Spell", ID = 361469, Color = "BLUE" }),
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
    BlastFurnace                = Action.Create({ Type = "Spell", ID = 375510, Hidden = true   }),

    --Devastation
    Pyre            	        = Action.Create({ Type = "Spell", ID = 357211   }),
    EternitySurge       	    = Action.Create({ Type = "Spell", ID = 359073   }),
    Dragonrage            	    = Action.Create({ Type = "Spell", ID = 375087   }),
    Animosity            	    = Action.Create({ Type = "Spell", ID = 375797, Hidden = true   }),
    Firestorm            	    = Action.Create({ Type = "Spell", ID = 368847   }),
    EternitysSpan            	= Action.Create({ Type = "Spell", ID = 375757, Hidden = true   }),
    ShatteringStar              = Action.Create({ Type = "Spell", ID = 370452   }),
    FontOfMagic                 = Action.Create({ Type = "Spell", ID = 375783, Hidden = true   }),
    EverburningFlame            = Action.Create({ Type = "Spell", ID = 370819, Hidden = true   }),
    Volatility                  = Action.Create({ Type = "Spell", ID = 369089, Hidden = true   }),
    Burnout                     = Action.Create({ Type = "Spell", ID = 375802, Hidden = true   }),
    LeapingFlames               = Action.Create({ Type = "Spell", ID = 370901, Hidden = true   }),
    ChargedBlast                = Action.Create({ Type = "Spell", ID = 370454, Hidden = true   }),
    FeedTheFlames               = Action.Create({ Type = "Spell", ID = 369846, Hidden = true   }),
    EyeOfInfinity               = Action.Create({ Type = "Spell", ID = 369375, Hidden = true   }),
    Snapfire                    = Action.Create({ Type = "Spell", ID = 370783, Hidden = true   }),
    SnapfireBuff                = Action.Create({ Type = "Spell", ID = 370818, Hidden = true   }),
    EssenceAttunement           = Action.Create({ Type = "Spell", ID = 375722, Hidden = true   }),
    EssenceBurstBuff            = Action.Create({ Type = "Spell", ID = 359618, Hidden = true   }),
}

local A = setmetatable(Action[ACTION_CONST_EVOKER_DEVASTATION], { __index = Action })

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
}

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
    local duration = GetUnitEmpowerStageDuration(player, 3)
    local currentStage = 0

    if A.FontOfMagic:IsTalentLearned() then
        if isChannel then
            if percentRemaining >= 40 and percentRemaining < 60 then
                currentStage = 1
            elseif percentRemaining >= 60 and percentRemaining < 80 then
                currentStage = 2
            elseif percentRemaining >= 80 and percentRemaining < 100 then
                currentStage = 3
            end
        end
        if percentRemaining == 0 and duration > 0 then
            currentStage = 4
        end
    elseif not A.FontOfMagic:IsTalentLearned() then
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
    end

    return currentStage

end

local function CurrentCast()

    if Player:IsChanneling() == A.FireBreath:Info() then
        Temp.LastSpellCast = A.FireBreath
    elseif Player:IsChanneling() == A.EternitySurge:Info() then
        Temp.LastSpellCast = A.EternitySurge
    elseif not Player:IsChanneling() then
        Temp.LastSpellCast = nil
    end

    return Temp.LastSpellCast

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
    local useAoE = A.GetToggle(2, "AoE")

    local empowerCastActive = GetUnitEmpowerStageDuration(player, 3) > 0
    local bypassCasting = A.LivingFlame:IsReady(unitID, true, true, true, true)
    local currentCast = CurrentCast()
    local empowerStage = EmpowerStage()
    
    local spellTargets = MultiUnits:GetActiveEnemies()
    local totalCastTime, _, percentRemaining, spellID, spellName, _, isChannel = Unit(player):CastTime(spellID)

    local function EnemyRotation(unitID)
        if not inCombat and A.LivingFlame:IsInRange(unitID) then
            -- actions.precombat+=/firestorm,if=talent.firestorm
            if A.Firestorm:IsReady(player) then
                return A.Firestorm:Show(icon)
            end
            -- actions.precombat+=/living_flame,if=!talent.firestorm
            if A.LivingFlame:IsReady(unitID) then
                return A.LivingFlame:Show(icon)
            end
        end

        local useHover = A.GetToggle(2, "useHover")
        if A.Hover:IsReady(player) and useHover and inCombat and isMoving then
            return A.Hover:Show(icon)
        end

        -- # Variable that evaluates when next dragonrage is by working out the maximum between the dragonrage cd and your empowers, ignoring CDR effect estimates.
        -- actions+=/variable,name=next_dragonrage,value=cooldown.dragonrage.remains<?(cooldown.eternity_surge.remains-2*gcd.max)<?(cooldown.fire_breath.remains-gcd.max)
        local nextDragonrage = 0
        if not BurstIsON(unitID) then 
            nextDragonrage = 120
            else nextDragonrage = math.max(A.Dragonrage:GetCooldown(), A.EternitySurge:GetCooldown() - 2 * A.GetGCD(), A.FireBreath:GetCooldown() - A.GetGCD())
        end
        -- # Rank 1 empower spell cast time TODO: multiplier should be 1.0 but 1.3 results in more dps for EBF builds
        -- actions+=/variable,name=r1_cast_time,value=1.3*spell_haste
        local r1CastTime = 1.3 * Player:SpellHaste()
        -- # Invoke External Power Infusions if they're available during dragonrage
        -- actions+=/invoke_external_buff,name=power_infusion,if=buff.dragonrage.up&!buff.power_infusion.up
        -- actions+=/call_action_list,name=trinkets
        local useTrinket = UseTrinkets()
        if useTrinket then
            return useTrinket:Show(icon)
        end

        local function AoERotation()
            -- # AOE action list, also a mess.
            -- actions.aoe=dragonrage,if=cooldown.fire_breath.remains<=gcd.max&cooldown.eternity_surge.remains<3*gcd.max
            if A.Dragonrage:IsReady(player) and BurstIsON(unitID) and A.FireBreath:GetCooldown() <= A.GetGCD() and A.EternitySurge:GetCooldown() < 3 * A.GetGCD() then
                return A.Dragonrage
            end
            -- actions.aoe+=/tip_the_scales,if=buff.dragonrage.up&(spell_targets.pyre<=6|!cooldown.fire_breath.up)
            if A.TiptheScales:IsReady(player) and Unit(player):HasBuffs(A.TiptheScales.ID) == 0 and BurstIsON(unitID) and Unit(player):HasBuffs(A.Dragonrage.ID) > 0 and (spellTargets <= 6 or A.FireBreath:GetCooldown() == 0) then
                return A.TiptheScales
            end
            -- actions.aoe+=/call_action_list,name=fb,if=buff.dragonrage.up|!talent.dragonrage|cooldown.dragonrage.remains>10&talent.everburning_flame
            if A.FireBreath:IsReady(player) and (not isMoving or Unit(player):HasBuffs(A.TiptheScales.ID) > 0) and (Unit(player):HasBuffs(A.Dragonrage.ID) > 0 or not A.Dragonrage:IsTalentLearned() or A.Dragonrage:GetCooldown() > 10 and A.EverburningFlame:IsTalentLearned()) then
                return A.FireBreath
            end
            -- actions.aoe+=/call_action_list,name=es,if=buff.dragonrage.up|!talent.dragonrage|cooldown.dragonrage.remains>15
            if A.EternitySurge:IsReady(player) and (not isMoving or Unit(player):HasBuffs(A.TiptheScales.ID) > 0) and (Unit(player):HasBuffs(A.Dragonrage.ID) > 0 or not A.Dragonrage:IsTalentLearned() or A.Dragonrage:GetCooldown() > 15) then
                return A.EternitySurge
            end
            -- actions.aoe+=/azure_strike,if=buff.dragonrage.up&buff.dragonrage.remains<(buff.essence_burst.max_stack-buff.essence_burst.stack)*gcd.max
            if A.AzureStrike:IsReady(unitID) and Unit(player):HasBuffs(A.Dragonrage.ID) > 0 and Unit(player):HasBuffs(A.Dragonrage.ID) < (1 + num(A.EssenceAttunement:IsTalentLearned()) - Unit(player):HasBuffsStacks(A.EssenceBurstBuff.ID)) * A.GetGCD() then
                return A.AzureStrike
            end
            -- actions.aoe+=/deep_breath,if=!buff.dragonrage.up
            if A.DeepBreath:IsReady(player) and A.BurstIsON(unitID) and Unit(player):HasBuffs(A.Dragonrage.ID) == 0 then
                return A.DeepBreath
            end
            -- actions.aoe+=/firestorm
            if A.Firestorm:IsReady(player) and (not isMoving or Unit(player):HasBuffs(A.Hover.ID) > 0) then
                return A.Firestorm
            end
            -- actions.aoe+=/shattering_star
            if A.ShatteringStar:IsReady(unitID) then
                return A.ShatteringStar
            end
            -- actions.aoe+=/azure_strike,if=cooldown.dragonrage.remains<gcd.max*6&cooldown.fire_breath.remains<6*gcd.max&cooldown.eternity_surge.remains<6*gcd.max
            if A.AzureStrike:IsReady(unitID) and A.Dragonrage:GetCooldown() < A.GetGCD() * 6 and A.FireBreath:GetCooldown() < A.GetGCD() * 6 and A.EternitySurge:GetCooldown() < A.GetGCD() * 6 then
                return A.AzureStrike
            end
            -- actions.aoe+=/pyre,if=talent.volatility
            if A.Pyre:IsReady(unitID) and A.Volatility:IsTalentLearned() then
                return A.Pyre
            end
            -- actions.aoe+=/living_flame,if=buff.burnout.up&buff.leaping_flames.up&!buff.essence_burst.up
            if A.LivingFlame:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.Hover.ID) > 0) and Unit(player):HasBuffs(A.Burnout.ID) > 0 and Unit(player):HasBuffs(A.LeapingFlames.ID) > 0 and Unit(player):HasBuffs(A.EssenceBurstBuff.ID) == 0 then
                return A.LivingFlame
            end
            -- actions.aoe+=/pyre,if=cooldown.dragonrage.remains>=10&spell_targets.pyre>=4
            if A.Pyre:IsReady(unitID) and (A.Dragonrage:GetCooldown() >= 10 or not BurstIsON(unitID)) and spellTargets >= 4 then
                return A.Pyre
            end
            -- actions.aoe+=/pyre,if=cooldown.dragonrage.remains>=10&spell_targets.pyre=3&buff.charged_blast.stack>=10
            if A.Pyre:IsReady(unitID) and (A.Dragonrage:GetCooldown() >= 10 or not BurstIsON(unitID)) and spellTargets == 3 and Unit(player):HasBuffsStacks(A.ChargedBlast.ID) >= 10 then
                return A.Pyre
            end
            -- actions.aoe+=/disintegrate,chain=1,if=!talent.shattering_star|cooldown.shattering_star.remains>5|essence>essence.max-1|buff.essence_burst.stack==buff.essence_burst.max_stack
            if A.Disintegrate:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.Hover.ID) > 0) and (not A.ShatteringStar:IsTalentLearned() or A.ShatteringStar:GetCooldown() > 5 or Player:Essence() > (Player:EssenceMax() - 1) or Unit(player):HasBuffsStacks(A.EssenceBurstBuff.ID) == (1 + num(A.EssenceAttunement:IsTalentLearned()))) then
                return A.Disintegrate
            end
            -- actions.aoe+=/living_flame,if=talent.snapfire&buff.burnout.up
            if A.LivingFlame:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.Hover.ID) > 0) and A.Snapfire:IsTalentLearned() and Unit(player):HasBuffs(A.Burnout.ID) > A.LivingFlame:GetSpellCastTime() then
                return A.LivingFlame
            end
            -- actions.aoe+=/azure_strike
            if A.AzureStrike:IsReady(unitID) then
                return A.AzureStrike
            end
        end 
        
        local function SingleTargetRotation()
            -- # ST Action List, it's a mess
            -- actions.st=use_item,name=kharnalex_the_first_light,if=!buff.dragonrage.up&debuff.shattering_star_debuff.down
            -- actions.st+=/dragonrage,if=cooldown.fire_breath.remains<gcd.max&cooldown.eternity_surge.remains<2*gcd.max|fight_remains<30
            if A.Dragonrage:IsReady(player) and BurstIsON(unitID) and A.FireBreath:GetCooldown() <= A.GetGCD() and A.EternitySurge:GetCooldown() < 3 * A.GetGCD() then
                return A.Dragonrage
            end
            -- # Use to extend DR when an empower cast won't fit inside the DR window anymore. When running FTF use on ES at the start of DR to maximize uses
            -- actions.st+=/tip_the_scales,if=buff.dragonrage.up&(buff.dragonrage.remains<variable.r1_cast_time&(buff.dragonrage.remains>cooldown.fire_breath.remains|buff.dragonrage.remains>cooldown.eternity_surge.remains)|talent.feed_the_flames&!cooldown.fire_breath.up)
            if A.TiptheScales:IsReady(player) and Unit(player):HasBuffs(A.Dragonrage.ID) > 0 and (Unit(player):HasBuffs(A.Dragonrage.ID) < r1CastTime and (Unit(unitID):HasBuffs(A.Dragonrage.ID) > A.FireBreath:GetCooldown() or Unit(player):HasBuffs(A.Dragonrage.ID) > A.EternitySurge:GetCooldown()) or A.FeedTheFlames:IsTalentLearned() and A.FireBreath:GetCooldown() > 0) then
                return A.TiptheScales
            end
            -- actions.st+=/call_action_list,name=fb,if=!talent.dragonrage|variable.next_dragonrage>15|!talent.animosity
            -- actions.st+=/call_action_list,name=es,if=!talent.dragonrage|variable.next_dragonrage>15|!talent.animosity
            if not A.Dragonrage:IsTalentLearned() or nextDragonrage > 15 or not A.Animosity:IsTalentLearned() then
                if A.FireBreath:IsReady(player) then
                    return A.FireBreath
                end
                if A.EternitySurge:IsReady(player) then
                    return A.EternitySurge
                end
            end
            -- # Wait for FB/ES to be ready if spending another GCD would result in the cast no longer fitting inside of DR
            -- actions.st+=/wait,sec=cooldown.fire_breath.remains,if=talent.animosity&buff.dragonrage.up&buff.dragonrage.remains<gcd.max+variable.r1_cast_time*buff.tip_the_scales.down&buff.dragonrage.remains-cooldown.fire_breath.remains>=variable.r1_cast_time*buff.tip_the_scales.down
            if A.FireBreath:GetCooldown() < A.GetGCD() and A.FireBreath:GetCooldown() > 0 and A.Animosity:IsTalentLearned() and Unit(player):HasBuffs(A.Dragonrage.ID) > 0 and Unit(player):HasBuffs(A.Dragonrage.ID) < A.GetGCD() + r1CastTime * (1 - num(Unit(player):HasBuffs(A.TiptheScales.ID) == 0)) and Unit(player):HasBuffs(A.Dragonrage.ID) - A.FireBreath:GetCooldown() >= r1CastTime * (1 - num(Unit(player):HasBuffs(A.TiptheScales.ID) == 0)) then
                return 
            end
            -- actions.st+=/wait,sec=cooldown.eternity_surge.remains,if=talent.animosity&buff.dragonrage.up&buff.dragonrage.remains<gcd.max+variable.r1_cast_time&buff.dragonrage.remains-cooldown.eternity_surge.remains>variable.r1_cast_time*buff.tip_the_scales.down
            if A.EternitySurge:GetCooldown() < A.GetGCD() and A.EternitySurge:GetCooldown() > 0 and A.Animosity:IsTalentLearned() and Unit(player):HasBuffs(A.Dragonrage.ID) > 0 and Unit(player):HasBuffs(A.Dragonrage.ID) < A.GetGCD() + r1CastTime * (1 - num(Unit(player):HasBuffs(A.TiptheScales.ID) == 0)) and Unit(player):HasBuffs(A.Dragonrage.ID) - A.EternitySurge:GetCooldown() >= r1CastTime * (1 - num(Unit(player):HasBuffs(A.TiptheScales.ID) == 0)) then
                return 
            end
            -- # Wait for 2 EBs to use SS while inside DR, otherwise use on CD
            -- actions.st+=/shattering_star,if=!buff.dragonrage.up|buff.essence_burst.stack==buff.essence_burst.max_stack|talent.eye_of_infinity
            if A.ShatteringStar:IsReady(unitID) then
                if Unit(player):HasBuffs(A.Dragonrage.ID) == 0 or Unit(player):HasBuffsStacks(A.EssenceBurstBuff.ID) == (1 + num(A.EssenceAttunement:IsTalentLearned())) or A.EyeOfInfinity:IsTalentLearned() then
                    return A.ShatteringStar
                end
            end
            -- # Spend the last 1 or 2 GCDs of DR on fillers to exit with 2 EBs
            -- actions.st+=/living_flame,if=buff.dragonrage.up&buff.dragonrage.remains<(buff.essence_burst.max_stack-buff.essence_burst.stack)*gcd.max&buff.burnout.up
            if A.LivingFlame:IsReady(unitID) and Unit(player):HasBuffs(A.Dragonrage.ID) > 0 and Unit(player):HasBuffs(A.Dragonrage.ID) < ((1 + num(A.EssenceAttunement:IsTalentLearned())) - Unit(player):HasBuffsStacks(A.EssenceBurstBuff.ID)) * A.GetGCD() and Unit(player):HasBuffs(A.Burnout.ID) > 0 then
                return A.LivingFlame
            end
            -- actions.st+=/azure_strike,if=buff.dragonrage.up&buff.dragonrage.remains<(buff.essence_burst.max_stack-buff.essence_burst.stack)*gcd.max
            if A.AzureStrike:IsReady(unitID) and Unit(player):HasBuffs(A.Dragonrage.ID) > 0 and Unit(player):HasBuffs(A.Dragonrage.ID) < ((1 + num(A.EssenceAttunement:IsTalentLearned())) - Unit(player):HasBuffsStacks(A.EssenceBurstBuff.ID)) * A.GetGCD() then
                return A.AzureStrike
            end
            -- # Hard cast only outside of SS and DR windows, always spend snapfire procs
            -- actions.st+=/firestorm,if=!buff.dragonrage.up&debuff.shattering_star_debuff.down|buff.snapfire.up
            if A.Firestorm:IsReady(player) and (not isMoving or Unit(player):HasBuffs(A.Hover.ID) > 0 or Unit(player):HasBuffs(A.SnapfireBuff.ID) > 0) then
                if Unit(player):HasBuffs(A.Dragonrage.ID) == 0 and Unit(unitID):HasDeBuffs(A.ShatteringStar.ID) == 0 or Unit(player):HasBuffs(A.SnapfireBuff.ID) > 0 then
                    return A.Firestorm
                end
            end
            -- # Spend burnout procs without overcapping resources
            -- actions.st+=/living_flame,if=buff.burnout.up&buff.essence_burst.stack<buff.essence_burst.max_stack&essence<essence.max-1
            if A.LivingFlame:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.Hover.ID) > 0) and Unit(player):HasBuffs(A.Burnout.ID) > A.LivingFlame:GetSpellCastTime() and Unit(player):HasBuffsStacks(A.EssenceBurstBuff.ID) < (1 + num(A.EssenceAttunement:IsTalentLearned())) and Player:Essence() < Player:EssenceMax() - 1 then
                return A.LivingFlame
            end
            -- # Ensure we clip Disintegrate inside DR even with our fillers, Pool 1-2 GCDs before SS is up inside DR
            -- actions.st+=/azure_strike,if=buff.dragonrage.up&(essence<3&!buff.essence_burst.up|(talent.shattering_star&cooldown.shattering_star.remains<=(buff.essence_burst.max_stack-buff.essence_burst.stack)*gcd.max))
            if A.AzureStrike:IsReady(unitID) and Unit(player):HasBuffs(A.Dragonrage.ID) > 0 and (Player:Essence() < 3 and Unit(player):HasBuffs(A.EssenceBurstBuff.ID) == 0 or (A.ShatteringStar:IsTalentLearned() and A.ShatteringStar:GetCooldown() <= ((1 + num(A.EssenceAttunement:IsTalentLearned())) - Unit(player):HasBuffsStacks(A.EssenceBurstBuff.ID)) * A.GetGCD())) then
                return A.AzureStrike
            end
            -- # In DR chain/clip after the 3rd damage tick, Outside of DR pool 6 seconds before SS unless it would result in overcapping resources TODO: revisit pooling conditions
            -- actions.st+=/disintegrate,chain=1,early_chain_if=evoker.use_early_chaining&buff.dragonrage.up&ticks>=2,interrupt_if=buff.dragonrage.up&ticks>=2&(evoker.use_clipping|cooldown.fire_breath.up|cooldown.eternity_surge.up),if=buff.dragonrage.up|(!talent.shattering_star|cooldown.shattering_star.remains>6|essence>essence.max-1|buff.essence_burst.stack==buff.essence_burst.max_stack)

            if A.Disintegrate:IsReady(unitID) and (Unit(player):HasBuffs(A.Dragonrage.ID) > 0 or (not A.ShatteringStar:IsTalentLearned() or A.ShatteringStar:GetCooldown() > 6) or (Player:Essence() > Player:EssenceMax() - 1) or Unit(player):HasBuffsStacks(A.EssenceBurstBuff.ID) == (1 + num(A.EssenceAttunement:IsTalentLearned()))) then
                return A.Disintegrate
            end
            -- actions.st+=/deep_breath,if=!buff.dragonrage.up&spell_targets.deep_breath>1
            if A.DeepBreath:IsReady(player) and BurstIsON(unitID) and Unit(player):HasBuffs(A.Dragonrage.ID) == 0 and spellTargets > 1 and useAoE then
                return A.DeepBreath
            end
            -- actions.st+=/living_flame
            if A.LivingFlame:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.Hover.ID) > 0) then
                return A.LivingFlame
            end
        end

        local doAoE = AoERotation()
        local doST = SingleTargetRotation()
        if A.LivingFlame:IsInRange(unitID) then
            if spellTargets >= 3 and useAoE then
                if doAoE then
                    return doAoE:Show(icon)
                end
            elseif doST then 
                return doST:Show(icon)
            end
        end   

    end

    --Show icon to use max rank empower ASAP.
    if bypassCasting then
        if currentCast ~= nil then 
            if empowerCastActive and (empowerStage == 4 or (empowerStage == 3 and not A.FontOfMagic:IsTalentLearned())) then
                return currentCast:Show(icon)
            end
            if currentCast == A.EternitySurge then
                -- actions.es=eternity_surge,empower_to=1,if=spell_targets.pyre<=1+talent.eternitys_span|buff.dragonrage.remains<1.75*spell_haste&buff.dragonrage.remains>=1*spell_haste
                if empowerStage >= 1 and spellTargets <= 1 + num(A.EternitysSpan:IsTalentLearned()) or Unit(player):HasBuffs(A.Dragonrage.ID) < 1.75 * Player:SpellHaste() and Unit(player):HasBuffs(A.Dragonrage.ID) >= 1 * Player:SpellHaste() then
                    return currentCast:Show(icon)
                end
                -- actions.es+=/eternity_surge,empower_to=2,if=spell_targets.pyre<=2+2*talent.eternitys_span|buff.dragonrage.remains<2.5*spell_haste&buff.dragonrage.remains>=1.75*spell_haste
                if empowerStage >= 2 and spellTargets <= 2 + 2 * num(A.EternitysSpan:IsTalentLearned()) or (Unit(player):HasBuffs(A.Dragonrage.ID) < 2.5 * Player:SpellHaste() and Unit(player):HasBuffs(A.Dragonrage.ID) >= 1.75 * Player:SpellHaste()) then
                    return currentCast:Show(icon)
                end
                -- actions.es+=/eternity_surge,empower_to=3,if=spell_targets.pyre<=3+3*talent.eternitys_span|!talent.font_of_magic|buff.dragonrage.remains<=3.25*spell_haste&buff.dragonrage.remains>=2.5*spell_haste
                if empowerStage >= 3 and spellTargets <= 3 + 3 * num(A.EternitysSpan:IsTalentLearned()) or (not A.FontOfMagic:IsTalentLearned() and Unit(player):HasBuffs(A.Dragonrage.ID) <= 3.25 * Player:SpellHaste() and Unit(player):HasBuffs(A.Dragonrage.ID) >= 2.5 * Player:SpellHaste()) then
                    return currentCast:Show(icon)
                end
            elseif currentCast == A.FireBreath then
                -- actions.fb=fire_breath,empower_to=1,if=(20+2*talent.blast_furnace.rank)+dot.fire_breath_damage.remains<(20+2*talent.blast_furnace.rank)*1.3|buff.dragonrage.remains<1.75*spell_haste&buff.dragonrage.remains>=1*spell_haste|active_enemies<=2
                if empowerStage >= 1 and (((20 + 2 * num(A.BlastFurnace:IsTalentLearned())) + Unit(unitID):HasDeBuffs(A.FireBreathDebuff.ID)) < (20 + 2 * num(A.BlastFurnace:IsTalentLearned())) * 1.3) or (Unit(player):HasBuffs(A.Dragonrage.ID) < 1.75 * Player:SpellHaste() and Unit(player):HasBuffs(A.Dragonrage.ID) >= 1 * Player:SpellHaste()) or spellTargets <= 2 then
                    return currentCast:Show(icon)
                end
                -- actions.fb+=/fire_breath,empower_to=2,if=(14+2*talent.blast_furnace.rank)+dot.fire_breath_damage.remains<(20+2*talent.blast_furnace.rank)*1.3|buff.dragonrage.remains<2.5*spell_haste&buff.dragonrage.remains>=1.75*spell_haste
                if empowerStage >= 2 and (((14 + 2 * num(A.BlastFurnace:IsTalentLearned())) + Unit(unitID):HasDeBuffs(A.FireBreathDebuff.ID)) < (20 + 2 * num(A.BlastFurnace:IsTalentLearned())) * 1.3) or (Unit(player):HasBuffs(A.Dragonrage.ID) < 2.5 * Player:SpellHaste() and Unit(player):HasBuffs(A.Dragonrage.ID) >= 1.75 * Player:SpellHaste()) then
                    return currentCast:Show(icon)
                end
                -- actions.fb+=/fire_breath,empower_to=3,if=(8+2*talent.blast_furnace.rank)+dot.fire_breath_damage.remains<(20+2*talent.blast_furnace.rank)*1.3|!talent.font_of_magic|buff.dragonrage.remains<=3.25*spell_haste&buff.dragonrage.remains>=2.5*spell_haste
                if empowerStage >= 3 and (((8 + 2 * num(A.BlastFurnace:IsTalentLearned())) + Unit(unitID):HasDeBuffs(A.FireBreathDebuff.ID)) < (20 + 2 * num(A.BlastFurnace:IsTalentLearned())) * 1.3) or (not A.FontOfMagic:IsTalentLearned() and Unit(player):HasBuffs(A.Dragonrage.ID) <= 3.25 * Player:SpellHaste() and Unit(player):HasBuffs(A.Dragonrage.ID) >= 2.5 * Player:SpellHaste()) then
                    return currentCast:Show(icon)
                end

                if A.Dragonrage:GetCooldown() > 10 and ((empowerStage == 1 and spellTargets >= 7) or (empowerStage == 2 and spellTargets >= 6) or (empowerStage == 3 and spellTargets >= 4)) then
                    return currentCast:Show(icon)
                end            
            end
        end
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