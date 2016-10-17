function get_sets()

send_command('bind ^f9 gs c toggle TP set')
send_command('bind !f9 gs c toggle Weaponskill sets')
send_command('bind f9 gs c toggle Idle set')

function file_unload()

	send_command('unbind ^f9')
	send_command('unbind ^f10')

	send_command('unbind !f9')
	send_command('unbind !f10')
	send_command('unbind !f12')

	send_command('unbind f9')
	send_command('unbind f10')
	send_command('unbind f11')
	send_command('unbind f12')



end


	-- JA Sets for Precast Function --
	sets.JA = {}

	sets.JA['Elemental Sforzo'] = {body="Futhark Coat"}
	sets.JA['Vallation'] = {body="Runeist Coat",legs="Futhark Trousers"}
	sets.JA['Valiance'] = {body="Runeist Coat",legs="Futhark Trousers"}
	sets.JA['Pflug'] = {feet="Runeist Bottes"}
	sets.JA['Swordplay'] = {hands="Futhark Mitons"}
	sets.JA['Gambit'] = {hands="Runeist Mitons"}
	sets.JA['Liement'] = {body="Futhark Coat"}
	sets.JA['Battuta'] = {head="Futhark Bandeau"}

	sets.JA['Lunge'] = {
    ammo="Dosis Tathlum",
    hands={ name="Leyline Gloves", augments={'Accuracy+6','Mag. Acc.+2','"Mag.Atk.Bns."+6',}},
    feet={ name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+3','Attack+10',}},
    neck="Eddy Necklace",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Fenrir Ring",
    right_ring="Acumen Ring",
    back="Toro Cape",
}

	sets.JA['Embolden'] = {back="Evasionist's Cape"}
	sets.JA['Vivacious Pulse'] = {legs="Runeist Trousers"}
	sets.JA['Provoke'] = {left_Ear="Friomisi Earring"}


	-- TP/Engaged sets --
  sets.TP = {}
	sets.TP.index = {'Reg', 'ACC', 'Hybrid', 'Tank', 'TankAcc', 'TankMag'}
	TP_index = 1

	sets.TP.Reg = {
    ammo="Ginsen",
    head="Skormoth Mask",
    body="Taeon Tabard",
    hands="Meg. Gloves +1",
    legs="Samnuha Tights",
    feet="Herculean Boots",
    neck="Asperity Necklace",
    waist="Cetl Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Epona's Ring",
    right_ring="Rajas Ring",
    back="Atheling Mantle",
  }

	sets.TP.ACC = {
    ammo="Honed Tathlum",
    head="Meghanada Visor +1",
    body="Taeon Tabard",
    hands="Meg. Gloves +1",
    legs="Meg. Chausses +1",
    feet="Meg. Jam. +1",
    neck="Subtlety Spec.",
    waist="Cetl Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Epona's Ring",
    right_ring="Rajas Ring",
    back="Xucau Mantle",
  }

	sets.TP.Hybrid = {
    ammo="Honed Tathlum",
    head="Meghanada Visor +1",
    body="Taeon Tabard",
    hands="Meg. Gloves +1",
    legs="Samnuha Tights",
    feet="Herculean Boots",
    neck="Subtlety Spec.",
    waist="Cetl Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Epona's Ring",
    right_ring="Rajas Ring",
    back="Atheling Mantle",
  }

	sets.TP.Tank = {
    ammo="Honed Tathlum",
    head="Meghanada Visor +1",
    body="Futhark Coat",
    hands="Meg. Gloves +1",
    legs="Meg. Chausses +1",
    feet="Herculean Boots",
    neck="Twilight Torque",
    waist="Cetl Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
    back="Xucau Mantle",
  }

	sets.TP.TankAcc ={
    ammo="Honed Tathlum",
    head="Meghanada Visor +1",
		body="Futhark Coat",
    hands="Meg. Gloves +1",
    feet="Meg. Jam. +1",
    feet="Herculean Boots",
    neck="Twilight Torque",
    waist="Cetl Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
    back="Xucau Mantle",
  }

  sets.TP.TankMag ={
    ammo="Honed Tathlum",
    head="Skormoth Mask",
		body="Futhark Coat",
    hands="Meg. Gloves +1",
    legs="Meg. Chausses +1",
    feet="Herculean Boots",
    neck="Twilight Torque",
    waist="Cetl Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Meridian Ring",
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
    back="Xucau Mantle",
  }

	-- Idle Sets --
	sets.Idle = {}
	sets.Idle.index = {'Regen'}
	Idle_index = 1


	sets.Idle.Regen = {
    head={ name="Herculean Helm", augments={'Accuracy+20 Attack+20','"Store TP"+1','Accuracy+15',}},
		body="Futhark Coat",
    hands="Meg. Gloves +1",
    legs={ name="Desultor Tassets", augments={'Phys. dmg. taken -4%','Movement speed +8%+2',}},
    feet={ name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+3','Attack+10',}},
    neck="Twilight Torque",
    waist="Fucho-no-Obi",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Renaye Ring",
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Breath dmg. taken -4%','Magic dmg. taken -4%',}},
    back={ name="Mecisto. Mantle", augments={'Cap. Point+42%','HP+13','DEF+6',}},
  }


	--WS Resolution Set --
	sets.WS = {}
	sets.Resolution = {}
	sets.Resolution.index = {'Normal'}
	Resolution_index = 1

	sets.Resolution.Normal = {
    head="Sukeroku Hachi.",
    body="Taeon Tabard",
    hands="Meg. Gloves +1",
    legs={ name="Taeon Tights", augments={'Accuracy+2','Weapon Skill Acc.+19','STR+5 DEX+5',}},
    feet={ name="Taeon Boots", augments={'Attack+21','Weapon Skill Acc.+17','Weapon skill damage +3%',}},
    neck="Breeze Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Steelflash Earring",
    left_ring="Apate Ring",
    right_ring="Rajas Ring",
    back="Vespid Mantle",
  }

	sets.Resolution.R = set_combine(sets.Resolution.Normal,{neck="Ygnas's Resolve +1"})

	sets.Dimidiation = {}
	sets.Dimidiation.index = {'Normal'}
	Dimidiation_index = 1

	sets.Dimidiation.Normal = set_combine(sets.Resolution.Normal,{neck="Nefarious Collar"})

	sets.Dimidiation.R = set_combine(sets.Dimidiation.Normal,{neck="Ygnas's Resolve +1"})


	-- WS Requiescat Set --

	sets.Requiescat = {}
	sets.Requiescat.index = {'Normal'}
	Requiescat_index = 1

	sets.Requiescat.Normal = sets.Resolution.Normal

	-- WS Ruinator Set --

	sets.Ruinator = {}
	sets.Ruinator.index = {'Normal'}
	Ruinator_index = 1

	sets.Ruinator.Normal = sets.Resolution.Normal

  -- WS Herc Slash Set --

	sets.HerculeanSlash = {}
	sets.HerculeanSlash.index = {'Normal'}
	Ruinator_index = 1

	sets.HerculeanSlash.Normal = {
    ammo="Dosis Tathlum",
    head="Sukeroku Hachi.",
    body="Taeon Tabard",
    hands="Meg. Gloves +1",
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
	-- Precast Spell sets --
	sets.precast = {}
	sets.precast.FC = {}

	sets.precast.FC = {
    head="Runeist Bandeau",
    body="Mirke Wardecors",
    hands="Leyline Gloves",
    legs="Samnuha Tights",
    feet="Herculean Boots",
    neck="Voltsurge Torque",
    waist="Twilight Belt",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Spell interruption rate down -5%',}},
    right_ring="Prolix Ring",
  }

	sets.precast.FC.Enhancing = set_combine(sets.precast.FC,{hands="Runeist Mitons",legs="Futhark Trousers",waist="Siegel Sash",})


	sets.precast.FC.Divine = set_combine(sets.precast.FC,{legs="Runeist Trousers"})

	--Phalanx Utility--
	sets.Utility = {}

	sets.Utility.Phalanx = set_combine(sets.precast.FC.Enhancing,{
			head="Futhark Bandeau"})

	--Copy and pasted set from Snprphnx_SCH example--
        --Obis--
         sets.Obi = {}
         sets.Obi.Fire = {waist='Karin Obi',ring2='Zodiac Ring'}
         sets.Obi.Earth = {waist='Dorin Obi',ring2='Zodiac Ring'}
         sets.Obi.Water = {waist='Suirin Obi',ring2='Zodiac Ring'}
         sets.Obi.Wind = {waist='Furin Obi',ring2='Zodiac Ring'}
         sets.Obi.Ice = {waist='Hyorin Obi',ring2='Zodiac Ring'}
         sets.Obi.Thunder = {waist='Rairin Obi',ring2='Zodiac Ring'}
         sets.Obi.Light = {waist='Korin Obi',ring2='Zodiac Ring'}
         sets.Obi.Dark = {waist='Anrin Obi',ring2='Zodiac Ring'}

  -----Tengu
	sets.tengu = {ammo="Tengu-No-Hane"}

end

--Precast Actions--

function precast(spell,act)

	if spell.type == 'JobAbility' then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
	end

	if spell.action_type == 'Enhancing' then
		equip(sets.precast.FC.Enhancing)
	end

	if spell.action_type == 'Divine' then
		equip(sets.precast.FC.Divine)
	end

	if spell.action_type == 'Magic' then
		equip(sets.precast.FC)
	end

	if spell.action_type == 'Ninjutsu' then
		equip(sets.precast.FC)
	end

	if spell.english == 'Lunge' or spell.english == 'Swipe' then
		equip(sets.JA['Lunge'])
		if spell.element == world.weather_element or spell_element == world.day_element then
                        equip(sets.JA['Lunge'],sets.Obi[spell.element])
		end
	end

	if spell.english == "Resolution" then
		equip(sets.Resolution[sets.Resolution.index[Resolution_index]])
	end

	if spell.english == "Requiescat" then
		equip(sets.Requiescat[sets.Requiescat.index[Requiescat_index]])
	end

	if spell.english == "Ruinator" then
		equip(sets.Ruinator[sets.Ruinator.index[Ruinator_index]])
	end

	if spell.english == "Dimidiation" then
		equip(sets.Dimidiation[sets.Dimidiation.index[Dimidiation_index]])
	end

	if spell.english == "Herculean Slash" then
		equip(sets.JA['Lunge'])
	end

	if buffactive['Reive Mark'] and spell.type == 'WeaponSkill' then
		equip(sets.Resolution.R)
	end

	if buffactive['Reive Mark'] and spell.english == 'Dimidiation' then
		equip(sets.Dimidiation.R)
	end

	if buffactive['Reive Mark'] and spell.english == 'Resolution' then
		equip(sets.Resolution.R)
	end

	if buffactive['Tenebrae'] and spell.english == 'Lunge' then
		equip(sets.JA.Lunge,{head="Pixie Hairpin +1"})
	end

	if buffactive['Tenebrae'] and spell.english == 'Swipe' then
		equip(sets.JA.Lunge,{head="Pixie Hairpin +1"})
	end

	if buffactive['Lux'] and spell.english == 'Lunge' then
		equip(sets.JA.Lunge,{ring2="Weatherspoon Ring"})
	end

	if buffactive['Lux'] and spell.english == 'Swipe' then
		equip(sets.JA.Lunge,{ring2="Weatherspoon Ring"})
	end

end

--Midcast functions for spells--

function midcast(spell,act)

	if spell.english == 'Phalanx' then
		equip(sets.Utility.Phalanx)
	end

	if spell.english == 'Flash' then
		equip(sets.precast.FC.Divine)
	end

	if spell.english == 'Regen IV' then
		equip(sets.precast.FC.Enhancing,{head="Runeist Bandeau"})
	end

	if spell.type == 'JobAbility' then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
	end

	if spell.english == 'Lunge' or spell.english == 'Swipe' then
		equip(sets.JA['Lunge'])
		if spell.element == world.weather_element or spell_element == world.day_element then
                        equip(sets.JA['Lunge'],sets.Obi[spell.element])
		end
	end

	if spell.english == "Resolution" then
		equip(sets.Resolution[sets.Resolution.index[Resolution_index]])
	end

	if spell.english == "Requiescat" then
		equip(sets.Requiescat[sets.Requiescat.index[Requiescat_index]])
	end

	if spell.english == "Ruinator" then
		equip(sets.Ruinator[sets.Ruinator.index[Ruinator_index]])
	end

	if spell.english == "Dimidiation" then
		equip(sets.Dimidiation[sets.Dimidiation.index[Dimidiation_index]])
	end

	if spell.english == "Herculean Slash" then
		equip(sets.JA['Lunge'])
	end

	if buffactive['Reive Mark'] and spell.type == 'WeaponSkill' then
		equip(sets.Resolution.R)
	end

	if buffactive['Reive Mark'] and spell.english == 'Dimidiation' then
		equip(sets.Dimidiation.R)
	end

	if buffactive['Reive Mark'] and spell.english == 'Resolution' then
		equip(sets.Resolution.R)
	end

	if buffactive['Tenebrae'] and spell.english == 'Lunge' then
		equip(sets.JA.Lunge,{head="Pixie Hairpin +1"})
	end

	if buffactive['Tenebrae'] and spell.english == 'Swipe' then
		equip(sets.JA.Lunge,{head="Pixie Hairpin +1"})
	end

	if spell.name == 'Resolution' or spell.name == "Dimidiation" then
            tengu_handler()
        end

end

function tengu_handler()
    if world.time >= 360 and world.time < 1080 then -- 6~18
        equip(sets.tengu)
    end
end
--Aftercast function, returns user to TP set after actions/spells--

function aftercast(spell,act)

	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_index]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_index]])
	end

	if player.status == 'Engaged' and buffactive['Battuta'] then
		equip{feet="Futhark Boots"}
	end

	if player.status == 'Engaged' and buffactive['Reive Mark'] then
                equip{neck="Ygnas's Resolve +1"}
       end
