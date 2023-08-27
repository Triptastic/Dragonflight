--#####################################
--##### TRIP'S RESTORATION SHAMAN #####
--#####################################

local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
local Covenant									= _G.LibStub("Covenant")
local TMW										= _G.TMW
local Listener                                  = Action.Listener
local Create                                    = Action.Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local CovenantIsON								= Action.CovenantIsON
local AuraIsValid                               = Action.AuraIsValid
local AuraIsValidByPhialofSerenity				= A.AuraIsValidByPhialofSerenity
local HealingEngine                             = Action.HealingEngine
local InterruptIsValid                          = Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Utils                                     = Action.Utils
local TeamCache                                 = Action.TeamCache
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player 
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit 
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TeamCacheFriendly                         = TeamCache.Friendly
local pairs                                     = pairs
local TeamCacheFriendlyGUIDs                = TeamCacheFriendly.GUIDs -- unitGUID to unitID
local TeamCacheEnemy                        = TeamCache.Enemy

--For Toaster
local Toaster									= _G.Toaster
local GetSpellTexture 							= _G.TMW.GetSpellTexture


-- Spells
Action[ACTION_CONST_SHAMAN_RESTORATION] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it

	-- Shaman General
    AncestralSpirit					= Action.Create({ Type = "Spell", ID = 2008		}),
    AstralRecall					= Action.Create({ Type = "Spell", ID = 556		}),
    AstralShift						= Action.Create({ Type = "Spell", ID = 108271	}),	
    Bloodlust						= Action.Create({ Type = "Spell", ID = 2825		}),
    CapacitorTotem					= Action.Create({ Type = "Spell", ID = 192058	}),	
    ChainHeal						= Action.Create({ Type = "Spell", ID = 1064		}),	
    ChainLightning					= Action.Create({ Type = "Spell", ID = 188443	}),	
    EarthElemental					= Action.Create({ Type = "Spell", ID = 198103	}),
    EarthbindTotem					= Action.Create({ Type = "Spell", ID = 2484		}),
    FarSight						= Action.Create({ Type = "Spell", ID = 6196		}),
    FlameShock						= Action.Create({ Type = "Spell", ID = 188389	}),
    FlametongueWeapon				= Action.Create({ Type = "Spell", ID = 318038	}),	
    FrostShock						= Action.Create({ Type = "Spell", ID = 196840	}),
    GhostWolf						= Action.Create({ Type = "Spell", ID = 2645		}),	
    HealingStreamTotem				= Action.Create({ Type = "Spell", ID = 5394		}),	
    HealingSurge					= Action.Create({ Type = "Spell", ID = 8004		}),	
    Hex								= Action.Create({ Type = "Spell", ID = 51514	}),	
    LightningBolt					= Action.Create({ Type = "Spell", ID = 188196	}),	
    LightningShield					= Action.Create({ Type = "Spell", ID = 192106	}),
    PrimalStrike					= Action.Create({ Type = "Spell", ID = 73899	}),	
    Purge							= Action.Create({ Type = "Spell", ID = 370		}),
    GreaterPurge					= Action.Create({ Type = "Spell", ID = 378773	}),
    TremorTotem						= Action.Create({ Type = "Spell", ID = 8143		}),	
    WaterWalking					= Action.Create({ Type = "Spell", ID = 546		}),
    WindShear						= Action.Create({ Type = "Spell", ID = 57994	}),
    NaturesSwiftness				= Action.Create({ Type = "Spell", ID = 378081	}),
    Reincarnation					= Action.Create({ Type = "Spell", ID = 20608, Hidden = true		}),	
    ElementalOrbit					= Action.Create({ Type = "Spell", ID = 383010, Hidden = true		}),	
	
	-- Restoration Specific
    AncestralVision					= Action.Create({ Type = "Spell", ID = 212048	}),
    EarthShield						= Action.Create({ Type = "Spell", ID = 974		}),
    HealingRain						= Action.Create({ Type = "Spell", ID = 73920	}),	
    HealingTideTotem				= Action.Create({ Type = "Spell", ID = 108280	}),	
	EarthlivingWeapon				= Action.Create({ Type = "Spell", ID = 382021	}),		
    HealingWave						= Action.Create({ Type = "Spell", ID = 77472	}),
    LavaBurst						= Action.Create({ Type = "Spell", ID = 51505	}),
    ManaTideTotem					= Action.Create({ Type = "Spell", ID = 16191	}),
    PurifySpirit					= Action.Create({ Type = "Spell", ID = 77130	}),
    Riptide							= Action.Create({ Type = "Spell", ID = 61295	}),
    SpiritLinkTotem					= Action.Create({ Type = "Spell", ID = 98008	}),
    SpiritwalkersGrace				= Action.Create({ Type = "Spell", ID = 79206	}),
    WaterShield						= Action.Create({ Type = "Spell", ID = 52127	}),
    AncestralGuidance				= Action.Create({ Type = "Spell", ID = 108281	}),
    EverRisingTide  				= Action.Create({ Type = "Spell", ID = 382029	}),    
    Stormkeeper       				= Action.Create({ Type = "Spell", ID = 383009	}),
    LavaSurge						= Action.Create({ Type = "Spell", ID = 77756, Hidden = true		}),
    TidalWaves						= Action.Create({ Type = "Spell", ID = 51564, Hidden = true		}),	
    TidalWavesBuff					= Action.Create({ Type = "Spell", ID = 61295, Hidden = true		}),		
	
	-- Normal Talents
    Torrent							= Action.Create({ Type = "Spell", ID = 200072, isTalent = true, Hidden = true	}),
    Undulation						= Action.Create({ Type = "Spell", ID = 200071, isTalent = true, Hidden = true	}),
    UnleashLife						= Action.Create({ Type = "Spell", ID = 73685, isTalent = true	}),
    EchooftheElements				= Action.Create({ Type = "Spell", ID = 200072, isTalent = true, Hidden = true	}),	
    Deluge							= Action.Create({ Type = "Spell", ID = 200076, isTalent = true, Hidden = true	}),	
    SurgeofEarth					= Action.Create({ Type = "Spell", ID = 320746, isTalent = true	}),
    SpiritWolf						= Action.Create({ Type = "Spell", ID = 260878, isTalent = true, Hidden = true	}),	
    EarthgrabTotem					= Action.Create({ Type = "Spell", ID = 51485, isTalent = true	}),
    StaticCharge					= Action.Create({ Type = "Spell", ID = 265046, isTalent = true, Hidden = true	}),
    AncestralVigor					= Action.Create({ Type = "Spell", ID = 207401, isTalent = true, Hidden = true	}),	
    EarthenWallTotem				= Action.Create({ Type = "Spell", ID = 198838, isTalent = true	}),
    AncestralProtectionTotem		= Action.Create({ Type = "Spell", ID = 207399, isTalent = true	}),
    NaturesGuardian					= Action.Create({ Type = "Spell", ID = 30884, isTalent = true, Hidden = true	}),
    GracefulSpirit					= Action.Create({ Type = "Spell", ID = 192088, isTalent = true, Hidden = true	}),
    WindRushTotem					= Action.Create({ Type = "Spell", ID = 192077, isTalent = true	}),	
    FlashFlood						= Action.Create({ Type = "Spell", ID = 280614, isTalent = true, Hidden = true	}),
    Downpour						= Action.Create({ Type = "Spell", ID = 207778, isTalent = true	}),	
    CloudburstTotem					= Action.Create({ Type = "Spell", ID = 157153, isTalent = true	}),	
    HighTide						= Action.Create({ Type = "Spell", ID = 157154, isTalent = true, Hidden = true	}),	
    Wellspring						= Action.Create({ Type = "Spell", ID = 197995	}),
    Ascendance						= Action.Create({ Type = "Spell", ID = 114052, isTalent = true	}),	
    TotemicRecall					= Action.Create({ Type = "Spell", ID = 108285	}),

    PrimordialWave					= Action.Create({ Type = "Spell", ID = 375982	}),
    PrimordialWaveBuff				= Action.Create({ Type = "Spell", ID = 375986, Hidden = true	}),	

	-- Conduits

	
	-- Legendaries
	-- General Legendaries

	-- Restoration Legendaries


	--Anima Powers - to add later...
	
	
	-- Trinkets
	

	-- Potions
    PotionofUnbridledFury			= Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 	
    SuperiorPotionofUnbridledFury	= Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }),
    PotionofSpectralIntellect		= Action.Create({ Type = "Potion", ID = 171273, QueueForbidden = true }),
    PotionofSpectralStamina			= Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }),
    PotionofEmpoweredExorcisms		= Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
    PotionofHardenedShadows			= Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofPhantomFire				= Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
    PotionofDeathlyFixation			= Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }),
    SpiritualHealingPotion			= Action.Create({ Type = "Item", ID = 171267, QueueForbidden = true }),
	PhialofSerenity				    = Action.Create({ Type = "Item", ID = 177278 }),
	
    -- Misc
    Channeling                      = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                     = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                        = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
    PoolResource                    = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),

	GrievousWounds					= Action.Create({ Type = "Spell", ID = 240559, Hidden = true   }),
	SpiritoftheRedeemer				= Action.Create({ Type = "Spell", ID = 215982   }),
	InescapableTorment				= Action.Create({ Type = "Spell", ID = 373427, Hidden = true   }),	
	Quaking                         = Action.Create({ Type = "Spell", ID = 240447, Hidden = true  }),
	AeratedManaPotion1				= Action.Create({ Type = "Potion", ID = 191384, Texture = 176108, Hidden = true  }),
	AeratedManaPotion2				= Action.Create({ Type = "Potion", ID = 191385, Texture = 176108, Hidden = true  }),
	AeratedManaPotion3				= Action.Create({ Type = "Potion", ID = 191386, Texture = 176108, Hidden = true  }),
	ArcaneBravery					= Action.Create({ Type = "Spell", ID = 385841, Hidden = true   }),	
	SpiritofRedemption				= Action.Create({ Type = "Spell", ID = 27827, Hidden = true   }),	
	
	GroundingTotem					= Action.Create({ Type = "Spell", ID = 204336   }),	
	StoneskinTotem					= Action.Create({ Type = "Spell", ID = 383017   }),	
	CounterstrikeTotem				= Action.Create({ Type = "Spell", ID = 204331   }),	
	TideTurner						= Action.Create({ Type = "Spell", ID = 404019, Hidden = true   }),	
	SpiritwalkersTidalTotem			= Action.Create({ Type = "Spell", ID = 404522, Hidden = true   }),	
	LightningLasso					= Action.Create({ Type = "Spell", ID = 305483   }),
	UnleashShield					= Action.Create({ Type = "Spell", ID = 356736   }),
};

