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
    indi_timer = ''
    indi_duration = 255
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')

    gear.default.obi_waist = "Aswang Sash"
    gear.default.obi_back = "Toro Cape"

    select_default_macro_book()

end

lowtier = S{"Fire", "Fire II", "Stone", "Stone II", "Blizzard", "Blizzard II", "Aero", "Aero II", "Water", "Water II", "Thunder", "Thunder II", "Fira", "Blizzara", "Aerora", "Stonera", "Thundara", "Watera"}
hightier = S{"Fire III", "Fire IV", "Stone IV", "Stone III", "Blizzard IV", "Blizzard III", "Aero IV", "Aero III", "Water IV", "Water III", "Thunder IV", "Thunder III", "Fira II", "Blizzara II", "Aerora II", "Stonera II", "Thundara II", "Watera II"}


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic",
    head="Azimuth hood +1"
    }
    sets.precast.JA['Curative Recantation'] = {hands="Bagua Mitaines"}
    sets.precast.JA['Mending Halation'] = {legs="Bagua Pants"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
    sets.precast.JA['Primal Zeal'] = {head="Bagua galero"}
    sets.precast.JA['Cardinal Chant'] = {head="geomancy galero"}


    -- Fast cast sets for spells

    sets.precast.FC = {
      main="Marin Staff",
      head="Haruspex Hat",
      body={ name="Helios Jacket", augments={'"Drain" and "Aspir" potency +8',}},
      hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
      legs="Geo. Pants +1",
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Voltsurge Torque",
      waist="Witful Belt",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Diamond Ring", augments={'MND+3','Spell interruption rate down -5%','"Resist Silence"+3',}},
      back="Swith Cape",
}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
      main="Tefnut Wand",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist="Siegel Sash",
})


    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
      hands="Bagua Mitaines",
})

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      head={ name="Vanya Hood", augments={'Healing magic skill +15','System: 2 ID: 123 Val: 4','Magic dmg. taken -2',}},
      body="Ischemia Chasu.",
      hands="Yaoyotl Gloves",
      legs="Assiduity Pants",
      feet={ name="Uk'uxkaj Boots", augments={'Haste+2','"Snapshot"+2','MND+8',}},
      neck="Asperity Necklace",
      waist="Fotia Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Rajas Ring",
      right_ring="Pyrosoul Ring",
      back="Toro Cape",
}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Flash Nova'] = {
      head={ name="Hagondes Hat", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+26',}},
      body={ name="Bokwus Robe", augments={'"Mag.Atk.Bns."+13','INT+10','MND+10',}},
      hands="Yaoyotl Gloves",
      legs={ name="Hagondes Pants", augments={'Phys. dmg. taken -4%','"Mag.Atk.Bns."+19',}},
      feet="Weath. Souliers +1",
      neck="Eddy Necklace",
      waist="Fotia Belt",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Acumen Ring",
      right_ring="Fenrir Ring",
      back="Toro Cape",
    }


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast =set_combine(sets.midcast.fastcast)

    sets.midcast.Regen = set_combine(sets.midcast.fastcast, {
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
})

    sets.midcast['Enhancing Magic']={
      head={ name="Vanya Hood", augments={'Healing magic skill +15','System: 2 ID: 123 Val: 4','Magic dmg. taken -2',}},
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      legs={ name="Vanya Slops", augments={'MND+6','System: 2 ID: 126 Val: 6','System: 2 ID: 177 Val: 3',}},
}

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
    back="grapevine cape"})

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
    waist="Emphatikos rope"})

    sets.midcast.Geomancy ={
      main="Staccato Staff",
      sub="Mephitis Grip",
      range="Dunna",
      head="Azimuth Hood +1",
      body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
      hands="Geomancy Mitaines +1",
      legs="Bagua Pants",
      feet="Azimuth Gaiters",
      neck="Voltsurge Torque",
      waist="Druid's Rope",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back="Swith Cape",
}

    sets.midcast.Geomancy.Indi =set_combine(sets.midcast.Geomancy, {legs="Bagua pants"})


    sets.midcast.Cure = {
      main="Tefnut Wand",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      ammo="Kalboron Stone",
      head={ name="Vanya Hood", augments={'Healing magic skill +15','System: 2 ID: 123 Val: 4','Magic dmg. taken -2',}},
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      hands={ name="Bokwus Gloves", augments={'Mag. Acc.+11','MND+9','INT+7',}},
      legs={ name="Vanya Slops", augments={'MND+6','System: 2 ID: 126 Val: 6','System: 2 ID: 177 Val: 3',}},
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Imbodla Necklace",
      waist="Druid's Rope",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Prolix Ring",
      right_ring="Sirona's Ring",
      back="Tempered Cape",
}

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
      waist="siegel sash",
})

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = {}

    sets.midcast.Shellra = {}

        -- Custom Spell Classes
    sets.midcast['Enfeebling Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Befouled Crown",
      body="Ischemia Chasu.",
      hands="Azimuth Gloves",
      legs="Vanya Slops",
      feet={ name="Uk'uxkaj Boots", augments={'Haste+2','"Snapshot"+2','MND+8',}},
      neck="Imbodla Necklace",
      waist="Aswang Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Perception Ring",
      right_ring="Balrahn's Ring",
      back="Refraction Cape",
}

    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {

})

    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Befouled Crown",
      body="Ischemia Chasu.",
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs="Azimuth Tights",
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Voltsurge Torque",
      waist="Aswang Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Perception Ring",
      right_ring="Balrahn's Ring",
      back="Refraction Cape",
}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
      head={ name="Bagua Galero", augments={'Enhances "Primeval Zeal" effect',}},
      body={ name="Helios Jacket", augments={'"Drain" and "Aspir" potency +8',}},
      waist="Fucho-no-Obi",
})

    sets.midcast.Aspir = sets.midcast.Drain



    sets.midcast.Stun = sets.precast.FC


    sets.midcast.Bolster = {body="Bagua Tunic +1"}

    sets.midcast['Life Cycle'] = {
      body="Geomancy Tunic",
      head="Azimuth hood +1",
}
    sets.midcast['Mending Halation'] = {legs="Bagua Pants"}

    sets.midcast['Radial Arcana'] = {feet="Bagua Sandals"}

    sets.midcast.Bolster.Pet = {body="Bagua Tunic +1"}

    sets.midcast['Life Cycle'].Pet = {
      body="Geomancy Tunic",
      head="Azimuth hood +1",
}
    sets.midcast['Mending Halation'].Pet = {legs="Bagua Pants"}

    sets.midcast.Bolster.Pet.Indi = {body="Bagua Tunic +1"}

    sets.midcast['Life Cycle'].Pet.Indi = {
      body="Geomancy Tunic",
      head="Azimuth hood +1",
}
    sets.midcast['Mending Halation'].Pet.Indi = {legs="Bagua Pants"}

