--####################################
--##### TRIP'S DISCIPLINE PRIEST #####
--####################################

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

Action[ACTION_CONST_PRIEST_DISCIPLINE] = {
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
	TranslucentImage			= Action.Create({ Type = "Spell", ID = 373446, Hidden = true   }),

    --Disc Talents
    Atonement						= Action.Create({ Type = "Spell", ID = 194384, Hidden = true   }),
	PowerWordRadiance				= Action.Create({ Type = "Spell", ID = 194509   }),
	Penance							= Action.Create({ Type = "Spell", ID = 47540, Texture = 391079 }),
	PenanceDmg						= Action.Create({ Type = "Spell", ID = 23018,  }),
	Purify							= Action.Create({ Type = "Spell", ID = 527   }),
	FlashHeal						= Action.Create({ Type = "Spell", ID = 2061   }),
	PainSuppression					= Action.Create({ Type = "Spell", ID = 33206   }),
	Schism							= Action.Create({ Type = "Spell", ID = 214621   }),
	PowerWordSolace					= Action.Create({ Type = "Spell", ID = 129250   }),
	PowerWordBarrier				= Action.Create({ Type = "Spell", ID = 62618   }),
	PurgeTheWicked					= Action.Create({ Type = "Spell", ID = 204197   }),
	Rapture							= Action.Create({ Type = "Spell", ID = 47536   }),
	ShadowCovenant					= Action.Create({ Type = "Spell", ID = 314867   }),
	ShadowCovenantBuff				= Action.Create({ Type = "Spell", ID = 322105   }),
	LightsWrath						= Action.Create({ Type = "Spell", ID = 373178   }),
	Evangelism						= Action.Create({ Type = "Spell", ID = 246287   }),
	PoweroftheDarkSide				= Action.Create({ Type = "Spell", ID = 198068, Hidden = true   }),
	PoweroftheDarkSideBuff			= Action.Create({ Type = "Spell", ID = 198069, Hidden = true   }),
	HarshDiscipline					= Action.Create({ Type = "Spell", ID = 373180, Hidden = true   }),
	HarshDisciplineStacks			= Action.Create({ Type = "Spell", ID = 373181, Hidden = true   }),
	HarshDisciplineBuff				= Action.Create({ Type = "Spell", ID = 373183, Hidden = true   }),
	Mindbender						= Action.Create({ Type = "Spell", ID = 123040   }),
	TwilightEqualibrium				= Action.Create({ Type = "Spell", ID = 390705, Hidden = true   }),
	TwilightEqualibriumHoly			= Action.Create({ Type = "Spell", ID = 390706, Hidden = true   }),
	TwilightEqualibriumShadow		= Action.Create({ Type = "Spell", ID = 390707, Hidden = true   }),
	ArcaneBravery					= Action.Create({ Type = "Spell", ID = 385841, Hidden = true   }),	
	SpiritofRedemption				= Action.Create({ Type = "Spell", ID = 27827, Hidden = true   }),
	Healthstone     = Action.Create({ Type = "Item", ID = 5512 }),
	GrievousWounds					= Action.Create({ Type = "Spell", ID = 240559, Hidden = true   }),
	SpiritoftheRedeemer				= Action.Create({ Type = "Spell", ID = 215982   }),
	InescapableTorment				= Action.Create({ Type = "Spell", ID = 373427, Hidden = true   }),	
	Quaking                         = Action.Create({ Type = "Spell", ID = 240447, Hidden = true  }),
	AeratedManaPotion1				= Action.Create({ Type = "Potion", ID = 191384, Texture = 176108, Hidden = true  }),
	AeratedManaPotion2				= Action.Create({ Type = "Potion", ID = 191385, Texture = 176108, Hidden = true  }),
	AeratedManaPotion3				= Action.Create({ Type = "Potion", ID = 191386, Texture = 176108, Hidden = true  }),
}

