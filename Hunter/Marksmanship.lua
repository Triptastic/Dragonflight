--##################################
--##### TRIP'S MARKSMAN HUNTER #####
--##################################

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

Action[ACTION_CONST_HUNTER_MARKSMANSHIP] = {
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
    
    --Marksmanship
    AimedShot				= Action.Create({ Type = "Spell", ID = 19434   }),
    RapidFire				= Action.Create({ Type = "Spell", ID = 257044   }),
    ChimaeraShot				= Action.Create({ Type = "Spell", ID = 342049   }),
    MultiShot				= Action.Create({ Type = "Spell", ID = 257620   }),
    DoubleTap				= Action.Create({ Type = "Spell", ID = 260402   }),
    BurstingShot				= Action.Create({ Type = "Spell", ID = 186387   }),
    TrickShots				= Action.Create({ Type = "Spell", ID = 257621   }),
    TrickShotsBuff				= Action.Create({ Type = "Spell", ID = 257622   }),
    Volley				= Action.Create({ Type = "Spell", ID = 260243   }),
    Trueshot				= Action.Create({ Type = "Spell", ID = 288613   }),
    WailingArrow				= Action.Create({ Type = "Spell", ID = 392060   }),
    LoneWolf				= Action.Create({ Type = "Spell", ID = 155228, Hidden = true   }),
    SteadyFocus				= Action.Create({ Type = "Spell", ID = 193533, Hidden = true     }),
    SteadyFocusBuff				= Action.Create({ Type = "Spell", ID = 193534, Hidden = true     }),
    SerpentstalkersTrickery				= Action.Create({ Type = "Spell", ID = 378888, Hidden = true     }),
    Streamline				= Action.Create({ Type = "Spell", ID = 260367, Hidden = true     }),
    SurgingShots				= Action.Create({ Type = "Spell", ID = 391559, Hidden = true     }),
    Salvo				= Action.Create({ Type = "Spell", ID = 400456, Hidden = true     }),
    Bombardment				= Action.Create({ Type = "Spell", ID = 386875, Hidden = true     }),
    PreciseShots				= Action.Create({ Type = "Spell", ID = 260242, Hidden = true     }),
    RazorFragments				= Action.Create({ Type = "Spell", ID = 388998, Hidden = true     }),
    Bulletstorm				= Action.Create({ Type = "Spell", ID = 389020, Hidden = true     }),
    FortitudeoftheBear		= Action.Create({ Type = "SpellSingleColor", ID = 392956, Color = "PINK"   }),

    ElementalPotion1    		= Action.Create({ Type = "Potion", ID = 191387, Texture = 176108, Hidden = true   }),
    ElementalPotion2    		= Action.Create({ Type = "Potion", ID = 191388, Texture = 176108, Hidden = true   }),
    ElementalPotion3    		= Action.Create({ Type = "Potion", ID = 191389, Texture = 176108, Hidden = true   }),
}

