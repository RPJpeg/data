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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
      main="Marin Staff",
      head="Artsieq Hat",
      body="Helios Jacket",
      hands="Gendewitha Gages +1",
      legs="Artsieq Hose",
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Orison Locket",
      waist="Witful Belt",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Diamond Ring", augments={'MND+3','Spell interruption rate down -5%','"Resist Silence"+3',}},
      back="Swith Cape",
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Orison Pantaloons +2"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
      main="Ababinili +1",
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
      right_ear="Nourish. Earring"
    })
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
      left_ear="Roundel Earring",
    }


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Fotia Belt"
    sets.precast.WS = {}

    sets.precast.WS['Flash Nova'] = {}


    -- Midcast Sets

    sets.midcast.FastRecast = sets.precast.FC

    -- Cure sets
    gear.default.obi_waist = "Witful Belt"
    gear.default.obi_back = "Tempered Cape"

    sets.midcast.CureSolace = {
      main="Ababinili +1",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Vanya Hood",
      body="Orison Bliaud +2",
      hands="Bokwus Gloves",
      legs="Orsn. Pantaln. +2",
      feet={ name="Piety Duckbills", augments={'Enhances "Protectra V" effect',}},
      neck="Imbodla Necklace",
      waist="Witful Belt",
      left_ear="Roundel Earring",
      right_ear="Nourish. Earring",
      left_ring="Perception Ring",
      right_ring="Sirona's Ring",
      back="Tempered Cape",
    }

    sets.midcast.Cure = set_combine(sets.midcast.CureSolace, {})

    sets.midcast.Curaga = set_combine(sets.midcast.CureSolace, {})

    sets.midcast.CureMelee = {
      head="Vanya Hood",
      body="Orison Bliaud +2",
      hands="Bokwus Gloves",
      legs="Orsn. Pantaln. +2",
      feet={ name="Piety Duckbills", augments={'Enhances "Protectra V" effect',}},
      neck="Imbodla Necklace",
      waist="Witful Belt",
      left_ear="Roundel Earring",
      right_ear="Nourish. Earring",
      left_ring="Perception Ring",
      right_ring="Sirona's Ring",
      back="Tempered Cape",
    }

    sets.midcast.Cursna = {
      head="Orison Cap +2",
      body="Orison Bliaud +2",
      hands="Orison Mitts +2",
      legs="Orsn. Pantaln. +2",
      feet="Genewitha Galoshes",
    }

    sets.midcast.StatusRemoval = {
      head="Orison Cap +2",
      body="Orison Bliaud +2",
      hands="Orison Mitts +2",
      legs="Orsn. Pantaln. +2",
      feet="Orsn. Duckbills +2",
    }

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Orison Cap +2",
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      hands="Gendewitha Gages +1",
      legs={ name="Piety Pantaloons", augments={'Enhances "Shellra V" effect',}},
      feet="Orsn. Duckbills +2",
      neck="Orison Locket",
      waist="Siegel Sash",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Diamond Ring", augments={'MND+3','Spell interruption rate down -5%','"Resist Silence"+3',}},
      back="Swith Cape",
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Auspice = {feet="Orison Duckbills +2"}

    sets.midcast.BarElement = {
        head="Orison Cap +2",
        body="Orison Bliaud +2",
        hands="Orison Mitts +2",
        legs="Piety Pantaloons",
        feet="Orison Duckbills +2"
      }

    sets.midcast.Regen = {
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      hands="Orison Mitts +2",
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
    }

    sets.midcast.Protectra = {feet="Piety Duckbills"}

    sets.midcast.Shellra = {legs="Piety Pantaloons"}


    sets.midcast['Divine Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Artsieq Hat",
      body="Ischemia Chasu.",
      hands={ name="Piety Mitts", augments={'Enhances "Martyr" effect',}},
      legs="Vanya Slops",
      feet={ name="Uk'uxkaj Boots", augments={'Haste+2','"Snapshot"+2','MND+8',}},
      neck="Voltsurge Torque",
      waist="Aswang Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Perception Ring",
      right_ring="Balrahn's Ring",
      back="Refraction Cape",
    }

    sets.midcast['Dark Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Artsieq Hat",
      body="Ischemia Chasu.",
      hands="Gendewitha Gages +1",
      legs="Vanya Slops",
      feet={ name="Uk'uxkaj Boots", augments={'Haste+2','"Snapshot"+2','MND+8',}},
      neck="Voltsurge Torque",
      waist="Aswang Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Perception Ring",
      right_ring="Balrahn's Ring",
      back="Refraction Cape",
    }

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Artsieq Hat",
      body="Ischemia Chasu.",
      hands="Gendewitha Gages +1",
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

    sets.midcast.IntEnfeebles = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Artsieq Hat",
      body="Ischemia Chasu.",
      hands="Gendewitha Gages +1",
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


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = sets.idle


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
      main="Ababinili +1",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Wivre Hairpin", augments={'"Refresh"+1','Earth resistance+6','Water resistance+6',}},
      body="Ischemia Chasu.",
      hands="Serpentes Cuffs",
      legs="Assiduity Pants",
      feet="Serpentes Sabots",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Roundel Earring",
      right_ear="Nourish. Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    sets.idle.PDT = sets.idle

    sets.idle.Town = {
      main="Ababinili +1",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Orison Cap +2",
      body="Ischemia Chasu.",
      hands="Serpentes Cuffs",
      legs={ name="Piety Pantaloons", augments={'Enhances "Shellra V" effect',}},
      feet={ name="Piety Duckbills", augments={'Enhances "Protectra V" effect',}},
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Roundel Earring",
      right_ear="Nourish. Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    sets.idle.Weak = sets.idle

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
      head="Vanya Hood",
      body="Ischemia Chasu.",
      hands="Gendewitha Gages +1",
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Asperity Necklace",
      waist="Cetl Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Rajas Ring",
      right_ring="Meridian Ring",
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Orison Mitts +2"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end

    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Tempered Cape"
    else
        gear.default.obi_back = "Refraction Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

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
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
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
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts =
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']

        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
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
    -- Default macro set/book
    set_macro_page(1, 19)
end