-- Elemental Magic sets

    sets.midcast['Elemental Magic']= {
      main="Marin Staff",
      sub="Zuuxowu Grip",
      ammo="Dosis Tathlum",
      head={ name="Hagondes Hat", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+26',}},
      body={ name="Bokwus Robe", augments={'"Mag.Atk.Bns."+13','INT+10','MND+10',}},
      hands="Yaoyotl Gloves",
      legs={ name="Hagondes Pants", augments={'Phys. dmg. taken -4%','"Mag.Atk.Bns."+19',}},
      feet="Weath. Souliers +1",
      neck="Eddy Necklace",
      waist="Aswang Sash",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Acumen Ring",
      right_ring="Fenrir Ring",
      back="Toro Cape",
}

    sets.midcast['Elemental Magic']['Accuracy']=set_combine(sets.midcast['Elemental Magic'], {
    waist=gear.ElementalObi,
})
    sets.midcast.Impact = {
      head=empty,
      body="Twilight Cloak",
}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
      main="Marin Staff",
      sub="Zuuxowu Grip",
      range="Dunna",
      head="Befouled Crown",
      body="Azimuth Coat",
      hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
      legs="Assiduity Pants",
      feet="Geomancy Sandals",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
}


    -- Idle sets

    sets.idle = sets.resting

    -- .Pet sets are for when Luopan is present.

    sets.idle.Pet = {
      range="Dunna",
      head="Azimuth Hood +1",
      body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
      hands="Geomancy Mitaines +1",
      legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
      feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},

    }

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = {
      range="Dunna",
      head="Azimuth Hood +1",
      body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
      hands="Geo. Mitaines +1",
      legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
      feet="Azimuth Gaiters",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},

}

    sets.idle.Town = {
      main="Staccato Staff",
      sub="Zuuxowu Grip",
      range="Dunna",
      head="Azimuth Hood +1",
      body="Azimuth Coat",
      hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
      legs="Assiduity Pants",
      feet="Geomancy Sandals",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
}

    sets.idle.Weak = sets.resting

    -- Defense sets

    sets.Kiting = {feet="Geomancy Sandals"}

    sets.latent_refresh = {waist="Fucho-no-obi"}




    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
      head={ name="Vanya Hood", augments={'Healing magic skill +15','System: 2 ID: 123 Val: 4','Magic dmg. taken -2',}},
      body="Ischemia Chasu.",
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Asperity Necklace",
      waist="Cetl Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Pyrosoul Ring",
      right_ring="Rajas Ring",
      back="Toro Cape",
}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end
 poison = 0
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
    if buff == "poison" then
        if gain then
            poison = 1
            add_to_chat(255, '*-*-*-*-*-*-*-*-* [ Poisoned ] *-*-*-*-*-*-*-*-*')
        else
            poison = 0
            add_to_chat(255, '*-*-*-*-*-*-*-*-* [ Poison OFF ] *-*-*-*-*-*-*-*-*')
        end
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Dual' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then

        -- this if for low tier
      if lowtier:contains(spell.name) then
        add_to_chat(204, '*-*-*-*-*-*-*-*-* [ Low TIER ] *-*-*-*-*-*-*-*-*')
        if buffactive.Poison then
            equip(sets.midcast['Elemental Magic'], {main="Mindmelter"})
        elseif spell.element == 'Earth' then
            equip(sets.midcast['Elemental Magic'], {neck="Quanpur Necklace"})
        elseif spell.element == 'Ice' then
            equip(sets.midcast['Elemental Magic'], {main="Ngqoqwanb"})
        elseif spell.element == 'Wind' then
            equip(sets.midcast['Elemental Magic'], {Main="Marin Staff +1", Back="Kaikias' Cape"})
        end


        if spell.element == world.day_element or spell.element == world.weather_element then
            equip(sets.midcast['Elemental Magic'], {waist="Hachirin-No-Obi"})
        end
      else
        -- high tier
        add_to_chat(204, '*-*-*-*-*-*-*-*-* [ High TIER ] *-*-*-*-*-*-*-*-*')
        if buffactive.Poison then
            equip(sets.midcast['Elemental Magic']['Accuracy'], {main="Mindmelter"})
        elseif spell.element == 'Earth' then
            equip(sets.midcast['Elemental Magic']['Accuracy'], {neck="Quanpur Necklace"})
        elseif spell.element == 'Ice' then
            equip(sets.midcast['Elemental Magic']['Accuracy'], {main="Ngqoqwanb"})
        elseif spell.element == 'Wind' then
            equip(sets.midcast['Elemental Magic'], {Main="Marin Staff +1", Back="Kaikias' Cape"})
        end


        if spell.element == world.day_element or spell.element == world.weather_element then
            equip(sets.midcast['Elemental Magic'], {waist="Hachirin-No-Obi"})
        end

      end

    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
            elseif spell.skill == 'Elemental Magic' then
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-- MAKE A MACRO : /tell <me> check
function open_coffer()
    CofferType = "Velkk Coffer"
    if player.inventory[CofferType] then
    NCoffer = player.inventory[CofferType].count
    bag = windower.ffxi.get_bag_info(0).count
    max = windower.ffxi.get_bag_info(0).max
    spots = max-bag
    if spots > 0 then
    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..NCoffer..'x '..CofferType..' to open - Inventory('..bag..'/'..max..') ] *-*-*-*-*-*-*-*-*')
    local nextcommand = ""
    for i=1, spots do
        nextcommand = nextcommand .. 'input /item "'..CofferType..'" <me>; wait 2;'
    end
    nextcommand = nextcommand .. 'input /tell '..player.name..' check'
    send_command(nextcommand)
    else
        add_to_chat(204, '*-*-*-*-*-*-*-*-* [ Inventory('..bag..'/'..max..') ] *-*-*-*-*-*-*-*-*')
    end
    else
        add_to_chat(204, '*-*-*-*-*-*-*-*-* [ No '..CofferType..' in inventory ] *-*-*-*-*-*-*-*-*')
    end
end


windower.register_event('chat message', function(original, sender, mode, gm)
    local match

                if sender == player.name then
                    if original == "check" then
                        open_coffer()
                    end
                end

    return sender, mode, gm
end)

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 9)
 end
