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
    state.CastingMode:options('Normal', 'Accuracy')
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
    head="Azimuth hood +1", back="Nantosuelta's Cape"
    }
    sets.precast.JA['Curative Recantation'] = {hands="Bagua Mitaines"}
    sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
    sets.precast.JA['Primal Zeal'] = {head="Bagua galero"}
    sets.precast.JA['Cardinal Chant'] = {head="geomancy galero"}


    -- Fast cast sets for spells

    sets.precast.FC = {
      main="Marin Staff +1",
      sub="Mephitis Grip",
      head="Merlinic Hood",
      body="Shango Robe",
      legs="Geo. Pants +1",
      feet="Merlinic Crackows",
      neck="Voltsurge Torque",
      waist="Witful Belt",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Prolix Ring",
      back="Lifestream Cape",
}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
      back="Pahtli Cape",
})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist="Siegel Sash", neck="Nodens Gorget"
})


    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
      hands="Bagua Mitaines",
})

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Flash Nova'] = {
    }


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast =set_combine(sets.midcast.fastcast)

    sets.midcast.Regen = set_combine(sets.midcast.fastcast, {
      head="Vanya Hood",
      body="Telchine Chas.",
      legs="Telchine Braconi",
      feet="Umbani Boots",
      left_ear="Gifted Earring",
})

    sets.midcast['Enhancing Magic']={
      head="Vanya Hood",
      body="Telchine Chas.",
      legs="Vanya Slops",
      feet="Umbani Boots",
      left_ear="Gifted Earring",
}

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
    back="grapevine cape"})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash", neck="Nodens Gorget"})

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
    waist="Emphatikos rope"})

    sets.midcast.Geomancy ={
      main="Solstice",
      sub="Genmei Shield",
      range="Dunna",
      head="Azimuth Hood +1",
      body="Bagua Tunic +1",
      hands="Geo. Mitaines +1",
      legs="Azimuth Tights",
      feet="Medium's Sabots",
      waist="Druid's Rope",
      left_ear="Gifted Earring",
      right_ring="Renaye Ring",
      back="Lifestream Cape",
}

    sets.midcast.Geomancy.Indi =set_combine(sets.midcast.Geomancy, {
      main="Solstice",
      sub="Genmei Shield",
      legs="Bagua Pants +1",
      feet="Azimuth Gaiters",
      back="Nantosuelta's Cape"
})


    sets.midcast.Cure = {
      main="Tefnut Wand",
      sub="Genbu's Shield",
      head="Vanya Hood",
      body="Telchine Chas.",
      hands="Bokwus Gloves",
      legs="Vanya Slops",
      neck="Imbodla Necklace",
      left_ear="Gifted Earring",
      right_ear="Lifestorm Earring",
      right_ring="Sirona's Ring",
      back="Solemnity Cape",
}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = {}

    sets.midcast.Shellra = {}

        -- Custom Spell Classes
    sets.midcast['Enfeebling Magic'] = {
      main="Marin Staff +1",
      sub="Mephitis Grip",
      ammo="Hydrocera",
      head="Merlinic Hood",
      body="Shango Robe",
      hands="Jhakri Cuffs +1",
      legs="Psycloth Lappas",
      feet="Medium's Sabots",
      neck="Imbodla Necklace",
      waist="Rumination Sash",
      left_ear="Psystorm Earring",
      right_ear="Lifestorm Earring",
      left_ring="Sangoma Ring",
      right_ring="Perception Ring",
      back="Nantosuelta's Cape",
}

    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {

})

    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = sets.midcast['Enfeebling Magic']

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
      head={ name="Bagua Galero", augments={'Enhances "Primeval Zeal" effect',}},
      body={ name="Helios Jacket", augments={'"Drain" and "Aspir" potency +8',}},
      waist="Fucho-no-Obi",
})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.precast.FC, {main="Apamajas II"})

    sets.midcast.Bolster = {body="Bagua Tunic +1"}

    sets.midcast['Life Cycle'] = {
      body="Geomancy Tunic",
      head="Azimuth hood +1",
      back="Nantosuelta's Cape",
}
    sets.midcast['Mending Halation'] = {legs="Bagua Pants +1"}

    sets.midcast['Radial Arcana'] = {feet="Bagua Sandals"}

    sets.midcast.Bolster.Pet = {body="Bagua Tunic +1"}

    sets.midcast['Life Cycle'].Pet = {
      body="Geomancy Tunic",
      head="Azimuth hood +1",
      back="Nantosuelta's Cape"
}
    sets.midcast['Mending Halation'].Pet = {legs="Bagua Pants +1"}

    sets.midcast.Bolster.Pet.Indi = {body="Bagua Tunic +1"}

    sets.midcast['Life Cycle'].Pet.Indi = {
      body="Geomancy Tunic",
      head="Azimuth hood +1",
      back="Nantosuelta's Cape"
}
    sets.midcast['Mending Halation'].Pet.Indi = {legs="Bagua Pants +1"}

