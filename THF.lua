-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.

    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Hybrid')
    state.HybridMode:options('Normal')
    state.RangedMode:options('Normal')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Fotia Belt"
    gear.AugQuiahuiz = {}

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {hands="Plunderer's Armlets +1", feet="Skulker's Poulaines +1"}
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Jute Boots +1"}

    sets.buff['Sneak Attack'] = {
      head="Meghanada Visor +1",
      body="Meghanada Cuirie",
      hands="Skulker's Armlets",
      legs="Samnuha Tights",
      feet="Meg. Jam. +1",
      neck="Love Torque",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Apate Ring",
      right_ring="Rajas Ring",
      back="Toutatis's Cape",
    }

    sets.buff['Trick Attack'] = {
      head="Meghanada Visor +1",
      body="Meghanada Cuirie",
      hands="Pillager's Armlets",
      legs="Samnuha Tights",
      feet="Meg. Jam. +1",
      neck="Love Torque",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Apate Ring",
      right_ring="Rajas Ring",
      back="Canny Cape",
    }

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines"}
    sets.precast.JA['Hide'] = {body="Assassin's Vest"}
    sets.precast.JA['Conspirator'] = {body = "Raider's Vest +2"}
    sets.precast.JA['Steal'] = {hands="Pillager's Armlets",legs="Pillager's Culottes",feet="Pillager's Poulaines"}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Skulker's Poulaines +1"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
      head="Haruspex Hat",
      body="Mirke Wardecors",
      hands="Leyline Gloves",
      legs="Samnuha Tights",
      feet="Meg. Jam. +1",
      neck="Voltsurge Torque",
      waist="Twilight Belt",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Diamond Ring", augments={'MND+3','Spell interruption rate down -5%','"Resist Silence"+3',}},
      back="Boxer's Mantle",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads", back="Mujin Mantle"})


    -- Ranged snapshot gear
    sets.precast.RA = {
      head="Meghanada Visor +1",
      body="Meghanada Cuirie",
      hands="Meg. Gloves +1",
      legs="Samnuha Tights",
      feet="Meg. Jam. +1",
      neck="Asperity Necklace",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Apate Ring",
      right_ring="Rajas Ring",
    }


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      head="Sukeroku Hachimaki",
      body="Taeon Tabard",
      hands="Meg. Gloves +1",
      legs="Herculean Trousers",
      feet={ name="Taeon Boots", augments={'Attack+21','Weapon Skill Acc.+17','Weapon skill damage +3%',}},
      neck="Rancor Collar",
      waist="Fotia Belt",
      left_ear="Ishvara Earring",
      right_ear="Bladeborn Earring",
      left_ring="Rufescent Ring",
      right_ring="Rajas Ring",
      back="Vespid Mantle",
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
      neck="Love Torque",
    })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {neck="Breeze Gorget"})
    sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {neck="Breeze Gorget"})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {neck="Breeze Gorget"})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {neck="Breeze Gorget"})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {neck="Breeze Gorget"})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {neck="Breeze Gorget"})
    sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {neck="Breeze Gorget"})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {neck="Breeze Gorget"})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {neck="Breeze Gorget"})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {neck="Breeze Gorget"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {neck="Breeze Gorget"})
    sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {neck="Breeze Gorget"})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {neck="Breeze Gorget"})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {neck="Breeze Gorget"})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {neck="Breeze Gorget"})

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {})
    sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})

    sets.precast.WS['Aeolian Edge'] = {
      head="Sukeroku Hachimaki",
      body="Taeon Tabard",
      hands="Meg. Gloves +1",
      legs={ name="Taeon Tights", augments={'Accuracy+2','Weapon Skill Acc.+19','STR+5 DEX+5',}},
      feet={ name="Taeon Boots", augments={'Attack+21','Weapon Skill Acc.+17','Weapon skill damage +3%',}},
      neck="Love Torque",
      waist="Fotia Belt",
      left_ear="Ishvara Earring",
      right_ear="Hecate's Earring",
      left_ring="Fenrir Ring",
      right_ring="Acumen Ring",
      back="Vespid Mantle",
    }

    sets.precast.WS['Cyclone'] = sets.precast.WS['Aeolian Edge']
    sets.precast.WS['Gust Slash'] = sets.precast.WS['Aeolian Edge']


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    -- Specific spells
    sets.midcast.Utsusemi = sets.precast.FC.Utsusemi

    -- Ranged gear
    sets.midcast.RA = sets.precast.RA

    sets.midcast.RA.Acc = sets.precast.RA


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = sets.idle


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
      head="Skormoth Mask",
      body="Meghanada Cuirie",
      hands="Meg. Gloves +1",
      legs="Desultor Tassets",
      feet="Jute Boots +1",
      neck="Twilight Torque",
      waist="Fotia Belt",
      left_ear="Dudgeon Earring",
      right_ear="Heartseeker Earring",
      left_ring="Defending Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back="Mecisto. Mantle",
    }

    sets.idle.Town = {
      head="Skormoth Mask",
      body="Meghanada Cuirie",
      hands="Meg. Gloves +1",
      legs="Desultor Tassets",
      feet="Jute Boots +1",
      neck="Subtlety Spec.",
      waist="Fotia Belt",
      left_ear="Dudgeon Earring",
      right_ear="Heartseeker Earring",
      left_ring="Defending Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back="Toutatis's Cape",
    }

    sets.idle.Weak = sets.idle


    -- Defense sets

    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
      head="Skormoth Mask",
      body="Meghanada Cuirie",
      hands="Floral Gauntlets",
      legs="Samnuha Tights",
      feet="Herculean Boots",
      neck="Asperity Necklace",
      waist="Cetl Belt",
      left_ear="Dudgeon Earring",
      right_ear="Heartseeker Earring",
      left_ring="Epona's Ring",
      right_ring="Rajas Ring",
      back="Canny Cape",
    }

    sets.engaged.Acc = {
      ammo="Honed Tathlum",
      head="Meghanada Visor +1",
      body="Meghanada Cuirie",
      hands="Meg. Gloves +1",
      legs="Meg. Chausses +1",
      feet="Meg. Jam. +1",
      neck="Subtlety Spec.",
      waist="Cetl Belt",
      left_ear="Dudgeon Earring",
      right_ear="Heartseeker Earring",
      left_ring="Epona's Ring",
      right_ring="Rajas Ring",
      back="Toutatis's Cape",
    }

    sets.engaged.Hybrid = {
      ammo="Ginsen",
      head="Herculean Helm",
      body="Meghanada Cuirie",
      hands="Floral Gauntlets",
      legs="Meg. Chausses +1",
      feet="Herculean Boots",
      neck="Clotharius Torque",
      waist="Cetl Belt",
      left_ear="Dudgeon Earring",
      right_ear="Heartseeker Earring",
      left_ring="Epona's Ring",
      right_ring="Rajas Ring",
      back="Toutatis's Cape",
    }


end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'

    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    msg = msg .. ': '

    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 18)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 18)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 18)
    else
        set_macro_page(1, 18)
    end
end
