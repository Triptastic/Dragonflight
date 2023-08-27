--######################################
--##### TRIP'S BEASTMASTERY HUNTER #####
--######################################

--[[
Borrowed icons:
SurvivaloftheFittest -> EveryManforHimself


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

Action[ACTION_CONST_HUNTER_BEASTMASTERY] = {
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
    CounterShot				= Action.Create({ Type = "Spell", ID = 147362   }), 
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
    PoisonInjection    			= Action.Create({ Type = "Spell", ID = 378014, Hidden = true	}), 
    
    --Beast Mastery
    CobraShot				= Action.Create({ Type = "Spell", ID = 193455   }),
    MultiShot				= Action.Create({ Type = "Spell", ID = 2643   }),
    BarbedShot				= Action.Create({ Type = "Spell", ID = 217200   }),
    BeastCleave 			= Action.Create({ Type = "Spell", ID = 115939, Hidden = true   }),
    BeastCleaveBuff			= Action.Create({ Type = "Spell", ID = 268877, Hidden = true   }),
    AMurderOfCrows			= Action.Create({ Type = "Spell", ID = 131894   }),
    Bloodshed				= Action.Create({ Type = "Spell", ID = 321530   }),
    DireBeast				= Action.Create({ Type = "Spell", ID = 120679   }),
    BestialWrath			= Action.Create({ Type = "Spell", ID = 19574   }),
    AspectoftheWild			= Action.Create({ Type = "Spell", ID = 193530   }),
    WailingArrow		    = Action.Create({ Type = "Spell", ID = 392060   }),
    CalloftheWild			= Action.Create({ Type = "Spell", ID = 359844   }),
    CobraShot				= Action.Create({ Type = "Spell", ID = 193455   }),
    FortitudeoftheBear		= Action.Create({ Type = "SpellSingleColor", ID = 272679, Color = "PINK"   }),
    Frenzy      			= Action.Create({ Type = "Spell", ID = 272790, Hidden = true   }),
    ScentofBlood     		= Action.Create({ Type = "Spell", ID = 193532, Hidden = true   }),
    AlphaPredator      		= Action.Create({ Type = "Spell", ID = 269737, Hidden = true   }),
    WildInstincts      		= Action.Create({ Type = "Spell", ID = 378442, Hidden = true   }),
    WildCall          		= Action.Create({ Type = "Spell", ID = 185789, Hidden = true   }),
    KillCleave         		= Action.Create({ Type = "Spell", ID = 378207, Hidden = true   }),  
}

local A = setmetatable(Action[ACTION_CONST_HUNTER_BEASTMASTERY], { __index = Action })

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

Pet:AddActionsSpells(253, {
	17253, -- Bite
	16827, -- Claw
	49966, -- Smack 
}, true)

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
    incomingAoEDamage                       = { 388537, --Arcane Fissue
                                                377004, --Deafening Screech
                                                388923, --Burst Forth
                                                212784, --Eye Storm
                                                192305, --Eye of the Storm (mini-boss)
                                                200901, --Eye of the Storm (boss)
                                                372863, --Ritual of Blazebinding
                                                153094, --Whispers of the Dark Star
                                                164974, --Dark Eclipse
                                                153804, --Inhale
                                                175988, --Omen of Death
                                                106228, --Nothingness
                                                374720, --Consuming Stomp
                                                384132, --Overwhelming Energy
                                                388008, --Absolute Zero
                                                385399, --Unleashed Destruction
                                                388817, --Shards of Stone
                                                387145, --Totemic Overload
    },
    stopCasting                             = { 377004, --Deafening Screech
                                                397892, --Scream of Pain
                                                196543, --Unnerving Howl
                                                199726, --Unruly Yell
                                                381516, --Interrupting Cloudburst
                                                384365, --Disruptive Shout
    },
    stunEnemy                               = { 197406, --Aggravated Skitterfly
                                                104295, --Blazing Imp  
                                                190174, --Hypnosis Bat  
    },
    scaryCasts                              = { 396023, --Incinerating Roar
                                                376279, --Concussive Slam
                                                388290, --Cyclone
                                                375457, --Chilling Tantrum
    },
    scaryDebuffs                            = { 394917, --Leaping Flames
                                                391686, --Conductive Mark
    },
}

local function InMelee(unitID)
    return A.RaptorStrike:IsInRange(unitID)
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
    
    local SurvivaloftheFittest = GetToggle(2, "SurvivaloftheFittest")
    if A.SurvivaloftheFittest:IsReady(player, nil, nil, true) and (Unit(player):HealthPercent() <= SurvivaloftheFittest or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1) then
        return A.EveryManforHimself
    end   
	
    if A.FortitudeoftheBear:IsReady(player) and Unit(player):HealthPercent() <= 70 then
        return A.FortitudeoftheBear
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
        if useKick and not notInterruptable and A.CounterShot:IsReady(unitID) and not Player:IsChanneling() then 
            return A.CounterShot
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

local function ActiveEnemies()

    local spells = {17253, 16827, 49966}
    local activeEnemies

    if not Pet:IsActive() then
        activeEnemies = 0
    else 
        for _, spell in pairs(spells) do
            if Pet:IsSpellKnown(spell) then
                activeEnemies = Pet:GetInRange(spell)
            end
        end
    end

    return activeEnemies

end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)

    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local useAoE = A.GetToggle(2, "AoE") 
    local activeEnemies = ActiveEnemies()

    local MendPetHP = A.GetToggle(2, "MendPetHP")
    if A.MendPet:IsReady(player) and Unit(pet):IsExists() and Unit(pet):HealthPercent() <= MendPetHP and Unit(pet):HealthPercent() > 0 and Unit(pet):HasBuffs(A.MendPet.ID, true) == 0 and Unit(pet):GetRange() < 40 then
        return A.MendPet:Show(icon)
    end 

    if A.CallPet:IsReady(player) and not Unit(pet):IsExists() then
        return A.CallPet:Show(icon)
    end
    
    if A.RevivePet:IsReady(player) and Unit(pet):IsDead() and not isMoving then
        return A.RevivePet:Show(icon)
    end

    local function EnemyRotation(unitID)

        if Unit(unitID):IsExplosives() then
            if A.CobraShot:IsReady(unitID) then
                return A.CobraShot:Show(icon)
            end
            if A.KillCommand:IsReady(unitID) then
                return A.KillCommand:Show(icon)
            end
        end

        local useRacial = A.GetToggle(1, "Racial")
        --actions.precombat+=/summon_pet,if=talent.kill_command|talent.beast_master
        
        if A.Misdirection:IsReady(player) and ((Unit(focus):IsExists() and IsUnitFriendly(focus)) or Unit(pet):IsExists()) then
            return A.Misdirection:Show(icon)
        end

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


        if BurstIsON(unitID) and useRacial and (Unit(unitID):TimeToDie() < 16 and Unit(unitID):IsBoss() or Unit(unitID):TimeToDie() > 16) and A.BarbedShot:IsInRange(unitID) then

            -- actions.cds+=/berserking,if=buff.call_of_the_wild.up|!talent.call_of_the_wild&buff.bestial_wrath.up|fight_remains<13
            if A.Berserking:IsReady(player) then
                if Unit(player):HasBuffs(A.CalloftheWild.ID) > 0 or (not A.CalloftheWild:IsTalentLearned() and Unit(player):HasBuffs(A.BestialWrath.ID) > 0) then
                    return A.Berserking:Show(icon)
                end
            end
            -- actions.cds+=/blood_fury,if=buff.call_of_the_wild.up|!talent.call_of_the_wild&(buff.bestial_wrath.up&(buff.bloodlust.up|target.health.pct<20))|fight_remains<16
            if A.BloodFury:IsReady(player) then
                if Unit(player):HasBuffs(A.CalloftheWild.ID) > 0 or (not A.CalloftheWild:IsTalentLearned() and Unit(player):HasBuffs(A.BestialWrath.ID) > 0) then
                    return A.BloodFury:Show(icon)
                end
            end
            -- actions.cds+=/ancestral_call,if=buff.call_of_the_wild.up|!talent.call_of_the_wild&(buff.bestial_wrath.up&(buff.bloodlust.up|target.health.pct<20))|fight_remains<16
            if A.AncestralCall:IsReady(player) then
                if Unit(player):HasBuffs(A.CalloftheWild.ID) > 0 or (not A.CalloftheWild:IsTalentLearned() and Unit(player):HasBuffs(A.BestialWrath.ID) > 0) then
                    return A.AncestralCall:Show(icon)
                end
            end
        end

        -- actions+=/call_action_list,name=trinkets
        local UseTrinket = UseTrinkets(unitID)
        if UseTrinket then
            return UseTrinket:Show(icon)
        end 

        -- actions+=/call_action_list,name=st,if=active_enemies<2|!talent.beast_cleave&active_enemies<3
        if activeEnemies < 2 or not A.BeastCleave:IsTalentLearned() and activeEnemies < 3 then
            -- actions.st=barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.main.buff.frenzy.up&pet.main.buff.frenzy.remains<=gcd+0.25|talent.scent_of_blood&pet.main.buff.frenzy.stack<3&cooldown.bestial_wrath.ready
            if A.BarbedShot:IsReady(unitID) then
                if Unit(pet):HasBuffs(A.Frenzy.ID) > 0 and Unit(pet):HasBuffs(A.Frenzy.ID) <= A.GetGCD() + 0.25 or A.ScentofBlood:IsTalentLearned() and Unit(pet):HasBuffsStacks(A.Frenzy.ID) < 3 and A.BestialWrath:GetCooldown() == 0 then
                    return A.BarbedShot:Show(icon)
                end
            end
            -- actions.st+=/kill_command,if=full_recharge_time<gcd&talent.alpha_predator
            if A.KillCommand:IsReady(unitID) and A.KillCommand:GetSpellChargesFullRechargeTime() < A.GetGCD() and A.AlphaPredator:IsTalentLearned() then
                return A.KillCommand:Show(icon)
            end
            -- actions.st+=/call_of_the_wild
            if A.CalloftheWild:IsReady(player) then
                return A.CalloftheWild:Show(icon)
            end
            -- actions.st+=/death_chakram
            if A.DeathChakram:IsReady(unitID) then
                return A.DeathChakram:Show(icon)
            end
            -- actions.st+=/bloodshed
            if A.Bloodshed:IsReady(unitID) then
                return A.Bloodshed:Show(icon)
            end
            -- actions.st+=/stampede
            if A.Stampede:IsReady(player) then
                return A.Stampede:Show(icon)
            end
            -- actions.st+=/a_murder_of_crows
            if A.AMurderOfCrows:IsReady(unitID) then
                return A.AMurderOfCrows:Show(icon)
            end
            -- actions.st+=/steel_trap
            if A.SteelTrap:IsReady(player) then
                return A.SteelTrap:Show(icon)
            end
            -- actions.st+=/explosive_shot
            if A.ExplosiveShot:IsReady(unitID) then
                return A.ExplosiveShot:Show(icon)
            end
            -- actions.st+=/bestial_wrath
            if A.BestialWrath:IsReady(player) and BurstIsON(unitID) and (Unit(unitID):TimeToDie() < 16 and Unit(unitID):IsBoss() or Unit(unitID):TimeToDie() > 16) and A.BarbedShot:IsInRange(unitID) then
                return A.BestialWrath:Show(icon)
            end
            -- actions.st+=/kill_command
            if A.KillCommand:IsReady(unitID) then
                return A.KillCommand:Show(icon)
            end
            -- actions.st+=/barbed_shot,target_if=min:dot.barbed_shot.remains,if=talent.wild_instincts&buff.call_of_the_wild.up|talent.wild_call&charges_fractional>1.4|full_recharge_time<gcd&cooldown.bestial_wrath.remains|talent.scent_of_blood&(cooldown.bestial_wrath.remains<12+gcd|full_recharge_time+gcd<8&cooldown.bestial_wrath.remains<24+(8-gcd)+full_recharge_time)|fight_remains<9
            if A.BarbedShot:IsReady(unitID) then
                if A.WildInstincts:IsTalentLearned() and Unit(player):HasBuffs(A.CalloftheWild.ID) > 0 or A.WildCall:IsTalentLearned() and A.BarbedShot:GetSpellChargesFrac() > 1.4 or A.BarbedShot:GetSpellChargesFullRechargeTime() < A.GetGCD() and A.BestialWrath:GetCooldown() > 0 or A.ScentofBlood:IsTalentLearned() and (A.BestialWrath:GetCooldown() < 12 + A.GetGCD() or A.BarbedShot:GetSpellChargesFullRechargeTime() + A.GetGCD() < 8 and A.BestialWrath:GetCooldown() < 24 + (8 - A.GetGCD()) + A.BarbedShot:GetSpellChargesFullRechargeTime()) or (Unit(unitID):TimeToDie() < 9 and Unit(unitID):IsBoss()) then
                    return A.BarbedShot:Show(icon)
                end
            end
            -- actions.st+=/dire_beast
            if A.DireBeast:IsReady(unitID) then
                return A.DireBeast:Show(icon)
            end
            -- actions.st+=/serpent_sting,target_if=min:remains,if=refreshable&target.time_to_die>duration
            if A.SerpentSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID) <= A.SerpentSting:GetSpellPandemicThreshold() and Unit(unitID):TimeToDie() > 18 then
                return A.SerpentSting:Show(icon)
            end
            -- actions.st+=/kill_shot
            if A.KillShot:IsReady(unitID) then
                return A.KillShot:Show(icon)
            end
            -- actions.st+=/aspect_of_the_wild
            if A.AspectoftheWild:IsReady(unitID) then
                return A.AspectoftheWild:Show(icon)
            end
            -- actions.st+=/cobra_shot
            if A.CobraShot:IsReady(unitID) then
                return A.CobraShot:Show(icon)
            end
            -- actions.st+=/wailing_arrow,if=pet.main.buff.frenzy.remains>execute_time|target.time_to_die<5
            if A.WailingArrow:IsReady(unitID) then
                if Unit(pet):HasBuffs(A.Frenzy.ID) > A.WailingArrow:GetSpellCastTime() or Unit(unitID):TimeToDie() < 5 then
                    return A.WailingArrow:Show(icon)
                end
            end
            -- actions.st+=/bag_of_tricks,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.BagofTricks:IsReady(player) and useRacial and Unit(player):HasBuffs(A.BestialWrath.ID) == 0 then
                return A.BagofTricks:Show(icon)
            end
            -- actions.st+=/arcane_pulse,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.ArcanePulse:IsReady(unitID) and useRacial and Unit(player):HasBuffs(A.BestialWrath.ID) == 0 then
                return A.ArcanePulse:Show(icon)
            end
            -- actions.st+=/arcane_torrent,if=(focus+focus.regen+15)<focus.max
            if A.ArcaneTorrent:IsReady(player) and useRacial and (Player:Focus() + Player:FocusRegen() + 15) < Player:FocusMax() then
                return A.ArcaneTorrent:Show(icon)
            end
        end

        -- actions+=/call_action_list,name=cleave,if=active_enemies>2|talent.beast_cleave&active_enemies>1
        if activeEnemies > 2 or A.BeastCleave:IsTalentLearned() and activeEnemies > 1 then
            -- actions.cleave=barbed_shot,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack>9&(pet.main.buff.frenzy.up&pet.main.buff.frenzy.remains<=gcd+0.25|talent.scent_of_blood&cooldown.bestial_wrath.remains<12+gcd|full_recharge_time<gcd&cooldown.bestial_wrath.remains)
            -- actions.cleave+=/barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.main.buff.frenzy.up&pet.main.buff.frenzy.remains<=gcd+0.25|talent.scent_of_blood&cooldown.bestial_wrath.remains<12+gcd|full_recharge_time<gcd&cooldown.bestial_wrath.remains
            if A.BarbedShot:IsReady(unitID) then
                if Unit(pet):HasBuffs(A.Frenzy.ID) > 0 and Unit(pet):HasBuffs(A.Frenzy.ID) <= A.GetGCD() + 0.25 or A.ScentofBlood:IsTalentLearned() and Unit(pet):HasBuffsStacks(A.Frenzy.ID) < 3 and A.BestialWrath:GetCooldown() == 0 then
                    return A.BarbedShot:Show(icon)
                end
            end
            -- actions.cleave+=/multishot,if=gcd-pet.main.buff.beast_cleave.remains>0.25
            if A.MultiShot:IsReady(unitID) and (A.GetGCD() - Unit(player):HasBuffs(A.BeastCleaveBuff.ID)) > 0.25 then
                return A.MultiShot:Show(icon)
            end
            -- actions.cleave+=/bestial_wrath
            if A.BestialWrath:IsReady(player) and BurstIsON(unitID) and (Unit(unitID):TimeToDie() < 16 and Unit(unitID):IsBoss() or Unit(unitID):TimeToDie() > 16) and A.BarbedShot:IsInRange(unitID) then
                return A.BestialWrath:Show(icon)
            end            
            -- actions.cleave+=/kill_command,if=talent.kill_cleave
            if A.KillCommand:IsReady(unitID) and A.KillCleave:IsTalentLearned() then
                return A.KillCommand:Show(icon)
            end
            -- actions.cleave+=/call_of_the_wild
            if A.CalloftheWild:IsReady(player) then
                return A.CalloftheWild:Show(icon)
            end
            -- actions.cleave+=/explosive_shot
            if A.ExplosiveShot:IsReady(unitID) then
                return A.ExplosiveShot:Show(icon)
            end
            -- actions.cleave+=/stampede,if=buff.bestial_wrath.up|target.time_to_die<15
            if A.Stampede:IsReady(player) then
                return A.Stampede:Show(icon)
            end
            -- actions.cleave+=/bloodshed
            if A.Bloodshed:IsReady(unitID) then
                return A.Bloodshed:Show(icon)
            end
            -- actions.cleave+=/death_chakram
            if A.DeathChakram:IsReady(unitID) then
                return A.DeathChakram:Show(icon)
            end
            -- actions.cleave+=/steel_trap
            if A.SteelTrap:IsReady(player) then
                return A.SteelTrap:Show(icon)
            end
            -- actions.cleave+=/a_murder_of_crows
            if A.AMurderOfCrows:IsReady(unitID) then
                return A.AMurderOfCrows:Show(icon)
            end
            -- actions.cleave+=/barbed_shot,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack>9&(talent.wild_instincts&buff.call_of_the_wild.up|fight_remains<9|talent.wild_call&charges_fractional>1.2)
            -- actions.cleave+=/barbed_shot,target_if=min:dot.barbed_shot.remains,if=talent.wild_instincts&buff.call_of_the_wild.up|fight_remains<9|talent.wild_call&charges_fractional>1.2
            if A.BarbedShot:IsReady(unitID) then
                if A.WildInstincts:IsTalentLearned() and Unit(player):HasBuffs(A.CalloftheWild.ID) > 0 or A.WildCall:IsTalentLearned() and A.BarbedShot:GetSpellChargesFrac() > 1.2 then
                    return A.BarbedShot:Show(icon)
                end
            end
            -- actions.cleave+=/kill_command
            if A.KillCommand:IsReady(unitID) then
                return A.KillCommand:Show(icon)
            end
            -- actions.cleave+=/dire_beast
            if A.DireBeast:IsReady(unitID) then
                return A.DireBeast:Show(icon)
            end
            -- actions.cleave+=/serpent_sting,target_if=min:remains,if=refreshable&target.time_to_die>duration
            if A.SerpentSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID) <= A.SerpentSting:GetSpellPandemicThreshold() and Unit(unitID):TimeToDie() > 18 then
                return A.SerpentSting:Show(icon)
            end
            -- actions.cleave+=/barrage,if=pet.main.buff.frenzy.remains>execute_time
            if A.Barrage:IsReady(player) and Unit(pet):HasBuffs(A.Frenzy.ID) > A.Barrage:GetSpellCastTime() then
                return A.Barrage:Show(icon)
            end
            --actions.cleave+=/multishot,if=pet.main.buff.beast_cleave.remains<gcd*2     
            if A.MultiShot:IsReady(unitID) and Unit(pet):HasBuffs(A.BeastCleaveBuff.ID) < A.GetGCD() * 2 then
                return A.MultiShot:Show(icon)
            end       
            -- actions.cleave+=/aspect_of_the_wild
            if A.AspectoftheWild:IsReady(unitID) then
                return A.AspectoftheWild:Show(icon)
            end
            -- actions.cleave+=/cobra_shot,if=focus.time_to_max<gcd*2|buff.aspect_of_the_wild.up&focus.time_to_max<gcd*4
            if A.CobraShot:IsReady(unitID) then
                if Player:FocusTimeToMax() < A.GetGCD() * 2 or Unit(player):HasBuffs(A.AspectoftheWild.ID) > 0 and Player:FocusTimeToMax() < A.GetGCD() * 4 then
                    return A.CobraShot:Show(icon)
                end
            end
            -- actions.cleave+=/wailing_arrow,if=pet.main.buff.frenzy.remains>execute_time|fight_remains<5
            if A.WailingArrow:IsReady(unitID) then
                if Unit(pet):HasBuffs(A.Frenzy.ID) > A.WailingArrow:GetSpellCastTime() or Unit(unitID):TimeToDie() < 5 then
                    return A.WailingArrow:Show(icon)
                end
            end
            -- actions.cleave+=/bag_of_tricks,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.BagofTricks:IsReady(player) and useRacial and Unit(player):HasBuffs(A.BestialWrath.ID) == 0 then
                return A.BagofTricks:Show(icon)
            end
            -- actions.cleave+=/arcane_torrent,if=(focus+focus.regen+30)<focus.max
            if A.ArcaneTorrent:IsReady(player) and useRacial and (Player:Focus() + Player:FocusRegen() + 15) < Player:FocusMax() then
                return A.ArcaneTorrent:Show(icon)
            end
            -- actions.cleave+=/kill_shot
            if A.KillShot:IsReady(unitID) then
                return A.KillShot:Show(icon)
            end
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