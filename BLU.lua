-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
	state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
	state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
	state.Buff.Convergence = buffactive.Convergence or false
	state.Buff.Diffusion = buffactive.Diffusion or false
	state.Buff.Efflux = buffactive.Efflux or false

	blue_spell_maps = {
        -- Magic nukes
        ['Sandspin']='Magic',['Cursed Sphere']='Magic',['Blastbomb']='Magic',['Bomb Toss']='Magic',['Death Ray']='Magic',
        ['Ice break']='Magic',['Maelstrom']='Magic',['Firespit']='Magic',['Acrid Stream']='Magic',['Leafstorm']='Magic',
        ['Thermal Pulse']='Magic',['Charged whisker']='Magic',['Water Bomb']='Magic',['Dark Orb']='Magic',['Mind Blast']='Magic',
        ['Magic Hammer']='Magic',['Everyone\'s Grudge']='Magic',['Mysterious Light']='Magic',['Eyes On Me']='Magic',
        ['Blazing Bound']='Magic',['Vapor Spray']='Magic',['Gates of Hades']='Magic',['Bilgestorm']='Magic',
        ['Tempestuous Upheaval']='Magic',['Rending Deluge']='Magic',['Embalming Earth']='Magic',['Foul Waters']='Magic',
        ['Retinal Glare']='Magic',['Droning Whirlwind']='Magic',['Regurgitation']='Debuff',

        -- Magical stuns
        ['Blitzstrahl']='MagicStun',['Temporal Shift']='MagicStun',['Thunderbolt']='MagicStun',

        -- Breath spells
        ['Poison Breath']='Breath',['Magnetite Cloud']='Breath',['Self Destruct']='Breath',['Hecatomb Wave']='Breath',['Radiant Breath']='Breath',
        ['Flying Hip Press']='Breath',['Bad Breath']='Breath',['Frost Breath']='Breath',['Heat Breath']='Breath',['Final Sting']='Breath',
        ['Thunder Breath']='Breath',['Wind Breath']='Breath',

        -- Buff spells where Blue Magic Skill matters (need verification)
        ['Metallic Body']='BuffSkill',['Diamondhide']='BuffSkill',['Reactor Cool']='BuffSkill',['Plasma Charge']='BuffSkill',
        ['Magic Barrier']='BuffSkill',['Barrier Tusk']='BuffSkill',['Orcish Counterstance']='BuffSkill',['Pyric Bulwark']='BuffSkill',
        ['Nature\'s Meditation']='BuffSkill',['Carcharian Verve']='BuffSkill',

        -- Debuffs
        ['Sheep Song']='Debuff',['Blood Drain']='Debuff',['Soporific']='Debuff',['Soud Blast']='Debuff',['Chaotic Eye']='Debuff',
        ['Digest']='Debuff',['Blank Gaze']='Debuff',['Venom Shell']='Debuff',['MP Drainkiss']='Debuff',['Stinking Gas']='Debuff',
        ['Geist Wall']='Debuff',['Awful Eye']='Debuff',['Blood Saber']='Debuff',['Jettatura']='Debuff',['Frightful Roar']='Debuff',
        ['Filamented Hold']='Debuff',['Cold Wave']='Debuff',['Light of Penance']='Debuff',['1000 Needles']='Debuff',['Feather Tickle']='Debuff',
        ['Yawn']='Debuff',['Voracious Trunk']='Debuff',['Infrasonics']='Debuff',['Sandspray']='Debuff',['Corrosive Ooze']='Debuff',
        ['Enervation']='Debuff',['Lowing']='Debuff',['Triumphant Roar']='Debuff',['Actinic Burst']='Debuff',['Osmosis']='Debuff',
        ['Cimicine Discharge']='Debuff',['Demoralizing Roar']='Debuff',['Auroral Drape']='Debuff',['Dream Flower']='Debuff',
        ['Reaving Wind']='Debuff',['Mortal Ray']='Debuff',['Absolute Terror']='Debuff',['Blistering Roar']='Debuff',

        -- Physical spells
        ['Foot Kick']='Physical',['Power Attack']='Physical',['Sprout Smack']='Physical',['Wild Oats']='Physical',['Queasyshroom']='Physical',
        ['Battle Dance']='Physical',['Bludgeon']='Physical',['Screwdriver']='Physical',['Smite of Rage']='Physical',['Pinecone Bomb']='Physical',
        ['Jet Stream']='Physical',['Uppercut']='Physical',['Mandibular Bite']='Physical',['Death Scissors']='Physical',
        ['Dimensional Death']='Physical',['Spinal Cleave']='Physical',['Frenetic Rip']='Physical',['Hydro Shot']='Physical',
        ['Hysteric Barrage']='Physical',['Cannonball']='Physical',['Asuran Claws']='Physical',['Disseverment']='Physical',
        ['Vertical Cleave']='Physical',['Goblin Rush']='Physical',['Vanity Dive']='Physical',['Benthic Typhoon']='Physical',
        ['Quad. Continuum']='Physical',['Empty Thrash']='Physical',['Heavy Strike']='Physical',['Grand slam']='Physical',
        ['Body Slam']='Physical',['Sub-zero Smash']='Physical',['Ram Charge']='Physical',['Delta Thrust']='Physical',
        ['Feather storm']='Physical',['Helldive']='Physical',['Spiral Spin']='Physical',['Claw Cyclone']='Physical',['Terror Touch']='Physical',
        ['Sickle Slash']='Physical',['Seedspray']='Physical',['Quadrastrike']='Physical',['Tourbillion']='Physical',['Amorphic Spikes']='Physical',
        ['Barbed Crescent']='Physical',['Bloodrake']='Physical',['Paralyzing Triad']='Physical',['Glutinous Dart']='Physical',

        -- Physical stuns
        ['Head Butt']='PhysStun',['Sudden Lunge']='PhysStun',['Tail Slap']='PhysStun',['Frypan']='PhysStun',['Whirl of Rage']='PhysStun',

        -- Cure spells, modified by blue skill,healing skill and MND
        ['Pollen']='BlueCure',['Healing Breeze']='BlueCure',['Wild Carrot']='BlueCure',['Magic Fruit']='BlueCure',
        ['Plenilune Embrace']='BlueCure',['White Wind']='BlueCure'}

    -- Spells that have static effects, not modified by skill or stats
    blue_no_skill_spell_list = S{'Cocoon','Harden Shell','Refueling','Zephyr Mantle','Regeneration','Animating Wail','Battery Charge',
        'Occultation','Winds of Promy.','Feather Barrier','Memento mori','Saline Coat','Warm-Up','Amplification','Exuviation','Fantod'}

    blue_diffusion_spell_list = S{'Cocoon','Metallic Body','Refueling','Feather Barrier','Memento Mori','Zephyr Mantle','Warm-Up','Amplification',
        'Saline Coat','Reactor Cool','Exuviation','Plasma Charge','Harden Shell'}

    -- Spells available only through Unbriled Learning
    blue_unbridled_spell_list = S{'Harden Shell','Thunderbolt','Absolute Terror','Gates of Hades','Tourbillion','Pyric Bulwark','Bilgestorm','Bloodrake',
        'Droning Whirlwind','Carcharian Verve','Blistering Roar'}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	options.OffenseModes = {'Normal','Accuracy'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	state.OffenseMode = 'Normal'

	-- Default macro set/book
	set_macro_page(2, 1)
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end


-- Define sets and vars used by this job file.
function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure lore'] = {hands="Luhlaza Bazubands"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan"})


	-- Weaponskill sets
	gear.default.weaponskill_neck = "Rancor Collar"
	gear.default.weaponskill_waist = "Fotia Belt"

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

  -- MAB > MND Modifiers
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {})

	-- Midcast Sets
	sets.midcast.FastRecast = sets.precast.FC

	-- Specific spells
	sets.midcast.Utsusemi = sets.midcast.FastRecast

	-- Blue Magic sets
	gear.default.obi_waist= "Penitent's Rope"
  gear.default.obi_back= "Toro Cape"

	sets.midcast.Physical = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	sets.midcast.PhysStun = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	sets.midcast.Magic = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	sets.midcast.Debuff = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	sets.midcast.MagicStun = set_combine(sets.midcast.FastRecast, sets.midcast.Debuff)

	sets.midcast.BuffSkill = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	sets.midcast.Breath = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	sets.midcast.BlueCure = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	-- Resting sets
	sets.resting = sets.idle


	-- Idle sets
	sets.idle = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	sets.idle.Town = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	sets.idle.Weak = sets.idle

	-- Defense sets
	sets.defense.PDT = sets.idle
	sets.defense.MDT = sets.idle
	sets.Kiting = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	-- Engaged sets

	sets.engaged = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

  sets.engaged.Accuracy = {
		head="Iuitl Headgear",
    neck="Ire Torque +1",
    ear1="Triumph Earring",
    ear2="Flame Earring",
		body="Magus Jubbah",
    hands="Espial Bracers",
    ring1="Rajas Ring",
    ring2="Spiral Ring",
		back="Cuchulain's Mantle",
    waist="Warwolf Belt",
    legs="Mavi Tayt +2",
    feet="Iuitl Gaiters"
  }

	-- Sets that have JS specific enhancements
	sets.buff['Burst Affinity'] = {legs="Assimilator's Shalwar",feet="Hashishin Basmak"}
	sets.buff['Chain Affinity'] = {head="Hashishin Kavuk",body="Luhlaza Jubbah",feet="Assimilator's charuqs"}
	sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
	sets.buff.Efflux = {legs="Hashishin Tayt",back="Rosmerta's Cape"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Auto handle Unbridled learning activation if casting a spell that requires it
	if blue_unbridled_spell_list[spell.englilsh] and not buffactive['Unbridled Learning'] then
		windower.send_command('@input /ja "Unbridled learning" <me>; wait 1.25; input /ma "'..spell.name..'" '..spell.target.name)
		eventArgs.cancel = true
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		if spell.skill == 'Blue Magic' then
			-- Define the Blue Magic spell type used
			classes.CustomClass = blue_spell_class(spell)
			--add_to_chat(122, 'Spell = '..classes.CustomClass)
		else
			-- Default base equipment layer is fast recast.
			equip(sets.midcast.FastRecast)
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Blue Magic' then
		if classes.CustomClass == 'Physical' then
			if state.Buff['Chain Affinity'] then
				equip(sets.buff['Chain Affinity'])
			end
			if state.Buff['Efflux'] then
				equip(sets.buff.Efflux)
			end
		elseif classes.CustomClass == 'Magic' then
			if state.Buff['Burst Affinity'] then
				equip(sets.buff['Burst Affinty'])
			end
			if state.Buff['Covergence'] then
				equip(sets.buff.Convergence)
			end
		elseif state.Buff['Diffusion'] and blue_diffusion_spell_list[spell] then
				equip(sets.buff.Diffusion)
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.english] ~= nil then
			state.Buff[spell.english] = true
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function blue_spell_class(spell)
	if blue_no_skill_spell_list[spell.english] then
		-- Use the default set if skill is not needed
		return nil
	elseif blue_spell_maps[spell.english] then
		-- If the spell is defined in blue_spell_maps
		-- return the value as customClass
		return blue_spell_maps[spell.english]
	else
		-- Basic error handling for when the blue spell name is not recognized
		-- fallback to standard set
		add_to_chat(122,'Spell '..spell.english..' not recognized, using default set')
		return nil
	end
end
