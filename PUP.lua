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
    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}

    -- Map automaton heads to combat roles
    petModes = {
        ['Harlequin Head'] = 'Melee',
        ['Sharpshot Head'] = 'Ranged',
        ['Valoredge Head'] = 'Tank',
        ['Stormwaker Head'] = 'Magic',
        ['Soulsoother Head'] = 'Heal',
        ['Spiritreaver Head'] = 'Nuke'
        }

    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}

    -- Var to track the current pet mode.
    state.PetMode = M{['description']='Pet Mode', 'None', 'Melee', 'Ranged', 'Tank', 'Magic', 'Heal', 'Nuke'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
    }

    update_pet_mode()
    select_default_macro_book()
end


-- Define sets used by this job file.
function init_gear_sets()

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
      head="Haruspex Hat",
      body={ name="Mirke Wardecors", augments={'"Fast Cast"+5','Mag. Acc.+4',}},
      neck="Voltsurge Torque",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Diamond Ring", augments={'MND+3','Spell interruption rate down -5%','"Resist Silence"+3',}},
      back="Swith Cape",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +1"}

    sets.precast.JA['Repair'] = {feet="Foire Babouches"}

    sets.precast.JA.Maneuver = {neck="Buffoon's Collar",body="Karagoz Farsetto",hands="Foire Dastanas",back="Dispersal Mantle"}



    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
      head="Whirlpool Mask",
      ear1="Roundel Earring",
    }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      head={ name="Uk'uxkaj Cap", augments={'Haste+2','"Snapshot"+2','STR+8',}},
      body={ name="Taeon Tabard", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','Weapon skill damage +2%',}},
      hands="Count's Cuffs",
      legs={ name="Taeon Tights", augments={'Accuracy+2','Weapon Skill Acc.+19','STR+5 DEX+5',}},
      feet={ name="Taeon Boots", augments={'Attack+21','Weapon Skill Acc.+17','Weapon skill damage +3%',}},
      neck="Rancor Collar",
      waist="Fotia Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Pyrosoul Ring",
      right_ring="Rajas Ring",
      back={ name="Dispersal Mantle", augments={'STR+2','Pet: TP Bonus+140','"Martial Arts"+13',}},
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stringing Pummel'] = sets.precast.WS
    sets.precast.WS['Victory Smite'] = sets.precast.WS
    sets.precast.WS['Shijin Spiral'] = sets.precast.WS


    -- Midcast Sets

    sets.midcast.FastRecast = sets.precast.FC


    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {
      legs="Foire Churidars"
}

    sets.midcast.Pet['Elemental Magic'] = {
      feet="Pitre Babouches"
}

    sets.midcast.Pet.WeaponSkill = {
      head="Cirque Cappello +1",
      hands="Karagoz Guanti",
      legs="Karagoz Pantaloni"
}


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = sets.idle


    -- Idle sets

    sets.idle = {
      head={ name="Pitre Taj", augments={'Enhances "Optimization" effect',}},
      body={ name="Taeon Tabard", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','Weapon skill damage +2%',}},
      hands="Count's Cuffs",
      legs={ name="Desultor Tassets", augments={'Phys. dmg. taken -4%','Movement speed +8%+2',}},
      feet={ name="Taeon Boots", augments={'Accuracy+24','"Triple Atk."+2','Crit. hit damage +2%',}},
      neck="Twilight Torque",
      waist="Fotia Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Renaye Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    sets.idle.Town = sets.idle

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
      head={ name="Pitre Taj", augments={'Enhances "Optimization" effect',}},
      body={ name="Pitre Tobe", augments={'Enhances "Overdrive" effect',}},
      hands={ name="Taeon Gloves", augments={'Pet: DEF+22','Pet: "Regen"+2','Pet: Damage taken -3%',}},
      legs="Karagoz Pantaloni",
      feet="Foire Babouches",
      neck="Empath Necklace",
      waist="Isa Belt",
      left_ear="Handler's Earring",
      right_ear="Handler's Earring +1",
      left_ring="Renaye Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back={ name="Visucius's Mantle", augments={'Pet: Acc.+12 Pet: R.Acc.+12 Pet: Atk.+12 Pet: R.Atk.+12','Pet: "Regen"+10',}},
    }

    sets.idle.Pet.Engaged.Ranged = sets.idle.Pet.Engaged

    sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged

    sets.idle.Pet.Engaged.Magic = sets.idle.Pet.Engaged


    -- Defense sets

    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
      head="Whirlpool Mask",
      body={ name="Taeon Tabard", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','Weapon skill damage +2%',}},
      hands="Count's Cuffs",
      legs="Karagoz Pantaloni",
      feet={ name="Taeon Boots", augments={'Accuracy+24','"Triple Atk."+2','Crit. hit damage +2%',}},
      neck="Asperity Necklace",
      waist="Shaolin Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Epona's Ring",
      right_ring="Rajas Ring",
      back={ name="Dispersal Mantle", augments={'STR+2','Pet: TP Bonus+140','"Martial Arts"+13',}},
    }

    sets.engaged.Acc = {
      head="Whirlpool Mask",
      body={ name="Taeon Tabard", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','Weapon skill damage +2%',}},
      hands="Count's Cuffs",
      legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
      feet={ name="Taeon Boots", augments={'Accuracy+24','"Triple Atk."+2','Crit. hit damage +2%',}},
      neck="Subtlety Spec.",
      waist="Shaolin Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Epona's Ring",
      right_ring="Rajas Ring",
      back={ name="Dispersal Mantle", augments={'STR+2','Pet: TP Bonus+140','"Martial Arts"+13',}},
    }

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "Weaponskill"
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == 'Wind Maneuver' then
        handle_equipping_gear(player.status)
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
    update_pet_mode()
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        display_pet_status()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'maneuver' then
        if pet.isvalid then
            local man = defaultManeuvers[state.PetMode.value]
            if man and tonumber(cmdParams[2]) then
                man = man[tonumber(cmdParams[2])]
            end

            if man then
                send_command('input /pet "'..man..'" <me>')
            end
        else
            add_to_chat(123,'No valid pet.')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
        return petModes[pet.head] or 'None'
    else
        return 'None'
    end
end

-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    state.PetMode:set(get_pet_mode())
    update_custom_groups()
end

-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end

-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)

        if magicPetModes:contains(state.PetMode.value) then
            petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end

        add_to_chat(122,petInfoString)
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 12)
    else
        set_macro_page(1, 12)
    end
end