-- Elemental Magic sets

    sets.midcast['Elemental Magic']= {
      main="Marin Staff +1",
      ammo="Dosis Tathlum",
      head="Merlinic Hood",
      body="Jhakri Robe +1",
      hands="Amalric Gages",
      legs="Merlinic Shalwar",
      feet="Merlinic Crackows",
      neck="Eddy Necklace",
      waist="Aswang Sash",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Fenrir Ring",
      right_ring="Acumen Ring",
      back="Nantosuelta's Cape",
      sub="Niobid Strap",
}

    sets.midcast['Elemental Magic']['Accuracy']={
      main="Marin Staff +1",
      sub="Niobid Strap",
      ammo="Dosis Tathlum",
      head="Merlinic Hood",
      body="Jhakri Robe +1",
      hands="Amalric Gages",
      legs="Merlinic Shalwar",
      feet="Merlinic Crackows",
      neck="Eddy Necklace",
      waist="Aswang Sash",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Fenrir Ring",
      right_ring="Acumen Ring",
      back="Nantosuelta's Cape",
    }

    sets.midcast.Impact = {
      head=empty,
      body="Twilight Cloak",
}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
      main="Solstice",
      sub="Genmei Shield",
      range="Dunna",
      head="Befouled Crown",
      body="Jhakri Robe +1",
      hands="Bagua Mitaines",
      legs="Assiduity Pants +1",
      feet="Geomancy Sandals +1",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Handler's Earring +1",
      right_ear="Handler's Earring",
      left_ring="Defending Ring",
      right_ring="Renaye Ring",
      back="Mecisto. Mantle",
}


    -- Idle sets

    sets.idle = sets.resting

    -- .Pet sets are for when Luopan is present.

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = sets.resting

    sets.idle.Pet = {
      main="Solstice",
      sub="Genmei Shield",
      range="Dunna",
      head="Azimuth Hood +1",
      body="Telchine chasuble",
      hands="Geomancy Mitaines +1",
      legs="Psycloth Lappas",
      feet="Bagua Sandals",
      neck="Twilight Torque",
      waist="Isa Belt",
      left_ear="Handler's Earring +1",
      right_ear="Handler's Earring",
      left_ring="Defending Ring",
      right_ring="Renaye Ring",
      back="Nantosuelta's Cape",


    }

    sets.idle.Town = {
      main="Solstice",
      sub="Genmei Shield",
      range="Dunna",
      head="Merlinic Hood",
      body="Jhakri Robe +1",
      hands="Bagua Mitaines",
      legs="Assiduity Pants +1",
      feet="Geomancy Sandals +1",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Handler's Earring +1",
      right_ear="Handler's Earring",
      left_ring="Defending Ring",
      right_ring="Renaye Ring",
      back="Nantosuelta's Cape",


}

    sets.idle.Weak = sets.resting

    -- Defense sets

    sets.Kiting = {feet="Geomancy Sandals +1"}

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