end

function buff_change(new,old)
	if buffactive['Battuta'] then
		equip{feet="Futhark Boots"}
	end

	if buffactive['Embolden'] then
		equip{back="Evasionist's Cape"}
	end

	if player.status == 'Engaged' and buffactive['Reive Mark'] then
                equip{neck="Ygnas's Resolve +1"}
        end

end

--Status Change function, switches user to TP set upon engaging--

function status_change(new,old)

	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_index]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_index]])
	end

	if buffactive['Battuta'] and new == 'Engaged' then
		equip{feet="Futhark Boots"}
	end

	if player.status == 'Engaged' and buffactive['Reive Mark'] then
                equip{neck="Ygnas's Resolve +1"}
        end
end




--Toggle Command functions--
--Gearswap direct command = //gs c toggle 'x' set
--Macro line = console gs c toggle x set
--ex: console gs c toggle TP set
-- Index is set to 1 or 'Reg', press button once to switch to 'Acc', and so on.

function self_command(command)
	if command == 'toggle TP set' then
		if TP_index < 6 then
		TP_index = TP_index +1
		else TP_index = 1 end
		send_command('@ input /echo >>> TP set changed to '..sets.TP.index[TP_index]..' ')
		equip(sets.TP[sets.TP.index[TP_index]])

	elseif command == 'toggle Weaponskill sets' then
		Resolution_index = Resolution_index +1
		if Resolution_index > #sets.Resolution.index then Resolution_index = 1 end
		Requiescat_index = Requiescat_index +1
		if Requiescat_index > #sets.Requiescat.index then Requiescat_index = 1 end
		Ruinator_index = Ruinator_index +1
		if Ruinator_index > #sets.Ruinator.index then Ruinator_index = 1 end
		Dimidiation_index = Dimidiation_index +1
		if Dimidiation_index > #sets.Dimidiation.index then Dimidiation_index = 1 end
		send_command('@ input /echo >>> All Weaponskill sets changed to '..sets.Dimidiation.index[Dimidiation_index]..' ')

	elseif command == 'toggle Multi set' then
		if TP_index < 11 and TP_index > 0 then
		TP_index = 11 end
		send_command('@ input /echo >>> TP set change to '..sets.TP.index[TP_index]..' ')
		equip(sets.TP[sets.TP.index[TP_index]])

	elseif command == 'toggle Magic set' then
		if TP_index < 12 and TP_index > 0 then
		TP_index = 12 end
		send_command('@ input /echo >>> Defense set changed to '..sets.TP.index[TP_index]..' ')
		equip(sets.TP[sets.TP.index[TP_index]])

	elseif command == 'toggle Idle set' then
		Idle_index = Idle_index +1
		if Idle_index > #sets.Idle.index then Idle_index = 1 end
		send_command('@ input /echo >>> Idle set changed to '..sets.Idle.index[Idle_index]..' ')
		equip(sets.Idle[sets.Idle.index[Idle_index]])

	end

end

function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 14)
	else
		set_macro_page(1, 14)
	end
end