local A = setmetatable(Action[ACTION_CONST_PRIEST_DISCIPLINE], { __index = Action })

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
	PWSDebuffs								= { 381461, --Savage Charge
												378229, --Marked for Butchery
	}
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
	--[[Rapture
	if A.PowerWordShield:IsReady(unitID) and Unit(player):HasBuffs(A.Rapture.ID) > 0 and not QueueOrder.useShields[Role] then
		if thisUnit.useShields and Unit(unitID):HasBuffs(A.PowerWordShield.ID) == 0 then 
			QueueOrder.useShields[Role] = true

			local default = thisUnit.HP + ( 100 * Unit(unitID):GetAbsorb(A.PowerWordShield.ID) / thisUnit.MHP )
			
			if Role == "HEALER" then
				thisUnit:SetupOffsets(db.OffsetHealersShields, default)
			elseif Role == "TANK" then 
				thisUnit:SetupOffsets(db.OffsetTanksShields, default)
			else 
				thisUnit:SetupOffsets(db.OffsetDamagersShields, default)
			end 					
			return 
		end 
	end]]
	if Unit(unitID):HasBuffs(A.SpiritoftheRedeemer.ID) > 0 or Unit(unitID):HasBuffs(A.SpiritofRedemption.ID) > 0 or Unit(unitID):HasBuffs(A.ArcaneBravery.ID) > 0 then
		thisUnit.Enabled = false
	else thisUnit.Enabled = true
	end

end)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end 

	--[[local Healthstone = A.GetToggle(2, "HealthstoneHP") 
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
	end]]

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
	elseif heal == A.Penance then
		healamount = A.Penance:GetSpellDescription()[1]
    elseif heal == A.PowerWordRadiance then
		healamount = A.PowerWordRadiance:GetSpellDescription()[3]
    elseif heal == A.ShadowCovenant then
		healamount = A.ShadowCovenant:GetSpellDescription()[3]
    elseif heal == A.Halo then
		healamount = A.Halo:GetSpellDescription()[3]
	elseif heal == A.DivineStar then
		healamount = A.DivineStar:GetSpellDescription()[3] * 2
	end

	return (healamount * 1000) * globalhealmod

