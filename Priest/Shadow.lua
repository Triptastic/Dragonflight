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
    PsychicLink      	        = Action.Create({ Type = "Spell", ID = 199484, Hidden = true   }),
    Quaking                         = Action.Create({ Type = "Spell", ID = 240447, Hidden = true  }),
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
    },
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

	local quakingTime = 99
	if Unit(player):HasDeBuffs(A.Quaking.ID) > 0 then
		quakingTime = Unit(player):HasDeBuffs(A.Quaking.ID)
	end

    Player:AddTier("Tier29", { 200327, 200326, 200328, 200324, 200329, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

    local members = GetNumGroupMembers()
    if A.PowerWordFortitude:IsReady(player) and not inCombat and (GetBuffsCount(A.PowerWordFortitude.ID) < members or Unit(player):HasBuffs(A.PowerWordFortitude.ID) == 0) then
        return A.PowerWordFortitude:Show(icon)
    end

	if Unit(player):IsCastingRemains() > quakingTime + 0.5 then
		return A:Show(icon, ACTION_CONST_STOPCAST)	
	end

	if A.Fade:IsReady(player) then
		local playerstatus = UnitThreatSituation(player)
		if (Unit(player):InParty() and (Unit(player):IsTanking() or playerstatus == 3)) or (LoC:Get("SNARE") > 0 and A.Phantasm:IsTalentLearned()) then
			return A.Fade:Show(icon)
		end
	end

    local function EnemyRotation(unitID)

        local petTime = Player:GetTotemTimeLeft(1)
        local useVT = Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) < A.VampiricTouch:GetSpellPandemicThreshold() and Unit(unitID):TimeToDie() > 15 and not A.ShadowCrash:IsSpellInFlight() and Player:IsCasting() ~= A.VampiricTouch:Info()
        local useSWP = Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) < A.ShadowWordPain:GetSpellPandemicThreshold() and Unit(unitID):TimeToDie() > 15 and not A.ShadowCrash:IsSpellInFlight() and Player:IsCasting() ~= A.VampiricTouch:Info()
        local usePet = A.Mindbender:IsTalentLearned() and Unit(unitID):TimeToDie() > 15
        local useCooldowns = (BurstIsON(unitID) or Unit(unitID):IsBoss()) and Unit(unitID):TimeToDie() > 20     
        local dotsUp = Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) > 0
        local allDotsUp = Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.DevouringPlague.ID, true) > 0
        local VTsApplied = Player:GetDeBuffsUnitCount(A.VampiricTouch.ID) >= MultiUnits:GetActiveEnemies()       
        local poolForCDs = (A.VoidEruption:GetCooldown() <= A.GetGCD() * 3 and A.VoidEruption:IsTalentLearned() or A.DarkAscension:GetCooldown() == 0 and A.DarkAscension:IsTalentLearned())

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

        if A.Shadowform:IsReady(player) and Unit(player):HasBuffs(A.Shadowform.ID) == 0 and Unit(player):HasBuffs(A.Voidform.ID) == 0 then
            return A.Shadowform:Show(icon)
        end

        if A.ArcaneTorrent:IsRacialReady(player, true) then
            return A.ArcaneTorrent:Show(icon)
        end

        if not inCombat then
            if A.ShadowCrash:IsReady(player) and A.ShadowWordPain:IsInRange(unitID) and BurstIsON(unitID) then
                return A.ShadowCrash:Show(icon)
            end
            if A.MindBlast:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.ShadowyInsight.ID) > 0) and A.Damnation:IsTalentLearned() then
                return A.MindBlast:Show(icon)
            end
            if A.VampiricTouch:IsReady(unitID) and not isMoving and useVT then
                return A.VampiricTouch:Show(icon)
            end        
        end

        if Unit(player):IsCastingRemains() < 0.5 and A.ShadowWordPain:IsInRange(unitID) and Player:IsChanneling() ~= A.MindSear:Info() and Player:IsChanneling() ~= A.MindFlay:Info() and Player:IsChanneling() ~= A.MindFlayInsanity:Info() and Player:IsChanneling() ~= A.VoidTorrent:Info() then

            if Unit(unitID):IsExplosives() then
                if A.ShadowWordDeath:IsReady(unitID, nil, nil, true) and A.DeathAndMadness:IsTalentLearned() and Player:InsanityDeficit() > 40 then
                    return A.ShadowWordDeath:Show(icon)
                end
                if A.ShadowWordPain:IsReady(unitID, nil, nil, true) then
                    return A.ShadowWordPain:Show(icon)
                end
            end

            if A.VampiricTouch:IsReady(unitID, nil, nil, true) and not isMoving and useVT then
                return A.VampiricTouch:Show(icon)
            end
            if A.ShadowWordPain:IsReady(unitID, nil, nil, true) and useSWP then
                return A.ShadowWordPain:Show(icon)
            end
            if A.Mindbender:IsReady(unitID, nil, nil, true) and usePet then
                return A.Mindbender:Show(icon)
            end
            if A.Shadowfiend:IsReady(unitID, nil, nil, true) and useCooldowns then
                return A.Shadowfiend:Show(icon)
            end
            if (A.DarkAscension:IsReady(player, nil, nil, true) or A.VoidEruption:IsReady(player, nil, nil, true)) and not isMoving and useCooldowns then
                return A.DarkAscension:Show(icon)
            end
            if A.PowerInfusion:IsReady(player, nil, nil, true) and Unit(player):HasBuffs(A.DarkAscension.ID) > 0 or Unit(player):HasBuffs(A.Voidform.ID) > 0 then
                local UseTrinket = UseTrinkets(unitID)
                if UseTrinket then
                    return UseTrinket
                end 
                return A.PowerInfusion:Show(icon)
            end
            if A.MindSear:IsReady(unitID, nil, nil, true) and not isMoving and (Unit(player):HasBuffs(A.MindDevourer.ID) > 0 or Player:Insanity() >= 100) and MultiUnits:GetActiveEnemies() >= 3 and Player:IsCasting() ~= A.MindSear:Info() then
                return A.MindSear:Show(icon)
            end
            if A.DevouringPlague:IsReady(unitID, nil, nil, true) and Player:Insanity() >= 100 then
                return A.DevouringPlague:Show(icon)
            end
            if A.ShadowWordDeath:IsReady(unitID, nil, nil, true) and A.InescapableTorment:IsTalentLearned() and petTime > 0 then
                return A.ShadowWordDeath:Show(icon)
            end
            if A.MindBlast:IsReady(unitID, nil, nil, true) and (not isMoving or Unit(player):HasBuffs(A.ShadowyInsight.ID) > 0) and A.InescapableTorment:IsTalentLearned() and petTime > A.MindBlast:GetSpellCastTime() and Player:IsCasting() ~= A.MindBlast:Info() then
                return A.MindBlast:Show(icon)
            end
            if A.VoidBolt:IsReady(unitID, nil, nil, true) and Unit(player):HasBuffs(A.Voidform.ID) > 0 then
                return A.VoidBolt:Show(icon)
            end
            if A.MindBlast:IsReady(unitID, nil, nil, true) and (not isMoving or Unit(player):HasBuffs(A.ShadowyInsight.ID) > 0) and A.MindBlast:GetSpellChargesFullRechargeTime() < A.MindBlast:GetSpellCastTime() and A.MindBlast:GetSpellChargesMax() >= 2 and Player:IsCasting() ~= A.MindBlast:Info() then
                return A.MindBlast:Show(icon)
            end
            if A.VoidTorrent:IsReady(unitID, nil, nil, true) and not isMoving and A.PsychicLink:IsTalentLearned() and MultiUnits:GetActiveEnemies() >= 3 and Player:IsCasting() ~= A.VoidTorrent:Info() then
                if A.MindSear:IsReady(unitID, nil, nil, true) and Player:IsCasting() ~= A.MindSear:Info() then
                    return A.MindSear:Show(icon)
                end
            end
            if A.Mindgames:IsReady(unitID, nil, nil, true) and not isMoving and A.PsychicLink:IsTalentLearned() and MultiUnits:GetActiveEnemies() >= 3 and Player:IsCasting() ~= A.Mindgames:Info() then
                return A.Mindgames:Show(icon)
            end
            if A.MindSear:IsReady(unitID, nil, nil, true) and not isMoving and MultiUnits:GetActiveEnemies() >= 3 and Player:IsCasting() ~= A.MindSear:Info() then
                return A.MindSear:Show(icon)
            end
            if A.DevouringPlague:IsReady(unitID, nil, nil, true) and Unit(unitID):TimeToDie() > 8 then
                return A.DevouringPlague:Show(icon)
            end
            if A.ShadowWordDeath:IsReady(unitID, nil, nil, true) and Unit(unitID):HealthPercent() <= 20 then
                return A.ShadowWordDeath:Show(icon)
            end
            if A.MindBlast:IsReady(unitID, nil, nil, true) and (not isMoving or Unit(player):HasBuffs(A.ShadowyInsight.ID) > 0) and Player:IsCasting() ~= A.MindBlast:Info() then
                return A.MindBlast:Show(icon)
            end
            if A.Mindgames:IsReady(unitID, nil, nil, true) and not isMoving and allDotsUp and A.DarkAscension:GetCooldown() > 15 and MultiUnits:GetActiveEnemies() < 5 and Player:IsCasting() ~= A.Mindgames:Info() then
                return A.Mindgames:Show(icon)
            end
            if A.ShadowCrash:IsReady(player, nil, nil, true) and BurstIsON(unitID) then
                return A.ShadowCrash:Show(icon)
            end
            if A.VoidTorrent:IsReady(unitID, nil, nil, true) and not isMoving and allDotsUp and Player:Insanity() < 35 and Player:IsCasting() ~= A.VoidTorrent:Info() then
                return A.VoidTorrent:Show(icon)
            end
            if A.Halo:IsReady(player, nil, nil, true) and not isMoving and MultiUnits:GetActiveEnemies() >= 2 and Player:IsCasting() ~= A.Halo:Info() then
                return A.Halo:Show(icon)
            end
            if A.DivineStar:IsReady(player, nil, nil, true) and MultiUnits:GetActiveEnemies() >= 2 then
                return A.DivineStar:Show(icon)
            end
            if A.MindFlay:IsReady(unitID, nil, nil, true) and not isMoving and Unit(player):HasBuffs(A.MindFlayInsanity.ID) > 0 and A.IdolofCthun:IsTalentLearned() and Player:IsCasting() ~= A.MindFlay:Info() then
                return A.MindFlay:Show(icon)
            end
            if A.MindSpike:IsReady(unitID, nil, nil, true) and Unit(player):HasBuffs(A.SurgeofDarkness.ID) > 0 and not A.IdolofCthun:IsTalentLearned() then
                return A.MindSpike:Show(icon)
            end
            if A.MindFlay:IsReady(unitID, nil, nil, true) and not isMoving and Unit(player):HasBuffs(A.MindFlayInsanity.ID) > 0 and not A.IdolofCthun:IsTalentLearned() and Player:IsCasting() ~= A.MindFlay:Info() then
                return A.MindFlay:Show(icon)
            end
            if A.MindFlay:IsReady(unitID, nil, nil, true) and not isMoving and A.IdolofCthun:IsTalentLearned() and Player:IsCasting() ~= A.MindFlay:Info() then
                return A.MindFlay:Show(icon)
            end
            if A.MindSpike:IsReady(unitID, nil, nil, true) and (not isMoving or Unit(player):HasBuffs(A.SurgeofDarkness.ID) > 0) and not A.IdolofCthun:IsTalentLearned() and not Player:IsCasting() ~= A.MindSpike:Info() then
                return A.MindSpike:Show(icon)
            end
            if A.ShadowWordDeath:IsReady(unitID, nil, nil, true) then
                return A.ShadowWordDeath:Show(icon)
            end
            if A.DivineStar:IsReady(player, nil, nil, true) then
                return A.DivineStar:Show(icon)
            end
            if A.ShadowWordPain:IsReady(player, nil, nil, true) then
                return A.ShadowWordPain:Show(icon)
            end
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