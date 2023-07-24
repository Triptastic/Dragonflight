--################################
--##### TRIP'S SHADOW PRIEST #####
--################################

local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
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

Action[ACTION_CONST_PRIEST_SHADOW] = {
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
    ShadowWordPain				= Action.Create({ Type = "Spell", ID = 589   }), 
    VampiricTouch				= Action.Create({ Type = "Spell", ID = 34914   }),
    Smite				        = Action.Create({ Type = "Spell", ID = 585   }),
    MindBlast				    = Action.Create({ Type = "Spell", ID = 8092   }),
    MindFlay				    = Action.Create({ Type = "Spell", ID = 15407   }),
    Fade				        = Action.Create({ Type = "Spell", ID = 586   }),
    PowerWordShield				= Action.Create({ Type = "Spell", ID = 17   }),
    DesperatePrayer				= Action.Create({ Type = "Spell", ID = 19236   }),
    MindSoothe  				= Action.Create({ Type = "Spell", ID = 453   }),
    PsychicScream				= Action.Create({ Type = "Spell", ID = 8122   }),
    PowerWordFortitude			= Action.Create({ Type = "Spell", ID = 21562   }),
    Shadowform  				= Action.Create({ Type = "Spell", ID = 232698   }),
    
    --Priest Class Talents
    Renew				        = Action.Create({ Type = "Spell", ID = 139   }),
    DispelMagic				    = Action.Create({ Type = "Spell", ID = 528   }),
    Shadowfiend				    = Action.Create({ Type = "Spell", ID = 34433   }),
    FlashHeal						= Action.Create({ Type = "Spell", ID = 2061   }),
    PrayerofMending				= Action.Create({ Type = "Spell", ID = 33076   }),
    PurifyDisease				= Action.Create({ Type = "Spell", ID = 213634   }),
    ShadowWordDeath				= Action.Create({ Type = "Spell", ID = 32379   }),
    HolyNova    				= Action.Create({ Type = "Spell", ID = 132157   }),
    AngelicFeather				= Action.Create({ Type = "Spell", ID = 121536   }),
    Phantasm    				= Action.Create({ Type = "Spell", ID = 108942   }),
    LeapofFaith 				= Action.Create({ Type = "Spell", ID = 73325   }),
    ShackleUndead				= Action.Create({ Type = "Spell", ID = 9484   }),
    VoidTendrils				= Action.Create({ Type = "Spell", ID = 108920   }),
    MindControl 				= Action.Create({ Type = "Spell", ID = 605   }),
    DominateMind				= Action.Create({ Type = "Spell", ID = 14515   }),
    MassDispel  				= Action.Create({ Type = "Spell", ID = 32375   }),
    PowerInfusion				= Action.Create({ Type = "Spell", ID = 10060   }),
    VampiricEmbrace				= Action.Create({ Type = "Spell", ID = 15286   }),
    TwinsoftheSunPriestess		= Action.Create({ Type = "Spell", ID = 373466, Hidden = true   }),
    DivineStar				    = Action.Create({ Type = "Spell", ID = 122121   }),
    Halo				        = Action.Create({ Type = "Spell", ID = 120644   }),
    Mindgames				    = Action.Create({ Type = "Spell", ID = 375901   }),
    SurgeofLight				= Action.Create({ Type = "Spell", ID = 109186, Hidden = true   }),
    PowerWordLife				= Action.Create({ Type = "Spell", ID = 373481   }),
    VoidShift   				= Action.Create({ Type = "Spell", ID = 108968   }),

    --Shadow Talents
    DevouringPlague				= Action.Create({ Type = "Spell", ID = 335467   }),
    Dispersion  				= Action.Create({ Type = "Spell", ID = 47585   }),
    Silence				        = Action.Create({ Type = "Spell", ID = 15487   }),
    Misery				        = Action.Create({ Type = "Spell", ID = 238558, Hidden = true   }),
    DarkVoid				    = Action.Create({ Type = "Spell", ID = 263346   }),
    PsychicHorror				= Action.Create({ Type = "Spell", ID = 64044   }),
    MindSear				    = Action.Create({ Type = "Spell", ID = 48045   }),
    MindSpike				    = Action.Create({ Type = "Spell", ID = 73510   }),
    MentalDecay				    = Action.Create({ Type = "Spell", ID = 375994, Hidden = true   }),
    DarkAscension				= Action.Create({ Type = "Spell", ID = 391109   }),
    Voidform				    = Action.Create({ Type = "Spell", ID = 194249   }),
    VoidEruption			    = Action.Create({ Type = "Spell", ID = 228260, Texture = 391109    }),
    VoidBolt				    = Action.Create({ Type = "Spell", ID = 205448, Texture = 391109   }),
    UnfurlingDarkness			= Action.Create({ Type = "Spell", ID = 341273, Hidden = true   }),
    SurgeofDarkness				= Action.Create({ Type = "Spell", ID = 87160, Hidden = true   }),
    ShadowyInsight				= Action.Create({ Type = "Spell", ID = 375888, Hidden = true   }),
    ShadowCrash				    = Action.Create({ Type = "Spell", ID = 205385   }),
    MindMelt				    = Action.Create({ Type = "Spell", ID = 391090, Hidden = true   }),
    Mindbender				    = Action.Create({ Type = "Spell", ID = 200174   }),
    Deathspeaker				= Action.Create({ Type = "Spell", ID = 392507, Hidden = true   }),
    MindFlayInsanity			= Action.Create({ Type = "Spell", ID = 391403   }),
    Damnation				    = Action.Create({ Type = "Spell", ID = 341374   }),
    VoidTorrent				    = Action.Create({ Type = "Spell", ID = 263165   }),
    MindDevourer				= Action.Create({ Type = "Spell", ID = 373202, Hidden = true   }),
    IdolofCthun				    = Action.Create({ Type = "Spell", ID = 377349, Hidden = true   }),
    InescapableTorment		    = Action.Create({ Type = "Spell", ID = 373427, Hidden = true   }),
    DarkReveries		        = Action.Create({ Type = "Spell", ID = 394963, Hidden = true   }),
    GatheringShadows	        = Action.Create({ Type = "Spell", ID = 394961, Hidden = true   }),
    ScreamsoftheVoid	        = Action.Create({ Type = "Spell", ID = 375767, Hidden = true   }),
    DeathAndMadness 	        = Action.Create({ Type = "Spell", ID = 321291, Hidden = true   }),
}