local A = setmetatable(Action[ACTION_CONST_SHAMAN_RESTORATION], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

local player = "player"
local target = "target"
local targettarget = "targettarget"
local mouseover = "mouseover"
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
	scaryCasts                              = { 396023, --Incinerating Roar
												376279, --Concussive Slam
												388290, --Cyclone
												375457, --Chilling Tantrum
	},
	GroundingTotemCasts                     = { 51505, --Lava Burst
												116858, --Chaos Bolt
												118, --Polymorph

	},
}

TMW:RegisterCallback("TMW_ACTION_HEALINGENGINE_UNIT_UPDATE", function(callbackEvent, thisUnit, db, QueueOrder)
	local unitID  = thisUnit.Unit
	local unitHP  = thisUnit.realHP
	local Role    = thisUnit.Role
    local Cleanse = A.GetToggle(2, "Cleanse")
	-- Dispel
	if A.PurifySpirit:IsReady(unitID) and Cleanse then
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

    local astralShiftHP = A.GetToggle(2, "astralShiftHP")
    if A.AstralShift:IsReady(player, nil, nil, true) and Unit(player):HealthPercent() <= astralShiftHP then
        return A.AstralShift
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then

        if A.WindShear:IsReady(unitID, nil, nil, true) and useKick and not notInterruptable then
			return A.WindShear
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

    if A.PurifySpirit:IsReady(unitID) and useDispel and AuraIsValid(unitID, "UseDispel", "Dispel") then
        return A.PurifySpirit
    end 


end

local function Purge(unitID)

    if AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow") then 
		if A.Purge:IsReady(unitID) then
			return A.Purge
		end
		if A.GreaterPurge:IsReady(unitID) then
			return A.GreaterPurge
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

local function HealCalc(heal)
    local healamount = 0
    local globalhealmod = A.GetToggle(2, "globalhealmod")
    local description
    
    if heal == A.Downpour then
      description = A.Downpour:GetSpellDescription()[3]
    else
      description = heal:GetSpellDescription()[1]
    end
  
    if description > 5 then
      healamount = description
    else
      healamount = description * 1000
    end
  
    return healamount * globalhealmod
end

local activeTotems = {"Earthen Wall Totem", "Healing Stream Totem", "Healing Tide Totem", "Earthgrab Totem", "Spirit Link Totem"}

local function UpdateTotems()
    for i = 1, 5 do
        local _, totemName = GetTotemInfo(i)
        if totemName then
            activeTotems[totemName] = GetTotemTimeLeft(i)
        else
            for j, name in ipairs(activeTotems) do
                if activeTotems[name] == nil then
                    table.remove(activeTotems, j)
                    break
                end
            end
        end
    end
end


local function OnEvent(self, event, ...)
    if event == "PLAYER_TOTEM_UPDATE" then
        UpdateTotems()
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TOTEM_UPDATE")
frame:SetScript("OnEvent", OnEvent)


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = Player:IsMoving()
    local hasSpiritwalkersGrace = Unit(player):HasBuffs(A.SpiritwalkersGrace.ID) > 0
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
	local getmembersAll = HealingEngine.GetMembersAll()
	local stopCasting = MultiUnits:GetByRangeCasting(60, 1, nil, Temp.stopCasting) >= 1
	local TTD = MultiUnits.GetByRangeAreaTTD(40)
	local quakingTime = 99
	if Unit(player):HasDeBuffs(A.Quaking.ID) > 0 then
		quakingTime = Unit(player):HasDeBuffs(A.Quaking.ID)
	end

    Player:AddTier("Tier29", { 200399, 200401, 200396, 200398, 200400, })
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

	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
	if not hasMainHandEnchant or (not inCombat and mainHandExpiration < 300000) then
		if A.EarthlivingWeapon:IsReady(player) then
			return A.EarthlivingWeapon:Show(icon)
		end
	end

	if not A.IsInPvP and A.WaterShield:IsReady(player) and Unit(player):HasBuffs(A.WaterShield.ID) == 0 and (Unit(player):HasBuffs(A.EarthShield.ID) == 0 or A.ElementalOrbit:IsTalentLearned()) then
		return A.WaterShield:Show(icon)
	end

	local ewtActive = false
	for i = 1, MAX_TOTEMS do
		local _, name, startTime = GetTotemInfo(i)
		if name == "Earthen Wall Totem" and startTime > 0 then
			ewtActive = true
			break
		end
	end

	if A.IsInPvP then
		if A.ElementalOrbit:IsTalentLearned() then
			if Unit(player):HasBuffs(A.WaterShield.ID) == 0 and Unit(player):HasBuffs(A.LightningShield.ID) == 0 then
				if A.LightningShield:IsReady(unitID) then
					return A.LightningShield:Show(icon)
				end
			end
		end
		if A.EarthgrabTotem:IsReady(player) then
			local namePlateUnitID
			for namePlateUnitID in pairs(ActiveUnitPlates) do                 
				if Unit(namePlateUnitID):IsPlayer() and not Unit(namePlateUnitID):IsNPC() and not Unit(namePlateUnitID):IsTotem() and A.IsUnitEnemy(namePlateUnitID) and Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 8 then 
					return A.EarthgrabTotem:Show(icon)
				end 
			end
		end
		if A.TremorTotem:IsReady(player) and (Unit("party1"):HasDeBuffs("Fear") > 0 or Unit("party2"):HasDeBuffs("Fear") > 0 or Unit("party3"):HasDeBuffs("Fear") > 0) then
			return A.TremorTotem:Show(icon)
		end
		if A.Zone == "arena" then
			if Unit("arena1"):HasBuffs("DamageBuffs") > 0 or Unit("arena2"):HasBuffs("DamageBuffs") > 0 or Unit("arena3"):HasBuffs("DamageBuffs") > 0 or (A.IsUnitEnemy("target") and Unit("target"):HasBuffs("DamageBuffs") > 0) then
				if A.CounterstrikeTotem:IsReady(player) then
					return A.CounterstrikeTotem:Show(icon)
				end
				if A.EarthenWallTotem:IsReady(player) and not ewtActive then
					return A.EarthenWallTotem:Show(icon)
				end
				if A.HealingTideTotem:IsReady(player) and (Unit("party1"):HasBuffs(A.EarthenWallTotem.ID) == 0 and Unit("party2"):HasBuffs(A.EarthenWallTotem.ID) == 0 and Unit("party3"):HasBuffs(A.EarthenWallTotem.ID) == 0) then
					return A.HealingTideTotem:Show(icon)
				end
			end
			if Unit("party1"):HasBuffs("DamageBuffs") > 0 or Unit("party2"):HasBuffs("DamageBuffs") > 0 or Unit("party3"):HasBuffs("DamageBuffs") > 0 then
				if A.Bloodlust:IsReady(player) then
					return A.Bloodlust:Show(icon)
				end
			end
		end
	end

	local function HealingRotation(unitID)

		local useCleanse = A.GetToggle(2, "Cleanse")

		local _, currGUID = HealingEngine.GetTarget()
		local getmembersAll = HealingEngine.GetMembersAll()	

        local Cleanses = Cleanse(unitID)
        if Cleanses then 
            return Cleanses:Show(icon)
        end 

		local UseTrinket = UseTrinkets(unitID)
		if UseTrinket then
			return UseTrinket:Show(icon)
		end  

		if A.TotemicRecall:IsReady(player, nil, nil, true) and Player:PrevGCD(1, A.EarthenWallTotem) then
			return A.TotemicRecall:Show(icon)
		end

		if A.GroundingTotem:IsReady(player, nil, nil, true) and (MultiUnits:GetByRangeCasting(30, nil, nil, Temp.GroundingTotemCasts) > 0 or Unit("party1"):HealthPercent() <= 60 or (Unit("party2"):HealthPercent() <= 60 and Unit("party2"):IsExists())) then
			return A.GroundingTotem:Show(icon)
		end

		local emergency = Unit(unitID):HealthPercent() <= A.GetToggle(2, "EmergencyHP")
		if A.SpiritwalkersGrace:IsReady(player) and emergency then
			return A.SpiritwalkersGrace:Show(icon)
		end
		if A.HealingWave:IsReady(unitID) and emergency and A.NaturesSwiftness:IsReady(player) then
			return A.NaturesSwiftness:Show(icon)
		end
		if A.HealingTideTotem:IsReady(player) and emergency and A.Riptide:IsInRange(unitID) and A.Zone == "arena" then
			return A.HealingTideTotem:Show(icon)
		end
        if A.HealingWave:IsReady(unitID) and Unit(player):HasBuffs(A.NaturesSwiftness.ID) > 0 then
            return A.HealingWave:Show(icon)
        end

		local canEarthShield = A.EarthShield:IsReady(unitID) and HealingEngine.GetBuffsCount(A.EarthShield.ID, 1, player) < (1 + num(A.ElementalOrbit:IsTalentLearned()))
		if canEarthShield then
			if (Unit(unitID):IsTanking() or Unit(unitID):IsTank()) and Unit(unitID):HasBuffs(A.EarthShield.ID, true) <= 1 and A.Zone ~= "arena" then
				return A.EarthShield:Show(icon)
			end
			if A.ElementalOrbit:IsTalentLearned() and Unit(player):HasBuffs(A.EarthShield.ID, true) <= 1 then
				if UnitGUID(player) ~= currGUID then
					HealingEngine.SetTarget(player, 1)
				end
				return A.EarthShield:Show(icon)
			end
		end
		if A.EarthShield:IsReady(unitID) and A.Zone == "arena" and Unit(unitID):GetRealTimeDMG() > 0 and Unit(unitID):IsFocused(nil, true) and Unit(unitID):HasBuffs(A.EarthShield.ID) == 0 then
			return A.EarthShield:Show(icon)
		end

		local ManaTideTotemMana = A.GetToggle(2, "ManaTideTotemMana")
		if inCombat and A.ManaTideTotem:IsReady(player) and Player:ManaPercentage() <= ManaTideTotemMana then
			return A.ManaTideTotem:Show(icon)
		end

        if A.Riptide:IsReady(unitID) and ((A.Riptide:GetSpellChargesFullRechargeTime() < A.GetGCD() or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.scaryCasts) >= 1 or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1) and A.PrimordialWave:IsReady(unitID)) then
            for i = 1, #getmembersAll do 
                local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(getmembersAll[i].Unit)
                if not IsUnitEnemy(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):GetRange() <= 40 and useHoTs and Unit(getmembersAll[i].Unit):HasBuffs(A.Riptide.ID) <= A.GetGCD() and HealingEngine.GetIncomingDMGAVG() < 10 then
                    if UnitGUID(getmembersAll[i].Unit) ~= currGUID then
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 1)
                    end
                    return A.Riptide:Show(icon)  
                end                
            end 
        end

		local riptideHP = A.GetToggle(2, "riptideHP")
        if A.Riptide:IsReady(unitID) then
			if riptideHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.Riptide) then
					return A.Riptide:Show(icon)
				end
			elseif riptideHP <= 99 then
				if Unit(unitID):HealthPercent() <= riptideHP then
					return A.Riptide:Show(icon)
				end
			end
		end	

		if inCombat and A.StoneskinTotem:IsReady(player) then
			return A.StoneskinTotem:Show(icon)
		end

        if inCombat and (MultiUnits:GetByRangeCasting(60, 1, nil, Temp.scaryCasts) >= 1 or MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1) then
			if A.CloudburstTotem:IsReady(player) then
				local cbtActive = false
				for i = 1, MAX_TOTEMS do
					local _, name, startTime = GetTotemInfo(i)
					if name == "Cloudburst Totem" and startTime > 0 then
						hstActive = true
						break
					end
				end
				if not cbtActive or (cbtActive and Unit(unitID):HealthPercent() <= 30) then
					return A.CloudburstTotem:Show(icon)
				end
			end
            if A.EarthenWallTotem:IsReady(player) then
                return A.EarthenWallTotem:Show(icon)
            end
            if A.EverRisingTide:IsReady(player) then
                return A.EverRisingTide:Show(icon)
            end
            if A.HealingStreamTotem:IsReady(player) then
                return A.HealingStreamTotem:Show(icon)
			end
        end

		if A.HealingTideTotem:IsReady(player) and (Unit("party1"):HasDeBuffs(76577) > 0 or Unit("party2"):HasDeBuffs(76577) > 0 or Unit("party3"):HasDeBuffs(76577) > 0) then -- Smoke Bomb
			return A.HealingTideTotem:Show(icon)
		end

		if A.HealingStreamTotem:IsReady(player) and inCombat and not isMoving and not A.CloudburstTotem:IsTalentLearned() then
			local hstActive = false
			for i = 1, MAX_TOTEMS do
				local _, name, startTime = GetTotemInfo(i)
				if name == "Healing Stream Totem" and startTime > 0 then
					hstActive = true
					break
				end
			end
			if not hstActive then
				return A.HealingStreamTotem:Show(icon)
			end
		end 

        local downpourHP = A.GetToggle(2, "downpourHP")
        local downpourUnits = A.GetToggle(2, "downpourUnits")
		local downpourTotal = 0
		if A.Downpour:IsReady(player) and (not isMoving or hasSpiritwalkersGrace) then
			if downpourHP >= 100 then
				for _, downpourUnit in pairs(TeamCache.Friendly.GUIDs) do
					if Unit(downpourUnit):HealthDeficit() >= HealCalc(A.Downpour) and Unit(downpourUnit):GetRange() <= 10 and not Unit(downpourUnit):InVehicle() then
						downpourTotal = downpourTotal + 1
					end
					if downpourTotal >= downpourUnits then
						downpourTotal = 0
						return A.Downpour:Show(icon)
					end 
				end
			elseif downpourHP <= 99 then
				if HealingEngine.GetBelowHealthPercentUnits(downpourHP, 10) >= downpourUnits then
					return A.Downpour:Show(icon)
				end
			end
		end

		
		local healingTideHP = A.GetToggle(2, "healingTideHP")
		local healingTideUnits = A.GetToggle(2, "healingTideUnits")
		if A.HealingTideTotem:IsReady(player) and inCombat and HealingEngine.GetBelowHealthPercentUnits(healingTideHP, 40) >= healingTideUnits then
			return A.HealingTideTotem:Show(icon)
		end


        local riptideCount = A.GetToggle(2, "riptideCount")
        local healingWaveHP = A.GetToggle(2, "healingWaveHP")
        local primordialWaveCount = A.GetToggle(2, "primordialWaveCount")
        if A.PrimordialWave:IsReady(unitID) and HealingEngine.GetBuffsCount(A.Riptide.ID, 1) >= HealingEngine.GetMinimumUnits(1, riptideCount) and HealingEngine.GetBelowHealthPercentUnits(healingWaveHP, 40) >= riptideCount then
            return A.PrimordialWave:Show(icon)
        end

        local unleashLifeHP = A.GetToggle(2, "unleashLifeHP")
        if A.UnleashLife:IsReady(unitID) then
			if unleashLifeHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.UnleashLife) then
					return A.UnleashLife:Show(icon)
				end
			elseif unleashLifeHP <= 99 then
				if Unit(unitID):HealthPercent() <= unleashLifeHP then
					return A.UnleashLife:Show(icon)
				end
			end
		end	

        if A.HealingWave:IsReady(unitID) and (not isMoving or hasSpiritwalkersGrace) and Unit(player):HasBuffs(A.PrimordialWaveBuff.ID) > A.HealingWave:GetSpellCastTime() then
            return A.HealingWave:Show(icon)
        end

        local ancestralGuidanceHP = A.GetToggle(2, "ancestralGuidanceHP")
        local ancestralGuidanceUnits = A.GetToggle(2, "ancestralGuidanceUnits")
		if A.AncestralGuidance:IsReady(player) then
			if ancestralGuidanceHP <= 99 then
				if HealingEngine.GetBelowHealthPercentUnits(ancestralGuidanceHP, 30) >= ancestralGuidanceUnits then
					return A.AncestralGuidance:Show(icon)
				end
			end	
		end 

        local chainHealHP = A.GetToggle(2, "chainHealHP")
        local chainHealUnits = A.GetToggle(2, "chainHealUnits")
		local chainHealTotal = 0
		if A.ChainHeal:IsReady(unitID) and (not isMoving or hasSpiritwalkersGrace) and not stopCasting and A.ChainHeal:GetSpellCastTime() < quakingTime + 0.5 then
			if chainHealHP >= 100 then
				for _, chainHealUnit in pairs(TeamCache.Friendly.GUIDs) do
					if Unit(chainHealUnit):HealthDeficit() >= HealCalc(A.ChainHeal) and Unit(chainHealUnit):GetRange() <= 30 and not Unit(chainHealUnit):InVehicle() then
						chainHealTotal = chainHealTotal + 1
					end
					if chainHealTotal >= chainHealUnits then
						chainHealTotal = 0
						if A.ManaTideTotem:IsReady(player) and A.SpiritwalkersTidalTotem:IsTalentLearned() then
							return A.ManaTideTotem:Show(icon)
						end
						return A.ChainHeal:Show(icon)
					end 
				end
			elseif chainHealHP <= 99 then
				if HealingEngine.GetBelowHealthPercentUnits(chainHealHP, 30) >= chainHealUnits then
					if A.ManaTideTotem:IsReady(player) and A.SpiritwalkersTidalTotem:IsTalentLearned() then
						return A.ManaTideTotem:Show(icon)
					end
					return A.ChainHeal:Show(icon)
				end
			end	
		end 

        local healingSurgeHP = A.GetToggle(2, "healingSurgeHP")
        if A.HealingSurge:IsReady(unitID) and (not isMoving or hasSpiritwalkersGrace) and not stopCasting and A.HealingSurge:GetSpellCastTime() < quakingTime + 0.5 then
			if healingSurgeHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.HealingSurge) then
					return A.HealingSurge:Show(icon)
				end
			elseif healingSurgeHP <= 99 then
				if Unit(unitID):HealthPercent() <= healingSurgeHP then
					return A.HealingSurge:Show(icon)
				end
			end
		end	

        if A.HealingWave:IsReady(unitID) and (not isMoving or hasSpiritwalkersGrace) and not stopCasting and A.HealingWave:GetSpellCastTime() < quakingTime + 0.5 then
			if healingWaveHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.HealingWave) then
					return A.HealingWave:Show(icon)
				end
			elseif healingWaveHP <= 99 then
				if Unit(unitID):HealthPercent() <= healingWaveHP then
					return A.HealingWave:Show(icon)
				end
			end
		end	

	end

    local function EnemyRotation(unitID)

		local hasStormkeeper = Unit(player):HasBuffs(A.Stormkeeper.ID) > 0

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

		if Unit(unitID):IsExplosives() then
            if A.FrostShock:IsReady(unitID) then
                return A.FrostShock:Show(icon)
            end
		end
        
		if A.HealingRain:IsReady(player) and TTD > 7 and (not isMoving or hasSpiritwalkersGrace) then
			return A.HealingRain:Show(icon)
		end

		if A.Stormkeeper:IsReady(player) and (not isMoving or hasSpiritwalkersGrace) and A.Stormkeeper:GetSpellCastTime() < quakingTime + 0.5 then
			return A.Stormkeeper:Show(icon)
		end

		if A.ChainLightning:IsReady(unitID) and (not isMoving or hasSpiritwalkersGrace) and A.ChainLightning:GetSpellCastTime() < quakingTime + 0.5 and MultiUnits:GetActiveEnemies() >= 2 then
			return A.ChainLightning:Show(icon)
		end

		if A.FlameShock:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) < A.GetGCD() then
			return A.FlameShock:Show(icon)
		end

		if A.LavaBurst:IsReady(unitID) and (not isMoving or hasSpiritwalkersGrace) and A.LavaBurst:GetSpellCastTime() < quakingTime + 0.5 then
			return A.LavaBurst:Show(icon)
		end

		if A.LightningBolt:IsReady(unitID) and (not isMoving or hasSpiritwalkersGrace or hasStormkeeper) and A.LightningBolt:GetSpellCastTime() < quakingTime + 0.5 then
			return A.LightningBolt:Show(icon)
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

