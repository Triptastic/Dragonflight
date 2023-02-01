--##############################
--##### TRIP'S HOLY PRIEST #####
--##############################

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
local HealingEngine                           	= Action.HealingEngine
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

Action[ACTION_CONST_PRIEST_HOLY] = {
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
    Smite				        = Action.Create({ Type = "Spell", ID = 585   }),
    MindBlast				    = Action.Create({ Type = "Spell", ID = 8092   }),
    MindFlay				    = Action.Create({ Type = "Spell", ID = 15407   }),
    Fade				        = Action.Create({ Type = "Spell", ID = 586   }),
	Phantasm			        = Action.Create({ Type = "Spell", ID = 108942   }),
    PowerWordShield				= Action.Create({ Type = "Spell", ID = 17   }),
    DesperatePrayer				= Action.Create({ Type = "Spell", ID = 19236   }),
    MindSoothe  				= Action.Create({ Type = "Spell", ID = 453   }),
    PsychicScream				= Action.Create({ Type = "Spell", ID = 8122   }),
    PowerWordFortitude			= Action.Create({ Type = "Spell", ID = 21562   }),	
    
    --Priest Class Talents
    Renew				        = Action.Create({ Type = "Spell", ID = 139   }),
    DispelMagic				    = Action.Create({ Type = "Spell", ID = 528   }),
    Shadowfiend				    = Action.Create({ Type = "Spell", ID = 34433   }),
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
	SurgeofLightBuff			= Action.Create({ Type = "Spell", ID = 114255, Hidden = true   }),
    PowerWordLife				= Action.Create({ Type = "Spell", ID = 373481   }),
    VoidShift   				= Action.Create({ Type = "Spell", ID = 108968   }),

    --Holy Talents
    HolyWordSerenity				= Action.Create({ Type = "Spell", ID = 2050   }),
	Heal							= Action.Create({ Type = "Spell", ID = 2060   }),
	Purify							= Action.Create({ Type = "Spell", ID = 527   }),
	HolyFire						= Action.Create({ Type = "Spell", ID = 14914   }),
	FlashHeal						= Action.Create({ Type = "Spell", ID = 2061   }),
	PrayerofHealing					= Action.Create({ Type = "Spell", ID = 596   }),
	GuardianSpirit					= Action.Create({ Type = "Spell", ID = 47788   }),
    HolyWordChastise				= Action.Create({ Type = "Spell", ID = 88625   }),
	HolyWordSanctify				= Action.Create({ Type = "Spell", ID = 34861   }),
	Censure							= Action.Create({ Type = "Spell", ID = 200199, Hidden = true   }),
	CircleofHealing					= Action.Create({ Type = "Spell", ID = 204883   }),
	SanctifiedPrayers				= Action.Create({ Type = "Spell", ID = 196489, Hidden = true   }),
	EmpyrealBlaze					= Action.Create({ Type = "Spell", ID = 372616   }),    
	EmpyrealBlazeBuff				= Action.Create({ Type = "Spell", ID = 372617   }), 
	PrayerCircle					= Action.Create({ Type = "Spell", ID = 321379, Hidden = true   }),
	HealingChorus					= Action.Create({ Type = "Spell", ID = 390885, Hidden = true   }),
	TrailofLight					= Action.Create({ Type = "Spell", ID = 200128, Hidden = true   }),
	DivineHymn						= Action.Create({ Type = "Spell", ID = 64843,   }),
	SymbolofHope					= Action.Create({ Type = "Spell", ID = 64901,   }),
	Apotheosis						= Action.Create({ Type = "Spell", ID = 200183   }),
	HolyWordSalvation				= Action.Create({ Type = "Spell", ID = 265202   }),
	Lightweaver						= Action.Create({ Type = "Spell", ID = 390992, Hidden = true   }),
	LightweaverBuff					= Action.Create({ Type = "Spell", ID = 390993, Hidden = true   }),
	Lightwell						= Action.Create({ Type = "Spell", ID = 372835   }),
	DivineWord						= Action.Create({ Type = "Spell", ID = 372760   }),
	ArcaneBravery					= Action.Create({ Type = "Spell", ID = 385841, Hidden = true   }),	
	GrievousWounds					= Action.Create({ Type = "Spell", ID = 240559, Hidden = true   }),
	SpiritofRedemption				= Action.Create({ Type = "Spell", ID = 27827, Hidden = true   }),
	Healthstone     = Action.Create({ Type = "Item", ID = 5512 }),
	--PvP
	SpiritoftheRedeemer				= Action.Create({ Type = "Spell", ID = 215982   }),	
	DivineAscension					= Action.Create({ Type = "Spell", ID = 328530, Texture = 38606   }),	
	DivineAscensionBuff				= Action.Create({ Type = "Spell", ID = 329543   }),
}

