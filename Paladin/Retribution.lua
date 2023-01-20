--######################################
--##### TRIP'S RETRIBUTION PALADIN #####
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

Action[ACTION_CONST_PALADIN_RETRIBUTION] = {
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
	
    --Paladin
    AvengingWrath                    = Action.Create({ Type = "Spell", ID = 31884    }),    
    BlessingofFreedom                = Action.Create({ Type = "Spell", ID = 1044        }),
    BlessingofProtection            = Action.Create({ Type = "Spell", ID = 1022        }),
    BlessingofSacrifice                = Action.Create({ Type = "Spell", ID = 6940        }),
    ConcentrationAura                = Action.Create({ Type = "Spell", ID = 317920    }),
    Consecration                    = Action.Create({ Type = "Spell", ID = 26573    }),
    CrusaderAura                    = Action.Create({ Type = "Spell", ID = 32223    }),
    CrusaderStrike                    = Action.Create({ Type = "Spell", ID = 35395    }),
    DevotionAura                    = Action.Create({ Type = "Spell", ID = 465        }),    
    DivineShield                    = Action.Create({ Type = "Spell", ID = 642        }),
    DivineSteed                        = Action.Create({ Type = "Spell", ID = 190784    }),
    FlashofLight                    = Action.Create({ Type = "Spell", ID = 19750,        }),
    HammerofJustice                    = Action.Create({ Type = "Spell", ID = 853        }),
    HammerofJusticeGreen            = Action.Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", Hidden = true, Hidden = true, QueueForbidden = true }),    
    HammerofWrath                    = Action.Create({ Type = "Spell", ID = 24275    }),
    HandofReckoning                    = Action.Create({ Type = "Spell", ID = 62124    }),    
    Judgment                        = Action.Create({ Type = "Spell", ID = 20271    }),
    LayOnHands                        = Action.Create({ Type = "Spell", ID = 633,          }),    
    Redemption                        = Action.Create({ Type = "Spell", ID = 7328        }),
    Rebuke                          = Action.Create({ Type = "Spell", ID = 96231        }),
    RetributionAura                    = Action.Create({ Type = "Spell", ID = 183435    }),
    ShieldoftheRighteous            = Action.Create({ Type = "Spell", ID = 53600    }),
    TurnEvil                        = Action.Create({ Type = "Spell", ID = 10326    }),
    WordofGlory                        = Action.Create({ Type = "Spell", ID = 85673,       }),     
    
    -- Retribution Specific
    BladeofJustice                        = Create({ Type = "Spell", ID = 184575    }),
    CleanseToxins                        = Create({ Type = "Spell", ID = 213644    }),    
    DivineStorm                            = Create({ Type = "Spell", ID = 53385    }),    
    HandofHindrance                        = Create({ Type = "Spell", ID = 183218    }),    
    Rebuke                                = Create({ Type = "Spell", ID = 96231    }),    
    RebukeGreen                         = Create({ Type = "SpellSingleColor",ID = 96231,Hidden = true,Color = "GREEN",QueueForbidden = true}),
    ShieldofVengeance                    = Create({ Type = "Spell", ID = 184662    }),    
    TemplarsVerdict                        = Create({ Type = "Spell", ID = 85256    }),
    WakeofAshes                            = Create({ Type = "Spell", ID = 255937    }), 
    RadiantDecree                            = Create({ Type = "Spell", ID = 384052    }),     
    
    -- Normal Talents
    Zeal                                = Create({ Type = "Spell", ID = 269569, Hidden = true    }),
    RighteousVerdict                    = Create({ Type = "Spell", ID = 267610, Hidden = true    }),    
    ExecutionSentence                    = Create({ Type = "Spell", ID = 343527    }),
    Exorcism                             = Create({ Type = "Spell", ID = 383185    }),
    DivineProtection                    = Create({ Type = "Spell", ID = 498    }),
    FiresofJustice                        = Create({ Type = "Spell", ID = 203316, Hidden = true    }),
    BladeofWrath                        = Create({ Type = "Spell", ID = 231832, Hidden = true     }),
    EmpyreanPower                        = Create({ Type = "Spell", ID = 326732, Hidden = true    }),
    EmpyreanPowerBuff                    = Create({ Type = "Spell", ID = 326733, Hidden = true    }),    
    FistofJustice                        = Create({ Type = "Spell", ID = 234299, Hidden = true    }),
    Repentance                            = Create({ Type = "Spell", ID = 20066    }),
    BlindingLight                        = Create({ Type = "Spell", ID = 115750    }),
    UnbreakableSpirit                    = Create({ Type = "Spell", ID = 114154, Hidden = true    }),    
    Cavalier                            = Create({ Type = "Spell", ID = 230332, Hidden = true    }),
    EyeforanEye                            = Create({ Type = "Spell", ID = 205191    }),    
    DivinePurpose                        = Create({ Type = "Spell", ID = 223817, Hidden = true    }),    
    HolyAvenger                            = Create({ Type = "Spell", ID = 105809    }),        
    Seraphim                            = Create({ Type = "Spell", ID = 152262    }),        
    SelflessHealer                        = Create({ Type = "Spell", ID = 85804, Hidden = true    }),    
    SelflessHealerBuff                        = Create({ Type = "Spell", ID = 114250, Hidden = true    }),   
    JusticarsVengeance                    = Create({ Type = "Spell", ID = 215661    }),    
    HealingHands                        = Create({ Type = "Spell", ID = 326734, Hidden = true    }),    
    SanctifiedWrath                        = Create({ Type = "Spell", ID = 317866, Hidden = true    }),
    Crusade                                = Create({ Type = "Spell", ID = 231895    }),    
    FinalReckoning                        = Create({ Type = "Spell", ID = 343721    }),    
    FinalReckoningDebuff                = Create({ Type = "Spell", ID = 343724, Hidden = true    }),    
    DivineToll                        = Create({ Type = "Spell", ID = 375576    }),
    DivineResonance                        = Create({ Type = "Spell", ID = 384029, Hidden = true    }),
    InnerGrace                        = Create({ Type = "Spell", ID = 383334, Hidden = true    }),
    EmpyreanLegacy                        = Create({ Type = "Spell", ID = 387170, Hidden = true    }),
    ExecutionersWrath                        = Create({ Type = "Spell", ID = 387196, Hidden = true    }),
    VanguardsMomentum                        = Create({ Type = "Spell", ID = 383314, Hidden = true    }),
    AshestoDust                        = Create({ Type = "Spell", ID = 383300, Hidden = true    }),
    Expurgation                        = Create({ Type = "Spell", ID = 383344, Hidden = true    }),
    ZealotsParagon                        = Create({ Type = "Spell", ID = 391142, Hidden = true    }),
    
    -- PvP Talents
    Luminescence                        = Create({ Type = "Spell", ID = 199428, Hidden = true    }),
    UnboundFreedom                        = Create({ Type = "Spell", ID = 305394, Hidden = true    }),
    VengeanceAura                        = Create({ Type = "Spell", ID = 210323, Hidden = true    }),
    BlessingofSanctuary                    = Create({ Type = "Spell", ID = 210256    }),    
    UltimateRetribution                    = Create({ Type = "Spell", ID = 287947, Hidden = true    }),
    Lawbringer                            = Create({ Type = "Spell", ID = 246806, Hidden = true    }),    
    DivinePunisher                        = Create({ Type = "Spell", ID = 204914, Hidden = true    }),
    AuraofReckoning                        = Create({ Type = "Spell", ID = 247675, Hidden = true    }),
    Jurisdiction                        = Create({ Type = "Spell", ID = 204979, Hidden = true    }),
    JudgmentsofthePure                      = Create({ Type = "Spell", ID = 355858, Hidden = true    }),    
    HallowedGround                        = Create({ Type = "Spell", ID = 216868, Hidden = true    }),    

}

