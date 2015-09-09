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

    gear.macc_hagondes = { name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},

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
      main="Marin Staff",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Stoicheion Medal",
      waist="Witful Belt",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Diamond Ring", augments={'MND+3','Spell interruption rate down -5%','"Resist Silence"+3',}},
      back="Swith Cape",
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      waist="Fotia Belt",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {}


    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
      main="Marin Staff",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Stoicheion Medal",
      waist="Witful Belt",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Diamond Ring", augments={'MND+3','Spell interruption rate down -5%','"Resist Silence"+3',}},
      back="Swith Cape",
    }

    sets.midcast.Cure = {
      main="Tefnut Wand",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      ammo="Kalboron Stone",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      hands={ name="Bokwus Gloves", augments={'Mag. Acc.+11','MND+8','INT+6',}},
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
      feet={ name="Uk'uxkaj Boots", augments={'Haste+2','"Snapshot"+2','MND+8',}},
      neck="Imbodla Necklace",
      left_ear="Roundel Earring",
      right_ear="Gifted Earring",
      right_ring="Sirona's Ring",
      back="Tempered Cape",
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
      main={ name="Keraunos", augments={'"Mag.Atk.Bns."+8','"Refresh"+1','INT+8',}},
      ammo="Kalboron Stone",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      hands="Yaoyotl Gloves",
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
      feet={ name="Uk'uxkaj Boots", augments={'Haste+2','"Snapshot"+2','MND+8',}},
      neck="Imbodla Necklace",
      right_ear="Gifted Earring",
      back="Refraction Cape",
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body="Ischemia Chasu.",
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet={ name="Uk'uxkaj Boots", augments={'Haste+2','"Snapshot"+2','MND+8',}},
      neck="Imbodla Necklace",
      waist="Aswang Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Irrwisch Ring",
      right_ring="Perception Ring",
      back={ name="Bane Cape", augments={'Elem. magic skill +1','Dark magic skill +9','"Mag.Atk.Bns."+3',}},
    }

    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body="Ischemia Chasu.",
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet="Goetia Sabots +2",
      neck="Imbodla Necklace",
      waist="Aswang Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Acumen Ring",
      right_ring="Perception Ring",
      back={ name="Bane Cape", augments={'Elem. magic skill +1','Dark magic skill +9','"Mag.Atk.Bns."+3',}},
    }

    sets.midcast.Drain = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body="Ischemia Chasu.",
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet="Goetia Sabots +2",
      neck="Imbodla Necklace",
      waist="Fucho-no-Obi",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Acumen Ring",
      right_ring="Perception Ring",
      back={ name="Bane Cape", augments={'Elem. magic skill +1','Dark magic skill +9','"Mag.Atk.Bns."+3',}},
    }

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
      main={ name="Apamajas II", augments={'Lightning Affinity: Magic Accuracy+6 Lightning Affinity: Recast time-14%','Lightning Affinity: Magic Damage+1',}},
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Stoicheion Medal",
      waist="Witful Belt",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Diamond Ring", augments={'MND+3','Spell interruption rate down -5%','"Resist Silence"+3',}},
      back="Swith Cape",
    }

    sets.midcast.BardSong = sets.midcast.FastRecast


    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
      main={ name="Keraunos", augments={'"Mag.Atk.Bns."+8','"Refresh"+1','INT+8',}},
      sub="Zuuxowu Grip",
      ammo="Witchstone",
      head={ name="Hagondes Hat", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+26',}},
      body="Spaekona's Coat +1",
      hands="Yaoyotl Gloves",
      legs={ name="Hagondes Pants", augments={'Phys. dmg. taken -4%','"Mag.Atk.Bns."+19',}},
      feet="Spae. Sabots +1",
      neck="Eddy Necklace",
      waist="Aswang Sash",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Acumen Ring",
      right_ring="Fenrir Ring",
      back={ name="Bane Cape", augments={'Elem. magic skill +1','Dark magic skill +9','"Mag.Atk.Bns."+3',}},
    }

    sets.midcast['Elemental Magic'].Resistant = sets.midcast['Elemental Magic']

    sets.midcast['Elemental Magic'].HighTierNuke = {
      main={ name="Keraunos", augments={'"Mag.Atk.Bns."+8','"Refresh"+1','INT+8',}},
      sub="Zuuxowu Grip",
      ammo="Witchstone",
      head={ name="Hagondes Hat", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+26',}},
      body={ name="Bokwus Robe", augments={'"Mag.Atk.Bns."+13','INT+10','MND+10',}},
      hands="Yaoyotl Gloves",
      legs={ name="Hagondes Pants", augments={'Phys. dmg. taken -4%','"Mag.Atk.Bns."+19',}},
      feet="Spae. Sabots +1",
      neck="Eddy Necklace",
      waist="Aswang Sash",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Acumen Ring",
      right_ring="Fenrir Ring",
      back="Toro Cape",
    }

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = sets.midcast['Elemental Magic'].HighTierNuke


    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = sets.midcast.FastRecast



    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
      main={ name="Keraunos", augments={'"Mag.Atk.Bns."+8','"Refresh"+1','INT+8',}},
      sub="Zuuxowu Grip",
      ammo="Witchstone",
      head={ name="Wivre Hairpin", augments={'"Refresh"+1','Earth resistance+6','Water resistance+6',}},
      body="Ischemia Chasu.",
      hands="Serpentes Cuffs",
      legs="Assiduity Pants",
      feet="Serpentes Sabots",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }


    -- Idle sets

    -- Normal refresh idle set
    sets.idle = {
      main={ name="Keraunos", augments={'"Mag.Atk.Bns."+8','"Refresh"+1','INT+8',}},
      sub="Zuuxowu Grip",
      ammo="Witchstone",
      head={ name="Wivre Hairpin", augments={'"Refresh"+1','Earth resistance+6','Water resistance+6',}},
      body="Ischemia Chasu.",
      hands="Serpentes Cuffs",
      legs="Assiduity Pants",
      feet="Serpentes Sabots",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = sets.idle

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = sets.idle

    -- Town gear.
    sets.idle.Town = {
      main={ name="Keraunos", augments={'"Mag.Atk.Bns."+8','"Refresh"+1','INT+8',}},
      sub="Zuuxowu Grip",
      ammo="Witchstone",
      head={ name="Hagondes Hat", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+26',}},
      body="Spaekona's Coat +1",
      hands="Serpentes Cuffs",
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet="Spae. Sabots +1",
      neck="Eddy Necklace",
      waist="Fucho-no-Obi",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    -- Defense sets

    sets.defense.PDT = sets.idle

    sets.defense.MDT = sets.idle

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

    sets.buff['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.magic_burst = {neck="Mizukage-no-Kubikazari"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
      main="Eminent Sickle",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Hagondes Hat", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+26',}},
      body="Ischemia Chasu.",
      hands="Yaoyotl Gloves",
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
      feet="Spae. Sabots +1",
      neck="Asperity Necklace",
      waist="Cetl Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Pyrosoul Ring",
      right_ring="Rajas Ring",
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
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
