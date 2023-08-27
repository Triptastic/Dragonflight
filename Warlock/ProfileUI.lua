--####################################
--##### TRIP'S WARLOCK PROFILEUI #####
--####################################


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
        [ACTION_CONST_WARLOCK_AFFLICTION] = {  
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
                { -- AOE
                    E = "Checkbox", 
                    DB = "autoDOT",
                    DBV = false,
                    L = { 
                        ANY = "Auto DOT", 
                    }, 
                    TT = { 
                        ANY = "Use Auto DOT (experimental)"
                    }, 
                    M = {},
                },
            },
            {
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Pet", value = "Pet" },
                        { text = "Nameplates", value = "Nameplates" },                    
                    },
                    DB = "aoeDetection",
                    DBV = "Pet",
                    L = { 
                        ANY = "AoE Detection"
                    },
                    TT = { 
                        ANY = "Choose method for AoE detection. Pet only works with Felhound and Sayaad."
                    },
                    M = {},
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
                { -- UnendingResolveHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "UnendingResolveHP",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Unending Resolve HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Unending Resolve.", 
                    },                     
                    M = {},
                },				
                { -- FelPactHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FelPactHP",
                    DBV = 75,
                    ONOFF = false,
                    L = { 
                        ANY = "Fel Pact HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Fel Pact.", 
                    },                     
                    M = {},
                },						
            },
            {
                { -- MortalCoilHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "MortalCoilHP",
                    DBV = 60,
                    ONOFF = true,
                    L = { 
                        ANY = "Mortal Coil Health (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Mortal Coil.", 
                    },                     
                    M = {},
                },	
                { -- DrainLife
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DrainLifeHP",
                    DBV = 30,
                    ONOFF = true,
                    L = { 
                        ANY = "Drain Life Health (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Drain Life.", 
                    },                     
                    M = {},
                },	
            },					
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- Pet Stuff -- Header
                {
                    E = "Header",
                    L = {
                        ANY = " ====== PETS ====== ",
                    },
                },
            },
            { -- Pet Stuff - Content
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = A.GetSpellInfo(688), value = "IMP" },
                        { text = A.GetSpellInfo(697), value = "VOIDWALKER" },                    
                        { text = A.GetSpellInfo(691), value = "FELHUNTER" },
                        { text = A.GetSpellInfo(366222), value = "SAYAAD" },
                    },
                    DB = "PetChoice",
                    DBV = "IMP",
                    L = { 
                        enUS = "Pet Selection", 
                        ruRU = "Выбор питомца", 
                        frFR = "Sélection du familier",
                    }, 
                    TT = { 
                        enUS = "Choose the pet to summon", 
                        ruRU = "Выберите питомца для призыва", 
                        frFR = "Choisir le familier à invoquer",
                    },
                    M = {},
                },
                { -- Health Funnel
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "HealthFunnelHP",
                    DBV = 10, 
                    ONOFF = true,
                    L = { 
                        ANY = "Health Funnel HP (%)",
                    }, 
                    TT = { 
                        ANY = "Will use Health Funnel when pet reaches percent HP. Won't use if own HP is critical."
                    },					
                    M = {},
                },					
            }, 
        },
        [ACTION_CONST_WARLOCK_DESTRUCTION] = {  
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
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Pet", value = "Pet" },
                        { text = "Nameplates", value = "Nameplates" },                    
                    },
                    DB = "aoeDetection",
                    DBV = "Pet",
                    L = { 
                        ANY = "AoE Detection"
                    },
                    TT = { 
                        ANY = "Choose method for AoE detection. Pet only works with Felhound and Sayaad."
                    },
                    M = {},
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
                { -- UnendingResolveHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "UnendingResolveHP",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Unending Resolve HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Unending Resolve.", 
                    },                     
                    M = {},
                },				
                { -- FelPactHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FelPactHP",
                    DBV = 75,
                    ONOFF = false,
                    L = { 
                        ANY = "Fel Pact HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Fel Pact.", 
                    },                     
                    M = {},
                },						
            },
            {
                { -- MortalCoilHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "MortalCoilHP",
                    DBV = 60,
                    ONOFF = true,
                    L = { 
                        ANY = "Mortal Coil Health (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Mortal Coil.", 
                    },                     
                    M = {},
                },	
                { -- DrainLife
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DrainLifeHP",
                    DBV = 30,
                    ONOFF = true,
                    L = { 
                        ANY = "Drain Life Health (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Drain Life.", 
                    },                     
                    M = {},
                },	
            },					
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- Pet Stuff -- Header
                {
                    E = "Header",
                    L = {
                        ANY = " ====== PETS ====== ",
                    },
                },
            },
            { -- Pet Stuff - Content
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = A.GetSpellInfo(688), value = "IMP" },
                        { text = A.GetSpellInfo(697), value = "VOIDWALKER" },                    
                        { text = A.GetSpellInfo(691), value = "FELHUNTER" },
                        { text = A.GetSpellInfo(366222), value = "SAYAAD" },
                    },
                    DB = "PetChoice",
                    DBV = "IMP",
                    L = { 
                        enUS = "Pet Selection", 
                        ruRU = "Выбор питомца", 
                        frFR = "Sélection du familier",
                    }, 
                    TT = { 
                        enUS = "Choose the pet to summon", 
                        ruRU = "Выберите питомца для призыва", 
                        frFR = "Choisir le familier à invoquer",
                    },
                    M = {},
                },
                { -- Health Funnel
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "HealthFunnelHP",
                    DBV = 10, 
                    ONOFF = true,
                    L = { 
                        ANY = "Health Funnel HP (%)",
                    }, 
                    TT = { 
                        ANY = "Will use Health Funnel when pet reaches percent HP. Won't use if own HP is critical."
                    },					
                    M = {},
                },					
            }, 
        },
        [ACTION_CONST_WARLOCK_DEMONOLOGY] = {  
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
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Pet", value = "Pet" },
                        { text = "Nameplates", value = "Nameplates" },                    
                    },
                    DB = "aoeDetection",
                    DBV = "Pet",
                    L = { 
                        ANY = "AoE Detection"
                    },
                    TT = { 
                        ANY = "Choose method for AoE detection. Pet only works with Felhound and Sayaad."
                    },
                    M = {},
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
                { -- UnendingResolveHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "UnendingResolveHP",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Unending Resolve HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Unending Resolve.", 
                    },                     
                    M = {},
                },				
                { -- FelPactHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FelPactHP",
                    DBV = 75,
                    ONOFF = false,
                    L = { 
                        ANY = "Fel Pact HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Fel Pact.", 
                    },                     
                    M = {},
                },						
            },
            {
                { -- MortalCoilHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "MortalCoilHP",
                    DBV = 60,
                    ONOFF = true,
                    L = { 
                        ANY = "Mortal Coil Health (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Mortal Coil.", 
                    },                     
                    M = {},
                },	
                { -- DrainLife
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DrainLifeHP",
                    DBV = 30,
                    ONOFF = true,
                    L = { 
                        ANY = "Drain Life Health (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Drain Life.", 
                    },                     
                    M = {},
                },	
            },					
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- Pet Stuff -- Header
                {
                    E = "Header",
                    L = {
                        ANY = " ====== PETS ====== ",
                    },
                },
            },
            { -- Pet Stuff - Content
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = A.GetSpellInfo(688), value = "IMP" },
                        { text = A.GetSpellInfo(697), value = "VOIDWALKER" },                    
                        { text = A.GetSpellInfo(691), value = "FELHUNTER" },
                        { text = A.GetSpellInfo(366222), value = "SAYAAD" },
                        { text = A.GetSpellInfo(30146), value = "FELGUARD" },
                    },
                    DB = "PetChoice",
                    DBV = "IMP",
                    L = { 
                        enUS = "Pet Selection", 
                        ruRU = "Выбор питомца", 
                        frFR = "Sélection du familier",
                    }, 
                    TT = { 
                        enUS = "Choose the pet to summon", 
                        ruRU = "Выберите питомца для призыва", 
                        frFR = "Choisir le familier à invoquer",
                    },
                    M = {},
                },
                { -- Health Funnel
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "HealthFunnelHP",
                    DBV = 10, 
                    ONOFF = true,
                    L = { 
                        ANY = "Health Funnel HP (%)",
                    }, 
                    TT = { 
                        ANY = "Will use Health Funnel when pet reaches percent HP. Won't use if own HP is critical."
                    },					
                    M = {},
                },					
            }, 
        },
    },
}