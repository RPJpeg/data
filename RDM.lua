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
    state.HybridMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal')

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
      main="Marin Staff +1",
      head="Atrophy Chapeau",
      body="Shango Robe",
      hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -1%','Song recast delay -1',}},
      legs={ name="Psycloth Lappas", augments={'MP+75','Mag. Acc.+14','"Fast Cast"+7',}},
      feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+3%','Mag. Acc.+15','"Mag.Atk.Bns."+10',}},
      neck="Voltsurge Torque",
      waist="Witful Belt",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Prolix Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back="Swith Cape",
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
      main="Tefnut Wand",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      back="Pahtli Cape",
})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
      waist="Siegel Sash",
})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
      main="Pukulatmuj",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      waist="Siegel Sash",
})

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      head="Jhakri Coronal +1",
      body={ name="Taeon Tabard", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','Weapon skill damage +2%',}},
      hands="Jhakri Cuffs +1",
      legs={ name="Taeon Tights", augments={'Accuracy+2','Weapon Skill Acc.+19','STR+5 DEX+5',}},
      feet={ name="Taeon Boots", augments={'Attack+21','Weapon Skill Acc.+17','Weapon skill damage +3%',}},
      neck="Rancor Collar",
      waist="Fotia Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Pyrosoul Ring",
      right_ring="Rajas Ring",
      back="Vespid Mantle",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = sets.precast.WS

    sets.precast.WS['Sanguine Blade'] = {
      head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Occult Acumen"+1','INT+9','Mag. Acc.+10',}},
      body={ name="Taeon Tabard", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','Weapon skill damage +2%',}},
      hands="Jhakri Cuffs +1",
      legs={ name="Taeon Tights", augments={'Accuracy+2','Weapon Skill Acc.+19','STR+5 DEX+5',}},
      feet={ name="Taeon Boots", augments={'Attack+21','Weapon Skill Acc.+17','Weapon skill damage +3%',}},
      neck="Eddy Necklace",
      waist="Fotia Belt",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Fenrir Ring",
      right_ring="Acumen Ring",
      back="Vespid Mantle",
    }


    -- Midcast Sets

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
      main="Tefnut Wand",
      sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','Mag. Acc.+5','"Cure" spellcasting time -7%',}},
      ammo="Kalboron Stone",
      head={ name="Vanya Hood", augments={'Healing magic skill +16','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
      body={ name="Gendewitha Bliaut", augments={'Phys. dmg. taken -1%','"Cure" spellcasting time -2%',}},
      hands={ name="Bokwus Gloves", augments={'Mag. Acc.+12','MND+10','INT+9',}},
      legs="Atrophy Tights",
      feet={ name="Medium's Sabots", augments={'MP+10',}},
      neck="Imbodla Necklace",
      waist="Druid's Rope",
      left_ear="Gwati Earring",
      right_ear="Gifted Earring",
      left_ring="Sirona's Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
      back="Solemnity Cape",
    }

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = sets.midcast.Cure

    sets.midcast.Regen = {
      body="Telchine Chas.",
      legs="Telchine Braconi"
    }

    sets.midcast['Enhancing Magic'] = {
      main="Pukulatmuj",
      sub="Genmei Shield",
      head="Befouled Crown",
      body={ name="Telchine Chas.", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
      hands="Atrophy Gloves",
      legs="Atrophy Tights",
      feet="Leth. Houseaux",
      waist="Siegel Sash",
      left_ear="Gwati Earring",
      right_ear="Gifted Earring",
      back="Sucellos's Cape",
    }

    sets.midcast.Refresh = {legs="Lethargy Fuseau"}

    sets.midcast.Stoneskin = {
      main="Pukulatmuj",
      sub="Genmei Shield",
      waist="Siegel Sash",
    }

    sets.midcast['Enfeebling Magic'] = {
      main="Marin Staff +1",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Occult Acumen"+1','INT+9','Mag. Acc.+10',}},
      body="Lethargy Sayon",
      hands="Jhakri Cuffs +1",
      legs={ name="Psycloth Lappas", augments={'MP+75','Mag. Acc.+14','"Fast Cast"+7',}},
      feet={ name="Uk'uxkaj Boots", augments={'Haste+2','"Snapshot"+2','MND+8',}},
      neck="Imbodla Necklace",
      waist="Aswang Sash",
      left_ear="Enchntr. Earring +1",
      right_ear="Gwati Earring",
      left_ring="Perception Ring",
      right_ring="Sangoma Ring",
      back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Mag. Acc.+3','Enh. Mag. eff. dur. +14',}},
    }

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})
    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})
    sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {feet="Vitivation Boots"})
    sets.midcast['Blind II'] = set_combine(sets.midcast['Enfeebling Magic'], {feet="Vitivation Boots"})
    sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {legs="Vitivation Tights"})
    sets.midcast['Blind II'] = set_combine(sets.midcast['Enfeebling Magic'], {legs="Vitivation Tights"})

    sets.midcast['Elemental Magic'] = {
      main="Marin Staff +1",
      sub="Niobid Strap",
      ammo="Dosis Tathlum",
      head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Occult Acumen"+1','INT+9','Mag. Acc.+10',}},
      body="Jhakri Robe +1",
      hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
      legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Fast Cast"+3','"Mag.Atk.Bns."+14',}},
      feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+3%','Mag. Acc.+15','"Mag.Atk.Bns."+10',}},
      neck="Eddy Necklace",
      waist="Aswang Sash",
      left_ear="Friomisi Earring",
      right_ear="Hecate's Earring",
      left_ring="Fenrir Ring",
      right_ring="Acumen Ring",
      back="Toro Cape",
    }

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {
      main="Marin Staff +1",
      sub="Mephitis Grip",
      ammo="Kalboron Stone",
      head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Occult Acumen"+1','INT+9','Mag. Acc.+10',}},
      body="Jhakri Robe +1",
      hands="Jhakri Cuffs +1",
      legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Fast Cast"+3','"Mag.Atk.Bns."+14',}},
      feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+3%','Mag. Acc.+15','"Mag.Atk.Bns."+10',}},
      neck="Voltsurge Torque",
      waist="Aswang Sash",
      left_ear="Enchntr. Earring +1",
      right_ear="Gwati Earring",
      left_ring="Perception Ring",
      right_ring="Sangoma Ring",
      back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Mag. Acc.+3','Enh. Mag. eff. dur. +14',}},
    }

    sets.midcast.Stun = set_combine(sets.precast.FC, {
      main={ name="Apamajas II", augments={'Lightning Affinity: Magic Accuracy+6 Lightning Affinity: Recast time-14%','Lightning Affinity: Magic Damage+1',}},
})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
      body={ name="Helios Jacket", augments={'"Drain" and "Aspir" potency +8',}},
      feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+3%','Mag. Acc.+15','"Mag.Atk.Bns."+10',}},
      waist="Fucho-no-Obi",
})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = sets.midcast['Enhancing Magic']

    sets.buff.ComposureOther = {
      head="Lethargy Chappel",
      body="Lethargy Sayon",
      hands="Lethargy Gantherots",
      legs="Lethargy Fuseau",
      feet="Lethargy Houseaux"
      }

    sets.buff.Saboteur = {hands="Lethargy Gantherots"}
    sets.buff['Chainspell'] = {body="Vitivation Tabard"}
    sets.buff['Spikes'] = {legs="Vitivation Tights"}

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = sets.idle


    -- Idle sets
    sets.idle = {
      main="Pukulatmuj",
      sub="Genmei Shield",
      ammo="Dosis Tathlum",
      head={ name="Vitivation Chapeau", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
      body="Jhakri Robe +1",
      hands="Serpentes Cuffs",
      legs="Jhakri Slops +1",
      feet="Serpentes Sabots",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Renaye Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
      back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
    }

    sets.idle.Town = {
      main="Pukulatmuj",
      sub="Genmei Shield",
      ammo="Dosis Tathlum",
      head={ name="Vitivation Chapeau", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
      body="Jhakri Robe +1",
      hands="Serpentes Cuffs",
      legs="Jhakri Slops +1",
      feet="Serpentes Sabots",
      neck="Twilight Torque",
      waist="Fucho-no-Obi",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Renaye Ring",
      right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
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
      head={ name="Taeon Chapeau", augments={'"Dual Wield"+2','STR+2 VIT+2',}},
      body={ name="Taeon Tabard", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','Weapon skill damage +2%',}},
      hands="Jhakri Cuffs +1",
      legs="Jhakri Slops +1",
      feet={ name="Taeon Boots", augments={'Accuracy+24','"Triple Atk."+2','Crit. hit damage +2%',}},
      neck="Subtlety Spec.",
      waist="Cetl Belt",
      left_ear="Steelflash Earring",
      right_ear="Bladeborn Earring",
      left_ring="Pyrosoul Ring",
      right_ring="Rajas Ring",
      back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Mag. Acc.+3','Enh. Mag. eff. dur. +14',}},
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

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Ice Spikes' or 'Blaze Spikes' or 'Shock Spikes' then
            enable('legs')
            equip(sets.buff['Spikes'])
            disable('feet')
        end
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