local A = setmetatable(Action[ACTION_CONST_PRIEST_HOLY], { __index = Action })

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
}

TMW:RegisterCallback("TMW_ACTION_HEALINGENGINE_UNIT_UPDATE", function(callbackEvent, thisUnit, db, QueueOrder)
	local unitID  = thisUnit.Unit
	local unitHP  = thisUnit.realHP
	local Role    = thisUnit.Role
    local Cleanse = A.GetToggle(2, "Cleanse")
	-- Dispel
	if A.Purify:IsReady(unitID) and Cleanse then
		if thisUnit.useDispel and not QueueOrder.useDispel[Role] and AuraIsValid(unitID, "UseDispel", "Dispel") then
			QueueOrder.useDispel[Role] = true
		
			if thisUnit.isSelf then
				thisUnit:SetupOffsets(db.OffsetSelfDispel, 10)
			elseif Role == "HEALER" then
				thisUnit:SetupOffsets(db.OffsetHealersDispel, 20)
			elseif Role == "TANK" then
				thisUnit:SetupOffsets(db.OffsetTanksDispel, 15)
			else
				thisUnit:SetupOffsets(db.OffsetDamagersDispel, 15)
			end
			return
		end
	end
	--SpiritofRedemption
	if Unit(unitID):HasBuffs(A.SpiritoftheRedeemer.ID) > 0 or Unit(unitID):HasBuffs(A.SpiritofRedemption.ID) > 0 or Unit(unitID):HasBuffs(A.ArcaneBravery.ID) > 0 then
		thisUnit.Enabled = false
	else thisUnit.Enabled = true
	end

end)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 or Unit(player):HasBuffs(A.SpiritoftheRedeemer.ID) > 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end  

	local Healthstone = A.GetToggle(2, "HealthstoneHP") 
	if Healthstone >= 0 then 
		if A.Healthstone:IsReadyByPassCastGCD(player) then 					
			if Healthstone >= 100 then -- AUTO 
				if Unit(player):TimeToDie() <= 9 and Unit(player):HealthPercent() <= 40 then 
					return A.Healthstone
				end 
			elseif Unit(player):HealthPercent() <= Healthstone then 
				return A.Healthstone							 
			end
		end
	end

	if A.SpiritoftheRedeemer:IsReady(player) and A.SpiritoftheRedeemer:IsTalentLearned() and Unit(player):HealthPercent() <= 20 and Unit(player):HasBuffs(A.DivineAscensionBuff.ID) == 0 then
		return A.SpiritoftheRedeemer
	end

	if A.DivineAscension:IsReady(player) and Unit(player):HealthPercent() <= 50 then
		return A.DivineAscension
	end

    local DesperatePrayerHP = A.GetToggle(2, "DesperatePrayerHP")
	if A.DesperatePrayer:IsReady(player) and Unit(player):HealthPercent() <= DesperatePrayerHP then
		return A.DesperatePrayer
	end

	-- Stoneform on self dispel (only PvE)
	if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
		return A.Stoneform
	end 

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        -- Silence
        if useCC and A.HolyWordChastise:IsReady(unitID) and A.Censure:IsTalentLearned() then 
			if A.DivineWord:IsReady(player) then
				return A.DivineWord
			end
            return A.HolyWordChastise
        end

        if A.PsychicScream:IsReady(player) then
			local namePlateUnitID
			for namePlateUnitID in pairs(ActiveUnitPlates) do   
                useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(namePlateUnitID, nil, nil, true)              
				if useCC and Unit(namePlateUnitID):IsPlayer() and not Unit(namePlateUnitID):IsNPC() and not Unit(namePlateUnitID):IsTotem() and A.IsUnitEnemy(namePlateUnitID) and Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 8 and A.PsychicScream:AbsentImun(namePlateUnitID, Temp.DisableMag) then 
					return A.PsychicScream
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

local function Cleanse(unitID)
    
    local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
    local unitGUID = UnitGUID(unitID)  

    if A.Purify:IsReady(unitID) and useDispel and AuraIsValid(unitID, "UseDispel", "Dispel") then
        return A.Purify
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

