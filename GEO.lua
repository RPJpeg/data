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
    indi_duration = 180
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    gear.default.weaponskill_waist = "Fotia Belt"

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic"}

    -- Fast cast sets for spells

    sets.precast.FC = {
      main="Marin Staff",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body={ name="Helios Jacket", augments={'Pet: Crit.hit rate +3','Summoning magic skill +1',}},
      hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
      legs="Geomancy Pants",
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Voltsurge Torque",
      waist="Witful Belt",
      left_ear="Loquac. Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Diamond Ring", augments={'MND+3','Spell interruption rate down -5%','"Resist Silence"+3',}},
      back="Swith Cape",
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      head={ name="Vanya Hood", augments={'----------------',}},
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

    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Geomancy = {range="Filiae Bell"}
    sets.midcast.Geomancy.Indi = {
      range="Filiae Bell",
      body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
      hands="Geomancy Mitaines",
      legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
    }

    sets.midcast.Cure = {
      main="Tefnut Wand",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      ammo="Kalboron Stone",
      head={ name="Vanya Hood", augments={'----------------',}},
      body="Ischemia Chasu.",
      hands={ name="Bokwus Gloves", augments={'Mag. Acc.+11','MND+9','INT+7',}},
      legs={ name="Vanya Slops", augments={'MND+5','System: 2 ID: 126 Val: 4','System: 2 ID: 177 Val: 2',}},
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Imbodla Necklace",
      waist="Witful Belt",
      left_ear="Lifestorm Earring",
      right_ear="Gifted Earring",
      left_ring="Sirona's Ring",
      right_ring={ name="Diamond Ring", augments={'MND+3','Spell interruption rate down -5%','"Resist Silence"+3',}},
      back="Tempered Cape",
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = {}

    sets.midcast.Shellra = {}

    sets.midcast.Stoneskin = {
      waist="Siegel Sash",
    }

    sets.midcast['Enfeebling Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body="Ischemia Chasu.",
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs={ name="Vanya Slops", augments={'MND+5','System: 2 ID: 126 Val: 4','System: 2 ID: 177 Val: 2',}},
      feet={ name="Uk'uxkaj Boots", augments={'Haste+2','"Snapshot"+2','MND+8',}},
      neck="Imbodla Necklace",
      waist="Aswang Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Perception Ring",
      right_ring="Balrahn's Ring",
      back="Refraction Cape",
    }

    sets.midcast['Elemental Magic'] = {
      main="Marin Staff",
      sub="Zuuxowu Grip",
      ammo="Witchstone",
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

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body="Geomancy Tunic",
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs={ name="Vanya Slops", augments={'MND+5','System: 2 ID: 126 Val: 4','System: 2 ID: 177 Val: 2',}},
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Voltsurge Torque",
      waist="Aswang Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Perception Ring",
      right_ring="Balrahn's Ring",
      back="Refraction Cape",
    }

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
      main="Apamajas II"
    })

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {head="Bagua Galero",waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast['Cardinal Chant'] = set_combine(sets.midcast.Geomancy, {head="Geomancy Galero"})

    sets.midcast['Bolster'] = set_combine(sets.midcast.Geomancy, {body="Bagua Tunic"})

    sets.midcast['Life Cycle'] = set_combine(sets.midcast.Geomancy, {body="Geomancy Tunic"})

    sets.midcast['Curative Recantation'] = set_combine(sets.midcast.Geomancy, {hands="Bagua Mitaines"})

    sets.midcast['Mending Halation'] = set_combine(sets.midcast.Geomancy, {legs="Bagua Pants"})

    sets.midcast['Radial Arcana'] = set_combine(sets.midcast.Geomancy, {feet="Bagua Sandals"})


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
      main="Marin Staff",
      sub="Zuuxowu Grip",
      range="Filiae Bell",
      head={ name="Wivre Hairpin", augments={'"Refresh"+1','Earth resistance+6','Water resistance+6',}},
      body="Ischemia Chasu.",
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

    sets.idle = {
      main="Marin Staff",
      sub="Zuuxowu Grip",
      range="Filiae Bell",
      head={ name="Wivre Hairpin", augments={'"Refresh"+1','Earth resistance+6','Water resistance+6',}},
      body="Ischemia Chasu.",
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

    sets.idle.PDT = sets.idle

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, {
      hands="Geomancy Mitaines",
      feet="Bagua Sandals",
    })

    sets.idle.PDT.Pet = sets.idle.Pet

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {legs="Bagua Pants"})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {legs="Bagua Pants"})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {legs="Bagua Pants"})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {legs="Bagua Pants"})

    sets.idle.Town = {
      main="Marin Staff",
      sub="Zuuxowu Grip",
      range="Filiae Bell",
      head={ name="Bagua Galero", augments={'Enhances "Primeval Zeal" effect',}},
      body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
      hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
      legs="Assiduity Pants",
      feet="Geomancy Sandals",
      neck="Voltsurge Torque",
      waist="Fucho-no-Obi",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    sets.idle.Weak = sets.idle

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}

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
      head={ name="Vanya Hood", augments={'----------------',}},
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

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

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
end

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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 9)
end
