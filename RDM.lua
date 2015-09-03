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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Aswang Sash"

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard"}


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
      right_ear="Roundel Earring",
    }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells

    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {
      main="Marin Staff",
      head="Atrophy Chapeau",
      body="Duelist's Tabard",
      hands={ name="Gendewitha Gages", augments={'Phys. dmg. taken -2%','Song spellcasting time -3%',}},
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

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {main="Pukulatmuj",
    sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
    waist="Siegel Sash",})

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      head={ name="Gende. Caubeen", augments={'Phys. dmg. taken -1%','Song spellcasting time -3%',}},
      body="Ischemia Chasu.",
      hands="Yaoyotl Gloves",
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Asperity Necklace",
      waist="Fotia Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Rajas Ring",
      right_ring="Pyrosoul Ring",
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = sets.precast.WS

    sets.precast.WS['Sanguine Blade'] = {
      head={ name="Hagondes Hat", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+26',}},
      body={ name="Bokwus Robe", augments={'"Mag.Atk.Bns."+13','INT+10','MND+10',}},
      hands="Yaoyotl Gloves",
      legs={ name="Hagondes Pants", augments={'Phys. dmg. taken -4%','"Mag.Atk.Bns."+19',}},
      feet={ name="Vitivation Boots", augments={'Enhances "Paralyze II" effect',}},
      neck="Stoicheion Medal",
      waist="Fotia Belt",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Fenrir Ring",
      right_ring="Acumen Ring",
      back="Toro Cape",
    }


    -- Midcast Sets

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
      main="Tefnut Wand",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      ammo="Kalboron Stone",
      head={ name="Gende. Caubeen", augments={'Phys. dmg. taken -1%','Song spellcasting time -3%',}},
      body={ name="Gendewitha Bliaut", augments={'Phys. dmg. taken -1%','"Cure" spellcasting time -2%',}},
      hands={ name="Bokwus Gloves", augments={'Mag. Acc.+11','MND+8','INT+6',}},
      legs="Atrophy Tights",
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Imbodla Necklace",
      waist="Witful Belt",
      left_ear="Roundel Earring",
      right_ear="Gifted Earring",
      left_ring="Perception Ring",
      right_ring="Sirona's Ring",
      back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Mag. Acc.+3','Enh. Mag. eff. dur. +14',}},
    }

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {}

    sets.midcast.Regen = {
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
    }

    sets.midcast['Enhancing Magic'] = {
      main="Pukulatmuj",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      hands="Atrophy Gloves",
      legs="Atrophy Tights",
      feet="Leth. Houseaux",
      back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Mag. Acc.+3','Enh. Mag. eff. dur. +14',}},
    }

    sets.midcast.Refresh = {legs="Lethargy Fuseau"}

    sets.midcast.Stoneskin = {
      main="Pukulatmuj",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      waist="Siegel Sash",
    }

    sets.midcast['Enfeebling Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body="Ischemia Chasu.",
      hands="Lethargy Gantherots",
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet={ name="Uk'uxkaj Boots", augments={'Haste+2','"Snapshot"+2','MND+8',}},
      neck="Imbodla Necklace",
      waist="Aswang Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Perception Ring",
      right_ring="Irrwisch Ring",
      back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Mag. Acc.+3','Enh. Mag. eff. dur. +14',}},
    }

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})

    sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {feet="Vitivation Boots"})

    sets.midcast['Elemental Magic'] = {
      main="Marin Staff",
      sub="Zuuxowu Grip",
      ammo="Witchstone",
      head={ name="Hagondes Hat", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+26',}},
      body={ name="Bokwus Robe", augments={'"Mag.Atk.Bns."+13','INT+10','MND+10',}},
      hands="Yaoyotl Gloves",
      legs={ name="Hagondes Pants", augments={'Phys. dmg. taken -4%','"Mag.Atk.Bns."+19',}},
      feet={ name="Vitivation Boots", augments={'Enhances "Paralyze II" effect',}},
      neck="Stoicheion Medal",
      waist="Aswang Sash",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Fenrir Ring",
      right_ring="Acumen Ring",
      back="Toro Cape",
    }

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {
      main="Marin Staff",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Artsieq Hat", augments={'Mag. Acc.+18','Mag. Evasion+7','Magic dmg. taken -2',}},
      body="Ischemia Chasu.",
      hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -4%','Pet: "Mag.Atk.Bns."+21',}},
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet={ name="Vitivation Boots", augments={'Enhances "Paralyze II" effect',}},
      neck="Imbodla Necklace",
      waist="Aswang Sash",
      left_ear="Lifestorm Earring",
      right_ear="Psystorm Earring",
      left_ring="Perception Ring",
      right_ring="Balrahn's Ring",
      back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Mag. Acc.+3','Enh. Mag. eff. dur. +14',}},
    }

    sets.midcast.Stun = {
      main={ name="Apamajas II", augments={'Lightning Affinity: Magic Accuracy+6 Lightning Affinity: Recast time-14%','Lightning Affinity: Magic Damage+1',}},
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head="Atrophy Chapeau",
      body="Duelist's Tabard",
      hands={ name="Gendewitha Gages", augments={'Phys. dmg. taken -2%','Song spellcasting time -3%',}},
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet={ name="Telchine Pigaches", augments={'"Fast Cast"+2',}},
      neck="Imbodla Necklace",
      waist="Witful Belt",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring="Prolix Ring",
      right_ring="Perception Ring",
      back="Swith Cape",
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {
      main="Pukulatmuj",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      body={ name="Telchine Chas.", augments={'"Fast Cast"+2','"Regen" potency+2',}},
      hands="Atrophy Gloves",
      legs="Atrophy Tights",
      feet="Leth. Houseaux",
      back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Mag. Acc.+3','Enh. Mag. eff. dur. +14',}},
    }

    sets.buff.ComposureOther = {
      head="Estoqueur's Chappel +2",
      body="Estoqueur's Sayon +2",
      hands="Lethargy Gantherots",
      legs="Lethargy Fuseau",
      feet="Lethargy Houseaux"
      }

    sets.buff.Saboteur = {hands="Lethargy Gantherots"}


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = sets.idle


    -- Idle sets
    sets.idle = {
      main="Pukulatmuj",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      ammo="Kalboron Stone",
      head={ name="Vitivation Chapeau", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
      body="Ischemia Chasu.",
      hands="Serpentes Cuffs",
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet="Serpentes Sabots",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    sets.idle.Town = {
      main="Pukulatmuj",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      ammo="Kalboron Stone",
      head={ name="Vitivation Chapeau", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
      body="Ischemia Chasu.",
      hands="Lethargy Gantherots",
      legs={ name="Artsieq Hose", augments={'MP+22','Mag. Acc.+16','MND+5',}},
      feet="Leth. Houseaux",
      neck="Imbodla Necklace",
      waist="Fucho-no-Obi",
      left_ear="Loquac. Earring",
      right_ear="Gifted Earring",
      left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    sets.idle.Weak = sets.idle

    sets.idle.PDT = sets.idle

    sets.idle.MDT = sets.idle


    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
      head={ name="Vitivation Chapeau", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
      body="Ischemia Chasu.",
      hands="Atrophy Gloves",
      legs={ name="Telchine Braconi", augments={'Mag. Evasion+13','"Cure" spellcasting time -6%','"Regen" potency+1',}},
      feet="Serpentes Sabots",
      neck="Asperity Necklace",
      waist="Cetl Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Rajas Ring",
      right_ring="Pyrosoul Ring",
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    sets.engaged.Defense = sets.engaged

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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
    if player.sub_job == 'DNC' then
        set_macro_page(1, 13)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 13)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 13)
    else
        set_macro_page(1, 13)
    end
end
