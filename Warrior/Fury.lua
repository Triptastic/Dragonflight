--###############################
--##### TRIP'S FURY WARRIOR #####
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

Action[ACTION_CONST_WARRIOR_FURY] = {
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
    BattleShout 				= Action.Create({ Type = "Spell", ID = 6673     }),
    Charge      				= Action.Create({ Type = "Spell", ID = 100      }),  
    Execute     				= Action.Create({ Type = "Spell", ID = 163201   }),  
    Hamstring   				= Action.Create({ Type = "Spell", ID = 1715     }),  
    Pummel      				= Action.Create({ Type = "Spell", ID = 6552     }),
    ShieldBlock 				= Action.Create({ Type = "Spell", ID = 2565     }), 
    ShieldSlam  				= Action.Create({ Type = "Spell", ID = 23922    }),
    Slam				        = Action.Create({ Type = "Spell", ID = 1464     }),  
    Taunt       				= Action.Create({ Type = "Spell", ID = 355      }),
    VictoryRush 				= Action.Create({ Type = "Spell", ID = 34428    }),  
    Whirlwind   				= Action.Create({ Type = "Spell", ID = 1680   }),                                     
    BerserkerStance				= Action.Create({ Type = "Spell", ID = 386196   }),
    DefensiveStance				= Action.Create({ Type = "Spell", ID = 386208   }),
    BerserkerRage				= Action.Create({ Type = "Spell", ID = 18499   }), 
    ImpendingVictory	    	= Action.Create({ Type = "Spell", ID = 202168   }),
    Intervene   				= Action.Create({ Type = "Spell", ID = 3411   }),
    RallyingCry 				= Action.Create({ Type = "Spell", ID = 97462   }),  
    BerserkerShout				= Action.Create({ Type = "Spell", ID = 384100   }),
    PiercingHowl				= Action.Create({ Type = "Spell", ID = 12323   }),
    SpellReflection				= Action.Create({ Type = "Spell", ID = 23920   }),
    HeroicLeap				    = Action.Create({ Type = "Spell", ID = 6544    }),
    IntimidatingShout			= Action.Create({ Type = "Spell", ID = 5246   }), 
    ThunderClap 				= Action.Create({ Type = "Spell", ID = 396719   }), 
    WreckingThrow				= Action.Create({ Type = "Spell", ID = 384110   }),
    ShatteringThrow				= Action.Create({ Type = "Spell", ID = 64382   }),
    StormBolt				    = Action.Create({ Type = "Spell", ID = 107570   }),
    BitterImmunity				= Action.Create({ Type = "Spell", ID = 383762   }),
    HeroicThrow 				= Action.Create({ Type = "Spell", ID = 57755   }), 
    TitanicThrow				= Action.Create({ Type = "Spell", ID = 384090   }),            
    Avatar      				= Action.Create({ Type = "Spell", ID = 107574   }), 
    ThunderousRoar				= Action.Create({ Type = "Spell", ID = 384318   }),
    SpearofBastion				= Action.Create({ Type = "Spell", ID = 376079   }), 
    Shockwave   				= Action.Create({ Type = "Spell", ID = 46968   }), 
    
    --Fury
    Bloodthirst				= Action.Create({ Type = "Spell", ID = 23881   }), 
    RagingBlow				= Action.Create({ Type = "Spell", ID = 85288   }), 
    EnragedRegeneration				= Action.Create({ Type = "Spell", ID = 184364   }),
    Rampage 				= Action.Create({ Type = "Spell", ID = 184367   }),  
    Recklessness				= Action.Create({ Type = "Spell", ID = 1719   }),
    OdynsFury				= Action.Create({ Type = "Spell", ID = 385059   }), 
    Onslaught				= Action.Create({ Type = "Spell", ID = 315720   }),  
    Ravager				= Action.Create({ Type = "Spell", ID = 228920   }), 
    Annihilator				= Action.Create({ Type = "Spell", ID = 383916   }), 
    Enrage				= Action.Create({ Type = "Spell", ID = 184361   }), 
    TitansTorment				= Action.Create({ Type = "Spell", ID = 390135   }),    
    TitanicRage				= Action.Create({ Type = "Spell", ID = 394329   }),
    MeatCleaver				= Action.Create({ Type = "Spell", ID = 280392   }),  
    ImprovedWhirlwind				= Action.Create({ Type = "Spell", ID = 12950   }),
    AshenJuggernaut				= Action.Create({ Type = "Spell", ID = 392536   }),   
    WrathandFury				= Action.Create({ Type = "Spell", ID = 392936   }),  
    OverwhelmingRage				= Action.Create({ Type = "Spell", ID = 382767   }),
    RecklessAbandon				= Action.Create({ Type = "Spell", ID = 396749   }),  
    Tenderize				= Action.Create({ Type = "Spell", ID = 388933   }),
    DancingBlades				= Action.Create({ Type = "Spell", ID = 391683   }),
}