local A = setmetatable(Action[ACTION_CONST_PRIEST_SHADOW], { __index = Action })

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
    VampiricTouchDelay                      = 0,
    customDispel                            = { --145206, --Proving Grounds Testing
                                                388392, --Monotonous Lecture
                                                391977, --Oversurge
                                                389033, --Lasher Toxin
                                                207278, --Arcane Lockdown
                                                207980, --Disintegration Beam
                                                372682, --Primal Chill
                                                114803, --Throw torch
                                                395872, --Sleepy Soliloquy
                                                106736, --Wither Will
                                                386546, --Waking Bane
                                                377488, --Icy Bindings
                                                388777, --Oppressive Miasma
                                                384686, --Energy Surge
                                                376827, --Conductive Strike
    },
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
    customBoPDebuff                         = { 196838, --Scent of Blood

    },
    freedomList                             = { 377488, --Icy Bindings
                                                387615, --Grasp of the Dead
    },
    scaryCasts                              = { 396023, --Incinerating Roar
                                                376279, --Concussive Slam
                                                388290, --Cyclone
                                                375457, --Chilling Tantrum
    },
    scaryDebuffs                            = { 394917, --Leaping Flames
                                                391686, --Conductive Mark

    },
    PWSDebuffs								= { 381461, --Savage Charge
                                                378229, --Marked for Butchery
                                            }
}

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end  
	
    local vampEmbraceHP = A.GetToggle(2, "vampEmbraceHP")
    local vampEmbraceUnits = A.GetToggle(2, "vampEmbraceUnits")
    local vampEmbraceTotal = 0
    local members = GetNumGroupMembers()
    if A.VampiricEmbrace:IsReady(player) then
        for _, vampEmbraceUnit in pairs(TeamCache.Friendly.GUIDs) do
            if Unit(vampEmbraceUnit):HealthPercent() <= vampEmbraceHP and Unit(vampEmbraceUnit):GetRange() <= 40 and not Unit(vampEmbraceUnit):InVehicle() then
                vampEmbraceTotal = vampEmbraceTotal + 1
            end
            if vampEmbraceTotal >= vampEmbraceUnits or (vampEmbraceTotal >= members and members >= 2) then
                vampEmbraceTotal = 0
                return A.VampiricEmbrace
            end 
        end
        if members == 0 then
            if Unit(player):HealthPercent() <= vampEmbraceHP then
                return A.VampiricEmbrace
            end
        end
        if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1 then
            return A.VampiricEmbrace
        end
    end

    local DispersionHP = A.GetToggle(2, "DispersionHP")
	if A.Dispersion:IsReady(player) and Unit(player):HealthPercent() <= DispersionHP then
		return A.Dispersion
	end
	
    local DesperatePrayerHP = A.GetToggle(2, "DesperatePrayerHP")
	if A.DesperatePrayer:IsReady(player) and Unit(player):HealthPercent() <= DesperatePrayerHP then
		return A.DesperatePrayer
	end

    local PWSHP = A.GetToggle(2, "PWSHP")
    if A.PowerWordShield:IsReady(player) and (Unit(player):HealthPercent() <= PWSHP or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1) and Unit(player):HasDeBuffs(A.PowerWordShield.ID) == 0 then
		return A.PowerWordShield
	end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        -- Silence
        if useKick and not notInterruptable and A.Silence:IsReady(unitID) then 
            return A.Silence
        end

        if useCC and not notInterruptable and A.PsychicHorror:IsReady(unitID) then 
            return A.PsychicHorror
        end

        if A.PsychicScream:IsReady(player) then
			local namePlateUnitID
			for namePlateUnitID in pairs(ActiveUnitPlates) do   
                useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(namePlateUnitID, nil, nil, true)              
				if useCC and Unit(namePlateUnitID):IsPlayer() and not Unit(namePlateUnitID):IsNPC() and not Unit(namePlateUnitID):IsTotem() and A.IsUnitEnemy(namePlateUnitID) and Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 8 and A.PsychicScream:AbsentImun(namePlateUnitID, Temp.DisableMag) then 
					return A.PsychicScream:Show(icon)
				end 
			end
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
    
   	    if useRacial and A.BullRush:AutoRacial(ununitIDit) then 
            return A.BullRush
   	    end 
    end