local A = setmetatable(Action[ACTION_CONST_PALADIN_RETRIBUTION], { __index = Action })

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
}

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end  
	
    local WoGHP = A.GetToggle(2, "WoGHP")
    if Unit(player):HealthPercent() <= WoGHP then
        if A.WordofGlory:IsReady(player) and A.HealingHands:IsTalentLearned() then
            return A.WordofGlory
        elseif A.FlashofLight:IsReady(player) and Unit(player):HasBuffsStacks(A.SelflessHealerBuff.ID) >= 4 then
            return A.FlashofLight
        end
    end

    local DivineProtectionHP = A.GetToggle(2, "DivineProtectionHP")
    if A.DivineProtection:IsReady(player) and Unit(player):HealthPercent() <= DivineProtectionHP then
        return A.DivineProtection
    end

    local DivineShieldHP = A.GetToggle(2, "DivineShieldHP")
    if A.DivineShield:IsReady(player) and Unit(player):HealthPercent() <= DivineShieldHP then
        return A.DivineShield
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)

    if castRemainsTime >= A.GetLatency() then
        -- Rebuke
        if useKick and not notInterruptable and A.Rebuke:IsReady(unitID) then 
            return A.Rebuke
        end
            
        if useCC and A.HammerofJustice:IsReady(unitID) then
            return A.HammerofJustice
        end

        if useCC and A.BlindingLight:IsReady(player) and A.HammerofJustice:IsInRange(unitID) then
            return A.BlindingLight
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

local function TimeToHPG()

    cooldownHammerofWrath = A.HammerofWrath:IsReady(unitID) and 0 or 10
    cooldownWakeofAshes = A.RadiantDecree:IsTalentLearned() and A.WakeofAshes:GetCooldown() or 15

    local generators = {A.Judgment:GetCooldown(), A.CrusaderStrike:GetCooldown(), cooldownHammerofWrath, A.BladeofJustice:GetCooldown(), cooldownWakeofAshes}

    minTimeToHPG = generators[1]

    for i, gen in ipairs(generators) do
        if gen < minTimeToHPG then
            minTimeToHPG = gen
        end
    end

    return minTimeToHPG
end