local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })

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
}

local function InMelee(unitID)
    return A.Bloodthirst:IsInRange(unitID)
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

    local BitterImmunityHP = A.GetToggle(2, "BitterImmunityHP")
    if A.BitterImmunity:IsReady(player) and Unit(player):HealthPercent() <= BitterImmunityHP then
        return A.BitterImmunity
    end

    local EnragedRegenerationHP = A.GetToggle(2, "EnragedRegenerationHP")
    if A.EnragedRegeneration:IsReady(player) and Unit(player):HealthPercent() <= EnragedRegenerationHP then
        return A.EnragedRegeneration
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        if useKick and not notInterruptable and A.Pummel:IsReady(unitID) then 
            return A.Pummel
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

    local function DamageRotation(unitID)


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

        --actions.precombat+=/berserker_stance,toggle=on
        if A.BerserkerStance:IsReady(player) and Unit(player):HasBuffs(A.BerserkerStance.ID) == 0 and Unit(player):HasBuffs(A.DefensiveStance.ID) == 0 then
            return A.BerserkerStance:Show(icon)
        end
        
        --actions+=/charge,if=time<=0.5|movement.distance>5
        if A.Charge:IsReady(unitID) then
            return A.Charge:Show(icon)
        end

        local function BurstRotation(unitID)

            local useRacial = A.GetToggle(1, "Racial")
            --actions+=/ravager,if=cooldown.avatar.remains<3
            if A.Ravager:IsReady(player) and Unit(unitID):GetRange() <= 40 and A.Avatar:GetCooldown() < 3 then
                return A.Ravager:Show(icon)
            end

            --actions+=/use_items
            local UseTrinket = UseTrinkets(unitID)
            if UseTrinket then
                return UseTrinket:Show(icon)
            end        

            --actions+=/blood_fury
            if A.BloodFury:IsReady(player) and useRacial and InMelee() then
                return A.BloodFury:Show(icon)
            end
            --actions+=/berserking,if=buff.recklessness.up
            if A.Berserking:IsReady(player) and useRacial and InMelee() and Unit(player):HasBuffs(A.Recklessness.ID) > 0 then
                return A.Berserking:Show(icon)
            end
            --actions+=/lights_judgment,if=buff.recklessness.down
            if A.LightsJudgment:IsReady(unitID) and useRacial and Unit(player):HasBuffs(A.Recklessness.ID) == 0 then
                return A.LightsJudgment:Show(icon)
            end
            --actions+=/fireblood
            if A.Fireblood:IsReady(player) and useRacial and InMelee() then
                return A.Fireblood:Show(icon)
            end
            --actions+=/ancestral_call
            if A.AncestralCall:IsReady(player) and useRacial and InMelee() then
                return A.Ancestralcall:Show(icon)
            end
            --actions+=/bag_of_tricks,if=buff.recklessness.down&buff.enrage.up
            if A.BagofTricks:IsReady(player) and useRacial and Unit(player):HasBuffs(A.Recklessness.ID) == 0 and Unit(player):HasBuffs(A.Enrage.ID) > 0 then
                return A.BagofTricks:Show(icon)
            end

            --actions+=/avatar,if=talent.titans_torment&buff.enrage.up&raid_event.adds.in>15|!talent.titans_torment&(buff.recklessness.up|boss&fight_remains<20)
            if A.Avatar:IsReady(player) and inMelee() then
                if (A.TitansTorment:IsTalentLearned() and Unit(player):HasBuffs(A.Enrage.ID) > 0) or (not A.TitansTorment:IsTalentLearned() and (Unit(player):HasBuffs(A.Recklessness.ID) > 0 or (Unit(unitID):IsBoss() and Unit(unitID):TimeToDie() < 20))) then
                    return A.Avatar:Show(icon)
                end
            end
            
            --actions+=/recklessness,if=!raid_event.adds.exists&(talent.annihilator&cooldown.avatar.remains<1|cooldown.avatar.remains>40|!talent.avatar|boss&fight_remains<12)
            --actions+=/recklessness,if=!raid_event.adds.exists&!talent.annihilator|boss&fight_remains<12
            if A.Recklessness:IsReady(player) and MultiUnits:GetByRangeInCombat(40, 2) == 1 and InMelee() and (not A.Annihilator:IsTalentLearned() or(A.Annihilator:IsTalentLearned() and A.Avatar:GetCooldown() < 1) or (A.Avatar:GetCooldown() > 40) or (not A.Avatar:IsTalentLearned()) or (Unit(unitID):IsBoss() and Unit(unitID):TimeToDie() < 12)) then
                return A.Recklessness:Show(icon)
            end

            --actions+=/spear_of_bastion,if=buff.enrage.up&(buff.recklessness.up|buff.avatar.up|boss&fight_remains<20|active_enemies>1)&raid_event.adds.in>15
            if A.SpearofBastion:IsReady(player) and Unit(unitID):GetRange() <= 25 and Unit(player):HasBuffs(A.Enrage.ID) > 0 and (Unit(player):HasBuffs(A.Recklessness.ID) > 0 or Unit(player):HasBuffs(A.Avatar.ID) > 0 or (Unit(unitID):IsBoss() and Unit(unitID):TimeToDie() < 20) or MultiUnits:GetByRange(25, 3) > 2) then
                return A.SpearofBastion:Show(icon)
            end
        
        end


        local function MultiTarget(unitID)
        
            --actions.multi_target+=/recklessness,if=raid_event.adds.in>15|active_enemies>1|boss&fight_remains<12
            if A.Recklessness:IsReady(player) and BurstIsON(unitID) then
                return A.Recklessness:Show(icon)
            end

            --actions.multi_target+=/odyns_fury,if=active_enemies>1&talent.titanic_rage&(!buff.meat_cleaver.up|buff.avatar.up|buff.recklessness.up)
            if A.OdynsFury:IsReady(player) and A.TitanicRage:IsTalentLearned() and (Unit(player):HasBuffs(A.MeatCleaver.ID) == 0 or Unit(player):HasBuffs(A.Avatar.ID) > 0 or Unit(player):HasBuffs(A.Recklessness.ID) > 0) then
                return A.OdynsFury:Show(icon)
            end

            --actions.multi_target+=/whirlwind,if=spell_targets.whirlwind>1&talent.improved_whirlwind&!buff.meat_cleaver.up|raid_event.adds.in<2&talent.improved_whirlwind&!buff.meat_cleaver.up
            if A.Whirlwind:IsReady(player) and A.ImprovedWhirlwind:IsTalentLearned() and Unit(player):HasBuffs(A.MeatCleaver.ID) == 0 then
                return A.Whirlwind:Show(icon)
            end

            --actions.multi_target+=/execute,if=buff.ashen_juggernaut.up&buff.ashen_juggernaut.remains<gcd
            if A.Execute:IsReady(unitID) and Unit(player):HasBuffs(A.AshenJuggernaut.ID) > 0 and Unit(player):HasBuffs(A.AshenJuggernaut.ID) < A.GetGCD() then
                return A.Execute:Show(icon)
            end

            --actions.multi_target+=/thunderous_roar,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)
            if A.ThunderousRoar:IsReady(player) and BurstIsON(unitID) and Unit(player):HasBuffs(A.Enrage.ID) > 0 then
                return A.ThunderousRoar:Show(icon)
            end

            --actions.multi_target+=/odyns_fury,if=active_enemies>1&buff.enrage.up&raid_event.adds.in>15
            if A.OdynsFury:IsReady(player) and Unit(player):HasBuffs(A.Enrage.ID) > 0 then
                return A.OdynsFury:Show(icon)
            end

            --actions.multi_target+=/crushing_blow,if=talent.wrath_and_fury&buff.enrage.up
            if A.RagingBlow:IsReady(unitID) and A.WrathandFury:IsTalentLearned() and Unit(player):HasBuffs(A.Enrage.ID) > 0 then
                return A.RagingBlow:Show(icon)
            end

            --actions.multi_target+=/execute,if=buff.enrage.up
            if A.Execute:IsReady(unitID) and Unit(player):HasBuffs(A.Enrage.ID) > 0 then
                return A.Execute:Show(icon)
            end
            
            --actions.multi_target+=/rampage,if=buff.recklessness.up|buff.enrage.remains<gcd|(rage>110&talent.overwhelming_rage)|(rage>80&!talent.overwhelming_rage)
            if A.Rampage:IsReady(unitID) and (Unit(player):HasBuffs(A.Recklessness.ID) > 0 or Unit(player):HasBuffs(A.Enrage.ID) < A.GetGCD() or (Player:Rage() > 110 and A.OverwhelmingRage:IsTalentLearned()) or (Player:Rage() > 80 and not A.OverwhelmingRage:IsTalentLearned())) then
                return A.Rampage:Show(icon)
            end

            --actions.multi_target+=/execute
            if A.Execute:IsReady(unitID) then
                return A.Execute:Show(icon)
            end
            
            --actions.multi_target+=/bloodbath,if=buff.enrage.up&talent.reckless_abandon&!talent.wrath_and_fury
            if A.Bloodthirst:IsReady(unitID) and Unit(player):HasBuffs(A.Enrage.ID) > 0 and A.RecklessAbandon:IsTalentLearned() and not A.WrathandFury:IsTalentLearned() then
                return A.Bloodthirst:Show(icon)
            end

            --actions.multi_target+=/bloodthirst,if=buff.enrage.down|(talent.annihilator&!buff.recklessness.up)
            if A.Bloodthirst:IsReady(unitID) and (Unit(player):HasBuffs(A.Enrage.ID) == 0 or (A.Annihilator:IsTalentLearned() and Unit(player):HasBuffs(A.Recklessness.ID) == 0)) then
                return A.Bloodthirst:Show(icon)
            end

            --actions.multi_target+=/onslaught,if=!talent.annihilator&buff.enrage.up|talent.tenderize
            if A.Onslaught:IsReady(unitID) and (not A.Annihilator:IsTalentLearned() and Unit(player):HasBuffs(A.Enrage.ID) > 0 or not A.Tenderize:IsTalentLearned()) then
                return A.Onslaught:Show(icon)
            end
            
            --actions.multi_target+=/raging_blow,if=charges>1&talent.wrath_and_fury
            if A.RagingBlow:IsReady(unitID) and A.RagingBlow:GetSpellCharges() > 1 and A.WrathandFury:IsTalentLearned() then
                return A.RagingBlow:Show(icon)
            end
            
            --actions.multi_target+=/crushing_blow,if=charges>1&talent.wrath_and_fury

            --actions.multi_target+=/bloodbath,if=buff.enrage.down|!talent.wrath_and_fury
            --actions.multi_target+=/crushing_blow,if=buff.enrage.up&talent.reckless_abandon
            --actions.multi_target+=/bloodthirst,if=!talent.wrath_and_fury
            if A.Bloodthirst:IsReady(unitID) and not A.WrathandFury:IsTalentLearned() then
                return A.Bloodthirst:Show(icon)
            end
            
            --actions.multi_target+=/raging_blow,if=charges>=1
            if A.RagingBlow:IsReady(unitID) then
                return A.RagingBlow:Show(icon)
            end

            --actions.multi_target+=/rampage
            if A.Rampage:IsReady(unitID) then
                return A.Rampage:Show(icon)
            end

            --actions.multi_target+=/slam,if=talent.annihilator
            if A.Slam:IsReady(unitID) and A.Annihilator:IsTalentLearned() then
                return A.Slam:Show(icon)
            end

            --actions.multi_target+=/bloodbath

            --actions.multi_target+=/crushing_blow
            --actions.multi_target+=/whirlwind
            if A.Whirlwind:IsReady(player) then
                return A.Whirlwind:Show(icon)
            end
        end

        local function SingleTarget(unitID)
        -- actions.single_target+=/whirlwind,if=spell_targets.whirlwind>1&talent.improved_whirlwind&!buff.meat_cleaver.up|raid_event.adds.in<2&talent.improved_whirlwind&!buff.meat_cleaver.up
            --actions.single_target+=/execute,if=buff.ashen_juggernaut.up&buff.ashen_juggernaut.remains<gcd
            if A.Execute:IsReady(unitID) and Unit(player):HasBuffs(A.AshenJuggernaut.ID) > 0 and Unit(player):HasBuffs(A.AshenJuggernaut.ID) < A.GetGCD() then
                return A.Execute:Show(icon)
            end

            --actions.single_target+=/thunderous_roar,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)
            if A.ThunderousRoar:IsReady(player) and Unit(player):HasBuffs(A.Enrage.ID) > 0 then
                return A.ThunderousRoar:Show(icon)
            end

            --[[actions.single_target+=/crushing_blow,if=talent.wrath_and_fury&buff.enrage.up
            if A.CrushingBlow:IsReady(unitID) and A.WrathandFury:IsTalentLearned() and Unit(player):HasBuffs(A.Enrage.ID) > 0 then
                return A.CrushingBlow:Show(icon)
            end]]
            
            --actions.single_target+=/execute,if=buff.enrage.up
            if A.Execute:IsReady(unitID) and Unit(player):HasBuffs(A.Enrage.ID) > 0 then
                return A.Execute:Show(icon)
            end

            --actions.single_target+=/odyns_fury,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)&(talent.dancing_blades&buff.dancing_blades.remains<5|!talent.dancing_blades)
            if A.OdynsFury:IsReady(player) and Unit(player):HasBuffs(A.Enrage.ID) > 0 and (Unit(player):HasBuffs(A.DancingBlades.ID) > 0 or not A.DancingBlades:IsTalentLearned()) then
                return A.OdynsFury:Show(icon)
            end

            --actions.single_target+=/rampage,if=buff.recklessness.up|buff.enrage.remains<gcd|(rage>110&talent.overwhelming_rage)|(rage>80&!talent.overwhelming_rage)
            if A.Rampage:IsReady(unitID) and (Unit(player):HasBuffs(A.Recklessness.ID) > 0 or Unit(player):HasBuffs(A.Enrage.ID) < A.GetGCD() or (Player:Rage() > 110 and A.OverwhelmingRage:IsTalentLearned()) or (Player:Rage() > 80 and not A.OverwhelmingRage:IsTalentLearned())) then
                return A.Rampage:Show(icon)
            end

            --actions.single_target+=/execute
            if A.Execute:IsReady(unitID) then
                return A.Execute:Show(icon)
            end

            --actions.single_target+=/bloodbath,if=buff.enrage.up&talent.reckless_abandon&!talent.wrath_and_fury
            if A.Bloodthirst:IsReady(unitID) and Unit(player):HasBuffs(A.Enrage.ID) > 0 and A.RecklessAbandon:IsTalentLearned() and not A.WrathandFury:IsTalentLearned() then
                return A.Bloodthirst:Show(icon)
            end

            --actions.single_target+=/bloodthirst,if=buff.enrage.down|(talent.annihilator&!buff.recklessness.up)
            if A.Bloodthirst:IsReady(unitID) and (Unit(player):HasBuffs(A.Enrage.ID) == 0 or (A.Annihilator:IsTalentLearned() and Unit(player):HasBuffs(A.Recklessness.ID) == 0)) then
                return A.Bloodthirst:Show(icon)
            end

        --actions.single_target+=/onslaught,if=!talent.annihilator&buff.enrage.up|talent.tenderize
            if A.Onslaught:IsReady(unitID) and (not A.Annihilator:IsTalentLearned() and Unit(player):HasBuffs(A.Enrage.ID) > 0 or not A.Tenderize:IsTalentLearned()) then
                return A.Onslaught:Show(icon)
            end

            --actions.single_target+=/raging_blow,if=charges>1&talent.wrath_and_fury
            --actions.single_target+=/crushing_blow,if=charges>1&talent.wrath_and_fury
            --actions.single_target+=/bloodbath,if=buff.enrage.down|!talent.wrath_and_fury
            --actions.single_target+=/crushing_blow,if=buff.enrage.up&talent.reckless_abandon
            if A.Bloodthirst:IsReady(unitID) and not A.WrathandFury:IsTalentLearned() then
                return A.Bloodthirst:Show(icon)
            end
            
            --actions.multi_target+=/raging_blow,if=charges>=1
            if A.RagingBlow:IsReady(unitID) then
                return A.RagingBlow:Show(icon)
            end

            --actions.multi_target+=/rampage
            if A.Rampage:IsReady(unitID) then
                return A.Rampage:Show(icon)
            end

            --actions.multi_target+=/slam,if=talent.annihilator
            if A.Slam:IsReady(unitID) and A.Annihilator:IsTalentLearned() then
                return A.Slam:Show(icon)
            end

            --actions.multi_target+=/bloodbath

            --actions.multi_target+=/crushing_blow
            --actions.multi_target+=/whirlwind
            if A.Whirlwind:IsReady(player) then
                return A.Whirlwind:Show(icon)
            end

            --actions.single_target+=/wrecking_throw
            if A.WreckingThrow:IsReady(unitID) then
                return A.WreckingThrow:Show(icon)
            end
            
        end
    
        if BurstIsON(unitID) then 
            if BurstRotation(unitID) then
                return true
            end
        end

        if MultiUnits:GetByRange(10, 4) > 2 then
            return MultiTarget(unitID)  
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