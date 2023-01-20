--#####################################
--##### TRIP'S PROTECTION PALADIN #####
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

Action[ACTION_CONST_PALADIN_PROTECTION] = {
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
    FlashofLight                    = Action.Create({ Type = "Spell", ID = 19750, predictName = "FlashofLight"        }),
    HammerofJustice                    = Action.Create({ Type = "Spell", ID = 853        }),
    HammerofJusticeGreen            = Action.Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", Hidden = true, Hidden = true, QueueForbidden = true }),    
    HammerofWrath                    = Action.Create({ Type = "Spell", ID = 24275    }),
    HandofReckoning                    = Action.Create({ Type = "Spell", ID = 62124    }),    
    Judgment                        = Action.Create({ Type = "Spell", ID = 275773    }),
    LayOnHands                        = Action.Create({ Type = "Spell", ID = 633, predictName = "LayOnHands"            }),    
    Redemption                        = Action.Create({ Type = "Spell", ID = 7328        }),
    Rebuke                          = Action.Create({ Type = "Spell", ID = 96231        }),
    RetributionAura                    = Action.Create({ Type = "Spell", ID = 183435    }),
    ShieldoftheRighteous            = Action.Create({ Type = "Spell", ID = 53600    }),
    TurnEvil                        = Action.Create({ Type = "Spell", ID = 10326    }),
    WordofGlory                        = Action.Create({ Type = "Spell", ID = 85673, predictName = "WordofGlory"        }),    
    Forbearance                        = Action.Create({ Type = "Spell", ID = 25771, Hidden = true    }), 
    Seraphim                        = Action.Create({ Type = "Spell", ID = 152262    }), 
    
    --Protection
    ArdentDefender                        = Action.Create({ Type = "Spell", ID = 31850        }),
    AvengersShield                        = Action.Create({ Type = "Spell", ID = 31935        }),
    BastionofLight                        = Action.Create({ Type = "Spell", ID = 378974        }),
    BlessedHammer                        = Action.Create({ Type = "Spell", ID = 204019        }),
    CleanseToxins                        = Action.Create({ Type = "Spell", ID = 213644        }),
    DivineToll                        = Action.Create({ Type = "Spell", ID = 375576        }),
    EyeofTyr                        = Action.Create({ Type = "Spell", ID = 387174        }),
    GuardianofAncientKings               = Action.Create({ Type = "Spell", ID = 86659        }),
    Sentinel                        = Action.Create({ Type = "Spell", ID = 389539        }),
    MomentofGlory                        = Action.Create({ Type = "Spell", ID = 327193        }),
    HammeroftheRighteous                        = Action.Create({ Type = "Spell", ID = 53595        }),
    AvengingWrathMight               = Action.Create({ Type = "Spell", ID = 31884, Hidden = true        }),
    BlessingofDusk               = Action.Create({ Type = "Spell", ID = 385126, Hidden = true        }),
    DivinePurposeBuff               = Action.Create({ Type = "Spell", ID = 223819, Hidden = true     }),
    CrusadersJudgment               = Action.Create({ Type = "Spell", ID = 204023, Hidden = true     }),
    ConsecrationBuff               = Action.Create({ Type = "Spell", ID = 188370, Hidden = true     }),
    ShiningLightFree               = Action.Create({ Type = "Spell", ID = 327510, Hidden = true     }),
}