local function Finishers(unitID)

    -- actions.finishers+=/variable,name=ds_castable,value=spell_targets.divine_storm>=2|buff.empyrean_power.up&!debuff.judgment.up&!buff.divine_purpose.up|buff.crusade.up&buff.crusade.stack<10&buff.empyrean_legacy.up&!talent.justicars_vengeance
    local dsCastable = false
    if MultiUnits:GetByRangeInCombat(10, 3) >= 2 or Unit(player):HasBuffs(A.EmpyreanPower.ID) > 0 and Unit(unitID):HasDeBuffs(A.Judgment.ID, true) == 0 and Unit(player):HasBuffs(A.DivinePurpose.ID) == 0 or Unit(player):HasBuffs(A.Crusade.ID) > 0 and Unit(player):HasBuffsStacks(A.Crusade.ID) < 10 and Unit(player):HasBuffs(A.EmpyreanLegacy.ID) > 0 and not A.JusticarsVengeance:IsTalentLearned() then
        dsCastable = true
        else dsCastable = false
    end

    -- actions.finishers+=/seraphim,if=(cooldown.avenging_wrath.remains>15|cooldown.crusade.remains>15)&!talent.final_reckoning&(!talent.execution_sentence|cooldown.execution_sentence.remains>action_cooldown|spell_targets.divine_storm>=5)&(!raid_event.adds.exists|raid_event.adds.in>40|raid_event.adds.in<gcd|raid_event.adds.up)|fight_remains<15&fight_remains>5|buff.crusade.up&buff.crusade.stack<10
    if A.Seraphim:IsReady(player) then
        if (A.AvengingWrath:GetCooldown() > 15 or A.Crusade:GetCooldown() > 15) and not A.FinalReckoning:IsTalentLearned() and (not A.ExecutionSentence:IsTalentLearned() or A.ExecutionSentence:GetCooldown() > 45 or MultiUnits:GetByRangeInCombat(10, 6) >= 5) or Unit(unitID):TimeToDie() < 15 and Unit(unitID):TimeToDie() > 5 or Unit(player):HasBuffs(A.Crusade.ID) > 0 and Unit(player):HasBuffsStacks(A.Crusade.ID) < 10 then
            return A.Seraphim
        end
    end

    -- actions.finishers+=/execution_sentence,if=(buff.crusade.down&cooldown.crusade.remains>10|buff.crusade.stack>=3|cooldown.avenging_wrath.remains>10)&(!talent.final_reckoning|cooldown.final_reckoning.remains>10)&target.time_to_die>8&(spell_targets.divine_storm<5|talent.executioners_wrath)
    if A.ExecutionSentence:IsReady(unitID) then
        if (Unit(player):HasBuffs(A.Crusade.ID) == 0 and A.Crusade:GetCooldown() > 10 or Unit(player):HasBuffsStacks(A.Crusade.ID) >= 3 or A.AvengingWrath:GetCooldown() > 10) and (not A.FinalReckoning:IsTalentLearned() or A.FinalReckoning:GetCooldown() > 10) and Unit(unitID):TimeToDie() > 8 and (MultiUnits:GetByRangeInCombat(10, 5) < 5 or A.ExecutionersWrath:IsTalentLearned()) then
            return A.ExecutionSentence
        end
    end

    -- actions.finishers+=/radiant_decree,if=(buff.crusade.down&cooldown.crusade.remains>5|buff.crusade.stack>=3|cooldown.avenging_wrath.remains>5)&(!talent.final_reckoning|cooldown.final_reckoning.remains>5)
    if A.RadiantDecree:IsReady(player) and A.CrusaderStrike:IsInRange(unitID) then
        if (Unit(player):HasBuffs(A.Crusade.ID) == 0 and A.Crusade:GetCooldown() > 5 or Unit(player):HasBuffsStacks(A.Crusade.ID) >= 3 or A.AvengingWrath:GetCooldown() > 5) and (not A.FinalReckoning:IsTalentLearned() or A.FinalReckoning:GetCooldown() > 5) then
            return A.RadiantDecree
        end
    end

    -- actions.finishers+=/divine_storm,if=variable.ds_castable&(!buff.empyrean_legacy.up|buff.crusade.up&buff.crusade.stack<10)&((!talent.crusade|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence|cooldown.execution_sentence.remains>gcd*6|cooldown.execution_sentence.remains>gcd*4&holy_power>=4|target.time_to_die<8|spell_targets.divine_storm>=5|!talent.seraphim&cooldown.execution_sentence.remains>gcd*2)&(!talent.final_reckoning|cooldown.final_reckoning.remains>gcd*6|cooldown.final_reckoning.remains>gcd*4&holy_power>=4|!talent.seraphim&cooldown.final_reckoning.remains>gcd*2)|talent.holy_avenger&cooldown.holy_avenger.remains<gcd*3|buff.holy_avenger.up|buff.crusade.up&buff.crusade.stack<10)
    if A.DivineStorm:IsReady(player) then
        if dsCastable and (Unit(player):HasBuffs(A.EmpyreanLegacy.ID) == 0 or Unit(player):HasBuffs(A.Crusade.ID) > 0 and Unit(player):HasBuffsStacks(A.Crusade.ID) < 10) and ((not A.Crusade:IsTalentLearned() or A.Crusade:GetCooldown() > A.GetGCD() * 3) and (not A.ExecutionSentence:IsTalentLearned() or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 6 or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 4 and Player:HolyPower() >= 4 or Unit(unitID):TimeToDie() < 8 or MultiUnits:GetByRangeInCombat(10, 6) >= 5 or not A.Seraphim:IsTalentLearned() and A.ExecutionSentence:GetCooldown() > A.GetGCD() * 2) and (not A.FinalReckoning:IsTalentLearned() or A.FinalReckoning:GetCooldown() > A.GetGCD() * 6 or A.FinalReckoning:GetCooldown() > A.GetGCD() * 4 and Player:HolyPower() >= 4 or not A.Seraphim:IsTalentLearned() and A.FinalReckoning:GetCooldown() > A.GetGCD() * 2) or A.HolyAvenger:IsTalentLearned() and A.HolyAvenger:GetCooldown() < A.GetGCD() * 3 or Unit(player):HasBuffs(A.HolyAvenger.ID) > 0 or Unit(player):HasBuffs(A.Crusade.ID) > 0 and Unit(player):HasBuffsStacks(A.Crusade.ID) < 10) then
            return A.DivineStorm
        end
    end

    -- actions.finishers+=/justicars_vengeance,if=((!talent.crusade|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence|cooldown.execution_sentence.remains>gcd*6|cooldown.execution_sentence.remains>gcd*4&holy_power>=4|target.time_to_die<8|!talent.seraphim&cooldown.execution_sentence.remains>gcd*2)&(!talent.final_reckoning|cooldown.final_reckoning.remains>gcd*6|cooldown.final_reckoning.remains>gcd*4&holy_power>=4|!talent.seraphim&cooldown.final_reckoning.remains>gcd*2)|talent.holy_avenger&cooldown.holy_avenger.remains<gcd*3|buff.holy_avenger.up|buff.crusade.up&buff.crusade.stack<10)&!buff.empyrean_legacy.up
    if A.JusticarsVengeance:IsReady(unitID) then
        if ((not A.Crusade:IsTalentLearned() or A.Crusade:GetCooldown() > A.GetGCD() * 3) and (not A.ExecutionSentence:IsTalentLearned() or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 6 or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 4 and Player:HolyPower() >= 4 or Unit(unitID):TimeToDie() < 8 or not A.Seraphim:IsTalentLearned() and A.ExecutionSentence:GetCooldown() > A.GetGCD() * 2) and (not A.FinalReckoning:IsTalentLearned() or A.FinalReckoning:GetCooldown() > A.GetGCD() * 6 or A.FinalReckoning:GetCooldown() > A.GetGCD() * 4 and Player:HolyPower() >= 4 or not A.Seraphim:IsTalentLearned() and A.FinalReckoning:GetCooldown() > A.GetGCD() * 2) or A.HolyAvenger:IsTalentLearned() and A.HolyAvenger:GetCooldown() < A.GetGCD() * 3 or Unit(player):HasBuffs(A.HolyAvenger.ID) > 0 or Unit(player):HasBuffs(A.Crusade.ID) > 0 and Unit(player):HasBuffsStacks(A.Crusade.ID) < 10) and Unit(player):HasBuffs(A.EmpyreanLegacy.ID) == 0 then
            return A.JusticarsVengeance
        end
    end


    -- actions.finishers+=/templars_verdict,if=(!talent.crusade|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence|cooldown.execution_sentence.remains>gcd*6|cooldown.execution_sentence.remains>gcd*4&holy_power>=4|target.time_to_die<8|!talent.seraphim&cooldown.execution_sentence.remains>gcd*2)&(!talent.final_reckoning|cooldown.final_reckoning.remains>gcd*6|cooldown.final_reckoning.remains>gcd*4&holy_power>=4|!talent.seraphim&cooldown.final_reckoning.remains>gcd*2)|talent.holy_avenger&cooldown.holy_avenger.remains<gcd*3|buff.holy_avenger.up|buff.crusade.up&buff.crusade.stack<10
    if A.TemplarsVerdict:IsReady(unitID) then
        if ((not A.Crusade:IsTalentLearned() or A.Crusade:GetCooldown() > A.GetGCD() * 3) and (not A.ExecutionSentence:IsTalentLearned() or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 6 or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 4 and Player:HolyPower() >= 4 or Unit(unitID):TimeToDie() < 8 or not A.Seraphim:IsTalentLearned() and A.ExecutionSentence:GetCooldown() > A.GetGCD() * 2) and (not A.FinalReckoning:IsTalentLearned() or A.FinalReckoning:GetCooldown() > A.GetGCD() * 6 or A.FinalReckoning:GetCooldown() > A.GetGCD() * 4 and Player:HolyPower() >= 4 or not A.Seraphim:IsTalentLearned() and A.FinalReckoning:GetCooldown() > A.GetGCD() * 2) or A.HolyAvenger:IsTalentLearned() and A.HolyAvenger:GetCooldown() < A.GetGCD() * 3 or Unit(player):HasBuffs(A.HolyAvenger.ID) > 0 or Unit(player):HasBuffs(A.Crusade.ID) > 0 and Unit(player):HasBuffsStacks(A.Crusade.ID) < 10) then
            return A.TemplarsVerdict
        end
    end

