--##################################
--##### TRIP'S SURVIVAL HUNTER #####
--##################################

--[[
Borrowed icons:
SurvivaloftheFittest -> EveryManforHimself
Coordinated Assault -> Stoneform


]]

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

Action[ACTION_CONST_HUNTER_SURVIVAL] = {
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
    ArcaneShot				= Action.Create({ Type = "Spell", ID = 185358   }), 
    AspectoftheChameleon				= Action.Create({ Type = "Spell", ID = 61648   }), 
    AspectoftheCheetah				= Action.Create({ Type = "Spell", ID = 186257   }), 
    AspectoftheTurtle				= Action.Create({ Type = "Spell", ID = 186265   }), 
    BeastLore   				= Action.Create({ Type = "Spell", ID = 1462   }), 
    BestialWrath				= Action.Create({ Type = "Spell", ID = 344572   }), 
    CallPet				= Action.Create({ Type = "Spell", ID = 883, Texture = 136   }), 
    Disengage				= Action.Create({ Type = "Spell", ID = 781   }), 
    DismissPet				= Action.Create({ Type = "Spell", ID = 2641   }), 
    EagleEye				= Action.Create({ Type = "Spell", ID = 6197   }), 
    Exhilaration				= Action.Create({ Type = "Spell", ID = 109304   }), 
    EyesoftheBeast				= Action.Create({ Type = "Spell", ID = 321297   }), 
    FeedPet				= Action.Create({ Type = "Spell", ID = 6991   }), 
    FeignDeath				= Action.Create({ Type = "Spell", ID = 5384   }), 
    Flare				= Action.Create({ Type = "Spell", ID = 1543   }), 
    FreezingTrap				= Action.Create({ Type = "Spell", ID = 187650   }),  
    HuntersMark				= Action.Create({ Type = "Spell", ID = 257284   }),
    MendPet				= Action.Create({ Type = "Spell", ID = 136   }),  
    RevivePet				= Action.Create({ Type = "Spell", ID = 982   }),
    SteadyShot				= Action.Create({ Type = "Spell", ID = 56641   }), 
    TameBeast				= Action.Create({ Type = "Spell", ID = 1515   }),
    TrackBeasts				= Action.Create({ Type = "Spell", ID = 1494   }),
    TrackDemons				= Action.Create({ Type = "Spell", ID = 19878   }),
    TrackDragonkin				= Action.Create({ Type = "Spell", ID = 19879   }),     
    TrackElementals				= Action.Create({ Type = "Spell", ID = 19880   }), 
    TrackGiants				= Action.Create({ Type = "Spell", ID = 19882   }), 
    TrackHidden				= Action.Create({ Type = "Spell", ID = 19885   }), 
    TrackHumanoids				= Action.Create({ Type = "Spell", ID = 19883   }),
    TrackMechanicals				= Action.Create({ Type = "Spell", ID = 229533   }), 
    TrackUndead				= Action.Create({ Type = "Spell", ID = 19884   }),  
    KillCommand				= Action.Create({ Type = "Spell", ID = 259489   }), 
    ConcussiveShot				= Action.Create({ Type = "Spell", ID = 5116   }), 
    KillShot				= Action.Create({ Type = "Spell", ID = 320976   }),
    Muzzle				= Action.Create({ Type = "Spell", ID = 187707   }),  
    TarTrap				= Action.Create({ Type = "Spell", ID = 187698   }), 
    Misdirection				= Action.Create({ Type = "Spell", ID = 34477   }), 
    SurvivaloftheFittest				= Action.Create({ Type = "Spell", ID = 264735   }), 
    TranquilizingShot				= Action.Create({ Type = "Spell", ID = 19801   }), 
    ScareBeast				= Action.Create({ Type = "Spell", ID = 1513   }), 
    Intimidation				= Action.Create({ Type = "Spell", ID = 19577   }), 
    HighExplosiveTrap				= Action.Create({ Type = "Spell", ID = 236776   }), 
    ScatterShot				= Action.Create({ Type = "Spell", ID = 213691   }), 
    BindingShot				= Action.Create({ Type = "Spell", ID = 109248   }), 
    Camouflage				= Action.Create({ Type = "Spell", ID = 199483   }), 
    SentinelOwl				= Action.Create({ Type = "Spell", ID = 388045   }), 
    SerpentSting				= Action.Create({ Type = "Spell", ID = 271788   }), 
    SteelTrap				= Action.Create({ Type = "Spell", ID = 162488   }), 
    Stampede				= Action.Create({ Type = "Spell", ID = 201430   }), 
    DeathChakram				= Action.Create({ Type = "Spell", ID = 375891   }),
    ExplosiveShot				= Action.Create({ Type = "Spell", ID = 212431   }),
    Barrage				= Action.Create({ Type = "Spell", ID = 120360   }),
    HydrasBite    			= Action.Create({ Type = "Spell", ID = 260241, Hidden = true	}), 
    
    --Survival
    RaptorStrike				= Action.Create({ Type = "Spell", ID = 186270   }), 
    WildfireBomb				= Action.Create({ Type = "Spell", ID = 259495   }), 
    WildfireBombDebuff	    	= Action.Create({ Type = "Spell", ID = 269747, Hidden = true	}),
    Harpoon				= Action.Create({ Type = "Spell", ID = 190925   }),
    AspectoftheEagle				= Action.Create({ Type = "Spell", ID = 186289   }), 
    Carve				= Action.Create({ Type = "Spell", ID = 187708   }), 
    Butchery				= Action.Create({ Type = "Spell", ID = 212436   }), 
    MongooseBite				= Action.Create({ Type = "Spell", ID = 259387   }), 
    FlankingStrike				= Action.Create({ Type = "Spell", ID = 269751   }), 
    CoordinatedAssault				= Action.Create({ Type = "Spell", ID = 360952   }),
    WildfireInfusion				= Action.Create({ Type = "Spell", ID = 271014   }), 
    FuryoftheEagle				= Action.Create({ Type = "Spell", ID = 203415   }),   
    Spearhead				= Action.Create({ Type = "Spell", ID = 360966   }),  
    TermsofEngagement				= Action.Create({ Type = "Spell", ID = 265895, Hidden = true   }),
    ShrapnelBomb				= Action.Create({ Type = "Spell", ID = 270335, Texture = 269747     }),
    ShrapnelBombDebuff			= Action.Create({ Type = "Spell", ID = 270339, Hidden = true 	}),
    InternalBleeding			= Action.Create({ Type = "Spell", ID = 270343, Hidden = true 	}),	
    PheromoneBomb				= Action.Create({ Type = "Spell", ID = 270323, Texture = 269747     }),
    PheromoneBombDebuff			= Action.Create({ Type = "Spell", ID = 270332, Hidden = true	}),	
    VolatileBomb				= Action.Create({ Type = "Spell", ID = 271045, Texture = 269747     }),	
    VolatileBombDebuff			= Action.Create({ Type = "Spell", ID = 271049, Hidden = true    }),   
    InternalBleeding			= Action.Create({ Type = "Spell", ID = 270343, Hidden = true    }), 
    LatentPoison    			= Action.Create({ Type = "Spell", ID = 273289, Hidden = true	}),	  
    VipersVenom    			= Action.Create({ Type = "Spell", ID = 268501, Hidden = true	}),   
    DeadlyDuoBuff    			= Action.Create({ Type = "Spell", ID = 397568, Hidden = true	}), 
    MongooseFury    			= Action.Create({ Type = "Spell", ID = 259388, Hidden = true	}), 
    CoordinatedKill    			= Action.Create({ Type = "Spell", ID = 385739, Hidden = true	}),
    Ranger    			= Action.Create({ Type = "Spell", ID = 385695, Hidden = true	}),
    BirdsofPrey    			= Action.Create({ Type = "Spell", ID = 260331, Hidden = true	}),
    ShreddedArmor    			= Action.Create({ Type = "Spell", ID = 410167, Hidden = true	}),
    Bombardier    			= Action.Create({ Type = "Spell", ID = 389880, Hidden = true	}),
    SeethingRage    			= Action.Create({ Type = "Spell", ID = 408835, Hidden = true	}),
    RuthlessMarauder    			= Action.Create({ Type = "Spell", ID = 385718, Hidden = true	}),
    AlphaPredator    			= Action.Create({ Type = "Spell", ID = 269737, Hidden = true	}),
}

