--############################
--##### TRIP'S EVOKER UI #####
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
    DateTime = "v1.0.0 (10 December 2020)",
    -- Class settings
    [2] = {        
        [ACTION_CONST_EVOKER_DEVASTATION] = { 
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
                { -- Hover
                    E = "Checkbox", 
                    DB = "useHover",
                    DBV = true,
                    L = { 
                        ANY = "Use Hover", 
                    }, 
                    TT = { 
                        ANY = "Automatically use Hover when moving and in combat.", 
                    }, 
                    M = {},
                },
            },
            { -- TRINKETS
                {
                    E = "Header",
                    L = {
                        ANY = " ====== DEFENSIVES ====== ",
                    },
                },
            },
            {               
                { -- ObsidianScalesHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ObsidianScalesHP",
                    DBV = 60,
                    ONOFF = false,
                    L = { 
                        ANY = "Obsidian Scales HP",
                    },
                    TT = { 
                        ANY = "Obsidian Scales HP (%)", 
                    },                     
                    M = {},
                },	
            },
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- TRINKETS
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
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },						
        },
        [ACTION_CONST_EVOKER_PRESERVATION] = { 
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
                { -- Hover
                    E = "Checkbox", 
                    DB = "useHover",
                    DBV = true,
                    L = { 
                        ANY = "Use Hover", 
                    }, 
                    TT = { 
                        ANY = "Automatically use Hover when moving and in combat.", 
                    }, 
                    M = {},
                },
            },
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- TRINKETS
                {
                    E = "Header",
                    L = {
                        ANY = " ====== DEFENSIVES ====== ",
                    },
                },
            },
            {               
                { -- ObsidianScalesHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ObsidianScalesHP",
                    DBV = 60,
                    ONOFF = false,
                    L = { 
                        ANY = "Obsidian Scales HP",
                    },
                    TT = { 
                        ANY = "Obsidian Scales HP (%)", 
                    },                     
                    M = {},
                },	
            },
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- TRINKETS
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
                        ANY = " ====== CLEANSE ====== ",
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
                        ANY = "Automatically cleanse (be sure to set suspend values in your advanced settings).",
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
                { -- EmergencyHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "EmergencyHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Emergency HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) of friendly target to consider a healing emergency.", 
                    },                     
                    M = {},
                },						
            },
            {
                { -- DreamFlightHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DreamFlightHP",
                    DBV = 80,
                    ONOFF = false,
                    L = { 
                        ANY = "Dream Flight HP",
                    },
                    TT = { 
                        ANY = "Dream Flight HP (%)", 
                    },                     
                    M = {},
                },	
                { -- DreamFlightUnits
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 15,                            
                    DB = "DreamFlightUnits",
                    DBV = 10,
                    ONOFF = false,
                    L = { 
                        ANY = "Dream Flight Units",
                    },
                    TT = { 
                        ANY = "Number of injured friendlies to use Dream Flight. As we can only check in a radius around the player, higher numbers become far less accurate. Will automatically scale to 5 if value is greater than 5 and in a dungeon.", 
                    },                     
                    M = {},
                },					
			},	
            {
                { -- DreamBreathHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DreamBreathHP",
                    DBV = 80,
                    ONOFF = false,
                    L = { 
                        ANY = "Dream Breath HP",
                    },
                    TT = { 
                        ANY = "Dream Breath HP (%)", 
                    },                     
                    M = {},
                },	
                { -- DreamBreathUnits
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 5,                            
                    DB = "DreamBreathUnits",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = "Dream Breath Units",
                    },
                    TT = { 
                        ANY = "Number of injured friendlies to use Dream Breath.", 
                    },                     
                    M = {},
                },					
			},	
            {
                { -- SpiritbloomHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "SpiritbloomHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Spirit Bloom HP",
                    },
                    TT = { 
                        ANY = "Spirit Bloom HP (%)", 
                    },                     
                    M = {},
                },
                { -- EchoHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "EchoHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Echo HP",
                    },
                    TT = { 
                        ANY = "Echo HP (%)", 
                    },                     
                    M = {},
                },
            },
            {
                { -- VerdantEmbraceHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "VerdantEmbraceHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Verdant Embrace HP",
                    },
                    TT = { 
                        ANY = "Verdant Embrace HP (%)", 
                    },                     
                    M = {},
                },
                { -- EmeraldBlossomHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "EmeraldBlossomHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Emerald Blossom HP",
                    },
                    TT = { 
                        ANY = "Emerald Blossom HP (%)", 
                    },                     
                    M = {},
                },
            },
            {
                { -- LivingFlameHP
                E = "Slider",                                                     
                MIN = 0, 
                MAX = 100,                            
                DB = "LivingFlameHP",
                DBV = 100,
                ONOFF = true,
                L = { 
                    ANY = "Living Flame HP",
                },
                TT = { 
                    ANY = "Living Flame HP (%)", 
                },                     
                M = {},
                },
            },
        },
	},
}	