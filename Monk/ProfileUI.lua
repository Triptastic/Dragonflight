--##########################
--##### TRIP'S MONK UI #####
--##########################

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
        [ACTION_CONST_MONK_BREWMASTER] = { 
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
                        ANY = " ====== DEFENSIVES ====== ",
                    },
                },
            },
			{
				{ -- AllowOverlap
                    E = "Checkbox", 
                    DB = "AllowOverlap",
                    DBV = false,
                    L = { 
                        ANY = "Allow Overlap of CDs",
                    }, 
                    TT = { 
                        ANY = "Allow the rotation to use multiple defensive cooldowns at the same time (except for Healing Elixir).",
                    }, 
                    M = {},
                },
            },
            {
                { -- HealingElixirHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HealingElixirHP",
                    DBV = 60,
                    ONOFF = false,
                    L = { 
                        ANY = "Healing Elixir HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Healing Elixir.", 
                    },                     
                    M = {},
                },
            },
            {		
                { -- ExpelHarmHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ExpelHarmHP",
                    DBV = 70,
                    ONOFF = false,
                    L = { 
                        ANY = "Expel Harm HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Expel Harm.", 
                    },                     
                    M = {},
                },	
                { -- HealingSphereCount
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 5,                            
                    DB = "HealingSphereCount",
                    DBV = 2,
                    ONOFF = false,
                    L = { 
                        ANY = "Expel Harm Healing Spheres",
                    },
                    TT = { 
                        ANY = "Healing Sphere amount needed before using Expel Harm", 
                    },                     
                    M = {},
                },	
			},		
			{
                { -- FortifyingBrewHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FortifyingBrewHP",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Fortifying Brew HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Fortifying Brew.", 
                    },                     
                    M = {},
                },		
                { -- DampenHarmHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DampenHarmHP",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Dampen Harm HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Dampen Harm.", 
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
        [ACTION_CONST_MONK_WINDWALKER] = { 
            { -- GENERAL HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== GENERAL ====== ",
                    },
                },
            },            
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
            { -- CLEANSE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== DEFENSIVES ====== ",
                    },
                },
            },
            {
                { -- AllowOverlap
                    E = "Checkbox", 
                    DB = "AllowOverlap",
                    DBV = false,
                    L = { 
                        ANY = "Allow Overlap of CDs",
                    }, 
                    TT = { 
                        ANY = "Allow the rotation to use multiple defensive cooldowns at the same time (except for Healing Elixir).",
                    }, 
                    M = {},
                },
                { -- HealingElixirHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HealingElixirHP",
                    DBV = 60,
                    ONOFF = false,
                    L = { 
                        ANY = "Healing Elixir HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Healing Elixir.", 
                    },                     
                    M = {},
                },				
            },		
            {
                { -- FortifyingBrewHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FortifyingBrewHP",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Fortifying Brew HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Fortifying Brew.", 
                    },                     
                    M = {},
                },		
                { -- DampenHarmHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DampenHarmHP",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Dampen Harm HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Dampen Harm.", 
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
        [ACTION_CONST_MONK_MISTWEAVER] = { 
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
                        ANY = " ====== DEFENSIVES ====== ",
                    },
                },
            },
			{
				{ -- AllowOverlap
                    E = "Checkbox", 
                    DB = "AllowOverlap",
                    DBV = false,
                    L = { 
                        ANY = "Allow Overlap of CDs",
                    }, 
                    TT = { 
                        ANY = "Allow the rotation to use multiple defensive cooldowns at the same time (except for Healing Elixir).",
                    }, 
                    M = {},
                },
                { -- HealingElixirHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HealingElixirHP",
                    DBV = 60,
                    ONOFF = false,
                    L = { 
                        ANY = "Healing Elixir HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Healing Elixir.", 
                    },                     
                    M = {},
                },				
			},		
			{
                { -- FortifyingBrewHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FortifyingBrewHP",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Fortifying Brew HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Fortifying Brew.", 
                    },                     
                    M = {},
                },		
                { -- DampenHarmHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DampenHarmHP",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Dampen Harm HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Dampen Harm.", 
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
                        ANY = "Automatically cleanse (careful when using this, might be very fast on cleansing).",
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
                { -- ExpelHarm
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ExpelHarmHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Expel Harm HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Expel Harm.", 
                    },                     
                    M = {},
                },					
                { -- Vivify
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "VivifyHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Vivify HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Vivify.", 
                    },                     
                    M = {},
                },
			},	
			{
				{ -- BlanketRenewingMist
                    E = "Checkbox", 
                    DB = "BlanketRenewingMist",
                    DBV = true,
                    L = { 
                        ANY = "Blanket Renewing Mist",
                    }, 
                    TT = { 
                        ANY = "Keep Renewing Mist on raid/party.",
                    }, 
                    M = {},
                },			
                { -- RenewingMist
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RenewingMistHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Renewing Mist HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Renewing Mist.", 
                    },                     
                    M = {},
                },
			},
			{
                { -- EnvelopingMist
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "EnvelopingMistHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Enveloping Mist HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Enveloping Mist.", 
                    },                     
                    M = {},
                },
                { -- LifeCocoon
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "LifeCocoonHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Life Cocoon HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Life Cocoon.", 
                    },                     
                    M = {},
                },					
			},
			{
                { -- EssenceFontHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "EssenceFontHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Essence Font HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Essence Font.", 
                    },                     
                    M = {},
                },			
                { -- EssenceFontTargets
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 6,                            
                    DB = "EssenceFontTargets",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = "Essence Font Targets",
                    },
                    TT = { 
                        ANY = "Amount of targets to fall below HP value (previous slider).", 
                    },                     
                    M = {},
                },
			},
			{
                { -- RefreshingJadeWind
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RefreshingJadeWindHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Refreshing Jade Wind HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Refreshing Jade Wind.", 
                    },                     
                    M = {},
                },			
                { -- EssenceFontTargets
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 6,                            
                    DB = "RefreshingJadeWindTargets",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = "Refreshing Jade Wind Targets",
                    },
                    TT = { 
                        ANY = "Amount of targets to fall below HP value (previous slider).", 
                    },                     
                    M = {},
                },
			},			
			{
                { -- ChiJiHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ChiJiHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Invoke Chi-Ji/Yu'lon HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Invoke Chi-Ji/Yu'lon.", 
                    },                     
                    M = {},
                },	
                { -- ChiJiTargets
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 25,                            
                    DB = "ChiJiTargets",
                    DBV = 25,
                    ONOFF = true,
                    L = { 
                        ANY = "Invoke Chi-Ji/Yu'lon Targets",
                    },
                    TT = { 
                        ANY = "Amount of targets to fall below HP value (previous slider).", 
                    },                     
                    M = {},
                },	
			},
			{
                { -- RevivalHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RevivalHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Revival/Restoral HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Revival/Restoral.", 
                    },                     
                    M = {},
                },
                { -- RevivalTargets
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 25,                            
                    DB = "RevivalTargets",
                    DBV = 25,
                    ONOFF = true,
                    L = { 
                        ANY = "Revival/Restoral Targets",
                    },
                    TT = { 
                        ANY = "Amount of targets to fall below HP value (previous slider)", 
                    },                     
                    M = {},
                },					
			},			
		},
	},
}	