local PassiveUnitID = {
    raid = {
        [1] = "raid1",
        [2] = "raid2",
        [3] = "raid3",
    },
    party = {
        [1] = "party1",
        [2] = "party2",
        [3] = "party3",
    },
    arena = {
        [1] = "arena1",
        [2] = "arena2",
        [3] = "arena3",
    },
}

local function ArenaRotation(icon)

    local n = icon.ID and icon.ID - 5
    if n then  
        local unitIDe
		local unitIDf
        if TeamCacheEnemy.Type then 
            unitIDe = PassiveUnitID[TeamCacheEnemy.Type][n]
        end 
        
        if TeamCacheFriendly.Type then 
            unitIDf = PassiveUnitID[TeamCacheFriendly.Type][n]
        end 

		if unitIDe and Unit(unitIDe):IsExists() and A.IsInPvP and not Player:IsStealthed() and not Player:IsMounted() and not Unit(unitIDe):InLOS() then     
			
			--Add kick on heal spell ?if team bursting
			local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitIDe, "Heal", nil, true)  
			if Unit(unitIDe):IsHealer() and (Unit("arena1"):HealthPercent() <= 50 or Unit("arena2"):HealthPercent() <= 50 or (Unit("arena3"):HealthPercent() <= 50 and Unit("arena3"):IsExists())) then 
				if useKick and A.WindShear:IsReady(unitIDe) and not notInterruptable and A.WindShear:AbsentImun(unitIDe, Temp.TotalAndMagKick) then
					return A.WindShear:Show(icon)
				end

				--Lasso healer
				if A.LightningLasso:IsReady(unitIDe, true) then 
					if Unit(unitIDe):IsHealer() and A.LightningLasso:AbsentImun(unitIDe, Temp.TotalAndMag) then 
						return A.UnleashShield:Show(icon)
					end 
				end
			end
		end



		local Cleanse = A.GetToggle(2, "Cleanse")
		
		if unitIDf and Cleanse and Unit(unitIDf):IsExists() and A.IsInPvP and not Player:IsStealthed() and not Player:IsMounted() and not Unit(unitIDf):InLOS() then	
			if A.PurifySpirit:IsReady(unitIDf, nil, nil, true) and AuraIsValid(unitIDf, "UseDispel", "Dispel") then 
                return A.PurifySpirit:Show(icon)
            end 			
		end
		
	end
end

A[6] = function(icon)

	return ArenaRotation(icon)
end

--AntiFake CC Focus
A[7] = function(icon)

	--[[local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(focus, nil, nil, true)
	if useCC and A.PsychicScreamGreen:IsReady(player) and Unit(focus):GetRange() <= 8 and A.PsychicScream:AbsentImun(focus, Temp.TotalAndMag) then
		return A.PsychicScreamGreen:Show(icon)
	end
	
	if useCC and A.PsychicHorrorRed:IsReady(focus) and A.PsychicHorror:AbsentImun(focus, Temp.TotalAndMag) then
		return A.PsychicHorrorRed:Show(icon)
	end]]

	return ArenaRotation(icon)
end

--AntiFake Interrupt Focus
A[8] = function(icon)  

	--[[local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(focus, nil, nil, true)   
	if useKick and A.SilenceGreen:IsReady(focus) and not notInterruptable and A.Silence:AbsentImun(focus, Temp.TotalAndMagKick) then
		return A.SilenceGreen:Show(icon)
	end		]]

	return ArenaRotation(icon)
end