end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
	local getmembersAll = HealingEngine.GetMembersAll()
	local petActive = Player:GetTotemTimeLeft(1) > 0
	local stopCasting = MultiUnits:GetByRangeCasting(60, 1, nil, Temp.stopCasting) >= 1
	local quakingTime = 99
	if Unit(player):HasDeBuffs(A.Quaking.ID) > 0 then
		quakingTime = Unit(player):HasDeBuffs(A.Quaking.ID)
	end

    Player:AddTier("Tier29", { 200327, 200326, 200328, 200324, 200329, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

	local usePotion = A.GetToggle(1, "Potion")
	local ManaPotion = A.GetToggle(2, "ManaPotion")
	local ManaPotionObject = A.DetermineUsableObject(player, nil, nil, true, nil, A.AeratedManaPotion1, A.AeratedManaPotion2, A.AeratedManaPotion3)
	
	if Player:ManaPercentage() < ManaPotion and usePotion and not A.IsInPvP and ManaPotionObject then
		return ManaPotionObject:Show(icon)
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

		local PainSuppressionHP = A.GetToggle(2, "PainSuppressionHP")
		local FlashHealHP = A.GetToggle(2, "FlashHealHP")
		local FlashHealSoLHP = A.GetToggle(2, "FlashHealSoLHP")
		local PenanceHP = A.GetToggle(2, "PenanceHP")
		local PowerWordRadianceHP = A.GetToggle(2, "PowerWordRadianceHP")
		local ShadowCovenantHP = A.GetToggle(2, "ShadowCovenantHP")
		local HaloHP = A.GetToggle(2, "HaloHP")
		local DivineStarHP = A.GetToggle(2, "DivineStarHP")
		local VoidShiftPlayer = A.GetToggle(2, "VoidShiftPlayer")
		local VoidShiftTarget = A.GetToggle(2, "VoidShiftTarget")		
		local useCleanse = A.GetToggle(2, "Cleanse")
		local atonementSensitivity = A.GetToggle(2, "atonementSensitivity")
		local useDirectHeal = math.abs(Unit(unitID):HealthPercent() - HealingEngine.GetHealthAVG()) >= atonementSensitivity

		if Unit(player):IsCastingRemains() < 0.6 and not Player:IsChanneling() then
			if A.PainSuppression:IsReady(unitID, nil, nil, true) and Unit(unitID):HealthPercent() <= PainSuppressionHP and inCombat and Unit(unitID):HasBuffs(A.PainSuppression.ID) == 0 then
				return A.PainSuppression:Show(icon)
			end

			if inCombat and (MultiUnits:GetByRangeCasting(60, 1, nil, Temp.scaryCasts) >= 1 or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1) then
				if A.Fade:IsReady(player, nil, nil, true) and A.TranslucentImage:IsTalentLearned() then
					return A.Fade:Show(icon)
				end
				if A.Rapture:IsReady(unitID, nil, nil, true) then
					return A.Rapture:Show(icon)
				end
			end

			if A.PowerWordLife:IsReady(unitID, nil, nil, true) and Unit(unitID):HealthPercent() < 35 then
				return A.PowerWordLife:Show(icon)
			end

			if A.VoidShift:IsReady(unitID, nil, nil, true) and Unit(unitID):HealthPercent() <= VoidShiftTarget and Unit(player):HealthPercent() >= VoidShiftPlayer then
				return A.VoidShift:Show(icon)
			end

			local Cleanses = Cleanse(unitID)
			if Cleanses then 
				return Cleanses:Show(icon)
			end 

			local UseTrinket = UseTrinkets(unitID)
			if UseTrinket then
				return UseTrinket:Show(icon)
			end  

			if A.Penance:IsReady(unitID, nil, nil, true) and not stopCasting and not inCombat and Unit(unitID):HealthPercent() <= 90 and 2.1 < quakingTime + 0.5 then
				return A.Penance:Show(icon)
			end

			if A.FlashHeal:IsReady(unitID, nil, nil, true) and not stopCasting and not inCombat and Unit(unitID):HasDeBuffs(A.GrievousWounds.ID) > 0 and A.FlashHeal:GetSpellCastTime() < quakingTime + 0.5 then
				return A.FlashHeal:Show(icon)
			end

			local _, currGUID = HealingEngine.GetTarget()
			local getmembersAll = HealingEngine.GetMembersAll()	

			if Unit(player):HasBuffs(A.Rapture.ID) > 0 then
				if A.PowerWordShield:IsReadyByPassCastGCD(player) then
					for i = 1, #getmembersAll do 
						local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(getmembersAll[i].Unit)
						if not IsUnitEnemy(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):GetRange() <= 40 and useShields and UnitGUID(getmembersAll[i].Unit) ~= currGUID and Unit(getmembersAll[i].Unit):HasBuffs(A.PowerWordShield.ID) <= A.GetGCD() and (HealingEngine.GetIncomingDMGAVG() < 10 or Unit(getmembersAll[i].Unit):HasBuffs(A.Atonement.ID) == 0) then
							HealingEngine.SetTarget(getmembersAll[i].Unit, 1)
							return A.PowerWordShield:Show(icon)  
						end                
					end 
				end
			end

			--[[if Unit(player):HasBuffs(A.Rapture.ID) > 0 then
				if A.PowerWordShield:IsReadyByPassCastGCD(player) then
					for i = 1, #getmembersAll do 
						local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(getmembersAll[i].Unit)
						if not IsUnitEnemy(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):GetRange() <= 40 and useShields and UnitGUID(getmembersAll[i].Unit) ~= currGUID and Unit(getmembersAll[i].Unit):HasBuffs(A.PowerWordShield.ID) <= A.GetGCD() then
							HealingEngine.SetTarget(getmembersAll[i].Unit, 1)
							return A.PowerWordShield:Show(icon)  
						end                
					end 
				end
			end]]
		
			local PWRadianceTotal = 0
			if A.PowerWordRadiance:IsReady(unitID, nil, nil, true) and not isMoving and not stopCasting and A.PowerWordRadiance:GetSpellCastTime() < quakingTime + 0.5 and Unit(player):IsCasting() ~= A.PowerWordRadiance:Info() then
				if PowerWordRadianceHP >= 100 then
					for _, PWRUnit in pairs(TeamCache.Friendly.GUIDs) do
						if Unit(PWRUnit):HealthDeficit() >= HealCalc(A.PowerWordRadiance) and Unit(PWRUnit):GetRange() <= 30 and not Unit(PWRUnit):InVehicle() and Unit(PWRUnit):HasBuffs(A.Atonement.ID, true) <= A.PowerWordRadiance:GetSpellCastTime() then
							PWRadianceTotal = PWRadianceTotal + 1
						end
						if PWRadianceTotal >= 3 then
							PWRadianceTotal = 0
							return A.PowerWordRadiance:Show(icon)
						end 
					end
				elseif PowerWordRadianceHP <= 99 then
					if HealingEngine.GetBelowHealthPercentUnits(PowerWordRadianceHP, 30) >= 3 and Unit(unitID):HasBuffs(A.Atonement.ID, true) == 0 then
						return A.PowerWordRadiance:Show(icon)
					end
				end
				if A.PowerWordRadiance:GetSpellCharges() == 2 and inCombat and HealingEngine.GetBelowHealthPercentUnits(95, 30) >= 3 then
					return A.PowerWordRadiance:Show(icon)
				end
			end

			local shadowCovenantTotal = 0
			if A.ShadowCovenant:IsReady(unitID, nil, nil, true) then
				if ShadowCovenantHP >= 100 then
					for _, shadowCovUnit in pairs(TeamCache.Friendly.GUIDs) do
						if Unit(shadowCovUnit):HealthDeficit() >= HealCalc(A.ShadowCovenant) and Unit(shadowCovUnit):GetRange() <= 30 and not Unit(shadowCovUnit):InVehicle() then
							shadowCovenantTotal = shadowCovenantTotal + 1
						end
						if shadowCovenantTotal >= 3 then
							shadowCovenantTotal = 0
							return A.ShadowCovenant:Show(icon)
						end 
					end
				elseif ShadowCovenantHP <= 99 then
					if HealingEngine.GetBelowHealthPercentUnits(ShadowCovenantHP, 30) >= 3 then
						return A.ShadowCovenant:Show(icon)
					end
				end
			end

			if A.PowerWordShield:IsReady(unitID, nil, nil, true) and Unit(unitID):HasBuffs(A.PowerWordShield.ID) == 0 then
				if Unit(player):HasBuffs(A.Rapture.ID) == 0 and (not inCombat or A.IsInPvP or ((Unit(unitID):IsTanking() or Unit(unitID):IsTank()) and Unit(unitID):HasBuffs(A.Atonement.ID, true) < A.GetGCD())) then
					return A.PowerWordShield:Show(icon)
				elseif Unit(player):HasBuffs(A.Rapture.ID) > 0 and (HealingEngine.GetIncomingDMGAVG() < 10 or Unit(unitID):HasBuffs(A.Atonement.ID) < A.GetGCD()) then
					return A.PowerWordShield:Show(icon)
				end
			end

			local haloTotal = 0
			if A.Halo:IsReady(player, nil, nil, true) and not isMoving and not stopCasting and A.Halo:GetSpellCastTime() < quakingTime + 0.5 then
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

			if A.Penance:IsReady(unitID, nil, nil, true) and not stopCasting and 2.1 < quakingTime + 0.5 and useDirectHeal then
				if PenanceHP >= 100 then
					if Unit(unitID):HealthDeficit() >= HealCalc(A.Penance) then
						return A.Penance:Show(icon)
					end
				elseif PenanceHP <= 99 then
					if Unit(unitID):HealthPercent() <= PenanceHP then
						return A.Penance:Show(icon)
					end
				end
			end		

			if A.FlashHeal:IsReady(unitID, nil, nil, true) and not stopCasting and (not Player:IsMoving() or Unit(player):HasBuffs(A.SurgeofLightBuff.ID) > 0) and A.FlashHeal:GetSpellCastTime() < quakingTime + 0.5 and useDirectHeal and Unit(player):IsCasting() ~= A.FlashHeal:Info() then
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
			if A.FlashHeal:IsReady(unitID, nil, nil, true) and not stopCasting and Unit(player):HasBuffs(A.SurgeofLightBuff.ID) > 0 then
				if FlashHealSoLHP >= 100 then
					if Unit(unitID):HealthDeficit() >= HealCalc(A.FlashHeal) then
						return A.FlashHeal:Show(icon)
					end
				elseif FlashHealSoLHP <= 99 then
					if Unit(unitID):HealthPercent() <= FlashHealSoLHP then
						return A.FlashHeal:Show(icon)
					end
				end
			end

			local alwaysPoM = A.GetToggle(2, "alwaysPoM")
			if A.PrayerofMending:IsReady(unitID, nil, nil, true) then
				if alwaysPoM or (not alwaysPoM and HealingEngine.GetBuffsCount(A.PrayerofMending.ID, nil, player) == 0) then
					return A.PrayerofMending:Show(icon)
				end
			end

			if Unit(unitID):HasBuffs(A.Atonement.ID, true) == 0 and Unit(unitID):HealthPercent() <= 95 then
				--[[if A.PowerWordShield:IsReady(unitID) and inCombat then
					return A.PowerWordShield:Show(icon)
				end]]

				if A.Renew:IsReady(unitID, nil, nil, true) and Unit(unitID):HasBuffs(A.Renew.ID, true) == 0 then
					return A.Renew:Show(icon)
				end
			end

			--[[if A.Renew:IsReadyByPassCastGCD(player) and not useDirectHeal then
				for i = 1, #getmembersAll do 
					if not IsUnitEnemy(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):GetRange() <= 40 and UnitGUID(getmembersAll[i].Unit) ~= currGUID and Unit(getmembersAll[i].Unit):HasBuffs(A.Atonement.ID) == 0 and Unit(getmembersAll[i].Unit):HealthPercent() <= 95 then
						HealingEngine.SetTarget(getmembersAll[i].Unit, 1)
						if Unit(player):HasBuffs(A.SurgeofLightBuff.ID) > 0 then
							return A.FlashHeal:Show(icon)
							else return A.Renew:Show(icon)
						end
					end                
				end 
			end]]
		end
	end

    local function EnemyRotation(unitID)

		local isCastingHoly = Player:IsCasting() == A.Smite:Info()
		local isCastingShadow = Player:IsCasting() == A.MindBlast:Info() or Player:IsCasting() == A.Mindgames:Info() or Player:IsCasting() == A.Schism:Info()

		local castShadow = (((Unit(player):HasBuffs(A.TwilightEqualibriumShadow.ID, true, true) > 0 and not Player:IsCasting()) or isCastingHoly) and A.TwilightEqualibrium:IsTalentLearned()) or not A.TwilightEqualibrium:IsTalentLearned()
		local castHoly = (((Unit(player):HasBuffs(A.TwilightEqualibriumHoly.ID, true, true) > 0 and not Player:IsCasting()) or isCastingShadow) and A.TwilightEqualibrium:IsTalentLearned()) or not A.TwilightEqualibrium:IsTalentLearned()

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

		if Unit(player):IsCastingRemains() < 0.5 and not Player:IsChanneling() then
			if A.VampiricEmbrace:IsReady(player, nil, nil, true) and Unit(player):HasBuffs(A.ShadowCovenantBuff.ID) > 3 then
				return A.VampiricEmbrace:Show(icon)
			end

			if (A.ShadowWordPain:IsReady(unitID, nil, nil, true) or A.PurgeTheWicked:IsReady(unitID, nil, nil, true)) and Unit(unitID):IsExplosives() then
				return A.ShadowWordPain:Show(icon)
			end

			if inCombat and (MultiUnits:GetByRangeCasting(60, 1, nil, Temp.scaryCasts) >= 1 or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1) and not A.Mindbender:IsTalentLearned() then
				if A.Shadowfiend:IsReady(unitID, nil, nil, true) then
					return A.Shadowfiend:Show(icon)
				end
			end

			if (A.ShadowWordPain:IsReady(unitID, nil, nil, true) or A.PurgeTheWicked:IsReady(unitID, nil, nil, true)) and (Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) <= 3 and Unit(unitID):HasDeBuffs(A.PurgeTheWicked.ID, true) <= 3) then
				return A.ShadowWordPain:Show(icon)
			end

			if A.LightsWrath:IsReady(unitID, nil, nil, true) and not stopCasting and not isMoving and A.LightsWrath:GetSpellCastTime() < quakingTime + 0.5 and HealingEngine.GetBuffsCount(A.Atonement.ID, A.LightsWrath:GetSpellCastTime()) >= HealingEngine.GetMinimumUnits(1, 10) then
				return A.LightsWrath:Show(icon)
			end

			if A.HolyNova:IsReady(player, nil, nil, true) and MultiUnits:GetByRangeInCombat(12, 5) >= 4 then
				return A.HolyNova:Show(icon)
			end

			if A.DivineStar:IsReady(player, nil, nil, true) and Unit(unitID):GetRange() <= 20 then
				return A.DivineStar:Show(icon)
			end

			if A.ShadowWordDeath:IsReady(unitID, nil, nil, true) and Unit(unitID):HealthPercent() <= 20 then
				return A.ShadowWordDeath:Show(icon)
			end

			if A.PowerWordSolace:IsReady(unitID, nil, nil, true) then
				return A.PowerWordSolace:Show(icon)
			end

			if A.Schism:IsReady(unitID, nil, nil, true) and not stopCasting and A.Schism:GetSpellCastTime() < quakingTime + 0.5 and Unit(unitID):TimeToDie() >= 10 and not isMoving and castShadow and Unit(player):HasBuffs(A.ShadowCovenantBuff.ID) > A.Schism:GetSpellCastTime() then
				return A.Schism:Show(icon)
			end

			local harshDisciplineReady = Unit(player):HasBuffs(A.HarshDisciplineBuff.ID, true, true) > 0 or (Unit(player):HasBuffsStacks(A.HarshDisciplineStacks.ID, true, true) >= 3 and (isCastingHoly or isCastingShadow)) or not A.HarshDiscipline:IsTalentLearned()
			if A.Penance:IsReady(unitID, nil, nil, true) and not stopCasting and 2.1 < quakingTime + 0.5 and ((Unit(player):HasBuffs(A.ShadowCovenantBuff.ID) > 0 and castShadow) or (Unit(player):HasBuffs(A.ShadowCovenantBuff.ID) == 0 and castHoly)) and (harshDisciplineReady or isMoving) then  
				return A.PenanceDmg:Show(icon)
			end

			if A.Mindbender:IsReady(unitID, nil, nil, true) and A.Mindbender:IsTalentLearned() then
				return A.Mindbender:Show(icon)
			end

			if A.MindBlast:IsReady(unitID, nil, nil, true) and not stopCasting and A.MindBlast:GetSpellCastTime() < quakingTime + 0.5 and not isMoving and castShadow and (Unit(player):HasBuffs(A.ShadowCovenantBuff.ID) > A.MindBlast:GetSpellCastTime() or not A.ShadowCovenant:IsTalentLearned() or (A.InescapableTorment:IsTalentLearned() and petActive) or (Unit(player):HasBuffsStacks(A.HarshDisciplineStacks.ID, true, true) >= 3 and not A.Mindgames:IsReady(unitID, nil, nil, true))) then
				return A.MindBlast:Show(icon)
			end

			if A.Mindgames:IsReady(unitID, nil, nil, true) and not stopCasting and A.Mindgames:GetSpellCastTime() < quakingTime + 0.5 and not isMoving and castShadow then
				return A.Mindgames:Show(icon)
			end

			if A.Smite:IsReady(unitID, nil, nil, true) and not stopCasting and A.Smite:GetSpellCastTime() < quakingTime + 0.5 and not isMoving then
				return A.Smite:Show(icon)
			end
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