local A = setmetatable(Action[ACTION_CONST_PALADIN_PROTECTION], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
local target = "target"
local pet = "pet"

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
        unit = "target"
    end  
	
    if inCombat then
        if A.WordofGlory:IsReady(player) and Unit(player):HealthPercent() <= 80 and Unit(player):HasBuffs(A.ShiningLightFree.ID) > 0 then
            return A.WordofGlory
        end

        if A.ArdentDefender:IsReady(player) and Unit(player):HealthPercent() <= 30 then
            return A.ArdentDefender
        end

        if A.GuardianofAncientKings:IsReady(player) and Unit(player):HealthPercent() <= 30 and Unit(player):HasBuffs(A.ArdentDefender.ID) == 0 then
            return A.GuardianofAncientKings
        end
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, countInterruptGCD(unitID))
	
	if castRemainsTime >= A.GetLatency() then
        -- CounterShot
        if useKick and not notInterruptable and A.Rebuke:IsReady(unitID) then 
            return A.Rebuke
        end
        if useCC and A.HammerofJustice:IsReady(unitID) then 
            return A.HammerofJustice
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

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unitID)
	
        local mightOrSentinel = not A.AvengingWrath:IsTalentLearned() and (not A.AvengingWrathMight:IsTalentLearned() or A.Sentinel:IsTalentLearned())
        
        if A.BurstIsON(unitID) and A.HammerofWrath:IsInRange(unitID) then
            --actions.cooldowns=seraphim
            if A.Seraphim:IsReady(player) then
                return A.Seraphim:Show(icon)
            end
            --actions.cooldowns+=/avenging_wrath,if=(buff.seraphim.up|!talent.seraphim.enabled)
            if A.AvengingWrath:IsReady(player) and (Unit(player):HasBuffs(A.Seraphim.ID) > 0 or not A.Seraphim:IsTalentLearned()) then
                return A.AvengingWrath:Show(icon)
            end
            --actions.cooldowns+=/sentinel,if=(buff.seraphim.up|!talent.seraphim.enabled)
            if A.Sentinel:IsReady(player) and (Unit(player):HasBuffs(A.Seraphim.ID) > 0 or not A.Seraphim:IsTalentLearned()) then
                return A.Sentinel:Show(icon)
            end
            --actions.cooldowns+=/bastion_of_light,if=buff.avenging_wrath.up|buff.sentinel.up
            if A.BastionofLight:IsReady(player) and (Unit(player):HasBuffs(A.AvengingWrath.ID) > 0 or unit(player):HasBuffs(A.Sentinel.ID) > 0) then
                return A.BastionofLight:Show(icon)
            end
            
        end

        --actions.standard=shield_of_the_righteous,if=(cooldown.seraphim.remains>=5|!talent.seraphim.enabled)&(((holy_power=3&!buff.blessing_of_dusk.up&!buff.holy_avenger.up)|(holy_power=5)|buff.bastion_of_light.up|buff.divine_purpose.up))
        if A.ShieldoftheRighteous:IsReady(player) and A.HammerofJustice:IsInRange(unitID) and ((A.Seraphim:GetCooldown() >= 5 or not A.Seraphim:IsTalentLearned()) and (((Player:HolyPower() == 3 and Unit(player):HasBuffs(A.BlessingofDusk.ID) == 0) or (Player:HolyPower() == 5) or Unit(player):HasBuffs(A.BastionofLight.ID) > 0 or Unit(player):HasBuffs(A.DivinePurposeBuff.ID) > 0))) then
            return A.ShieldoftheRighteous:Show(icon)
        end
        --actions.standard+=/avengers_shield,if=buff.moment_of_glory.up|!talent.moment_of_glory.enabled
        if A.AvengersShield:IsReady(unitID) and (Unit(player):HasBuffs(A.MomentofGlory.ID) > 0 or not A.MomentofGlory:IsTalentLearned()) then
            return A.AvengersShield:Show(icon)
        end
        --actions.standard+=/hammer_of_wrath,if=buff.avenging_wrath.up|buff.sentinel.up|(!talent.avenging_wrath.enabled&(!talent.avenging_wrath_might.enabled|talent.sentinel.enabled))
        if A.HammerofWrath:IsReady(unitID) then
            return A.HammerofWrath:Show(icon)
        end
        --actions.standard+=/judgment,target_if=min:debuff.judgment.remains,if=charges=2|!talent.crusaders_judgment.enabled
        if A.Judgment:IsReady(unitID) and (A.Judgment:GetSpellCharges() == 2 or not A.CrusadersJudgment:IsTalentLearned()) then
            return A.Judgment:Show(icon)
        end
        --actions.standard+=/divine_toll,if=time>20|((!talent.seraphim.enabled|buff.seraphim.up)&(buff.avenging_wrath.up|buff.sentinel.up|(!talent.avenging_wrath.enabled&(!talent.avenging_wrath_might.enabled|talent.sentinel.enabled)))&(buff.moment_of_glory.up|!talent.moment_of_glory.enabled))
        if A.DivineToll:IsReady(unitID) then
            return A.DivineToll:Show(icon)
        end
        --actions.standard+=/avengers_shield
        if A.AvengersShield:IsReady(unitID) then
            return A.AvengersShield:Show(icon)
        end
        --actions.standard+=/judgment,target_if=min:debuff.judgment.remains
        if A.Judgment:IsReady(unitID) then
            return A.Judgment:Show(icon)
        end
        --actions.standard+=/consecration,if=!consecration.up
        if A.Consecration:IsReady(player) and A.HammerofJustice:IsInRange(unitID) and Unit(player):HasBuffs(A.ConsecrationBuff.ID, true) == 0 then
            return A.Consecration:Show(icon)
        end
        --actions.standard+=/eye_of_tyr
        if A.EyeofTyr:IsReady(player) and A.HammerofJustice:IsInRange(unitID) then
            return A.EyeofTyr:Show(icon)
        end
        --actions.standard+=/blessed_hammer
        if A.BlessedHammer:IsReady(player) and A.HammerofJustice:IsInRange(unitID) then
            return A.BlessedHammer:Show(icon)
        end
        --actions.standard+=/hammer_of_the_righteous
        if A.HammeroftheRighteous:IsReady(player) then
            return A.HammeroftheRighteous:Show(icon)
        end
        --actions.standard+=/word_of_glory,if=buff.shining_light_free.up
        if A.WordofGlory:IsReady(player) and Unit(player):HasBuffs(A.ShiningLightFree.ID) > 0 then
            return A.WordofGlory:Show(icon)
        end
        
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