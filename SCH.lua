-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')


    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    gear.macc_hagondes = {name="Hagondes Cuffs"}

    send_command('bind ^` input /ma Stun <t>')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants"}


    -- Fast cast sets for spells

    sets.precast.FC = {
      main="Marin Staff +1",
      sub="Mephitis Grip",
      head="Merlinic Hood",
      body="Shango Robe",
      hands="Gende. Gages +1",
      legs="Psycloth Lappas",
      feet="Merlinic Crackows",
      neck="Voltsurge Torque",
      waist="Witful Belt",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back="Swith Cape",
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = sets.precast.FC

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})


    -- Midcast Sets

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
      main="Tefnut Wand",
      sub="Genbu's Shield",
      ammo="Kalboron Stone",
      head="Vanya Hood",
      body="Gendewitha Bliaut",
      hands="Bokwus Gloves",
      legs="Vanya Slops",
      feet="Peda. Loafers",
      neck="Imbodla Necklace",
      waist="Druid's Rope",
      left_ear="Gwati Earring",
      right_ear="Gifted Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      right_ring="Sirona's Ring",
      back="Solemnity Cape",
    }

    sets.midcast.CureWithLightWeather = sets.midcast.Cure

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Regen = set_combine(sets.precast.FC, {
      head="Arbatel Bonnet",
      body="Telchine Chas.",
      legs="Telchine Braconi",
      back="Bookworm's Cape",
    })

    sets.midcast.Cursna = {}

    sets.midcast['Enhancing Magic'] = {
      main="Staccato Staff",
      sub="Niobid Strap",
      ammo="Kalboron Stone",
      head="Befouled Crown",
      body="Telchine Chas.",
      hands="Acad. Bracers",
      legs="Vanya Slops",
      neck="Imbodla Necklace",
      waist="Siegel Sash",
      back="Solemnity Cape",
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers"})

    sets.midcast.Protect = sets.midcast['Enhancing Magic']
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = sets.midcast['Enhancing Magic']
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
      main="Marin Staff +1",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Merlinic Hood",
      body="Shango Robe",
      hands="Jhakri Cuffs +1",
      legs="Chironic hose",
      feet="Jhakri Pigaches +1",
      neck="Imbodla Necklace",
      waist="Aswang Sash",
      left_ear="Enchntr. Earring +1",
      right_ear="Gwati Earring",
      left_ring="Perception Ring",
      right_ring="Sangoma Ring",
      back="Refraction Cape",
    }

    sets.midcast.IntEnfeebles = {
      main="Marin Staff +1",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Merlinic Hood",
      body="Shango Robe",
      hands="Jhakri Cuffs +1",
      legs="Chironic hose",
      feet="Jhakri Pigaches +1",
      neck="Imbodla Necklace",
      waist="Aswang Sash",
      left_ear="Enchntr. Earring +1",
      right_ear="Gwati Earring",
      left_ring="Perception Ring",
      right_ring="Sangoma Ring",
      back="Refraction Cape",
    }

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = {
      main="Marin Staff +1",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Merlinic Hood",
      body="Shango Robe",
      hands="Jhakri Cuffs +1",
      legs="Psycloth Lappas",
      feet="Jhakri Pigaches +1",
      neck="Imbodla Necklace",
      waist="Aswang Sash",
      left_ear="Enchntr. Earring +1",
      right_ear="Gwati Earring",
      left_ring="Perception Ring",
      right_ring="Sangoma Ring",
      back="Refraction Cape",
    }

    sets.midcast.Kaustra = {
      main="Keraunos",
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
      back="Bookworm's Cape",
    }

    sets.midcast.Drain = {
      body={ name="Helios Jacket", augments={'"Drain" and "Aspir" potency +8',}},
      feet="Merlinic Crackows",
      waist="Fucho-no-Obi",
    }

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.precast.FC, {
      main="Apamajas II",
})

    sets.midcast.Stun.Resistant = sets.midcast.Stun


    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {
      main="Keraunos",
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
      back="Bookworm's Cape",
    }

    sets.midcast['Elemental Magic'].Resistant = sets.midcast['Elemental Magic']

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = sets.midcast['Elemental Magic']

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = sets.midcast['Elemental Magic']

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    -- Sets to return to when not performing an action.

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle.Town = {
      main="Keraunos",
      sub="Niobid Strap",
      ammo="Dosis Tathlum",
      head="Arbatel Bonnet",
      body="Jhakri Robe +1",
      hands="Amalric Gages",
      legs="Chironic hose",
      feet="Arbatel Loafers",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Renaye Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back="Mecisto. Mantle",
    }

    sets.idle.Field = {
      main="Keraunos",
      sub="Niobid Strap",
      ammo="Dosis Tathlum",
      head="Befouled Crown",
      body="Jhakri Robe +1",
      hands="Serpentes Cuffs",
      legs="Assid. Pants +1",
      feet="Serpentes Sabots",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Renaye Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back="Mecisto. Mantle",
    }

    sets.resting = sets.idle.Field


    sets.idle.Field.PDT = sets.idle.Field


    sets.idle.Field.Stun = sets.midcast.Stun

    sets.idle.Weak = sets.idle.Field


    -- Defense sets

    sets.defense.PDT = sets.idle.Field

    sets.defense.MDT = sets.idle.Field


    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {}



    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet"}
    sets.buff['Perpetuance'] = {hands="Savant's Bracers +2"}
    sets.buff['Immanence'] = {hands="Savant's Bracers +2"}
    sets.buff['Penury'] = {legs="Arbatel Pants"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants"}
    sets.buff['Celerity'] = {feet="Pedagogy Loafers"}
    sets.buff['Alacrity'] = {feet="Pedagogy Loafers"}

    sets.buff['Klimaform'] = {feet="Arbatel Loafers"}

    sets.buff.FullSublimation = {head="Academic's Mortarboard",ear1="Savant's Earring",body="Pedagogy Gown"}
    sets.buff.PDTSublimation = {head="Academic's Mortarboard",ear1="Savant's Earring"}

    --sets.buff['Sandstorm'] = {feet="Desert Boots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 16)
end
