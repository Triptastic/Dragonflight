--############################
--##### TRIP'S PRIEST UI #####
--############################

local TMW											= TMW 
local CNDT											= TMW.CNDT
local Env											= CNDT.Env

local A												= Action
local GetToggle										= A.GetToggle
local InterruptIsValid								= A.InterruptIsValid

local UnitCooldown									= A.UnitCooldown
local Unit											= A.Unit 
local Player										= A.Player 
local Pet											= A.Pet
local LoC											= A.LossOfControl
local MultiUnits									= A.MultiUnits
local EnemyTeam										= A.EnemyTeam
local FriendlyTeam									= A.FriendlyTeam
local TeamCache										= A.TeamCache
local InstanceInfo									= A.InstanceInfo
local select, setmetatable							= select, setmetatable

A.Data.ProfileEnabled[Action.CurrentProfile] = true
A.Data.ProfileUI = {    
    DateTime = "v2.0 (28 August 2023)",
    -- Class settings
    [2] = {        
        [ACTION_CONST_PRIEST_SHADOW] = { 
			{ -- GENERAL OPTIONS FIRST ROW
				{ -- AOE
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
                        Custom = "/run Action.AoEToggleMode()",
                        -- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
                        Value = value or nil, 
                        -- Very Very Optional, no idea why it will be need however.. 
                        TabN = '@number' or nil,                                
                        Print = '@string' or nil,
                    },
                },				
            },
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- CLEANSE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== DEFENSIVES ====== ",
                    },
                },
            },
			{
                { -- DispersionHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DispersionHP",
                    DBV = 20,
                    ONOFF = false,
                    L = { 
                        ANY = "Dispersion HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Dispersion.", 
                    },                     
                    M = {},
                },	
                { -- DesperatePrayerHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DesperatePrayerHP",
                    DBV = 75,
                    ONOFF = false,
                    L = { 
                        ANY = "Desperate Prayer HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Desperate Prayer on yourself.", 
                    },                     
                    M = {},
                },	
            },
            {
                { -- VampEmbraceHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "vampEmbraceHP",
                    DBV = 70,
                    ONOFF = false,
                    L = { 
                        ANY = "Vampiric Embrace HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Vampiric Embrace. Used with the units slider.", 
                    },                     
                    M = {},
                },			
                { -- VampEmbraceUnits
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "vampEmbraceUnits",
                    DBV = 5,
                    ONOFF = false,
                    L = { 
                        ANY = "Vampiric Embrace Units",
                    },
                    TT = { 
                        ANY = "Number of units below HP (%) of previous slider to use Vampiric Embrace. Automatically scales down to maximum number of members if slider is higher than max.", 
                    },                     
                    M = {},
                },			
			},
            {
                { -- PWSHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PWSHP",
                    DBV = 60,
                    ONOFF = false,
                    L = { 
                        ANY = "Power Word: Shield HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Power Word: Shield on yourself.", 
                    },                     
                    M = {},
                },					
			},	            
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- PRIEST HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== TRINKETS ====== ",
                    },
                },
            },
			{
				{ -- Trinket Type 1
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Damage", value = "Damage" },
						{ text = "Friendly", value = "Friendly" },
						{ text = "Self Defensive", value = "SelfDefensive" },
						{ text = "Mana Gain", value = "ManaGain" },						
                    },
                    DB = "TrinketType1",
                    DBV = "Damage",
                    L = { 
                        ANY = "First Trinket",
                    }, 
                    TT = { 
                        ANY = "Pick what type of trinket you have in your first/upper trinket slot (only matters for trinkets with Use effects).", 
                    }, 
                    M = {},
                },	
				{ -- Trinket Type 2
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Damage", value = "Damage" },
						{ text = "Friendly", value = "Friendly" },
						{ text = "Self Defensive", value = "SelfDefensive" },
						{ text = "Mana Gain", value = "ManaGain" },						
                    },
                    DB = "TrinketType2",
                    DBV = "Damage",
                    L = { 
                        ANY = "Second Trinket",
                    }, 
                    TT = { 
                        ANY = "Pick what type of trinket you have in your second/lower trinket slot (only matters for trinkets with Use effects).", 
                    }, 
                    M = {},
                },				
			},			
			{
                { -- TrinketValue1
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketValue1",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "First Trinket Value",
                    },
                    TT = { 
                        ANY = "HP/Mana (%) to use your first trinket, based on what you've chosen for your trinket type. Damage trinkets will be used on burst targets.", 
                    },                     
                    M = {},
                },	
                { -- TrinketValue2
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketValue2",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Second Trinket Value",
                    },
                    TT = { 
                        ANY = "HP/Mana (%) to use your second trinket, based on what you've chosen for your trinket type. Damage trinkets will be used on burst targets.", 
                    },                     
                    M = {},
                },					
			},				
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },				
        },
        [ACTION_CONST_PRIEST_DISCIPLINE] = { 
            { -- GENERAL OPTIONS FIRST ROW
				{ -- AOE
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
                        Custom = "/run Action.AoEToggleMode()",
                        -- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
                        Value = value or nil, 
                        -- Very Very Optional, no idea why it will be need however.. 
                        TabN = '@number' or nil,                                
                        Print = '@string' or nil,
                    },
                },
                { -- HealthstoneHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ManaPotion",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Mana Potion MP (%)",
                    },
                    TT = { 
                        ANY = "MP (%) to use Mana Potion.", 
                    },                     
                    M = {},
                },	
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- CLEANSE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== DEFENSIVES ====== ",
                    },
                },
            },	
            {	
                { -- DesperatePrayerHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DesperatePrayerHP",
                    DBV = 75,
                    ONOFF = false,
                    L = { 
                        ANY = "Desperate Prayer HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Desperate Prayer on yourself.", 
                    },                     
                    M = {},
                },	
            },
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- TRINKETS HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== TRINKETS ====== ",
                    },
                },
            },
			{
				{ -- Trinket Type 1
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Damage", value = "Damage" },
						{ text = "Friendly", value = "Friendly" },
						{ text = "Self Defensive", value = "SelfDefensive" },
						{ text = "Mana Gain", value = "ManaGain" },						
                    },
                    DB = "TrinketType1",
                    DBV = "Damage",
                    L = { 
                        ANY = "First Trinket",
                    }, 
                    TT = { 
                        ANY = "Pick what type of trinket you have in your first/upper trinket slot (only matters for trinkets with Use effects).", 
                    }, 
                    M = {},
                },	
				{ -- Trinket Type 2
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Damage", value = "Damage" },
						{ text = "Friendly", value = "Friendly" },
						{ text = "Self Defensive", value = "SelfDefensive" },
						{ text = "Mana Gain", value = "ManaGain" },						
                    },
                    DB = "TrinketType2",
                    DBV = "Damage",
                    L = { 
                        ANY = "Second Trinket",
                    }, 
                    TT = { 
                        ANY = "Pick what type of trinket you have in your second/lower trinket slot (only matters for trinkets with Use effects).", 
                    }, 
                    M = {},
                },				
			},			
			{
                { -- TrinketValue1
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketValue1",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "First Trinket Value",
                    },
                    TT = { 
                        ANY = "HP/Mana (%) to use your first trinket, based on what you've chosen for your trinket type. Damage trinkets will be used on burst targets.", 
                    },                     
                    M = {},
                },	
                { -- TrinketValue2
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketValue2",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Second Trinket Value",
                    },
                    TT = { 
                        ANY = "HP/Mana (%) to use your second trinket, based on what you've chosen for your trinket type. Damage trinkets will be used on burst targets.", 
                    },                     
                    M = {},
                },					
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- CLEANSE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== OPTIONS ====== ",
                    },
                },
            },			
			{
				{ -- Cleanse
                    E = "Checkbox", 
                    DB = "Cleanse",
                    DBV = true,
                    L = { 
                        ANY = "Cleanse",
                    }, 
                    TT = { 
                        ANY = "Automatically cleanse (be sure to set suspend delay in advanced options on loader).",
                    }, 
                    M = {},
                },
                { -- Cleanse
                    E = "Checkbox", 
                    DB = "alwaysPoM",
                    DBV = true,
                    L = { 
                        ANY = "Always Prayer of Mending",
                    }, 
                    TT = { 
                        ANY = "Keep Prayer of Mending on cooldown (turn this off if you want to only use it when there are no stacks of PoM on any party member).",
                    }, 
                    M = {},
                },
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- CLEANSE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== HEALING VALUES ====== ",
                    },
                },
            },				
			{
                { -- Global Heal Modifier
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 2, 
					Precision = 1,
                    DB = "globalhealmod",
                    DBV = 1,
                    ONOFF = false,
                    L = { 
                        ANY = "Global Heal Modifier",
                    },
                    TT = { 
                        ANY = "Multiplies the healing calculations by this amount (if healing sliders are set to AUTO). A lower number means that your heals will be cast sooner. Not recommended to have this higher than 1. Default is 0.8.", 
                    },                     
                    M = {},
                },
                { -- Global Heal Modifier
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100, 
                    DB = "atonementSensitivity",
                    DBV = 35,
                    ONOFF = false,
                    L = { 
                        ANY = "Atonement Sensitivity",
                    },
                    TT = { 
                        ANY = "The % HP outlier required to switch to a direct heal spell versus using atonement healing. The higher the number, the more you rely on atonement for healing and less on direct healing. Recommended somewhere around 35.", 
                    },                     
                    M = {},
                },		
            },
            {
                { -- PainSuppressionHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PainSuppressionHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Pain Suppression HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Pain Suppression.", 
                    },                     
                    M = {},
                },						
                { -- PenanceHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PenanceHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Penance HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Penance on friendly target.", 
                    },                     
                    M = {},
                },
            },
            {					
                { -- FlashHealHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FlashHealHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Flash Heal No SoL HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Flash Heal without Surge of Light.", 
                    },                     
                    M = {},
                },			
                { -- FlashHealHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FlashHealSoLHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Flash Heal SoL HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Flash Heal with Surge of Light.", 
                    },                     
                    M = {},
                },		
			},	
            {
                { -- PowerWordRadianceHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PowerWordRadianceHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Power Word Radiance HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Power Word Radiance.", 
                    },                     
                    M = {},
                },	
                { -- ShadowCovenantHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ShadowCovenantHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Shadow Covenant HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Shadow Covenant.", 
                    },                     
                    M = {},
                },	
            },	
            {
                { -- HaloHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HaloHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Halo HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Halo.", 
                    },                     
                    M = {},
                },	
                { -- DivineStarHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DivineStarHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Divine Star HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Divine Star.", 
                    },                     
                    M = {},
                },	
            },	
            {
                { -- HolyNovaHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HolyNovaHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Holy Nova HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Holy Nova (only used with 20 stacks of Rhapsody).", 
                    },                     
                    M = {},
                },	
            },
            {
                { -- VoidShiftTarget
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "VoidShiftTarget",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Void Shift Target HP (%)",
                    },
                    TT = { 
                        ANY = "Target HP (%) to use Void Shift.", 
                    },                     
                    M = {},
                },	
                { -- VoidShiftPlayer
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "VoidShiftPlayer",
                    DBV = 70,
                    ONOFF = false,
                    L = { 
                        ANY = "Void Shift Player HP (%)",
                    },
                    TT = { 
                        ANY = "Player HP (%) to use Void Shift.", 
                    },                     
                    M = {},
                },	
            },
		},  
        [ACTION_CONST_PRIEST_HOLY] = { 
            { -- GENERAL OPTIONS FIRST ROW
				{ -- AOE
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
                        Custom = "/run Action.AoEToggleMode()",
                        -- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
                        Value = value or nil, 
                        -- Very Very Optional, no idea why it will be need however.. 
                        TabN = '@number' or nil,                                
                        Print = '@string' or nil,
                    },
                },
                { -- HealthstoneHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ManaPotion",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Mana Potion MP (%)",
                    },
                    TT = { 
                        ANY = "MP (%) to use Mana Potion.", 
                    },                     
                    M = {},
                },	
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- CLEANSE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== DEFENSIVES ====== ",
                    },
                },
            },
            {
                { -- DesperatePrayerHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DesperatePrayerHP",
                    DBV = 75,
                    ONOFF = false,
                    L = { 
                        ANY = "Desperate Prayer HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Desperate Prayer on yourself.", 
                    },                     
                    M = {},
                },	
            },
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- TRINKETS HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== TRINKETS ====== ",
                    },
                },
            },
			{
				{ -- Trinket Type 1
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Damage", value = "Damage" },
						{ text = "Friendly", value = "Friendly" },
						{ text = "Self Defensive", value = "SelfDefensive" },
						{ text = "Mana Gain", value = "ManaGain" },						
                    },
                    DB = "TrinketType1",
                    DBV = "Damage",
                    L = { 
                        ANY = "First Trinket",
                    }, 
                    TT = { 
                        ANY = "Pick what type of trinket you have in your first/upper trinket slot (only matters for trinkets with Use effects).", 
                    }, 
                    M = {},
                },	
				{ -- Trinket Type 2
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Damage", value = "Damage" },
						{ text = "Friendly", value = "Friendly" },
						{ text = "Self Defensive", value = "SelfDefensive" },
						{ text = "Mana Gain", value = "ManaGain" },						
                    },
                    DB = "TrinketType2",
                    DBV = "Damage",
                    L = { 
                        ANY = "Second Trinket",
                    }, 
                    TT = { 
                        ANY = "Pick what type of trinket you have in your second/lower trinket slot (only matters for trinkets with Use effects).", 
                    }, 
                    M = {},
                },				
			},			
			{
                { -- TrinketValue1
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketValue1",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "First Trinket Value",
                    },
                    TT = { 
                        ANY = "HP/Mana (%) to use your first trinket, based on what you've chosen for your trinket type. Damage trinkets will be used on burst targets.", 
                    },                     
                    M = {},
                },	
                { -- TrinketValue2
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketValue2",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Second Trinket Value",
                    },
                    TT = { 
                        ANY = "HP/Mana (%) to use your second trinket, based on what you've chosen for your trinket type. Damage trinkets will be used on burst targets.", 
                    },                     
                    M = {},
                },					
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- CLEANSE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== OPTIONS ====== ",
                    },
                },
            },			
			{
				{ -- Cleanse
                    E = "Checkbox", 
                    DB = "Cleanse",
                    DBV = true,
                    L = { 
                        ANY = "Cleanse",
                    }, 
                    TT = { 
                        ANY = "Automatically cleanse (be sure to set suspend delay in advanced options on loader).",
                    }, 
                    M = {},
                },
                { -- Cleanse
                    E = "Checkbox", 
                    DB = "alwaysPoM",
                    DBV = true,
                    L = { 
                        ANY = "Use PoM on cooldown",
                    }, 
                    TT = { 
                        ANY = "Keep Prayer of Mending on cooldown (turn this off if you want to only use it when there are no stacks of PoM on any party member).",
                    }, 
                    M = {},
                },
            },
            {
                { -- saveChastise
                    E = "Checkbox", 
                    DB = "saveChastise",
                    DBV = true,
                    L = { 
                        ANY = "Only Chastise for stun",
                    }, 
                    TT = { 
                        ANY = "Only use Chastise for stun, not for added DPS.",
                    }, 
                    M = {},
                }
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- CLEANSE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== HEALING VALUES ====== ",
                    },
                },
            },				
			{
                { -- Global Heal Modifier
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 2, 
					Precision = 1,
                    DB = "globalhealmod",
                    DBV = 0.8,
                    ONOFF = false,
                    L = { 
                        ANY = "Global Heal Modifier",
                    },
                    TT = { 
                        ANY = "Multiplies the healing calculations by this amount (if healing sliders are set to AUTO). A lower number means that your heals will be cast sooner. Not recommended to have this higher than 1. Default is 0.8.", 
                    },                     
                    M = {},
                },	
                { -- GuardianSpiritHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "GuardianSpiritHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Guardian Spirit HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Guardian Spirit.", 
                    },                     
                    M = {},
                },						
            },
			{
                { -- HealHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HealHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Heal HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Heal.", 
                    },                     
                    M = {},
                },					
                { -- FlashHealHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FlashHealHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Flash Heal HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Flash Heal.", 
                    },                     
                    M = {},
                },			
			},	
            {
                { -- PrayerofHealingHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PrayerofHealingHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Prayer of Healing HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Prayer of Healing.", 
                    },                     
                    M = {},
                },	
                { -- CircleofHealingHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "CircleofHealingHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Circle of Healing HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Circle of Healing.", 
                    },                     
                    M = {},
                },	
            },	
            {
                { -- HaloHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HaloHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Halo HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Halo.", 
                    },                     
                    M = {},
                },	
                { -- DivineStarHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DivineStarHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Divine Star HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Divine Star.", 
                    },                     
                    M = {},
                },	
            },	
            {
                { -- HWSanctifyHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HWSanctifyHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Holy Word: Sanctify HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Holy Word: Sanctify.", 
                    },                     
                    M = {},
                },	
                { -- HWSerenityHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HWSerenityHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Holy Word: Serenity HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Holy Word: Serenity.", 
                    },                     
                    M = {},
                },	
            },	
            {
                { -- VoidShiftTarget
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "VoidShiftTarget",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Void Shift Target HP (%)",
                    },
                    TT = { 
                        ANY = "Target HP (%) to use Void Shift.", 
                    },                     
                    M = {},
                },	
                { -- VoidShiftPlayer
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "VoidShiftPlayer",
                    DBV = 70,
                    ONOFF = false,
                    L = { 
                        ANY = "Void Shift Player HP (%)",
                    },
                    TT = { 
                        ANY = "Player HP (%) to use Void Shift.", 
                    },                     
                    M = {},
                },	
            },
		},
	},
}	