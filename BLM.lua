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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT')

    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    gear.macc_hagondes = "Hagondes Cuffs",

    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c activate MagicBurst')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    ---- Precast Sets ----

    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat"}

    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {
      main="Marin Staff +1",
      head="Merlinic Hood",
      body="Shango Robe",
      legs="Psycloth Lappas",
      feet="Telchine Pigaches",
      neck="Voltsurge Torque",
      waist="Witful Belt",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Prolix Ring",
      right_ring="Defending Ring",
      back="Swith Cape",
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", neck="Nodens Gorget"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
      head="Goetia Petasos +2",
      feet="Spae. Sabots +1",
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
      back="Pahtli Cape",
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      waist="Fotia Belt",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {}


    ---- Midcast Sets ----

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
      main="Tefnut Wand",
      sub="Genbu's Shield",
      ammo="Hydrocera",
      head="Vanya Hood",
      body="Jhakri Robe +1",
      hands="Bokwus Gloves",
      legs="Vanya Slops",
      feet="Medium's Sabots",
      neck="Imbodla Necklace",
      waist="Druid's Rope",
      left_ear="Lifestorm Earring",
      right_ear="Gifted Earring",
      left_ring="Perception Ring",
      right_ring="Sirona's Ring",
      back="Solemnity Cape",
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
      head="Befouled Crown",
      body="Telchine Chas.",
      legs="Vanya Slops",
      feet="Merlinic Crackows",
      waist="Siegel Sash",
      left_ear="Gifted Earring",
      right_ear="Gwati Earring",
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash", neck="Nodens Gorget"})

    sets.midcast['Enfeebling Magic'] = {
      main="Marin Staff +1",
      sub="Enki Strap",
      ammo="Hydrocera",
      head="Merlinic Hood",
      body="Jhakri Robe +1",
      hands="Jhakri Cuffs +1",
      legs="Psycloth Lappas",
      feet="Merlinic Crackows",
      neck="Imbodla Necklace",
      waist="Rumination Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Perception Ring",
      right_ring="Sangoma Ring",
      back="Taranus's Cape"
    }

    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = sets.midcast['Enfeebling Magic']

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {body="Helios Jacket", waist="Fucho-no-obi"})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
      main="Apamajas II",
      sub="Enki Strap",
      ammo="Hydrocera",
      head="Merlinic Hood",
      body="Shango Robe",
      hands="Jhakri Cuffs +1",
      legs="Psycloth Lappas",
      feet="Merlinic Crackows",
      neck="Voltsurge Torque",
      waist="Witful Belt",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Prolix Ring",
      right_ring="Sangoma Ring",
      back="Swith Cape",
    }

    sets.midcast.BardSong = sets.midcast.FastRecast


    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
      main="Lathi",
      sub="Enki Strap",
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
      left_ring="Jhakri Ring",
      right_ring="Acumen Ring",
      back="Toro Cape",
    }

    sets.midcast['Elemental Magic'].HighTierNuke = {
      main="Lathi",
      sub="Enki Strap",
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
      left_ring="Jhakri Ring",
      right_ring="Acumen Ring",
      back="Toro Cape",
    }

    sets.midcast['Elemental Magic'].Resistant = sets.midcast['Elemental Magic'].HighTierNuke

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = sets.midcast['Elemental Magic'].HighTierNuke


    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = sets.midcast.FastRecast



    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = sets.idle


    -- Idle sets

    -- Normal refresh idle set
    sets.idle = {
      main="Lathi",
      sub="Enki Strap",
      ammo="Dosis Tathlum",
      head="Befouled Crown",
      body="Jhakri Robe +1",
      hands="Serpentes Cuffs",
      legs="Assid. Pants +1",
      feet="Serpentes Sabots",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Renaye Ring",
      right_ring="Defending Ring",
      back="Mecisto. Mantle",
    }

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = sets.idle

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = sets.idle

    -- Town gear.
    sets.idle.Town = {
      main="Lathi",
      sub="Enki Strap",
      ammo="Dosis Tathlum",
      head="Merlinic Hood",
      body="Jhakri Robe +1",
      hands="Jhakri Cuffs +1",
      legs="Merlinic Shalwar",
      feet="Merlinic Crackows",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Renaye Ring",
      right_ring="Defending Ring",
      back="Mecisto. Mantle",
    }

    -- Defense sets

    sets.defense.PDT = sets.idle

    sets.defense.MDT = sets.idle

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

    sets.buff['Mana Wall'] = {feet="Goetia Sabots +2", back="Taranus's cape"}

    sets.magic_burst = {neck="Mizukage-no-Kubikazari"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
      main="Eminent Sickle",
      sub="Enki Strap",
      ammo="Hydrocera",
      head="Hagondes Hat",
      body="Ischemia Chasu.",
      hands="Amalric Gages",
      legs="Telchine Braconi",
      feet="Spae. Sabots +1",
      neck="Asperity Necklace",
      waist="Cetl Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Pyrosoul Ring",
      right_ring="Rajas Ring",
      back="Mecisto. Mantle",
    }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Witful Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
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
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
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
    set_macro_page(1, 1)
end
