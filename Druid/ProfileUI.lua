--###########################
--##### TRIP'S DRUID UI #####
--###########################

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
    DateTime = "v1.0.0 (10 December 2020)",
    -- Class settings
    [2] = {        
        [ACTION_CONST_DRUID_GUARDIAN] = { 
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
        },
        [ACTION_CONST_DRUID_FERAL] = { 
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
		},  
        [ACTION_CONST_DRUID_BALANCE] = { 
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
                { -- BarkskinHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "BarkskinHP",
                    DBV = 50,
                    ONOFF = false,
                    L = { 
                        ANY = "Barkskin HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Barkskin.", 
                    },                     
                    M = {},
                },	
                { -- RenewalHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RenewalHP",
                    DBV = 60,
                    ONOFF = false,
                    L = { 
                        ANY = "Renewal HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Renewal.", 
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
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
        },
        [ACTION_CONST_DRUID_RESTORATION] = { 
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
                { -- ManaPotion
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
                { -- BarkskinHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "BarkskinHP",
                    DBV = 50,
                    ONOFF = false,
                    L = { 
                        ANY = "Barkskin HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Barkskin.", 
                    },                     
                    M = {},
                },	
                { -- RenewalHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RenewalHP",
                    DBV = 60,
                    ONOFF = false,
                    L = { 
                        ANY = "Renewal HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Renewal.", 
                    },                     
                    M = {},
                },	
            },
			{
				{ -- autoShift
                    E = "Checkbox", 
                    DB = "autoShift",
                    DBV = true,
                    L = { 
                        ANY = "Automatically Shapeshift",
                    }, 
                    TT = { 
                        ANY = "Automatically shapeshift out of roots.",
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
            },
            {	
                { -- IronbarkHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "IronbarkHP",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Ironbark HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Ironbark.", 
                    },                     
                    M = {},
                },		
                { -- EmergencyHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "EmergencyHP",
                    DBV = 35,
                    ONOFF = false,
                    L = { 
                        ANY = "Emergency HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to consider emergency (Nature's Swiftness + Regrowth).", 
                    },                     
                    M = {},
                },					
            },
			{
                { -- SwiftmendNoReforestation
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "SwiftmendNoReforestation",
                    DBV = 70,
                    ONOFF = false,
                    L = { 
                        ANY = "Swiftmend without Reforestation HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Swiftmend with less than 2 stacks of Reforestation.", 
                    },                     
                    M = {},
                },
                { -- SwiftmendReforestation
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "SwiftmendReforestation",
                    DBV = 45,
                    ONOFF = false,
                    L = { 
                        ANY = "Swiftmend with Reforestation HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Swiftmend at 2 stacks of Reforestation.", 
                    },                     
                    M = {},
                },
            },
            {					
                { -- RejuvenationHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RejuvenationHP",
                    DBV = 90,
                    ONOFF = false,
                    L = { 
                        ANY = "Rejuventation HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Rejuvenation.", 
                    },                     
                    M = {},
                },		
                    { -- AdaptiveSwarmHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "AdaptiveSwarmHP",
                    DBV = 90,
                    ONOFF = false,
                    L = { 
                        ANY = "Adaptive Swarm HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Adaptive Swarm.", 
                    },                     
                    M = {},
                },		
			},	
            {
                { -- RegrowthHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RegrowthHP",
                    DBV = 60,
                    ONOFF = false,
                    L = { 
                        ANY = "Regrowth HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Regrowth with no Omen of Clarity.", 
                    },                     
                    M = {},
                },	
                { -- RegrowthHPOOC
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RegrowthHPOOC",
                    DBV = 75,
                    ONOFF = false,
                    L = { 
                        ANY = "Regrowth HP with Omen (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Regrowth with Omen of Clarity.", 
                    },                     
                    M = {},
                },	
            },	
            {
                { -- wildGrowthHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "wildGrowthHP",
                    DBV = 85,
                    ONOFF = false,
                    L = { 
                        ANY = "Wild Growth HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Wild Growth (use with next slider).", 
                    },                     
                    M = {},
                },	
                { -- wildGrowthUnits
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 6,                            
                    DB = "wildGrowthUnits",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = "Wild Growth Units",
                    },
                    TT = { 
                        ANY = "Amount of units below HP (%) to use Wild Growth (use with previous slider).", 
                    },                     
                    M = {},
                },	
            },	
            {
                { -- convokeHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "convokeHP",
                    DBV = 70,
                    ONOFF = false,
                    L = { 
                        ANY = "Convoke The Spirits HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Convoke The Spirits (use with next slider).", 
                    },                     
                    M = {},
                },	
                { -- convokeUnits
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "convokeUnits",
                    DBV = 4,
                    ONOFF = false,
                    L = { 
                        ANY = "Convoke The Spirits Units",
                    },
                    TT = { 
                        ANY = "Amount of units below HP (%) to use Convoke The Spirits (use with previous slider).", 
                    },                     
                    M = {},
                },	
            },	
        },
	},
}	