end


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local useRacial = A.GetToggle(1, "Racial")

    local function EnemyRotation(unitID)

        local useFinisher = Finishers(unitID)

        if A.ShieldofVengeance:IsReady(player) then
            return A.ShieldofVengeance:Show(icon)
        end

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

        --actions+=/call_action_list,name=cooldowns
        if BurstIsON(unitID) and A.CrusaderStrike:IsInRange(unitID) and (Unit(unitID):TimeToDie() > 10 or Unit(unitID):IsBoss()) then
            -- actions.cooldowns=potion,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10|fight_remains<25
            -- actions.cooldowns+=/lights_judgment,if=spell_targets.lights_judgment>=2|!raid_event.adds.exists|raid_event.adds.in>75|raid_event.adds.up
            if A.LightsJudgment:IsReady(unitID) then
                return A.LightsJudgment:Show(icon)
            end
            -- actions.cooldowns+=/fireblood,if=(buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10)&!talent.execution_sentence
            if A.Fireblood:IsReady(player) and (Unit(player):HasBuffs(A.AvengingWrath.ID) > 0 or Unit(player):HasBuffsStacks(A.Crusade.ID) == 10) and not A.ExecutionSentence:IsTalentLearned() then
                return A.Fireblood:Show(icon)
            end
            -- actions.cooldowns+=/use_item,slot=trinket1,if=(buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10)&(!trinket.2.has_cooldown|trinket.2.cooldown.remains|variable.trinket_priority=1)|trinket.1.proc.any_dps.duration>=fight_remains
            local UseTrinket = UseTrinkets(unitID)
            if Unit(player):HasBuffs(A.AvengingWrath.ID) > 0 or Unit(player):HasBuffsStacks(A.Crusade.ID) == 10 then
                if UseTrinket then
                    return UseTrinket:Show(icon)
                end   
            end
            -- actions.cooldowns+=/shield_of_vengeance,if=(!talent.execution_sentence|cooldown.execution_sentence.remains<52)&fight_remains>15
            if A.ShieldofVengeance:IsReady(player) and (not A.ExecutionSentence:IsTalentLearned() or A.ExecutionSentence:GetCooldown() < 52) and Unit(unitID):TimeToDie() > 15 then
                return A.ShieldofVengeance:Show(icon)
            end
            -- actions.cooldowns+=/avenging_wrath,if=((holy_power>=4&time<5|holy_power>=3&time>5)|talent.holy_avenger&cooldown.holy_avenger.remains=0)&(!talent.seraphim|!talent.final_reckoning|cooldown.seraphim.remains>0)
            if A.AvengingWrath:IsReady(player) then
                if ((Player:HolyPower() >= 4 and Unit(player):CombatTime() < 5 or Player:HolyPower() >= 3 and Unit(player):CombatTime() > 5) or A.HolyAvenger:IsTalentLearned() and A.HolyAvenger:GetCooldown() < 1) and (not A.Seraphim:IsTalentLearned() or not A.FinalReckoning:IsTalentLearned() or A.Seraphim:GetCooldown() > 0) then
                    return A.AvengingWrath:Show(icon)
                end
            end
            -- actions.cooldowns+=/crusade,if=holy_power>=5&time<5|holy_power>=3&time>5
            if A.Crusade:IsReady(player) then
                if Player:HolyPower() >= 5 and Unit(player):CombatTime() < 5 or Player:HolyPower() >= 3 and Unit(player):CombatTime() > 5 then
                    return A.Crusade:Show(icon)
                end
            end
            -- actions.cooldowns+=/holy_avenger,if=time_to_hpg=0&holy_power<=2&(buff.avenging_wrath.up|talent.crusade&(cooldown.crusade.remains=0|buff.crusade.up)|fight_remains<20)
            if A.HolyAvenger:IsReady(player) then
                if TimeToHPG() == 0 and Player:HolyPower() <= 2 and (Unit(player):HasBuffs(A.AvengingWrath.ID) > 0 or A.Crusade:IsTalentLearned() and (A.Crusade:IsReadyByPassCastGCD(player) or Unit(player):HasBuffs(A.Crusade.ID) > 0) or Unit(unitID):TimeToDie() < 20) then
                    return A.HolyAvenger:Show(icon)
                end
            end
            -- actions.cooldowns+=/final_reckoning,if=(holy_power>=4&time<8|holy_power>=3&time>=8)&(cooldown.avenging_wrath.remains>gcd|cooldown.crusade.remains&(!buff.crusade.up|buff.crusade.stack>=10))&(time_to_hpg>0|holy_power=5)&(!talent.seraphim|buff.seraphim.up)&(!raid_event.adds.exists|raid_event.adds.up|raid_event.adds.in>40)&(!buff.avenging_wrath.up|holy_power=5|cooldown.hammer_of_wrath.remains)
            if A.FinalReckoning:IsReady(player) and A.CrusaderStrike:IsInRange(unitID) then
                if (Player:HolyPower() >= 4 and Unit(player):CombatTime() < 8 or Player:HolyPower() >= 3 and Unit(player):CombatTime() >= 8) and (A.AvengingWrath:GetCooldown() > A.GetGCD() or A.Crusade:GetCooldown() > 0 and (Unit(player):HasBuffs(A.Crusade.ID) == 0 or Unit(player):HasBuffsStacks(A.Crusade.ID) >= 10)) and (TimeToHPG() > 0 or Player:HolyPower() == 5) and (not A.Seraphim:IsTalentLearned() or Unit(player):HasBuffs(A.Seraphim.ID) > 0) and (Unit(player):HasBuffs(A.AvengingWrath.ID) == 0 or Player:HolyPower() == 5 or not A.HammerofWrath:IsReadyByPassCastGCD(unitID)) then
                    return A.FinalReckoning:Show(icon)
                end
            end
        end     
       
        --actions+=/call_action_list,name=es_fr_pooling,if=(!raid_event.adds.exists|raid_event.adds.up|raid_event.adds.in<9|raid_event.adds.in>30)&(talent.execution_sentence&cooldown.execution_sentence.remains<9&spell_targets.divine_storm<5|talent.final_reckoning&cooldown.final_reckoning.remains<9)&target.time_to_die>8
        if ((A.ExecutionSentence:IsTalentLearned() and A.ExecutionSentence:GetCooldown() < 9 and MultiUnits:GetByRangeInCombat(10, 5) < 5) or A.FinalReckoning:IsTalentLearned() and A.FinalReckoning:GetCooldown() < 9) and Unit(unitID):TimeToDie() > 8 then
            -- actions.es_fr_pooling+=/seraphim,if=holy_power=5&(!talent.final_reckoning|cooldown.final_reckoning.remains<=gcd*3|cooldown.final_reckoning.remains>action_cooldown)&(!talent.execution_sentence|cooldown.execution_sentence.remains<=gcd*3|cooldown.execution_sentence.remains>action_cooldown|talent.final_reckoning)
            if A.Seraphim:IsReady(player) then
                if Player:HolyPower() == 5 and (not A.FinalReckoning:IsTalentLearned() or A.FinalReckoning:GetCooldown() <= (A.GetGCD() * 3) or A.FinalReckoning:GetCooldown() > 45) and (not A.ExecutionSentence:IsTalentLearned() or A.ExecutionSentence:GetCooldown() <= (A.GetGCD() * 3) or A.ExecutionSentence:GetCooldown() > 45 or A.FinalReckoning:IsTalentLearned()) then
                    return A.Seraphim:Show(icon)
                end
            end
            -- actions.es_fr_pooling+=/call_action_list,name=finishers,if=holy_power=5|debuff.final_reckoning.up|buff.crusade.up&buff.crusade.stack<10
            if Player:HolyPower() == 5 or Unit(unitID):HasDeBuffs(A.FinalReckoningDebuff.ID) > 0 or Unit(player):HasBuffs(A.Crusade.ID) > 0 and Unit(player):HasBuffsStacks(A.Crusade.ID) < 10 then
                if useFinisher then
                    return useFinisher:Show(icon)
                end
            end
            -- actions.es_fr_pooling+=/hammer_of_wrath,if=talent.vanguards_momentum
            if A.HammerofWrath:IsReady(unitID) and A.VanguardsMomentum:IsTalentLearned() then
                return A.HammerofWrath:Show(icon)
            end
            -- actions.es_fr_pooling+=/wake_of_ashes,if=holy_power<=2&talent.ashes_to_dust&(cooldown.crusade.remains|cooldown.avenging_wrath.remains)
            if A.WakeofAshes:IsReady(player) and A.CrusaderStrike:IsInRange(unitID) and not A.RadiantDecree:IsTalentLearned() and Player:HolyPower() <= 2 and A.AshestoDust:IsTalentLearned() and (A.Crusade:GetCooldown() > 0 or A.AvengingWrath:GetCooldown() > 0) then
                return A.WakeofAshes:Show(icon)
            end
            -- actions.es_fr_pooling+=/blade_of_justice,if=holy_power<=3
            if A.BladeofJustice:IsReady(unitID) and Player:HolyPower() <= 3 then
                return A.BladeofJustice:Show(icon)
            end
            -- actions.es_fr_pooling+=/judgment,if=!debuff.judgment.up
            if A.Judgment:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Judgment.ID) == 0 then
                return A.Judgment:Show(icon)
            end
            -- actions.es_fr_pooling+=/hammer_of_wrath
            if A.HammerofWrath:IsReady(unitID) then
                return A.HammerofWrath:Show(icon)
            end
            -- actions.es_fr_pooling+=/crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2)
            if A.CrusaderStrike:IsReady(unitID) and A.CrusaderStrike:GetSpellChargesFrac() >= 1.75 and (Player:HolyPower() <=2 or Player:HolyPower() <=3 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 and A.Judgment:GetCooldown() > A.GetGCD() * 2) then
                return A.CrusaderStrike:Show(icon)
            end
            -- actions.es_fr_pooling+=/seraphim,if=!talent.final_reckoning&(cooldown.execution_sentence.remains<=gcd*3|cooldown.execution_sentence.remains>action_cooldown)
            if A.Seraphim:IsReady(player) and A.CrusaderStrike:IsInRange(unitID) and not A.FinalReckoning:IsTalentLearned() and (A.ExecutionSentence:GetCooldown() <= A.GetGCD() * 3 or A.ExecutionSentence:GetCooldown() > 45) then
                return A.Seraphim:Show(icon)
            end
            -- actions.es_fr_pooling+=/call_action_list,name=finishers
            if useFinisher then
                return useFinisher:Show(icon)
            end
            -- actions.es_fr_pooling+=/crusader_strike
            if A.CrusaderStrike:IsReady(unitID) then
                return A.CrusaderStrike:Show(icon)
            end
            -- actions.es_fr_pooling+=/arcane_torrent,if=holy_power<=4
            if A.ArcaneTorrent:IsReady(player) and useRacial and A.CrusaderStrike:IsInRange(unitID) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- actions.es_fr_pooling+=/exorcism,if=active_enemies=1|consecration.up
            if A.Exorcism:IsReady(unitID) and (MultiUnits:GetByRangeInCombat(10, 3) == 1 or Unit(unitID):HasDeBuffs(A.Consecration.ID) > 0) then
                return A.Exorcism:Show(icon)
            end
            -- actions.es_fr_pooling+=/seraphim,if=(!talent.final_reckoning|cooldown.final_reckoning.remains<=gcd*3|cooldown.final_reckoning.remains>action_cooldown)&(!talent.execution_sentence|cooldown.execution_sentence.remains<=gcd*3|cooldown.execution_sentence.remains>action_cooldown|talent.final_reckoning)
            if A.Seraphim:IsReady(player) then
                if (not A.FinalReckoning:IsTalentLearned() or A.FinalReckoning:GetCooldown() <= A.GetGCD() * 3 or A.FinalReckoning:GetCooldown() > 45) and (not A.ExecutionSentence:IsTalentLearned() or A.ExecutionSentence:GetCooldown() <= A.GetGCD() * 3 or A.ExecutionSentence:GetCooldown() > 45 or A.FinalReckoning:IsTalentLearned()) then
                    return A.Seraphim:Show(icon)
                end
            end
            -- actions.es_fr_pooling+=/consecration
            if A.Consecration:IsReady(player) and A.CrusaderStrike:IsInRange(unitID) then
                return A.Consecration:Show(icon)
            end
        end
        
        --actions+=/call_action_list,name=es_fr_active,if=debuff.execution_sentence.up|debuff.final_reckoning.up
        if Unit(unitID):HasDeBuffs(A.ExecutionSentence.ID, true) > 0 or Unit:HasDeBuffs(A.FinalReckoning.ID, true) > 0 then
            local Finisher = Finishers(unitID)
            -- actions.es_fr_active=fireblood
            if A.Fireblood:IsReady(player) and useRacial then
                return A.Fireblood:Show(icon)
            end
            -- actions.es_fr_active+=/call_action_list,name=finishers,if=holy_power=5|debuff.judgment.up|debuff.final_reckoning.up&(debuff.final_reckoning.remains<gcd.max|spell_targets.divine_storm>=2&!talent.execution_sentence)|debuff.execution_sentence.up&debuff.execution_sentence.remains<gcd.max
            if Player:HolyPower() == 5 or Unit(unitID):HasDeBuffs(A.Judgment.ID) > 0 or Unit(unitID):HasDeBuffs(A.FinalReckoningDebuff.ID) > 0 and (Unit(unitID):HasDeBuffs(A.FinalReckoningDebuff.ID) < A.GetGCD() or MultiUnits:GetByRange(10, 3) >= 2 and not A.ExecutionSentence:IsTalentLearned()) or Unit(unitID):HasDeBuffs(A.ExecutionSentence.ID) > 0 and Unit(unitID):HasDeBuffs(A.ExecutionSentence.ID) < A.GetGCD() then
                if useFinisher then
                    return useFinisher:Show(icon)
                end
            end
            -- actions.es_fr_active+=/divine_toll,if=holy_power<=2
            if A.DivineToll:IsReady(unitID) and Player:HolyPower() <= 2 then
                return A.DivineToll:Show(icon)
            end
            -- actions.es_fr_active+=/wake_of_ashes,if=holy_power<=2&(debuff.final_reckoning.up&debuff.final_reckoning.remains<gcd*2&!talent.divine_resonance|debuff.execution_sentence.up&debuff.execution_sentence.remains<gcd|spell_targets.divine_storm>=5&talent.divine_resonance&talent.execution_sentence)
            if A.WakeofAshes:IsReady(player) and not A.RadiantDecree:IsTalentLearned() and A.CrusaderStrike:IsInRange(unitID) then
                if Player:HolyPower() <= 2 and (Unit(unitID):HasBuffs(A.FinalReckoningDebuff.ID) > 0 and Unit(unitID):HasDeBuffs(A.FinalReckoningDebuff.ID) < A.GetGCD() * 2 and not A.DivineResonance:IsTalentLearned() or Unit(unitID):HasDeBuffs(A.ExecutionSentence.ID) > 0 and Unit(unitID):HasDeBuffs(A.ExecutionSentence.ID) < A.GetGCD() or MultiUnits:GetByRangeInCombat(10, 6) >= 5 and A.DivineResonance:IsTalentLearned() and A.ExecutionSentence:IsTalentLearned()) then
                    return A.WakeofAshes:Show(icon)
                end
            end
            -- actions.es_fr_active+=/blade_of_justice,if=talent.expurgation&(!talent.divine_resonance&holy_power<=3|holy_power<=2)
            if A.BladeofJustice:IsReady(unitID) and A.Expurgation:IsTalentLearned() and (not A.DivineResonance:IsTalentLearned() and Player:HolyPower() <= 3 or Player:HolyPower() <= 2) then
                return A.BladeofJustice:Show(icon)
            end
            -- actions.es_fr_active+=/judgment,if=!debuff.judgment.up&holy_power>=2
            if A.Judgment:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Judgment.ID) == 0 and Player:HolyPower() >= 2 then
                return A.Judgment:Show(icon)
            end
            -- actions.es_fr_active+=/call_action_list,name=finishers
            if useFinisher then
                return useFinisher:Show(icon)
            end
            -- actions.es_fr_active+=/wake_of_ashes,if=holy_power<=2
            if A.WakeofAshes:IsReady(player) and not A.RadiantDecree:IsTalentLearned() and Player:HolyPower() <= 2 and A.CrusaderStrike:IsInRange(unitID) then
                return A.WakeofAshes:Show(icon)
            end
            -- actions.es_fr_active+=/blade_of_justice,if=holy_power<=3
            if A.BladeofJustice:IsReady(unitID) and Player:HolyPower() <= 3 then
                return A.BladeofJustice:Show(icon)
            end
            -- actions.es_fr_active+=/judgment,if=!debuff.judgment.up
            if A.Judgment:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Judgment.ID) == 0 then
                return A.Judgment:Show(icon)
            end
            -- actions.es_fr_active+=/hammer_of_wrath
            if A.HammerofWrath:IsReady(unitID) then
                return A.HammerofWrath:Show(icon)
            end
            -- actions.es_fr_active+=/crusader_strike
            if A.CrusaderStrike:IsReady(unitID) then
                return A.CrusaderStrike:Show(icon)
            end
            -- actions.es_fr_active+=/arcane_torrent
            if A.ArcaneTorrent:IsReady(player) and A.CrusaderStrike:IsInRange(unitID) and useRacial then
                return A.ArcaneTorrent:Show(icon)
            end
            -- actions.es_fr_active+=/exorcism,if=active_enemies=1|consecration.up
            if A.Exorcism:IsReady(unitID) and (MultiUnits:GetByRangeInCombat(10, 3) == 1 or Unit(unitID):HasDeBuffs(A.Consecration.ID) > 0) then
                return A.Exorcism:Show(icon)
            end
            -- actions.es_fr_active+=/consecration  
            if A.Consecration:IsReady(player) and A.CrusaderStrike:IsInRange(unitID) then
                return A.Consecration:Show(icon)
            end
        end

        -- actions.generators=call_action_list,name=finishers,if=holy_power=5|(debuff.judgment.up|holy_power=4)&buff.divine_resonance.up|buff.holy_avenger.up
        if Player:HolyPower() == 5 or ((Unit(unitID):HasDeBuffs(A.Judgment.ID, true) > 0 or Player:HolyPower() == 4) and Unit(player):HasBuffs(A.DivineResonance.ID) > 0) or Unit(player):HasBuffs(A.HolyAvenger.ID) > 0 then    
            if useFinisher then
                return useFinisher:Show(icon)
            end
        end

        -- actions.generators+=/hammer_of_wrath,if=talent.zealots_paragon
        if A.HammerofWrath:IsReady(unitID) and A.ZealotsParagon:IsTalentLearned() then
            return A.HammerofWrath:Show(icon)
        end
        -- actions.generators+=/wake_of_ashes,if=holy_power<=2&talent.ashes_to_dust&(cooldown.avenging_wrath.remains|cooldown.crusade.remains)
        if A.WakeofAshes:IsReady(player) and not A.RadiantDecree:IsTalentLearned() and A.CrusaderStrike:IsInRange(unitID) then
            if Player:HolyPower() <= 2 and A.AshestoDust:IsTalentLearned() and (A.AvengingWrath:GetCooldown() > 0 or A.Crusade:GetCooldown() > 0) then
                return A.WakeofAshes:Show(icon)
            end
        end
        -- actions.generators+=/divine_toll,if=holy_power<=2&!debuff.judgment.up&(!talent.seraphim|buff.seraphim.up)&(!raid_event.adds.exists|raid_event.adds.in>30|raid_event.adds.up)&!talent.final_reckoning&(!talent.execution_sentence|fight_remains<8|spell_targets.divine_storm>=5)&(cooldown.avenging_wrath.remains>15|cooldown.crusade.remains>15|fight_remains<8)
        if A.DivineToll:IsReady(unitID) then
            if Player:HolyPower() <= 2 and Unit(unitID):HasDeBuffs(A.Judgment.ID) == 0 and (not A.Seraphim:IsTalentLearned() or Unit(player):HasBuffs(A.Seraphim.ID) > 0) and (not A.FinalReckoning:IsTalentLearned() and (not A.ExecutionSentence:IsTalentLearned() or (Unit(unitID):IsBoss() and Unit(unitID):TimeToDie() < 8) or MultiUnits:GetByRangeInCombat(10, 6) >= 5) and A.AvengingWrath:GetCooldown() > 15 or A.Crusade:GetCooldown() > 15 or (Unit(unitID):IsBoss() and Unit(unitID):TimeToDie() < 8)) then
                return A.DivineToll:Show(icon)
            end
        end
        -- actions.generators+=/judgment,if=!debuff.judgment.up&holy_power>=2
        if A.Judgment:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Judgment.ID) == 0 and Player:HolyPower() >= 2 then
            return A.Judgment:Show(icon)
        end
        -- actions.generators+=/wake_of_ashes,if=(holy_power=0|holy_power<=2&cooldown.blade_of_justice.remains>gcd*2)&(!raid_event.adds.exists|raid_event.adds.in>20|raid_event.adds.up)&(!talent.seraphim|cooldown.seraphim.remains>5)&(!talent.execution_sentence|cooldown.execution_sentence.remains>15|target.time_to_die<8|spell_targets.divine_storm>=5)&(!talent.final_reckoning|cooldown.final_reckoning.remains>15|fight_remains<8)&(cooldown.avenging_wrath.remains|cooldown.crusade.remains)
        if A.WakeofAshes:IsReady(player) and not A.RadiantDecree:IsTalentLearned() and A.CrusaderStrike:IsInRange(unitID) then
            if (Player:HolyPower() == 0 or Player:HolyPower() <= 2 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2) and (not A.Seraphim:IsTalentLearned() or A.Seraphim:GetCooldown() > 5) and (not A.ExecutionSentence:IsTalentLearned() or A.ExecutionSentence:GetCooldown() > 15 or Unit(unitID):TimeToDie() < 8 or MultiUnits:GetByRangeInCombat(10, 6) >= 5) and (not A.FinalReckoning:IsTalentLearned() or A.FinalReckoning:GetCooldown() > 15 or Unit(unitID):TimeToDie() < 8) and (A.AvengingWrath:GetCooldown() > 0 or A.Crusade:GetCooldown() > 0) then
                return A.WakeofAshes:Show(icon)
            end
        end
        -- actions.generators+=/call_action_list,name=finishers,if=holy_power>=3&buff.crusade.up&buff.crusade.stack<10
        if Player:HolyPower() >= 3 and Unit(player):HasBuffs(A.Crusade.ID) > 0 and Unit(player):HasBuffsStacks(A.Crusade.ID) < 10 then
            if useFinisher then
                return useFinisher:Show(icon)
            end
        end
        -- actions.es_fr_active+=/exorcism,if=active_enemies=1|consecration.up
        if A.Exorcism:IsReady(unitID) and (MultiUnits:GetByRangeInCombat(10, 3) == 1 or Unit(unitID):HasDeBuffs(A.Consecration.ID) > 0) then
            return A.Exorcism:Show(icon)
        end
        -- actions.generators+=/judgment,if=!debuff.judgment.up
        if A.Judgment:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Judgment.ID) == 0 then
            return A.Judgment:Show(icon)
        end
        -- actions.generators+=/hammer_of_wrath
        if A.HammerofWrath:IsReady(unitID) then
            return A.HammerofWrath:Show(icon)
        end
        -- actions.generators+=/blade_of_justice,if=holy_power<=3
        if A.BladeofJustice:IsReady(unitID) and Player:HolyPower() <= 3 then
            return A.BladeofJustice:Show(icon)
        end
        -- actions.generators+=/call_action_list,name=finishers,if=(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up|buff.empyrean_power.up)
        if Unit(unitID):HealthPercent() <= 20 or Unit(player):HasBuffs(A.AvengingWrath.ID) > 0 or Unit(player):HasBuffs(A.Crusade.ID) > 0 or Unit(player):HasBuffs(A.EmpyreanPowerBuff.ID) > 0 then
            if useFinisher then
                return useFinisher:Show(icon)
            end
        end
        -- actions.generators+=/consecration,if=!consecration.up&spell_targets.divine_storm>=2
        if A.Consecration:IsReady(player) and MultiUnits:GetByRangeInCombat(10, 3) >= 2 then
            return A.Consecration:Show(icon)
        end
        -- actions.generators+=/crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2)
        if A.CrusaderStrike:IsReady(unitID) and A.CrusaderStrike:GetSpellChargesFrac() >= 1.75 and (Player:HolyPower() <=2 or Player:HolyPower() <=3 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 and A.Judgment:GetCooldown() > A.GetGCD() * 2) then
            return A.CrusaderStrike:Show(icon)
        end
        -- actions.generators+=/call_action_list,name=finishers
        if useFinisher then
            return useFinisher:Show(icon)
        end
        -- actions.es_fr_active+=/consecration  
        if A.Consecration:IsReady(player) and A.CrusaderStrike:IsInRange(unitID) then
            return A.Consecration:Show(icon)
        end
        -- actions.generators+=/crusader_strike
        if A.CrusaderStrike:IsReady(unitID) then
            return A.CrusaderStrike:Show(icon)
        end
        -- actions.generators+=/arcane_torrent
        if A.ArcaneTorrent:IsReady(player) and A.CrusaderStrike:IsInRange(unitID) then
            return A.ArcaneTorrent:Show(icon)
        end
        -- actions.es_fr_active+=/consecration  
        if A.Consecration:IsReady(player) and A.CrusaderStrike:IsInRange(unitID) then
            return A.Consecration:Show(icon)
        end


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