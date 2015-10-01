-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    gear.MovementFeet = {name="Hachiya Kyahan"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Hachiya Kyahan"

    select_movement_feet()
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Iga Tekko +2"}
    sets.precast.JA['Sange'] = {body="Mochizuki Chainmail"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
      head={ name="Uk'uxkaj Cap", augments={'Haste+2','"Snapshot"+2','STR+8',}},
      body="Hachi. Chain. +1",
      hands={ name="Taeon Gloves", augments={'DEF+20','"Triple Atk."+2','Crit. hit damage +2%',}},
      legs="Hachi. Hakama +1",
      feet={ name="Taeon Boots", augments={'Accuracy+24','"Triple Atk."+2','Crit. hit damage +2%',}},
    }
        -- Uk'uxkaj Cap, Daihanshi Habaki

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
      head="Whirlpool Mask",
      body={ name="Mochi. Chainmail", augments={'Enhances "Sange" effect',}},
      hands={ name="Otronif Gloves", augments={'Phys. dmg. taken -3%','"Mag.Def.Bns."+2',}},
      legs="Hachi. Hakama +1",
      feet={ name="Taeon Boots", augments={'Accuracy+24','"Triple Atk."+2','Crit. hit damage +2%',}},
      neck="Subtlety Spec.",
      waist="Cetl Belt",
      left_ear="Steelflash Earring",
      right_ear="Heartseeker Earring",
      left_ring="Epona's Ring",
      right_ring="Rajas Ring",
      back={ name="Yokaze Mantle", augments={'STR+1','DEX+2','Weapon skill damage +1%',}},
    }

    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells

    sets.precast.FC = {
      head={ name="Anwig Salade", augments={'"Fast Cast"+3','"Blood Pact" ability delay -3','INT+2','"Fast Cast"+2',}},
      body={ name="Mirke Wardecors", augments={'"Fast Cast"+5','Mag. Acc.+4',}},
      hands={ name="Mochizuki Tekko", augments={'Enh. "Ninja Tool Expertise" effect',}},
      legs="Iga Hakama +2",
      feet="Iga Kyahan +2",
      neck="Voltsurge Torque",
      waist="Druid's Rope",
      left_ear="Loquac. Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back="Mujin Mantle",
    }
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Mochizuki Chainmail",feet="Iga Kyahan +2"})

    -- Snapshot for ranged
    sets.precast.RA = {
      body={ name="Mochi. Chainmail", augments={'Enhances "Sange" effect',}},
      hands="Hachiya Tekko +1",
      legs="Hachi. Hakama +1",
      feet={ name="Taeon Boots", augments={'Accuracy+24','"Triple Atk."+2','Crit. hit damage +2%',}},
      back={ name="Yokaze Mantle", augments={'STR+1','DEX+2','Weapon skill damage +1%',}},
    }

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      head={ name="Uk'uxkaj Cap", augments={'Haste+2','"Snapshot"+2','STR+8',}},
      body="Hachi. Chain. +1",
      hands={ name="Taeon Gloves", augments={'DEF+20','"Triple Atk."+2','Crit. hit damage +2%',}},
      legs={ name="Taeon Tights", augments={'"Triple Atk."+2','Crit. hit damage +2%',}},
      feet={ name="Taeon Boots", augments={'Attack+6','Weapon skill damage +3%',}},
      neck="Rancor Collar",
      waist="Fotia Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Epona's Ring",
      right_ring="Rajas Ring",
      back={ name="Yokaze Mantle", augments={'STR+1','DEX+2','Weapon skill damage +1%',}},
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,
        {})

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,
        {})

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {})


    sets.precast.WS['Aeolian Edge'] = {
      head={ name="Uk'uxkaj Cap", augments={'Haste+2','"Snapshot"+2','STR+8',}},
      body="Hachi. Chain. +1",
      hands={ name="Taeon Gloves", augments={'DEF+20','"Triple Atk."+2','Crit. hit damage +2%',}},
      legs={ name="Taeon Tights", augments={'"Triple Atk."+2','Crit. hit damage +2%',}},
      feet={ name="Taeon Boots", augments={'Attack+6','Weapon skill damage +3%',}},
      neck="Rancor Collar",
      waist="Fotia Belt",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Fenrir Ring",
      right_ring="Acumen Ring",
      back="Toro Cape",
    }


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet="Iga Kyahan +2"})

    sets.midcast.ElementalNinjutsu = {
      head="Koga Hatsuburi",
      body="Hachi. Chain. +1",
      hands="Iga Tekko +2",
      legs={ name="Taeon Tights", augments={'"Triple Atk."+2','Crit. hit damage +2%',}},
      feet={ name="Mochizuki Kyahan", augments={'Reduces elem. ninjutsu III cast time',}},
      neck="Voltsurge Torque",
      waist="Twilight Belt",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Fenrir Ring",
      right_ring="Acumen Ring",
      back="Toro Cape",
    }

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {back="Yokaze Mantle"})

    sets.midcast.NinjutsuDebuff = {
      head="Hachiya Hatsuburi",
      body="Hachi. Chain. +1",
      hands={ name="Taeon Gloves", augments={'DEF+20','"Triple Atk."+2','Crit. hit damage +2%',}},
      legs={ name="Taeon Tights", augments={'"Triple Atk."+2','Crit. hit damage +2%',}},
      feet={ name="Mochizuki Kyahan", augments={'Reduces elem. ninjutsu III cast time',}},
      neck="Voltsurge Torque",
      waist="Twilight Belt",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Fenrir Ring",
      right_ring="Perception Ring",
      back={ name="Yokaze Mantle", augments={'STR+1','DEX+2','Weapon skill damage +1%',}},
    }

    sets.midcast.NinjutsuBuff = sets.midcast.NinjutsuDebuff

    sets.midcast.RA = sets.precast.RA
    -- Hachiya Hakama/Thurandaut Tights +1

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = sets.idle

    -- Idle sets
    sets.idle = {
      head={ name="Uk'uxkaj Cap", augments={'Haste+2','"Snapshot"+2','STR+8',}},
      body="Hachi. Chain. +1",
      hands={ name="Mochizuki Tekko", augments={'Enh. "Ninja Tool Expertise" effect',}},
      legs="Hachi. Hakama +1",
      feet=gear.MovementFeet,
      neck="Twilight Torque",
      waist="Fotia Belt",
      left_ear="Dudgeon Earring",
      right_ear="Heartseeker Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    sets.idle.Town = sets.idle

    sets.idle.Weak = sets.idle

    -- Defense sets
    sets.defense.Evasion = sets.idle

    sets.defense.PDT = sets.idle

    sets.defense.MDT = sets.idle


    sets.Kiting = {feet=gear.MovementFeet}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {}
    sets.engaged.Acc = {}
    sets.engaged.Evasion = {}
    sets.engaged.Acc.Evasion = {}
    sets.engaged.PDT = {}
    sets.engaged.Acc.PDT = {}

    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = {}
    sets.engaged.Acc.HighHaste = {}
    sets.engaged.Evasion.HighHaste = {}
    sets.engaged.Acc.Evasion.HighHaste = {}
    sets.engaged.PDT.HighHaste = {}
    sets.engaged.Acc.PDT.HighHaste = {}

    -- Custom melee group: Embrava Haste (7% DW)
    sets.engaged.EmbravaHaste = {}
    sets.engaged.Acc.EmbravaHaste = {}
    sets.engaged.Evasion.EmbravaHaste = {}
    sets.engaged.Acc.Evasion.EmbravaHaste = {}
    sets.engaged.PDT.EmbravaHaste = {}
    sets.engaged.Acc.PDT.EmbravaHaste = {}

    -- Custom melee group: Max Haste (0% DW)
    sets.engaged.MaxHaste = {}
    sets.engaged.Acc.MaxHaste = {}
    sets.engaged.Evasion.MaxHaste = {}
    sets.engaged.Acc.Evasion.MaxHaste = {}
    sets.engaged.PDT.MaxHaste = {}
    sets.engaged.Acc.PDT.MaxHaste = {}


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Iga Ningi +2"}
    sets.buff.Doom = {}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings

    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava

    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear

    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste

    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste

    classes.CustomMeleeGroups:clear()

    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(5, 3)
    else
        set_macro_page(1, 3)
    end
end