local A = setmetatable(Action[ACTION_CONST_HUNTER_MARKSMANSHIP], { __index = Action })

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

    -- AspectoftheTurtle
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


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)

    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local useAoE = A.GetToggle(2, "AoE")

    local MendPetHP = A.GetToggle(2, "MendPetHP")
    if A.MendPet:IsReady(player) and Unit(pet):IsExists() and Unit(pet):HealthPercent() <= MendPetHP and Unit(pet):HealthPercent() > 0 and Unit(pet):HasBuffs(A.MendPet.ID, true) == 0 and Unit(pet):GetRange() < 40 and not A.LoneWolf:IsTalentLearned() then
        return A.MendPet:Show(icon)
    end 

    if A.CallPet:IsReady(player) and not Unit(pet):IsExists() and not isMoving and not A.LoneWolf:IsTalentLearned() then
        return A.CallPet:Show(icon)
    end
    
    if A.RevivePet:IsReady(player) and Unit(pet):IsDead() and not isMoving and not A.LoneWolf:IsTalentLearned() then
        return A.RevivePet:Show(icon)
    end

    local function EnemyRotation(unitID)
        local useRacial = A.GetToggle(1, "Racial")
        --actions.precombat+=/summon_pet,if=talent.kill_command|talent.beast_master

        if Unit(unitID):IsExplosives() then
            if A.SerpentSting:IsReady(unitID) then
                return A.SerpentSting:Show(icon)
            end
        end

        --actions.precombat+=/double_tap,precast_time=10
        --actions.precombat+=/use_item,name=algethar_puzzle_box
        --# Precast Aimed Shot on one or two targets unless we could cleave it with Volley on two targets.
        --actions.precombat+=/aimed_shot,if=active_enemies<3&(!talent.volley|active_enemies<2)
        --actions.precombat+=/wailing_arrow,if=active_enemies>2|!talent.steady_focus
        --# Precast Steady Shot on two targets if we are saving Aimed Shot to cleave with Volley, otherwise on three or more targets.
        --actions.precombat+=/steady_shot,if=active_enemies>2|talent.volley&active_enemies=2
        
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

        --actions+=/call_action_list,name=trinkets
        local UseTrinket = UseTrinkets(unitID)
        if UseTrinket then
            return UseTrinket:Show(icon)
        end 

        if BurstIsON(unitID) and A.SteadyShot:IsInRange(unitID) then
        --actions.cds+=/berserking,if=boss&fight_remains<13
            if A.Berserking:IsReady(player) and useRacial and (Unit(unitID):TimeToDie() > 13 or (Unit(unitID):IsBoss() and Unit(unitID):TimeToDie() < 13)) then
                return A.Berserking:Show(icon)
            end
            --actions.cds+=/blood_fury,if=buff.trueshot.up|cooldown.trueshot.remains>30|boss&fight_remains<16
            if A.BloodFury:IsReady(player) and useRacial and (Unit(player):HasBuffs(A.Trueshot.ID) > 0 or A.Trueshot:GetCooldown() > 30 or (Unit(unitID):IsBoss() and Unit(unitID):TimeToDie() < 16)) then
                return A.BloodFury:Show(icon)
            end
            --actions.cds+=/ancestral_call,if=buff.trueshot.up|cooldown.trueshot.remains>30|boss&fight_remains<16
            if A.AncestralCall:IsReady(player) and useRacial and (Unit(player):HasBuffs(A.Trueshot.ID) > 0 or A.Trueshot:GetCooldown() > 30 or (Unit(unitID):IsBoss() and Unit(unitID):TimeToDie() < 16)) then
                return A.AncestralCall:Show(icon)
            end
            --actions.cds+=/fireblood,if=buff.trueshot.up|cooldown.trueshot.remains>30|boss&fight_remains<9
            if A.Fireblood:IsReady(player) and useRacial and (Unit(player):HasBuffs(A.Trueshot.ID) > 0 or A.Trueshot:GetCooldown() > 30 or (Unit(unitID):IsBoss() and Unit(unitID):TimeToDie() < 9)) then
                return A.Fireblood:Show(icon)
            end
            --actions.cds+=/lights_judgment,if=buff.trueshot.down
            if A.LightsJudgment:IsReady(unitID) and Unit(player):HasBuffs(A.Trueshot.ID) == 0 then
                return A.LightsJudgment:Show(icon)
            end
            --actions.cds+=/potion,if=buff.trueshot.up&(buff.bloodlust.up|target.health.pct<20)|boss&fight_remains<26
            local damagePotion = A.GetToggle(2, "damagePotion")
            local potionBossOnly = A.GetToggle(2, "potionBossOnly")
            local damagePotionObject = A.DetermineUsableObject(player, nil, nil, true, nil, A.ElementalPotion1, A.ElementalPotion2, A.ElementalPotion3)
            if damagePotionObject and damagePotion and ((potionBossOnly and Unit(unitID):IsBoss()) or not potionBossOnly) then
                if Unit(player):HasBuffs(A.Trueshot.ID) > 0 then
                    return damagePotionObject:Show(icon)
                end
            end
            --actions.cds+=/salvo
            if A.Salvo:IsReady(player) then
                return A.DoubleTap:Show(icon)
            end

            if A.Trueshot:IsReady(player) then
                return A.Trueshot:Show(icon)
            end
        end

        --actions+=/call_action_list,name=st,if=active_enemies<3|!talent.trick_shots
        if MultiUnits:GetActiveEnemies() < 3 or not A.TrickShots:IsTalentLearned() then

            --actions.st+=/steady_shot,if=talent.steady_focus&(steady_focus_count&buff.steady_focus.remains<5|buff.steady_focus.down&!buff.trueshot.up)
            if A.SteadyShot:IsReady(unitID) and A.SteadyFocus:IsTalentLearned() and ((Unit(player):HasBuffs(A.SteadyFocusBuff.ID) > 0 and Unit(player):HasBuffs(A.SteadyFocusBuff.ID) < 5) or (Unit(player):HasBuffs(A.SteadyFocusBuff.ID) == 0 and Unit(player):HasBuffs(A.Trueshot.ID) == 0)) then
                return A.SteadyShot:Show(icon)
            end
            --actions.st+=/kill_shot
            if A.KillShot:IsReady(unitID) then
                return A.KillShot:Show(icon)
            end
            --actions.st+=/steel_trap
            if A.SteelTrap:IsReady(player) and A.ArcaneShot:IsInRange(unitID) then
                return A.SteelTrap:Show(icon)
            end
            --actions.st+=/serpent_sting,cycle_targets=1,if=refreshable&!talent.serpentstalkers_trickery&buff.trueshot.down
            if A.SerpentSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) < 3 and not A.SerpentstalkersTrickery:IsTalentLearned() and Unit(player):HasBuffs(A.Trueshot.ID) == 0 then
                return A.SerpentSting:Show(icon)
            end
            --actions.st+=/explosive_shot
            if A.ExplosiveShot:IsReady(unitID) then
                return A.ExplosiveShot:Show(icon)
            end
            --# Save Double Tap for Rapid Fire if at least Streamline is taken.
            --actions.st+=/double_tap,if=(cooldown.rapid_fire.remains<gcd|!talent.streamline)&(!raid_event.adds.exists|raid_event.adds.up&(raid_event.adds.in<10&raid_event.adds.remains<3|raid_event.adds.in>cooldown|active_enemies>1)|!raid_event.adds.up&(raid_event.adds.count=1|raid_event.adds.in>cooldown))
            if A.DoubleTap:IsReady(player) and (A.RapidFire:GetCooldown() < A.GetGCD() or not A.Streamline:IsTalentLearned()) then
                return A.DoubleTap:Show(icon)
            end
            --actions.st+=/stampede
            if A.Stampede:IsReady(player) then
                return A.Stampede:Show(icon)
            end
            --actions.st+=/death_chakram
            if A.DeathChakram:IsReady(unitID) then
                return A.DeathChakram:Show(icon)
            end
            --actions.st+=/wailing_arrow,if=active_enemies>1
            if A.WailingArrow:IsReady(unitID) and MultiUnits:GetActiveEnemies() > 1 then
                return A.WailingArrow:Show(icon)
            end
            --actions.st+=/volley
            if A.Volley:IsReady(player) and useAoE then
                return A.Volley:Show(icon)
            end
            --# With at least Streamline, Double Tap Rapid Fire.
            --actions.st+=/rapid_fire,if=talent.surging_shots|buff.double_tap.up&talent.streamline
            if A.RapidFire:IsReady(unitID) and (A.SurgingShots:IsTalentLearned() or Unit(player):HasBuffs(A.DoubleTap.ID) > 0 and A.Streamline:IsTalentLearned()) then
                return A.RapidFire:Show(icon)
            end
            --actions.st+=/trueshot,if=!raid_event.adds.exists&(!trinket.1.has_use_buff|trinket.1.cooldown.remains>30|trinket.1.cooldown.ready)&(!trinket.2.has_use_buff|trinket.2.cooldown.remains>30|trinket.2.cooldown.ready)|raid_event.adds.exists&(!raid_event.adds.up&(raid_event.adds.duration+raid_event.adds.in<25|raid_event.adds.in>60)|raid_event.adds.up&raid_event.adds.remains>10)|active_enemies>1|boss&fight_remains<25
            --# Trigger Trick Shots from Bombardment if it isn't already up, or trigger Salvo if Volley isn't being used to trigger it.
            --actions.st+=/multishot,if=buff.bombardment.up&buff.trick_shots.down&active_enemies>1|talent.salvo&buff.salvo.down&!talent.volley
            if A.MultiShot:IsReady(unitID) and useAoE and ((Unit(player):HasBuffs(A.Bombardment.ID) > 0 and Unit(player):HasBuffs(A.TrickShotsBuff.ID) == 0 and MultiUnits:GetActiveEnemies() > 1) or (Unit(player):HasBuffs(A.Salvo.ID) > 0 and not A.Volley:IsTalentLearned())) then
                return A.MultiShot:Show(icon)
            end
            --# For Serpentstalker's Trickery, target the lowest remaining Serpent Sting. On one target don't overwrite Precise Shots unless Trueshot is up or Aimed Shot would cap otherwise, and on two targets don't overwrite Precise Shots if you have Chimaera Shot, but ignore those general rules if we can cleave it.
            --actions.st+=/aimed_shot,cycle_targets=1,if=talent.serpentstalkers_trickery&((buff.precise_shots.down|(buff.trueshot.up|full_recharge_time<gcd+cast_time)&(!talent.chimaera_shot|active_enemies<2))|buff.trick_shots.remains>execute_time&active_enemies>1)
            --# For no Serpentstalker's Trickery, target the highest Latent Poison stack. Same general rules as the previous line.
           --actions.st+=/aimed_shot,cycle_targets=1,if=(buff.precise_shots.down|(buff.trueshot.up|full_recharge_time<gcd+cast_time)&(!talent.chimaera_shot|active_enemies<2))|buff.trick_shots.remains>execute_time&active_enemies>1
            if A.AimedShot:IsReady(unitID) and not isMoving and ((Unit(player):HasBuffs(A.PreciseShots.ID) == 0 or (Unit(player):HasBuffs(A.Trueshot.ID) > 0 or A.AimedShot:GetSpellChargesFullRechargeTime() < (A.GetGCD() + Player:Execute_Time(A.AimedShot.ID))) and (not A.ChimaeraShot:IsTalentLearned() or MultiUnits:GetActiveEnemies() < 2)) or Unit(player):HasBuffs(A.TrickShotsBuff.ID) > Player:Execute_Time(A.AimedShot.ID) and MultiUnits:GetActiveEnemies() > 1) then
                return A.AimedShot:Show(icon)
            end
            --# Refresh Steady Focus if it would run out while refreshing it.
            --actions.st+=/steady_shot,if=talent.steady_focus&buff.steady_focus.remains<execute_time*2
            if A.SteadyShot:IsReady(unitID) and A.SteadyFocus:IsTalentLearned() and Unit(player):HasBuffs(A.SteadyFocusBuff.ID) < (Player:Execute_Time(A.SteadyShot.ID) * 2) then
                return A.SteadyShot:Show(icon)
            end
            --actions.st+=/rapid_fire
            if A.RapidFire:IsReady(unitID) then
                return A.RapidFire:Show(icon)
            end
            --actions.st+=/wailing_arrow,if=buff.trueshot.down
            if A.WailingArrow:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.Trueshot.ID) == 0 then
                return A.WailingArrow:Show(icon)
            end
            --actions.st+=/chimaera_shot,if=buff.precise_shots.up|focus>cost+action.aimed_shot.cost
            if A.ChimaeraShot:IsReady(unitID) and (Unit(player):HasBuffs(A.PreciseShots.ID) > 0 or Player:Focus() > (A.ChimaeraShot:GetSpellPowerCost() + A.AimedShot:GetSpellPowerCost())) then
                return A.ArcaneShot:Show(icon)
            end
            --actions.st+=/arcane_shot,if=buff.precise_shots.up|focus>cost+action.aimed_shot.cost
            if A.ArcaneShot:IsReady(unitID) and (Unit(player):HasBuffs(A.PreciseShots.ID) > 0 or Player:Focus() > (A.ArcaneShot:GetSpellPowerCost() + A.AimedShot:GetSpellPowerCost())) then
                return A.ArcaneShot:Show(icon)
            end
            --actions.st+=/bag_of_tricks,if=buff.trueshot.down
            if A.BagofTricks:IsReady(player) and useRacial and Unit(player):HasBuffs(A.Trueshot.ID) == 0 then
                return A.BagofTricks:Show(icon)
            end
            --actions.st+=/steady_shot
            if A.SteadyShot:IsReady(unitID) then
                return A.SteadyShot:Show(icon)
            end

        end


        --actions+=/call_action_list,name=trickshots,if=active_enemies>2
        if MultiUnits:GetActiveEnemies() > 2 then

            --actions.trickshots+=/steady_shot,if=talent.steady_focus&steady_focus_count&buff.steady_focus.remains<8
            if A.SteadyShot:IsReady(unitID) and A.SteadyFocus:IsTalentLearned() and Unit(player):HasBuffs(A.SteadyFocusBuff.ID) > 0 and Unit(player):HasBuffs(A.SteadyFocusBuff.ID) < 8 then
                return A.SteadyShot:Show(icon)
            end
            --actions.trickshots+=/kill_shot,if=buff.razor_fragments.up
            if A.KillShot:IsReady(unitID) and Unit(player):HasBuffs(A.RazorFragments.ID) > 0 then
                return A.KillShot:Show(icon)
            end
            --actions.trickshots+=/explosive_shot
            if A.ExplosiveShot:IsReady(unitID) then
                return A.ExplosiveShot:Show(icon)
            end
            --actions.trickshots+=/stampede
            if A.Stampede:IsReady(player) then
                return A.Stampede:Show(icon)
            end
            --actions.trickshots+=/death_chakram
            if A.DeathChakram:IsReady(unitID) then
                return A.DeathChakram:Show(icon)
            end
            if A.WailingArrow:IsReady(unitID) and not isMoving then
                return A.WailingArrow:Show(icon)
            end
            --actions.trickshots+=/serpent_sting,cycle_targets=1,if=refreshable&talent.hydras_bite
            if A.SerpentSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID) < 3 and A.HydrasBite:IsTalentLearned() then
                return A.SerpentSting:Show(icon)
            end
            --actions.trickshots+=/barrage,if=active_enemies>7
            if A.Barrage:IsReady(player) and MultiUnits:GetActiveEnemies() > 7 then
                return A.Barrage:Show(icon)
            end
            --actions.trickshots+=/volley
            if A.Volley:IsReady(player) and useAoE then
                return A.Volley:Show(icon)
            end
            --actions.trickshots+=/trueshot
            if A.Trueshot:IsReady(player) and BurstIsON(unitID) then
                return A.Trueshot:Show(icon)
            end
            --actions.trickshots+=/rapid_fire,if=buff.trick_shots.remains>=execute_time&(talent.surging_shots|buff.double_tap.up&talent.streamline)
            if A.RapidFire:IsReady(unitID) and Unit(player):HasBuffs(A.TrickShotsBuff.ID) >= Player:Execute_Time(A.RapidFire.ID) and (A.SurgingShots:IsTalentLearned() or Unit(player):HasBuffs(A.DoubleTap.ID) > 0 and A.Streamline:IsTalentLearned()) then
                return A.RapidFire:Show(icon)
            end
            --# For Serpentstalker's Trickery, target the lowest remaining Serpent Sting. Generally only cast if it would cleave with Trick Shots. Don't overwrite Precise Shots unless Trueshot is up or Aimed Shot would cap otherwise.
            --actions.trickshots+=/aimed_shot,cycle_targets=1,if=talent.serpentstalkers_trickery&(buff.trick_shots.remains>=execute_time&(buff.precise_shots.down|buff.trueshot.up|full_recharge_time<cast_time+gcd))
            --# For no Serpentstalker's Trickery, target the highest Latent Poison stack. Same general rules as the previous line.
            --actions.trickshots+=/aimed_shot,cycle_targets=1,if=(buff.trick_shots.remains>=execute_time&(buff.precise_shots.down|buff.trueshot.up|full_recharge_time<cast_time+gcd))
            if A.AimedShot:IsReady(unitID) and not isMoving and (Unit(player):HasBuffs(A.TrickShotsBuff.ID) >= Player:Execute_Time(A.AimedShot.ID) and (Unit(player):HasBuffs(A.PreciseShots.ID) == 0 or Unit(player):HasBuffs(A.Trueshot.ID) > 0 or A.AimedShot:GetSpellChargesFullRechargeTime() < (Player:Execute_Time(A.AimedShot.ID) + A.GetGCD()))) then
                return A.AimedShot:Show(icon)
            end
            --actions.trickshots+=/rapid_fire,if=buff.trick_shots.remains>=execute_time
            if A.RapidFire:IsReady(unitID) and Unit(player):HasBuffs(A.TrickShotsBuff.ID) >= Player:Execute_Time(A.RapidFire.ID) then
                return A.RapidFire:Show(icon)
            end
            --actions.trickshots+=/chimaera_shot,if=buff.trick_shots.up&buff.precise_shots.up&focus>cost+action.aimed_shot.cost&active_enemies<4
            if A.ChimaeraShot:IsReady(unitID) and Unit(player):HasBuffs(A.TrickShotsBuff.ID) > 0 and Unit(player):HasBuffs(A.PreciseShots.ID) > 0 and Player:Focus() > (A.ChimaeraShot:GetSpellPowerCost() + A.AimedShot:GetSpellPowerCost()) and MultiUnits:GetActiveEnemies() < 4 then
                return A.ArcaneShot:Show(icon)
            end
            --actions.trickshots+=/multishot,if=buff.trick_shots.down|(buff.precise_shots.up|buff.bulletstorm.stack=10)&focus>cost+action.aimed_shot.cost
            if A.MultiShot:IsReady(unitID) and useAoE and (Unit(player):HasBuffs(A.TrickShotsBuff.ID) == 0 or Unit(player):HasBuffs(A.PreciseShots.ID) > 0 or Unit(player):HasBuffsStacks(A.Bulletstorm.ID) >= 10) and Player:Focus() > (A.MultiShot:GetSpellPowerCost() + A.AimedShot:GetSpellPowerCost()) then
                return A.MultiShot:Show(icon)
            end
            --# Only use baseline Serpent Sting as a filler in cleave if it's the only source of applying Latent Poison.
            --actions.trickshots+=/serpent_sting,cycle_targets=1,if=refreshable&talent.poison_injection&!talent.serpentstalkers_trickery
            if A.SerpentSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) < 3 and A.PoisonInjection:IsTalentLearned() and not A.SerpentstalkersTrickery:IsTalentLearned() then
                return A.SerpentSting:Show(icon)
            end
            --actions.trickshots+=/steel_trap
            if A.SteelTrap:IsReady(player) then
                return A.SteelTrap:Show(icon)
            end
            --actions.trickshots+=/kill_shot,if=focus>cost+action.aimed_shot.cost
            if A.KillShot:IsReady(unitID) and Player:Focus() > (A.KillShot:GetSpellPowerCost() + A.AimedShot:GetSpellPowerCost()) then
                return A.KillShot:Show(icon)
            end
            --actions.trickshots+=/multishot,if=focus>cost+action.aimed_shot.cost
            if A.MultiShot:IsReady(unitID) and useAoE and Player:Focus() > (A.MultiShot:GetSpellPowerCost() + A.AimedShot:GetSpellPowerCost()) then
                return A.MultiShot:Show(icon)
            end
            --actions.trickshots+=/bag_of_tricks,if=buff.trueshot.down
            if A.BagofTricks:IsReady(player) and useRacial and Unit(player):HasBuffs(A.Trueshot.ID) == 0 then
                return A.BagofTricks:Show(icon)
            end
            --actions.trickshots+=/steady_shot
            if A.SteadyShot:IsReady(unitID) then
                return A.SteadyShot:Show(icon)
            end
        
        end

        
       
        --[[actions.trinkets+=/variable,name=sync_up,value=buff.trueshot.up|cooldown.trueshot.remains<2&(!raid_event.adds.exists|raid_event.adds.exists&(!raid_event.adds.up&(raid_event.adds.duration+raid_event.adds.in<25|raid_event.adds.in>60)|raid_event.adds.up&raid_event.adds.remains>10))
        actions.trinkets+=/variable,name=sync_remains,value=cooldown.trueshot.remains
        actions.trinkets+=/variable,name=trinket_1_stronger,value=trinket.1.has_use_buff&(!trinket.2.has_use_buff|trinket.2.cooldown.duration<trinket.1.cooldown.duration)|!trinket.1.has_use_buff&trinket.1.has_cooldown&!trinket.2.has_use_buff&trinket.2.cooldown.duration<trinket.1.cooldown.duration|!trinket.2.has_cooldown
        actions.trinkets+=/variable,name=trinket_2_stronger,value=trinket.2.has_use_buff&(!trinket.1.has_use_buff|trinket.1.cooldown.duration<trinket.2.cooldown.duration)|!trinket.2.has_use_buff&trinket.2.has_cooldown&!trinket.1.has_use_buff&trinket.1.cooldown.duration<trinket.2.cooldown.duration|!trinket.1.has_cooldown
        actions.trinkets+=/use_items,slots=trinket1,if=trinket.1.has_use_buff&(variable.sync_up&(variable.trinket_1_stronger|trinket.2.cooldown.remains)|!variable.sync_up&(variable.trinket_1_stronger&(variable.sync_remains>trinket.1.cooldown.duration%2|trinket.2.has_use_buff&trinket.2.cooldown.remains>variable.sync_remains-15&trinket.2.cooldown.remains-5<variable.sync_remains&variable.sync_remains+40>fight_remains)|variable.trinket_2_stronger&(trinket.2.cooldown.remains&(trinket.2.cooldown.remains-5<variable.sync_remains&variable.sync_remains>=20|trinket.2.cooldown.remains-5>=variable.sync_remains&(variable.sync_remains>trinket.1.cooldown.duration%2|trinket.1.cooldown.duration<fight_remains&(variable.sync_remains+trinket.1.cooldown.duration>fight_remains)))|trinket.2.cooldown.ready&variable.sync_remains>20&variable.sync_remains<trinket.2.cooldown.duration%2)))|!trinket.1.has_use_buff&(variable.sync_up&(variable.trinket_1_stronger|trinket.2.cooldown.remains)|!variable.sync_up&(!trinket.2.has_use_buff&(variable.trinket_1_stronger|trinket.2.cooldown.remains)|trinket.2.has_use_buff&(variable.sync_remains>20|trinket.2.cooldown.remains>20)))|target.time_to_die<25&(variable.trinket_1_stronger|trinket.2.cooldown.remains)
        actions.trinkets+=/use_items,slots=trinket2,if=trinket.2.has_use_buff&(variable.sync_up&(variable.trinket_2_stronger|trinket.1.cooldown.remains)|!variable.sync_up&(variable.trinket_2_stronger&(variable.sync_remains>trinket.2.cooldown.duration%2|trinket.1.has_use_buff&trinket.1.cooldown.remains>variable.sync_remains-15&trinket.1.cooldown.remains-5<variable.sync_remains&variable.sync_remains+40>fight_remains)|variable.trinket_1_stronger&(trinket.1.cooldown.remains&(trinket.1.cooldown.remains-5<variable.sync_remains&variable.sync_remains>=20|trinket.1.cooldown.remains-5>=variable.sync_remains&(variable.sync_remains>trinket.2.cooldown.duration%2|trinket.2.cooldown.duration<fight_remains&(variable.sync_remains+trinket.2.cooldown.duration>fight_remains)))|trinket.1.cooldown.ready&variable.sync_remains>20&variable.sync_remains<trinket.1.cooldown.duration%2)))|!trinket.2.has_use_buff&(variable.sync_up&(variable.trinket_2_stronger|trinket.1.cooldown.remains)|!variable.sync_up&(!trinket.1.has_use_buff&(variable.trinket_2_stronger|trinket.1.cooldown.remains)|trinket.1.has_use_buff&(variable.sync_remains>20|trinket.1.cooldown.remains>20)))|target.time_to_die<25&(variable.trinket_2_stronger|trinket.1.cooldown.remains)]]

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