local function HealCalc(heal)

	local healamount = 0
	local globalhealmod = A.GetToggle(2, "globalhealmod")
	
	if heal == A.FlashHeal then
		healamount = A.FlashHeal:GetSpellDescription()[1]
	elseif heal == A.Heal then
		healamount = A.Heal:GetSpellDescription()[1]
    elseif heal == A.PrayerofHealing then
		healamount = A.PrayerofHealing:GetSpellDescription()[2]
    elseif heal == A.CircleofHealing then
		healamount = A.CircleofHealing:GetSpellDescription()[2]
    elseif heal == A.Halo then
		healamount = A.Halo:GetSpellDescription()[3]
	elseif heal == A.DivineStar then
		healamount = A.DivineStar:GetSpellDescription()[3] * 2
	elseif heal == A.HolyWordSanctify then
		healamount = A.HolyWordSanctify:GetSpellDescription()[1]
	elseif heal == A.HolyWordSerenity then
		healamount = A.HolyWordSerenity:GetSpellDescription()[1]
	end

	return (healamount * 1000) * globalhealmod

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
    local isMoving = Player:IsMoving() and Unit(player):HasBuffs(A.DivineAscensionBuff.ID) == 0
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
	local getmembersAll = HealingEngine.GetMembersAll()

    Player:AddTier("Tier29", { 200327, 200326, 200328, 200324, 200329, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

    if A.PowerWordFortitude:IsReady(player) and not inCombat and not A.IsInPVP and (GetBuffsCount(A.PowerWordFortitude.ID) < TeamCache.Friendly.Size or Unit(player):HasBuffs(A.PowerWordFortitude.ID) == 0) then
        return A.PowerWordFortitude:Show(icon)
    end

	if A.Fade:IsReady(player) then
		local playerstatus = UnitThreatSituation(player)
		if (Unit(player):InParty() and (Unit(player):IsTanking() or playerstatus == 3)) or (LoC:Get("SNARE") > 0 and A.Phantasm:IsTalentLearned()) then
			return A.Fade:Show(icon)
		end
	end

	if A.IsInPvP then
		if A.PsychicScream:IsReady(player) then
			local namePlateUnitID
			for namePlateUnitID in pairs(ActiveUnitPlates) do                 
				if Unit(namePlateUnitID):IsPlayer() and not Unit(namePlateUnitID):IsNPC() and not Unit(namePlateUnitID):IsTotem() and A.IsUnitEnemy(namePlateUnitID) and Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 8 and A.PsychicScream:AbsentImun(namePlateUnitID, Temp.DisableMag) then 
					return A.PsychicScream:Show(icon)
				end 
			end
		end

		if A.VoidTendrils:IsReady(player) then
			local namePlateUnitID
			for namePlateUnitID in pairs(ActiveUnitPlates) do                 
				if Unit(namePlateUnitID):IsPlayer() and not Unit(namePlateUnitID):IsNPC() and not Unit(namePlateUnitID):IsTotem() and A.IsUnitEnemy(namePlateUnitID) and Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 8 and A.PsychicScream:AbsentImun(namePlateUnitID, Temp.DisableMag) then 
					return A.VoidTendrils:Show(icon)
				end 
			end
		end
	end

	local function HealingRotation(unitID)

		local HealHP = A.GetToggle(2, "HealHP")
		local FlashHealHP = A.GetToggle(2, "FlashHealHP")
		local CircleofHealingHP = A.GetToggle(2, "CircleofHealingHP")
		local HaloHP = A.GetToggle(2, "HaloHP")
		local DivineStarHP = A.GetToggle(2, "DivineStarHP")
		local HWSanctifyHP = A.GetToggle(2, "HWSanctifyHP")
		local HWSerenityHP = A.GetToggle(2, "HWSerenityHP")
		local PrayerofHealingHP = A.GetToggle(2, "PrayerofHealingHP")
		local GuardianSpiritHP = A.GetToggle(2, "GuardianSpiritHP")
		local VoidShiftPlayer = A.GetToggle(2, "VoidShiftPlayer")
		local VoidShiftTarget = A.GetToggle(2, "VoidShiftTarget")		
		local useCleanse = A.GetToggle(2, "Cleanse")

		if A.FlashHeal:IsReady(unitID) and not inCombat and Unit(unitID):HasDeBuffs(A.GrievousWounds.ID) > 0 then
			return A.FlashHeal:Show(icon)
		end

		if A.GuardianSpirit:IsReady(unitID) and Unit(unitID):HealthPercent() <= GuardianSpiritHP and inCombat then
			return A.GuardianSpirit:Show(icon)
		end

		local UseTrinket = UseTrinkets(unitID)
		if UseTrinket then
			return UseTrinket:Show(icon)
		end  

		if A.Apotheosis:IsReady(player) and inCombat and (MultiUnits:GetByRangeCasting(60, 1, nil, Temp.scaryCasts) >= 1 or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1) and A.HolyWordSerenity:GetCooldown() > 0 and A.HolyWordSanctify:GetCooldown() > 0 then
			return A.Apotheosis:Show(icon)
		end

		if A.PowerWordLife:IsReady(unitID) and Unit(unitID):HealthPercent() < 35 then
			return A.PowerWordLife:Show(icon)
		end

		if A.VoidShift:IsReady(unitID) and Unit(unitID):HealthPercent() <= VoidShiftTarget and Unit(player):HealthPercent() >= VoidShiftPlayer then
			return A.VoidShift:Show(icon)
		end

        local Cleanses = Cleanse(unitID)
        if Cleanses then 
            return Cleanses:Show(icon)
        end 

		--[[if A.Purify:IsReady(unitID) and useCleanse then
			for i = 1, #getmembersAll do 
				if A.Purify:IsInRange(getmembersAll[i].Unit) and not Unit(getmembersAll[i].Unit):IsDead() and AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Dispel") then  
					HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
				end                
			end
		end]]

		local sanctifyTotal = 0
		if A.HolyWordSanctify:IsReady(player) then
			if HWSanctifyHP >= 100 then
				for _, sanctifyUnit in pairs(TeamCache.Friendly.GUIDs) do
					if Unit(sanctifyUnit):HealthDeficit() >= HealCalc(A.HolyWordSanctify) and Unit(sanctifyUnit):GetRange() <= 10 and not Unit(sanctifyUnit):InVehicle() then
						sanctifyTotal = sanctifyTotal + 1
					end
					if sanctifyTotal >= 3 then
						sanctifyTotal = 0
						if A.DivineWord:IsReady(player) then
							return A.DivineWord:Show(icon)
						end
						return A.HolyWordSanctify:Show(icon)
					end 
				end
			elseif HWSanctifyHP <= 99 then
				if HealingEngine.GetBelowHealthPercentUnits(HWSanctifyHP, 10) >= 3 then
					if A.DivineWord:IsReady(player) then
						return A.DivineWord:Show(icon)
					end
					return A.HolyWordSanctify:Show(icon)
				end
			end
		end
	
		if A.HolyWordSerenity:IsReady(unitID) then
			if HWSerenityHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.HolyWordSerenity) then
					if A.DivineWord:IsReady(player) then
						return A.DivineWord:Show(icon)
					end
					return A.HolyWordSerenity:Show(icon)
				end
			elseif HWSerenityHP <= 99 then
				if Unit(unitID):HealthPercent() <= HWSerenityHP then
					if A.DivineWord:IsReady(player) then
						return A.DivineWord:Show(icon)
					end
					return A.HolyWordSerenity:Show(icon)
				end
			end
		end	
	
		local circleofhealingTotal = 0
		if A.CircleofHealing:IsReady(player) then
			if CircleofHealingHP >= 100 then
				for _, cohUnit in pairs(TeamCache.Friendly.GUIDs) do
					if Unit(cohUnit):HealthDeficit() >= HealCalc(A.CircleofHealing) and Unit(cohUnit):GetRange() <= 30 and not Unit(cohUnit):InVehicle() then
						circleofhealingTotal = circleofhealingTotal + 1
					end
					if circleofhealingTotal >= 3 then
						circleofhealingTotal = 0
						return A.CircleofHealing:Show(icon)
					end 
				end
			elseif CircleofHealingHP <= 99 then
				if HealingEngine.GetBelowHealthPercentUnits(CircleofHealingHP, 40) >= 3 then
					return A.CircleofHealing:Show(icon)
				end
			end	
		end

		local haloTotal = 0
		if A.Halo:IsReady(player) and not isMoving then
			if HaloHP >= 100 then
				for _, haloUnit in pairs(TeamCache.Friendly.GUIDs) do
					if Unit(haloUnit):HealthDeficit() >= HealCalc(A.Halo) and Unit(haloUnit):GetRange() <= 30 and not Unit(haloUnit):InVehicle() then
						haloTotal = haloTotal + 1
					end
					if haloTotal >= 3 then
						haloTotal = 0
						return A.Halo:Show(icon)
					end 
				end
			elseif HaloHP <= 99 then
				if HealingEngine.GetBelowHealthPercentUnits(HaloHP, 30) >= 3 then
					return A.Halo:Show(icon)
				end
			end	
		end

		local pohTotal = 0
		if A.PrayerofHealing:IsReady(player) and not A.Lightweaver:IsTalentLearned() and not isMoving then
			if PrayerofHealingHP >= 100 then
				for _, pohUnit in pairs(TeamCache.Friendly.GUIDs) do
					if Unit(pohUnit):HealthDeficit() >= HealCalc(A.PrayerofHealing) and Unit(pohUnit):GetRange() <= 30 and not Unit(pohUnit):InVehicle() and Unit(pohUnit):HasBuffs(14268) == 0 then
						pohTotal = pohTotal + 1
					end
					if pohTotal >= 3 then
						pohTotal = 0
						return A.PrayerofHealing:Show(icon)
					end 
				end
			elseif PrayerofHealingHP <= 99 then
				if HealingEngine.GetBelowHealthPercentUnits(PrayerofHealingHP, 40) >= 3 then
					return A.PrayerofHealing:Show(icon)
				end
			end	
		end
	
		if A.Heal:IsReady(unitID) and (not A.Lightweaver:IsTalentLearned() or Unit(player):HasBuffs(A.LightweaverBuff.ID) > 1) and not Player:IsMoving() and A.HolyWordSerenity:GetCooldown() > 0 then
			if HealHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.Heal) then
					return A.Heal:Show(icon)
				end
			elseif HealHP <= 99 then
				if Unit(unitID):HealthPercent() <= HealHP then
					return A.Heal:Show(icon)
				end
			end
		end
	
		if A.FlashHeal:IsReady(unitID) and Unit(player):HasBuffs(A.LightweaverBuff.ID) < 2 and (not Player:IsMoving() or Unit(player):HasBuffs(A.SurgeofLightBuff.ID) > 0) and A.HolyWordSerenity:GetCooldown() > 0 then
			if FlashHealHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.FlashHeal) then
					return A.FlashHeal:Show(icon)
				end
			elseif FlashHealHP <= 99 then
				if Unit(unitID):HealthPercent() <= FlashHealHP then
					return A.FlashHeal:Show(icon)
				end
			end
		end

		local alwaysPoM = A.GetToggle(2, "alwaysPoM")
		if A.PrayerofMending:IsReady(unitID) then
			if alwaysPoM or (not alwaysPoM and HealingEngine.GetBuffsCount(A.PrayerofMending.ID, nil, player) == 0) then
				return A.PrayerofMending:Show(icon)
			end
		end

		if A.FlashHeal:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.GrievousWounds.ID) > 0 then
			return A.FlashHeal:Show(icon)
		end

		if A.Renew:IsReady(unitID) and Unit(unitID):HasBuffs(A.Renew.ID, true) == 0 and Unit(unitID):HealthPercent() <= 90 then
			return A.Renew:Show(icon)
		end

		if A.SymbolofHope:IsReady(player) and Player:ManaPercentage() <= 70 and A.DesperatePrayer:GetCooldown() >= 60 and not isMoving then
			return A.SymbolofHope:Show(icon)
		end

	end

    local function EnemyRotation(unitID)

        -- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end
		
		local DoPurge = Purge(unitID)
		if DoPurge then 
			return DoPurge:Show(icon)
		end	

		local UseTrinket = UseTrinkets(unitID)
		if UseTrinket then
			return UseTrinket:Show(icon)
		end  

		if A.ShadowWordPain:IsReady(unitID) and Unit(unitID):IsExplosives() then
			return A.ShadowWordPain:Show(icon)
		end

		if A.HolyWordChastise:IsReady(unitID) and not A.Censure:IsTalentLearned() then
			if A.DivineWord:IsReady(player) then
				return A.DivineWord:Show(icon)
			end
			return A.HolyWordChastise:Show(icon)
		end

		if A.EmpyrealBlaze:IsReady(player) and A.HolyFire:GetCooldown() > 5 then
			return A.EmpyrealBlaze:Show(icon)
		end

		if A.HolyFire:IsReady(unitID) and (not isMoving or Unit(player):HasBuffs(A.EmpyrealBlazeBuff.ID) > 0) then
			return A.HolyFire:Show(icon)
		end

		if A.HolyNova:IsReady(player) and MultiUnits:GetByRangeInCombat(12, 5) >= 4 then
			return A.HolyNova:Show(icon)
		end

		if A.DivineStar:IsReady(player) and Unit(unitID):GetRange() <= 20 then
			return A.DivineStar:Show(icon)
		end

		if A.ShadowWordDeath:IsReady(unitID) and Unit(unitID):HealthPercent() <= 20 then
			return A.ShadowWordDeath:Show(icon)
		end

		if A.ShadowWordPain:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) <= 3 then
			return A.ShadowWordPain:Show(icon)
		end

		if A.Mindgames:IsReady(unitID) and not isMoving then
			return A.Mindgames:Show(icon)
		end

		if A.Smite:IsReady(unitID) and not isMoving then
			return A.Smite:Show(icon)
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