end

local function Purge(unitID)

    if A.DispelMagic:IsReady(unitID) and (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) then 
		return A.DispelMagic
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

        -- actions.trinkets=use_item,name=scars_of_fraternal_strife,if=(!buff.scars_of_fraternal_strife_4.up&time>1)|(buff.voidform.up|buff.power_infusion.up|buff.dark_ascension.up|cooldown.void_eruption.remains>10)
        -- actions.trinkets+=/use_item,name=macabre_sheet_music,if=cooldown.void_eruption.remains>10|cooldown.dark_ascension.remains>10
        -- actions.trinkets+=/use_item,name=soulletting_ruby,if=buff.voidform.up|buff.power_infusion.up|buff.dark_ascension.up|cooldown.void_eruption.remains>10,target_if=min:target.health.pct
        -- # Use this on CD for max CDR
        -- actions.trinkets+=/use_item,name=architects_ingenuity_core
        -- # Default fallback for usable items: Use on cooldown in order by trinket slot.
        -- actions.trinkets+=/use_items,if=buff.voidform.up|buff.power_infusion.up|buff.dark_ascension.up|cooldown.void_eruption.remains>10

end

local function GetBuffsCount(ID, duration, source, byID)
	-- @usage GetBuffsCount(ID[, duration, source, byID])
	-- @return number 	 
    local total = 0
	for _, thisUnit in pairs(TeamCache.Friendly.GUIDs) do
		if Unit(thisUnit):HasBuffs(ID, source, byID) > (duration or 0) and A.FlashHeal:IsInRange(thisUnit) then
			total = total + 1
		end
	end
	
    return total 
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

    Player:AddTier("Tier29", { 200327, 200326, 200328, 200324, 200329, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

    local members = GetNumGroupMembers()
    if A.PowerWordFortitude:IsReady(player) and not inCombat and (GetBuffsCount(A.PowerWordFortitude.ID) < members or Unit(player):HasBuffs(A.PowerWordFortitude.ID) == 0) then
        return A.PowerWordFortitude:Show(icon)
    end

    local function EnemyRotation(unitID)


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

		local DoPurge = Purge(unitID)
		if DoPurge then 
			return DoPurge:Show(icon)
		end	

        if Temp.VampiricTouchDelay == 0 and Player:IsCasting() == A.VampiricTouch:Info() then
            Temp.VampiricTouchDelay = 60
            elseif Temp.VampiricTouchDelay > 0 then
            Temp.VampiricTouchDelay = Temp.VampiricTouchDelay - 1
        end

        -- actions.precombat+=/shadowform,if=!buff.shadowform.up
        if A.Shadowform:IsReady(player) and Unit(player):HasBuffs(A.Shadowform.ID) == 0 and Unit(player):HasBuffs(A.Voidform.ID) == 0 then
            return A.Shadowform:Show(icon)
        end
        -- actions.precombat+=/arcane_torrent
        if A.ArcaneTorrent:IsRacialReady(player, true) then
            return A.ArcaneTorrent:Show(icon)
        end

        -- actions.precombat+=/use_item,name=shadowed_orb_of_torment
        -- actions.precombat+=/variable,name=mind_sear_cutoff,op=set,value=2
        -- actions+=/variable,name=pool_amount,op=set,value=60
        local MindSearCutoff = 2
        local poolAmount = 60

        local petActive = Player:GetTotemTimeLeft(1) > 0
        local VTRefreshable = Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) < 6.2 and Temp.VampiricTouchDelay == 0
        local SWPRefreshable = Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) < 4.8


        if not inCombat then
            if A.ShadowCrash:IsReady(player) and A.ShadowWordPain:IsInRange(unitID) then
                return A.ShadowCrash:Show(icon)
            end
            if A.MindBlast:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.ShadowyInsight.ID) > 0) and A.Damnation:IsTalentLearned() then
                return A.MindBlast:Show(icon)
            end
            if A.VampiricTouch:IsReady(unitID) and not isMoving and VTRefreshable and (not A.Damnation:IsTalentLearned() or A.Damnation:GetCooldown() > 0) and not A.ShadowCrash:IsSpellInFlight() then
                return A.VampiricTouch:Show(icon)
            end        
        end

		if Unit(unitID):IsExplosives() then
            if A.ShadowWordDeath:IsReady(unitID) and A.DeathAndMadness:IsTalentLearned() and Player:InsanityDeficit() > 40 then
                return A.ShadowWordDeath:Show(icon)
            end
            if A.ShadowWordPain:IsReady(unitID) then
			    return A.ShadowWordPain:Show(icon)
            end
		end


        -- # Executed every time the actor is available.
        -- actions=variable,name=dp_cutoff,op=set,value=!talent.mind_sear|(spell_targets.mind_sear<=variable.mind_sear_cutoff&(!buff.mind_devourer.up|spell_targets.mind_sear=1))
        -- actions+=/variable,name=holding_crash,op=set,value=raid_event.adds.in<20
        -- actions+=/run_action_list,name=aoe,if=spell_targets.mind_sear>2|spell_targets.vampiric_touch>3
        -- actions+=/run_action_list,name=main


        local DPCutoff = not A.MindSear:IsTalentLearned() or (MultiUnits:GetActiveEnemies() <= MindSearCutoff and (Unit(player):HasBuffs(A.MindDevourer.ID) == 0 or MultiUnits:GetActiveEnemies() == 1))

        -- # Executed every time the actor is available.
        -- actions=potion,if=buff.voidform.up|buff.power_infusion.up|buff.dark_ascension.up
        -- actions+=/variable,name=dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking
        local dotsUp = Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) > 0
        -- actions+=/variable,name=all_dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking&dot.devouring_plague.ticking
        local allDotsUp = Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.DevouringPlague.ID, true) > 0
        -- actions+=/variable,name=max_vts,op=set,default=1,value=spell_targets.vampiric_touch
        local maxVTs = MultiUnits:GetActiveEnemies()
        -- actions+=/variable,name=max_vts,op=set,value=(spell_targets.mind_sear<=5)*spell_targets.mind_sear,if=buff.voidform.up

        -- actions+=/variable,name=is_vt_possible,op=set,value=0,default=1
        local isVTPossible = false
        -- actions+=/variable,name=is_vt_possible,op=set,value=1,target_if=max:(target.time_to_die*dot.vampiric_touch.refreshable),if=target.time_to_die>=18
        if Unit(unitID):TimeToDie() >= 18 then
            isVTPossible = true
        end
        -- actions+=/variable,name=vts_applied,op=set,value=active_dot.vampiric_touch>=variable.max_vts|!variable.is_vt_possible
        local VTsApplied = Player:GetDeBuffsUnitCount(A.VampiricTouch.ID) >= maxVTs or not isVTPossible
        -- actions+=/variable,name=pool_for_cds,op=set,value=(cooldown.void_eruption.remains<=gcd.max*3&talent.void_eruption|cooldown.dark_ascension.up&talent.dark_ascension)
        local poolForCDs = (A.VoidEruption:GetCooldown() <= A.GetGCD() * 3 and A.VoidEruption:IsTalentLearned() or A.DarkAscension:GetCooldown() == 0 and A.DarkAscension:IsTalentLearned())
        -- actions+=/variable,name=dp_cutoff,op=set,value=!talent.mind_sear|(spell_targets.mind_sear<=variable.mind_sear_cutoff&(!buff.mind_devourer.up|spell_targets.mind_sear=1))
        local DPCutoff = not A.MindSear:IsTalentLearned() or (MultiUnits:GetActiveEnemies() <= MindSearCutoff and (Unit(player):HasBuffs(A.MindDevourer.ID) == 0 or MultiUnits:GetActiveEnemies() == 1))

        -- actions+=/run_action_list,name=main
        local function Cooldowns(unitID)
              -- actions+=/fireblood,if=buff.power_infusion.up|fight_remains<=8
            if A.Fireblood:IsRacialReady(player) and (Unit(player):HasBuffs(A.PowerInfusion.ID) > 0 or Unit(unitID):TimeToDie() <= 8) then
                return A.Fireblood:Show(icon)
            end
            -- actions+=/berserking,if=buff.power_infusion.up|fight_remains<=12
            if A.Berserking:IsRacialReady(player) and (Unit(player):HasBuffs(A.PowerInfusion.ID) > 0 or Unit(unitID):TimeToDie() <= 12) then
                return A.Berserking:Show(icon)
            end
            -- actions+=/blood_fury,if=buff.power_infusion.up|fight_remains<=15
            if A.BloodFury:IsRacialReady(player) and (Unit(player):HasBuffs(A.PowerInfusion.ID) > 0 or Unit(unitID):TimeToDie() <= 15) then
                return A.BloodFury:Show(icon)
            end
            -- actions+=/ancestral_call,if=buff.power_infusion.up|fight_remains<=15
            if A.AncestralCall:IsRacialReady(player) and (Unit(player):HasBuffs(A.PowerInfusion.ID) > 0 or Unit(unitID):TimeToDie() <= 15) then
                return A.AncestralCall:Show(icon)
            end      
            
            -- actions.cds=power_infusion,if=(buff.voidform.up|buff.dark_ascension.up)
            if A.PowerInfusion:IsReady(player) and A.ShadowWordPain:IsInRange(unitID) and (Unit(player):HasBuffs(A.Voidform.ID) > 0 or Unit(player):HasBuffs(A.DarkAscension.ID) > 0) then
                return A.PowerInfusion
            end
            -- actions.cds+=/void_eruption,if=!cooldown.fiend.up&(pet.fiend.active|!talent.mindbender)&(cooldown.mind_blast.charges=0|time>15|buff.shadowy_insight.up&cooldown.mind_blast.charges=buff.shadowy_insight.stack)
            if A.VoidEruption:IsReady(player) and not isMoving then
                if A.ShadowWordPain:IsInRange(unitID) and A.Shadowfiend:GetCooldown() > 0 and (petActive or not A.Mindbender:IsTalentLearned()) and (A.MindBlast:GetSpellCharges() == A.MindBlast:GetSpellChargesMax() or Unit(player):CombatTime() > 15 or Unit(player):HasBuffs(A.ShadowyInsight.ID) > 0 and A.MindBlast:GetSpellCharges() == Unit(player):HasBuffsStacks(A.ShadowyInsight.ID)) then
                    return A.VoidEruption
                end
            end
            -- actions.cds+=/dark_ascension,if=pet.fiend.active&cooldown.mind_blast.charges<2|!talent.mindbender&!cooldown.fiend.up&cooldown.fiend.remains>=15
            if A.DarkAscension:IsReady(player) and not isMoving then
                if petActive and A.MindBlast:GetSpellChargesFullRechargeTime() < 2 or not A.Mindbender:IsTalentLearned() and A.Shadowfiend:GetCooldown() >= 15 then
                    return A.DarkAscension
                end
            end
            -- actions.cds+=/call_action_list,name=trinkets
            local UseTrinket = UseTrinkets(unitID)
            if UseTrinket then
                return UseTrinket
            end        
            -- actions.cds+=/mindbender,if=(dot.shadow_word_pain.ticking&variable.vts_applied|action.shadow_crash.in_flight)
            if A.Mindbender:IsReady(unitID) then
                if Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) > 0 and VTsApplied or A.ShadowCrash:IsSpellInFlight() then
                    return A.Mindbender
                end
            end
            -- actions.cds+=/mindbender,if=(dot.shadow_word_pain.ticking&variable.vts_applied|action.shadow_crash.in_flight)
            if A.Shadowfiend:IsReady(unitID) then
                if Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) > 0 and VTsApplied or A.ShadowCrash:IsSpellInFlight() then
                    return A.Shadowfiend
                end
            end
        end
        
        -- actions.main=call_action_list,name=cds
        local useCooldowns = Cooldowns(unitID)
        if useCooldowns and BurstIsON(unitID) and Unit(unitID):TimeToDie() >= 5 then
            return useCooldowns:Show(icon)
        end
        -- # Use Mind Blast when capped on charges and talented into Mind Devourer to fish for the buff. Only use when facing 3-7 targets.
        -- actions.main+=/mind_blast,if=cooldown.mind_blast.charges>=2&talent.mind_devourer&spell_targets.mind_sear>=3&spell_targets.mind_sear<=7&!buff.mind_devourer.up
        if A.MindBlast:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.ShadowyInsight.ID) > 0) and A.MindBlast:GetSpellChargesFullRechargeTime() < 2 and A.MindDevourer:IsTalentLearned() and MultiUnits:GetActiveEnemies() >= 3 and MultiUnits:GetActiveEnemies() <= 7 and Unit(player):HasBuffs(A.MindDevourer.ID) == 0 then
            return A.MindBlast:Show(icon)
        end
        -- actions.main+=/shadow_word_death,if=pet.fiend.active&talent.inescapable_torment&(pet.fiend.remains<=gcd|target.health.pct<20)&spell_targets.mind_sear<=7
        if A.ShadowWordDeath:IsReady(unitID) and petActive and A.InescapableTorment:IsTalentLearned() and Unit(unitID):HealthPercent() < 20 and MultiUnits:GetActiveEnemies() <= 7 then
            return A.ShadowWordDeath:Show(icon)
        end
        -- actions.main+=/mind_blast,if=(cooldown.mind_blast.full_recharge_time<=gcd.max|pet.fiend.remains<=cast_time+gcd.max)&pet.fiend.active&talent.inescapable_torment&pet.fiend.remains>cast_time&spell_targets.mind_sear<=7
        if A.MindBlast:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.ShadowyInsight.ID) > 0) then
            if A.MindBlast:GetSpellChargesFullRechargeTime() <= A.GetGCD() or (Player:GetTotemTimeLeft(1) <= (A.MindBlast:GetSpellCastTime() + A.GetGCD())) and petActive and A.InescapableTorment:IsTalentLearned() and (Player:GetTotemTimeLeft(1) > (A.MindBlast:GetSpellCastTime())) and MultiUnits:GetActiveEnemies() <= 7 then
                return A.MindBlast:Show(icon)
            end
        end
        -- actions.main+=/damnation,target_if=dot.vampiric_touch.refreshable&variable.is_vt_possible|dot.shadow_word_pain.refreshable
        if A.Damnation:IsReady(unitID) and (VTRefreshable and isVTPossible or SWPRefreshable) then
            return A.Damnation:Show(icon)
        end
        -- actions.main+=/void_bolt,if=variable.dots_up&insanity<=85
        if A.VoidBolt:IsReady(unitID) and dotsUp and Player:Insanity() <= 85 and Unit(player):HasBuffs(A.Voidform.ID) > 0 then
            return A.VoidBolt:Show(icon)
        end
        -- # Use Mind Devourer Procs on Mind Sear when facing 2 or more targets or Voidform is active.
        -- actions.main+=/mind_sear,target_if=(spell_targets.mind_sear>1|buff.voidform.up)&buff.mind_devourer.up
        if A.MindSear:IsReady(unitID) and not isMoving and (MultiUnits:GetActiveEnemies() > 1 or Unit(player):HasBuffs(A.Voidform.ID) > 0) and Unit(player):HasBuffs(A.MindDevourer.ID) > 0 then
            return A.MindSear:Show(icon)
        end
        -- # Use Mind Sear on 3+ targets and either you have at least 75 insanity, 4pc buff is inactive, or 2pc buff is at 3 stacks.
        -- actions.main+=/mind_sear,target_if=spell_targets.mind_sear>variable.mind_sear_cutoff&(insanity>=75|((!set_bonus.tier29_4pc&!set_bonus.tier29_2pc)|!buff.dark_reveries.up)|(!set_bonus.tier29_2pc|buff.gathering_shadows.stack=3)),chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
        if A.MindSear:IsReady(unitID) and not isMoving then
            if MultiUnits:GetActiveEnemies() > MindSearCutoff and (Player:Insanity() >= 75 or ((not T29has4P and not T29has2P) or Unit(player):HasBuffs(A.DarkReveries.ID) > 0) or (not T29has2P or Unit(player):HasBuffsStacks(A.GatheringShadows.ID) == 3)) then
                return A.MindSear:Show(icon)
            end
        end
        -- actions.main+=/devouring_plague,if=(refreshable&!variable.pool_for_cds|insanity>75|talent.void_torrent&cooldown.void_torrent.remains<=3*gcd|buff.mind_devourer.up&cooldown.mind_blast.full_recharge_time<=2*gcd.max&!cooldown.void_eruption.up&talent.void_eruption)&variable.dp_cutoff
        if A.DevouringPlague:IsReady(unitID) then
            if (not poolForCDs or Player:Insanity() > 75 or A.VoidTorrent:IsTalentLearned() and A.VoidTorrent:GetCooldown() <= (3 * A.GetGCD()) or Unit(player):HasBuffs(A.MindDevourer.ID) > 0 and A.MindBlast:GetSpellChargesFullRechargeTime() <= (2 * A.GetGCD()) and A.VoidEruption:GetCooldown() > 0 and A.VoidEruption:IsTalentLearned()) and DPCutoff then
                return A.DevouringPlague:Show(icon)
            end
        end
        -- actions.main+=/shadow_word_death,target_if=(target.health.pct<20&spell_targets.mind_sear<4)&(!talent.inescapable_torment|cooldown.fiend.remains>=10)|(pet.fiend.active&talent.inescapable_torment&spell_targets.mind_sear<=7)|buff.deathspeaker.up&(cooldown.fiend.remains+gcd.max)>buff.deathspeaker.remains
        if A.ShadowWordDeath:IsReady(unitID) then
            if (Unit(unitID):HealthPercent() < 20 and MultiUnits:GetActiveEnemies() < 4) and (not A.InescapableTorment:IsTalentLearned() or A.Shadowfiend:GetCooldown() >= 10) or (petActive and A.InescapableTorment:IsTalentLearned() and MultiUnits:GetActiveEnemies() <= 7) or Unit(player):HasBuffs(A.Deathspeaker.ID) > (A.Shadowfiend:GetCooldown() + A.GetGCD())
            then
                return A.ShadowWordDeath:Show(icon)
            end
        end
        -- actions.main+=/vampiric_touch,target_if=(refreshable&target.time_to_die>=18&(dot.vampiric_touch.ticking|!variable.vts_applied)&variable.max_vts>0|(talent.misery.enabled&dot.shadow_word_pain.refreshable))&cooldown.shadow_crash.remains>=dot.vampiric_touch.remains&!action.shadow_crash.in_flight
        if A.VampiricTouch:IsReady(unitID) and not isMoving and Temp.VampiricTouchDelay == 0 then
            if (VTRefreshable and Unit(unitID):TimeToDie() >= 18 and (Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) > 0 or not VTsApplied) and maxVTs > 0 or (A.Misery:IsTalentLearned() and SWPRefreshable)) and A.ShadowCrash:GetCooldown() >= Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) and not A.ShadowCrash:IsSpellInFlight() then
                return A.VampiricTouch:Show(icon)
            end
        end

        -- actions.main+=/shadow_word_pain,target_if=refreshable&target.time_to_die>=18&!talent.misery.enabled
        if A.ShadowWordPain:IsReady(unitID) and SWPRefreshable and Unit(unitID):TimeToDie() >= 18 and not A.Misery:IsTalentLearned() then
            return A.ShadowWordPain:Show(icon)
        end
        -- actions.main+=/mind_blast,if=variable.vts_applied&(!buff.mind_devourer.up|cooldown.void_eruption.up&talent.void_eruption)
        if A.MindBlast:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.ShadowyInsight.ID) > 0) and VTsApplied and (Unit(player):HasBuffs(A.MindDevourer.ID) == 0 or A.VoidEruption:GetCooldown() > 0 and A.VoidEruption:IsTalentLearned()) then
            return A.MindBlast:Show(icon)
        end
        -- actions.main+=/mindgames,if=spell_targets.mind_sear<5&variable.all_dots_up
        if A.Mindgames:IsReady(unitID) and not isMoving and MultiUnits:GetActiveEnemies() < 5 and allDotsUp then
            return A.Mindgames:Show(icon)
        end
        -- actions.main+=/shadow_crash,if=raid_event.adds.in>10
        if A.ShadowCrash:IsReady(player) and A.ShadowWordPain:IsInRange(unitID) then
            return A.ShadowCrash:Show(icon)
        end
        -- actions.main+=/dark_void,if=raid_event.adds.in>20
        if A.DarkVoid:IsReady(unitID) and not isMoving then
            return A.DarkVoid:Show(icon)
        end
        -- actions.main+=/devouring_plague,if=buff.voidform.up&variable.dots_up&variable.dp_cutoff
        if A.DevouringPlague:IsReady(unitID) and Unit(player):HasBuffs(A.Voidform.ID) > 0 and dotsUp and DPCutoff then
            return A.DevouringPlague:Show(icon)
        end
        -- actions.main+=/void_torrent,if=insanity<=35,target_if=variable.dots_up
        if A.VoidTorrent:IsReady(unitID) and Player:Insanity() <=5 and dotsUp then
            return A.VoidTorrent:Show(icon)
        end
        -- actions.main+=/mind_blast,if=raid_event.movement.in>cast_time+0.5&(!talent.inescapable_torment|!cooldown.fiend.up&talent.inescapable_torment|variable.vts_applied)
        if A.MindBlast:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.ShadowyInsight.ID) > 0) and (not A.InescapableTorment:IsTalentLearned() or A.Shadowfiend:GetCooldown() > 0 and A.InescapableTorment:IsTalentLearned() or VTsApplied) then
            return A.MindBlast:Show(icon)
        end
        -- actions.main+=/vampiric_touch,if=buff.unfurling_darkness.up
        if A.VampiricTouch:IsReady(unitID) and Unit(player):HasBuffs(A.UnfurlingDarkness.ID) > 0 and Temp.VampiricTouchDelay == 0 then
            return A.VampiricTouch:Show(icon)
        end
        -- actions.main+=/mind_flay,if=buff.mind_flay_insanity.up&variable.dots_up&(!buff.surge_of_darkness.up|talent.screams_of_the_void)
        if A.MindFlay:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.MindFlayInsanity.ID) > 0 and (Unit(player):HasBuffs(A.SurgeofDarkness.ID) == 0 or A.ScreamsoftheVoid:IsTalentLearned()) then
            return A.MindFlay:Show(icon)
        end
        -- # Use Halo if all DoTS are active and you are not in Voidform or it will hit at least 2 targets. Save up to 20s if adds are coming soon.
        -- actions.main+=/halo,if=raid_event.adds.in>20&(spell_targets.halo>1|(variable.all_dots_up&!buff.voidform.up))
        if A.Halo:IsReady(player) and not isMoving and Unit(unitID):GetRange() <= 30 and (MultiUnits:GetActiveEnemies() > 1 or (allDotsUp and Unit(player):HasBuffs(A.Voidform.ID) == 0)) then
            return A.Halo:Show(icon)
        end
        -- # Use when it will hit at least 2 targets.
        -- actions.main+=/divine_star,if=spell_targets.divine_star>1
        if A.DivineStar:IsReady(unitID) and Unit(unitID):GetRange() <= 30 and MultiUnits:GetActiveEnemies() > 1 then
            return A.DivineStar:Show(icon)
        end
        -- actions.main+=/lights_judgment,if=!raid_event.adds.exists|raid_event.adds.in>75
        if A.LightsJudgment:IsRacialReady(unitID) then
            return A.LightsJudgment:Show(icon)
        end
        -- actions.main+=/mind_spike,if=buff.surge_of_darkness.up|(!talent.mental_decay|dot.vampiric_touch.remains>=(cooldown.shadow_crash.remains+action.shadow_crash.travel_time))&(talent.mind_melt|!talent.idol_of_cthun)
        if A.MindSpike:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.SurgeofDarkness.ID) > 0) then
            if Unit(player):HasBuffs(A.SurgeofDarkness.ID) > 0 or (not A.MentalDecay:IsTalentLearned() or Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) >= A.ShadowCrash:GetCooldown()) and (A.MindMelt:IsTalentLearned() or not A.IdolofCthun:IsTalentLearned()) then
                return A.MindSpike:Show(icon)
            end
        end
        -- actions.main+=/mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
        if A.MindFlay:IsReady(unitID) and not isMoving then
            return A.MindFlay:Show(icon)
        end
        -- # Use Shadow Crash while moving as a low-priority action when adds will not come in 30 seconds.
        -- actions.main+=/shadow_crash,if=raid_event.adds.in>30
        if A.ShadowCrash:IsReady(player) and A.ShadowWordPain:IsInRange(unitID) then
            return A.ShadowCrash:Show(icon)
        end
        -- # Use Shadow Word: Death while moving as a low-priority action in execute
        -- actions.main+=/shadow_word_death,target_if=target.health.pct<20
        if A.ShadowWordDeath:IsReady(unitID) and Unit(unitID):HealthPercent() < 20 then
            return A.ShadowWordDeath:Show(icon)
        end
        -- # Use Divine Star while moving as a low-priority action
        -- actions.main+=/divine_star
        if A.DivineStar:IsReady(unitID) and Unit(unitID):GetRange() < 30 then
            return A.DivineStar:Show(icon)
        end
        -- # Use Shadow Word: Death while moving as a low-priority action
        -- actions.main+=/shadow_word_death
        if A.ShadowWordDeath:IsReady(unitID) then
            return A.ShadowWordDeath:Show(icon)
        end
        -- # Use Shadow Word: Pain while moving as a low-priority action
        -- actions.main+=/shadow_word_pain
        if A.ShadowWordPain:IsReady(unitID) then
            return A.ShadowWordPain:Show(icon)
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