local A = setmetatable(Action[ACTION_CONST_HUNTER_SURVIVAL], { __index = Action })

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

local function InMelee(unitID)
    return A.Muzzle:IsInRange(unitID)
end 
InMelee = A.MakeFunctionCachedDynamic(InMelee)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
	
    -- Exhilaration
    local Exhilaration = GetToggle(2, "ExhilarationHP")
    if     Exhilaration >= 0 and A.Exhilaration:IsReady(player) and 
    (
        (     -- Auto 
            Exhilaration >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Exhilaration < 100 and 
            Unit(player):HealthPercent() <= Exhilaration
        )
    ) 
    then 
        return A.Exhilaration
    end

	
    -- AspectoftheTurtle
    local AspectoftheTurtle = GetToggle(2, "Turtle")
    if     AspectoftheTurtle >= 0 and A.AspectoftheTurtle:IsReady(player) and 
    (
        (     -- Auto 
            AspectoftheTurtle >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AspectoftheTurtle < 100 and 
            Unit(player):HealthPercent() <= AspectoftheTurtle
        )
    ) 
    then
        return A.AspectoftheTurtle
    end   
    
    -- AspectoftheTurtle
    local SurvivaloftheFittest = GetToggle(2, "SurvivaloftheFittest")
    if     SurvivaloftheFittest >= 0 and A.SurvivaloftheFittest:IsReady(player) and 
    (
        (     -- Auto 
        SurvivaloftheFittest >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
        SurvivaloftheFittest < 100 and 
            Unit(player):HealthPercent() <= SurvivaloftheFittest
        )
    ) 
    then
        return A.EveryManforHimself
    end         
	
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        -- CounterShot
        if useKick and not notInterruptable and A.Muzzle:IsReady(unitID) then 
            return A.Muzzle
        end

        if useCC and not notInterruptable and A.Intimidation:IsReady(unitID) then 
            return A.Intimidation
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

local function CanPurge(unitID)
    if A.TranquilizingShot:IsReady(unitID, true) then 
        if (AuraIsValid(unitID, "UseDispel", "PurgeHigh") or AuraIsValid(unitID, "nil", "Enrage")) then 
            return A.TranquilizingShot
        end 
    end 
end 

local function UseTrinkets(unitID)
	local TrinketType1 = A.GetToggle(2, "TrinketType1")
	local TrinketType2 = A.GetToggle(2, "TrinketType2")
	local TrinketValue1 = A.GetToggle(2, "TrinketValue1")
	local TrinketValue2 = A.GetToggle(2, "TrinketValue2")	

	if A.Trinket1:IsReady(unitID) then
		if TrinketType1 == "Damage" and Player:ManaPercentage() >= 20 then
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
		if TrinketType2 == "Damage" and Player:ManaPercentage() >= 20 then
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

local WildfireInfusions = {
    A.ShrapnelBomb,
    A.PheromoneBomb,
    A.VolatileBomb,
  }

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)

    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()

    Player:AddTier("Tier30", { 202479, 202477, 202480, 202478, 202482, })
    local T30has2P = Player:HasTier("Tier30", 2)
    local T30has4P = Player:HasTier("Tier30", 4)


    local function EnemyRotation(unitID)
        local useRacial = A.GetToggle(1, "Racial")
        local CoordinatedAssaultUp = Unit(player):HasBuffs(A.CoordinatedAssault.ID) > 0
        local SpearheadUp = Unit(player):HasBuffs(A.Spearhead.ID) > 0
        
        local mb_rs_cost

        if A.MongooseBite:IsTalentLearned() then
            mb_rs_cost = A.MongooseBite:GetSpellPowerCost()
        else
            mb_rs_cost = A.RaptorStrike:GetSpellPowerCost()
        end

        local MendPetHP = A.GetToggle(2, "MendPetHP")
        if A.MendPet:IsReady(player) and Unit(pet):IsExists() and Unit(pet):HealthPercent() <= MendPetHP and Unit(pet):HealthPercent() > 0 and Unit(pet):HasBuffs(A.MendPet.ID, true) == 0 and Unit(pet):GetRange() < 40 then
            return A.MendPet:Show(icon)
        end 

        --actions.precombat+=/summon_pet
        if A.CallPet:IsReady(player) and not Unit(pet):IsExists() and not isMoving then
            return A.CallPet:Show(icon)
        end
        
        if A.RevivePet:IsReady(player) and Unit(pet):IsDead() and not isMoving then
            return A.RevivePet:Show(icon)
        end

        --actions+=/muzzle
        -- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end 

        --actions+=/tranquilizing_shot
        local DoPurge = CanPurge(unitID)
        if DoPurge then
            return DoPurge:Show(icon)
        end    

        --[[actions+=/call_action_list,name=cds
        actions+=/variable,name=mb_rs_cost,op=setif,value=action.mongoose_bite.cost,value_else=action.raptor_strike.cost,condition=talent.mongoose_bite
        actions+=/call_action_list,name=st,if=active_enemies<3
        actions+=/call_action_list,name=cleave,if=active_enemies>2
        actions+=/arcane_torrent]]

        if A.BurstIsON(unitID) and InMelee(unitID) then
            --actions.cds+=/harpoon,if=talent.terms_of_engagement.enabled&focus<focus.max
            if A.Harpoon:IsReady(unitID) and A.TermsofEngagement:IsTalentLearned() and Player:Focus() < Player:FocusMax() then
                return A.Harpoon:Show(icon)
            end

            --actions.cds+=/blood_fury,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
            if A.BloodFury:IsReady(player) and useRacial and (CoordinatedAssaultUp or SpearheadUp or (not A.Spearhead:IsTalentLearned() and not A.CoordinatedAssault:IsTalentLearned())) then
                return A.BloodFury:Show(icon)
            end

            --actions.cds+=/ancestral_call,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
            if A.AncestralCall:IsReady(player) and useRacial and (CoordinatedAssaultUp or SpearheadUp or (not A.Spearhead:IsTalentLearned() and not A.CoordinatedAssault:IsTalentLearned())) then
                return A.AncestralCall:Show(icon)
            end
            
            --actions.cds+=/fireblood,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
            if A.Fireblood:IsReady(player) and useRacial and (CoordinatedAssaultUp or SpearheadUp or (not A.Spearhead:IsTalentLearned() and not A.CoordinatedAssault:IsTalentLearned())) then
                return A.Fireblood:Show(icon)
            end

            --actions.cds+=/lights_judgment
            if A.LightsJudgment:IsReady(unitID) and useRacial then
                return A.LightsJudgment:Show(icon)
            end

            --actions.cds+=/bag_of_tricks,if=cooldown.kill_command.full_recharge_time>gcd
            if A.BagofTricks:IsReady(unitID) and useRacial and A.KillCommand:GetSpellChargesFullRechargeTime() > A.GetGCD() then
                return A.BagofTricks:Show(icon)
            end

            --actions.cds+=/berserking,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault|time_to_die<13
            if A.Berserking:IsReady(player) and useRacial and (CoordinatedAssaultUp or SpearheadUp or (not A.Spearhead:IsTalentLearned() and not A.CoordinatedAssault:IsTalentLearned()) or (Unit(unitID):TimeToDie() < 13 and Unit(unitID):IsBoss())) then
                return A.Berserking:Show(icon)
            end

            --actions.cds+=/muzzle
            --actions.cds+=/potion,if=target.time_to_die<30|buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
            --actions.cds+=/use_items
            local UseTrinket = UseTrinkets(unitID)
            if UseTrinket then
                return UseTrinket:Show(icon)
            end 
        end

        --actions.cds+=/aspect_of_the_eagle,if=target.distance>=6
        if A.AspectoftheEagle:IsReady(player) and A.BurstIsON(unitID) and Unit(unitID):GetRange() >= 15 then
            return A.AspectoftheEagle:Show(icon)
        end

        if A.MultiUnits:GetByRangeInCombat(10, 5) > 2 then
            --actions.cleave=kill_shot,if=buff.coordinated_assault_empower.up&talent.birds_of_prey
            if A.KillShot:IsReady(unitID) and CoordinatedAssaultUp and A.BirdsofPrey:IsTalentLearned() then
                return A.KillShot:Show(icon)
            end

            --actions.cleave+=/death_chakram
            if A.DeathChakram:IsReady(unitID) then
                return A.DeathChakram:Show(icon)
            end

            --actions.cleave+=/wildfire_bomb
            if A.WildfireBomb:IsReady(unitID) then
                return A.WildfireBombDebuff:Show(icon)
            end

            --actions.cleave+=/stampede
            if A.Stampede:IsReady(player) and InMelee(unitID) then
                return A.Stampede:Show(icon)
            end

            --actions.cleave+=/coordinated_assault,if=cooldown.fury_of_the_eagle.remains|!talent.fury_of_the_eagle
            if A.CoordinatedAssault:IsReady(unitID) and BurstIsON(unitID) and (A.FuryoftheEagle:GetCooldown() > 0 or not A.FuryoftheEagle:IsTalentLearned()) then
                return A.Stoneform:Show(icon)
            end

            --actions.cleave+=/explosive_shot
            if A.ExplosiveShot:IsReady(unitID) then
                return A.ExplosiveShot:Show(icon)
            end
            
            --actions.cleave+=/carve,if=cooldown.wildfire_bomb.full_recharge_time>spell_targets%2
            if A.Carve:IsReady(player) and InMelee(unitID) and A.WildfireBomb:GetSpellChargesFullRechargeTime() > (A.MultiUnits:GetByRangeInCombat(10, 5) % 2) then
                return A.Carve:Show(icon)
            end

            --actions.cleave+=/butchery,if=full_recharge_time<gcd
            if A.Butchery:IsReady(player) and A.Butchery:GetSpellChargesFullRechargeTime() < A.GetGCD() then
                return A.Butchery:Show(icon)
            end

            --actions.cleave+=/wildfire_bomb,if=!dot.wildfire_bomb.ticking
            if A.WildfireBomb:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.WildfireBomb.ID, true) == 0 then
                return A.WildfireBombDebuff:Show(icon)
            end

            --actions.cleave+=/butchery,if=dot.shrapnel_bomb.ticking&(dot.internal_bleeding.stack<2|dot.shrapnel_bomb.remains<gcd)
            if A.Butchery:IsReady(player) and Unit(unitID):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0 and (Unit(unitID):HasDeBuffsStacks(A.InternalBleeding.ID, true) < 2 or Unit(unitID):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) < A.GetGCD()) then
                return A.Butchery:Show(icon)
            end

            --actions.cleave+=/fury_of_the_eagle
            if A.FuryoftheEagle:IsReady(player) then
                return A.FuryoftheEagle:Show(icon)
            end

            --actions.cleave+=/carve,if=dot.shrapnel_bomb.ticking
            if A.Carve:IsReady(player) and Unit(unitID):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0 then
                return A.Carve:Show(icon)
            end

            --actions.cleave+=/flanking_strike
            if A.FlankingStrike:IsReady(unitID) then
                return A.FlankingStrike:Show(icon)
            end

            --actions.cleave+=/butchery,if=(!next_wi_bomb.shrapnel|!talent.wildfire_infusion)
            if A.Butchery:IsReady(player) and (not A.ShrapnelBomb:IsTalentLearned() or not A.WildfireInfusion:IsTalentLearned()) then
                return A.Butchery:Show(icon)
            end

            --actions.cleave+=/mongoose_bite,cycle_targets=1,if=debuff.latent_poison.stack>8
            if A.MongooseBite:IsReady(unitID) and Unit(unitID):HasDeBuffsStacks(A.LatentPoison.ID, true) > 8 then
                return A.MongooseBite:Show(icon)
            end

            --actions.cleave+=/raptor_strike,cycle_targets=1,if=debuff.latent_poison.stack>8
            if A.RaptorStrike:IsReady(unitID) and Unit(unitID):HasDeBuffsStacks(A.LatentPoison.ID, true) > 8 then
                return A.RaptorStrike:Show(icon)
            end

            --actions.cleave+=/kill_command,cycle_targets=1,if=full_recharge_time<gcd
            if A.KillCommand:IsReady(unitID) and Unit(pet):IsExists() and Unit(pet):InCC() == 0 and A.KillCommand:GetSpellChargesFullRechargeTime() < A.GetGCD() and Unit(pet):IsExists() and Unit(pet):InCC() == 0 then
                return A.KillCommand:Show(icon)
            end

            --actions.cleave+=/carve
            if A.Carve:IsReady(player) then
                return A.Carve:Show(icon)
            end

            --actions.cleave+=/kill_shot,if=!buff.coordinated_assault.up
            if A.KillShot:IsReady(unitID) and not CoordinatedAssaultUp then
                return A.KillShot:Show(icon)
            end

            --actions.cleave+=/steel_trap
            if A.SteelTrap:IsReady(player) and A.ArcaneShot:IsInRange(unitID) then
                return A.SteelTrap:Show(icon)
            end

            --actions.cleave+=/spearhead
            if A.Spearhead:IsReady(unitID) then
                return A.Spearhead:Show(icon)
            end

            --actions.cleave+=/mongoose_bite,target_if=min:dot.serpent_sting.remains,if=buff.spearhead.remains
            if A.MongooseBite:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) > 0 and SpearheadUp then
                return A.MongooseBite:Show(icon)
            end

            --actions.cleave+=/serpent_sting,cycle_targets=1,if=refreshable&target.time_to_die>12&(!talent.vipers_venom|talent.hydras_bite)
            if A.SerpentSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) <= 3 and Unit(unitID):TimeToDie() > 12 and (not A.VipersVenom:IsTalentLearned() or A.HydrasBite:IsTalentLearned()) then
                return A.SerpentSting:Show(icon)
            end

            --actions.cleave+=/mongoose_bite,cycle_targets=1
            if A.MongooseBite:IsReady(unitID) then
                return A.MongooseBite:Show(icon)
            end
            --actions.cleave+=/raptor_strike,cycle_targets=1
            if A.RaptorStrike:IsReady(unitID) then
                return A.RaptorStrike:Show(icon)
            end
        end

        --actions.st=kill_command,target_if=min:bloodseeker.remains,if=talent.spearhead&debuff.shredded_armor.stack<1&cooldown.spearhead.remains<2*gcd
        if A.KillCommand:IsReady(unitID) and Unit(pet):IsExists() and Unit(pet):InCC() == 0 and A.Spearhead:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ShreddedArmor.ID, true) == 0 and A.Spearhead:GetCooldown() < A.GetGCD() * 2 then
            return A.KillCommand:Show(icon)
        end

        --actions.st+=/wildfire_bomb,if=talent.spearhead&cooldown.spearhead.remains<2*gcd&debuff.shredded_armor.stack>0        
        if A.WildfireBomb:IsReady(unitID) and A.Spearhead:IsTalentLearned() and A.Spearhead:GetCooldown() < A.GetGCD() * 2 and Unit(unitID):HasDeBuffsStacks(A.ShreddedArmor.ID, true) > 0 then
            return A.WildfireBomb:Show(icon)
        end

        --actions.st+=/death_chakram,if=focus+cast_regen<focus.max|talent.spearhead&!cooldown.spearhead.remains
        if A.DeathChakram:IsReady(unitID) and ((Player:Focus() + 21) < Player:FocusMax() or (A.Spearhead:IsTalentLearned() and A.Spearhead:GetCooldown() == 0)) then
            return A.DeathChakram:Show(icon)
        end

        --actions.st+=/spearhead,if=focus+action.kill_command.cast_regen>focus.max-10&(cooldown.death_chakram.remains|!talent.death_chakram)
        if A.Spearhead:IsReady(unitID) and (Player:Focus() + 21) > Player:FocusMax() - 10 and (A.DeathChakram:GetCooldown() > 0 or not A.DeathChakram:IsTalentLearned()) then
            return A.Spearhead:Show(icon)
        end

        --actions.st+=/kill_shot,if=buff.coordinated_assault_empower.up
        if A.KillShot:IsReady(unitID) and CoordinatedAssaultUp then
            return A.KillShot:Show(icon)
        end

        --actions.st+=/wildfire_bomb,if=debuff.shredded_armor.stack>0&(full_recharge_time<2*gcd|talent.bombardier&!cooldown.coordinated_assault.remains|talent.bombardier&buff.coordinated_assault.up&buff.coordinated_assault.remains<2*gcd)&set_bonus.tier30_4pc
        if A.WildfireBomb:IsReady(unitID) and Unit(unitID):HasDeBuffsStacks(A.ShreddedArmor.ID, true) > 0 and (A.WildfireBomb:GetSpellChargesFullRechargeTime() < A.GetGCD() * 2 or A.Bombardier:IsTalentLearned() and A.CoordinatedAssault:GetCooldown() == 0 or A.Bombardier:IsTalentLearned() and CoordinatedAssaultUp and Unit(player):HasBuffs(A.CoordinatedAssault.ID) < A.GetGCD() * 2) and T30has4P then
            return A.WildfireBomb:Show(icon)
        end

        --actions.st+=/kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<gcd&focus+cast_regen<focus.max&(buff.deadly_duo.stack>2|buff.spearhead.remains&dot.pheromone_bomb.remains)
        if A.KillCommand:IsReady(unitID) and Unit(pet):IsExists() and Unit(pet):InCC() == 0 and A.KillCommand:GetSpellChargesFullRechargeTime() < A.GetGCD() and Player:Focus() + 21 < Player:FocusMax() and (Unit(player):HasBuffsStacks(A.DeadlyDuoBuff.ID) > 2 or SpearheadUp and Unit(unitID):HasDeBuffs(A.PheromoneBombDebuff.ID) > 0) then
            return A.KillCommand:Show(icon)
        end
        
        --actions.st+=/kill_command,target_if=min:bloodseeker.remains,if=cooldown.wildfire_bomb.full_recharge_time<3*gcd&debuff.shredded_armor.stack<1&set_bonus.tier30_4pc&!buff.spearhead.remains
        if A.KillCommand:IsReady(unitID) and Unit(pet):IsExists() and Unit(pet):InCC() == 0 and A.WildfireBomb:GetSpellChargesFullRechargeTime() < 3 * A.GetGCD() and Unit(unitID):HasDeBuffs(A.ShreddedArmor.ID, true) == 0 and T30has4P and not SpearheadUp then
            return A.KillCommand:Show(icon)
        end

        --actions.st+=/mongoose_bite,if=buff.spearhead.remains
        if A.MongooseBite:IsReady(unitID) and SpearheadUp then
            return A.MongooseBite:Show(icon)
        end

        --actions.st+=/mongoose_bite,if=active_enemies=1&target.time_to_die<focus%(variable.mb_rs_cost-cast_regen)*gcd|buff.mongoose_fury.up&buff.mongoose_fury.remains<gcd
        if A.MongooseBite:IsReady(unitID) and (A.MultiUnits:GetByRangeInCombat(10, 5) == 1 and Unit(unitID):TimeToDie() < Player:Focus() % (mb_rs_cost) * A.GetGCD() or Unit(player):HasBuffs(A.MongooseFury.ID) > 0 and Unit(player):HasBuffs(A.MongooseFury.ID) < A.GetGCD()) then
            return A.MongooseBite:Show(icon)
        end

        --actions.st+=/kill_shot,if=!buff.coordinated_assault.up
        if A.KillShot:IsReady(unitID) and not CoordinatedAssaultUp then
            return A.KillShot:Show(icon)
        end

        --actions.st+=/raptor_strike,if=active_enemies=1&target.time_to_die<focus%(variable.mb_rs_cost-cast_regen)*gcd
        if A.RaptorStrike:IsReady(unitID) and A.MultiUnits:GetByRangeInCombat(10, 5) == 1 and Unit(unitID):TimeToDie() < Player:Focus() % (mb_rs_cost) * A.GetGCD() then
            return A.RaptorStrike:Show(icon)
        end

        --actions.st+=/serpent_sting,cycle_targets=1,if=!dot.serpent_sting.ticking&target.time_to_die>7&!talent.vipers_venom
        if A.SerpentSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) == 0 and Unit(unitID):TimeToDie() > 7 and not A.VipersVenom:IsTalentLearned() then
            return A.SerpentSting:Show(icon)
        end

        --actions.st+=/fury_of_the_eagle,if=buff.seething_rage.up&buff.seething_rage.remains<3*gcd&(!raid_event.adds.exists|active_enemies>1|raid_event.adds.exists&raid_event.adds.in>40)
        if A.FuryoftheEagle:IsReady(player) and InMelee(unitID) and Unit(player):HasBuffs(A.SeethingRage.ID) > 0 and Unit(player):HasBuffs(A.SeethingRage.ID) < 3 * A.GetGCD() then
            return A.FuryoftheEagle:Show(icon)
        end

        --actions.st+=/mongoose_bite,if=talent.alpha_predator&buff.mongoose_fury.up&buff.mongoose_fury.remains<focus%(variable.mb_rs_cost-cast_regen)*gcd|buff.seething_rage.remains&active_enemies=1
        if A.MongooseBite:IsReady(unitID) and (A.AlphaPredator:IsTalentLearned() and Unit(player):HasBuffs(A.MongooseFury.ID) > 0 and Unit(player):HasBuffs(A.MongooseFury.ID) < Player:Focus() % mb_rs_cost * A.GetGCD() or Unit(player):HasBuffs(A.SeethingRage.ID) > 0 and A.MultiUnits:GetByRangeInCombat(10, 5) == 1) then
            return A.MongooseBite:Show(icon)
        end

        --actions.st+=/flanking_strike,if=focus+cast_regen<focus.max
        if A.FlankingStrike:IsReady(unitID) and Player:Focus() + 30 < Player:FocusMax() then
            return A.FlankingStrike:Show(icon)
        end

        --actions.st+=/stampede
        if A.Stampede:IsReady(player) and InMelee(unitID) then
            return A.Stampede:Show(icon)
        end

        --actions.st+=/coordinated_assault,if=!talent.coordinated_kill&target.health.pct<20&(!buff.spearhead.remains&cooldown.spearhead.remains|!talent.spearhead)|talent.coordinated_kill&(!buff.spearhead.remains&cooldown.spearhead.remains|!talent.spearhead)
        if A.CoordinatedAssault:IsReady(unitID) and A.BurstIsON(unitID) and (not A.CoordinatedKill:IsTalentLearned() and Unit(unitID):HealthPercent() < 20 and (not SpearheadUp or not A.Spearhead:IsTalentLearned()) or A.CoordinatedKill:IsTalentLearned() and ((not SpearheadUp and A.Spearhead:GetCooldown() > 0) or not A.Spearhead:IsTalentLearned())) then
            return A.Stoneform:Show(icon)
        end

        --actions.st+=/kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<gcd&focus+cast_regen<focus.max&(cooldown.flanking_strike.remains|!talent.flanking_strike)
        if A.KillCommand:IsReady(unitID) and Unit(pet):IsExists() and Unit(pet):InCC() == 0 and A.KillCommand:GetSpellChargesFullRechargeTime() <  A.GetGCD() and Player:Focus() + 21 < Player:FocusMax() and (A.FlankingStrike:GetCooldown() > 0 or not A.FlankingStrike:IsTalentLearned()) then
            return A.KillCommand:Show(icon)
        end

        --actions.st+=/serpent_sting,cycle_targets=1,if=refreshable&!talent.vipers_venom
        if A.SerpentSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) <= 3 and not A.VipersVenom:IsTalentLearned() then
            return A.SerpentSting:Show(icon)
        end

        --actions.st+=/wildfire_bomb,if=raid_event.adds.in>cooldown.wildfire_bomb.full_recharge_time-(cooldown.wildfire_bomb.full_recharge_time%3.5)&full_recharge_time<2*gcd
        if A.WildfireBomb:IsReady(unitID) and A.WildfireBomb:GetSpellChargesFullRechargeTime() < A.GetGCD() * 2 then
            return A.WildfireBomb:Show(icon)
        end

        --actions.st+=/mongoose_bite,if=dot.shrapnel_bomb.ticking
        if A.MongooseBite:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0 then
            return A.MongooseBite:Show(icon)
        end

        --actions.st+=/wildfire_bomb,if=raid_event.adds.in>cooldown.wildfire_bomb.full_recharge_time-(cooldown.wildfire_bomb.full_recharge_time%3.5)&set_bonus.tier30_4pc&(!dot.wildfire_bomb.ticking&debuff.shredded_armor.stack>0&focus+cast_regen<focus.max|active_enemies>1)
        if A.WildfireBomb:IsReady(unitID) and T30has4P and (Unit(unitID):HasDeBuffs(A.WildfireBombDebuff.ID) == 0 and Unit(unitID):HasDeBuffsStacks(A.ShreddedArmor.ID, true) > 0 and Player:Focus() + (10*val(CoordinatedAssaultUp)) < Player:FocusMax() or A.MultiUnits:GetByRangeInCombat(10, 5) > 1) then
            return A.WildfireBomb:Show(icon)
        end

        --actions.st+=/mongoose_bite,cycle_targets=1,if=buff.mongoose_fury.up
        if A.MongooseBite:IsReady(unitID) and Unit(player):HasBuffs(A.MongooseFury.ID) > 0 then
            return A.MongooseBite:Show(icon)
        end

        --actions.st+=/explosive_shot,if=talent.ranger
        if A.ExplosiveShot:IsReady(unitID) and A.Ranger:IsTalentLearned() then
            return A.ExplosiveShot:Show(icon)
        end

        --actions.st+=/fury_of_the_eagle,if=(!equipped.djaruun_pillar_of_the_elder_flame|cooldown.elder_flame_408821.remains>40)&target.health.pct<65&talent.ruthless_marauder&(!raid_event.adds.exists|raid_event.adds.exists&raid_event.adds.in>40)
        if A.FuryoftheEagle:IsReady(unitID) and Unit(unitID):HealthPercent() < 65 and A.RuthlessMarauder:IsTalentLearned() then
            return A.FuryoftheEagle:Show(icon)
        end

        --actions.st+=/mongoose_bite,target_if=max:debuff.latent_poison.stack,if=focus+action.kill_command.cast_regen>focus.max-10|set_bonus.tier30_4pc
        if A.MongooseBite:IsReady(unitID) and (Player:Focus() + 21 > (Player:FocusMax() - 10) or T30has4P) then
            return A.MongooseBite:Show(icon)
        end

        --actions.st+=/raptor_strike,target_if=max:debuff.latent_poison.stack
        if A.RaptorStrike:IsReady(unitID) then
            return A.RaptorStrike:Show(icon)
        end

        --actions.st+=/steel_trap
        if A.SteelTrap:IsReady(player) and A.ArcaneShot:IsInRange(unitID) then
            return A.SteelTrap:Show(icon)
        end

        --actions.st+=/wildfire_bomb,if=!dot.wildfire_bomb.ticking
        if A.WildfireBomb:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.WildfireBombDebuff.ID, true) == 0 then
            return A.WildfireBombDebuff:Show(icon)
        end

        --actions.st+=/kill_command,cycle_targets=1
        if A.KillCommand:IsReady(unitID) and Unit(pet):IsExists() and Unit(pet):InCC() == 0 then
            return A.KillCommand:Show(icon)
        end

        --actions.st+=/coordinated_assault,if=!talent.coordinated_kill&time_to_die>140
        if A.CoordinatedAssault:IsReady(unitID) and BurstIsON(unitID) and not A.CoordinatedKill:IsTalentLearned() and Unit(unitID):TimeToDie() > 140 then
            return A.Stoneform:Show(icon)
        end
        --actions.st+=/fury_of_the_eagle,interrupt=1
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