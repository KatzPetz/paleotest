
local S = mobs.intllib

-- Sleeping and Awake animation sets

local animation_awake = {
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 50,
		stand_end = 110,
		walk_start = 1,
		walk_end = 40,
		punch_start = 120,
		punch_end = 150,
		punch_loop = false,
		}
local animation_sleep = {
                stand_speed = 5,
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 195,
		stand_end = 210,
		walk_start = 195,
		walk_end = 210,
		punch_loop = false,
		}

-- Land and Water animation sets

local animation_water = {
	        speed_normal = 10,
	        speed_sprint = 20,
	        stand_start = 160,
	        stand_end = 190,
	        walk_start = 160,
	        walk_end = 190,
	        punch_start = 120,
	        punch_end = 150,
	        walk_loop = false,
		}
local animation_land = {
	        speed_normal = 10,
	        speed_sprint = 20,
	        stand_start = 50,
	        stand_end = 110,
	        walk_start = 1,
	        walk_end = 40,
	        punch_start = 120,
	        punch_end = 150,
	        punch_loop = false,
		}


-- Spinosaurus by ElCeejo

mobs:register_mob("paleotest:spinosaurus", {
	type = "monster",
	hp_min = 89,
	hp_max = 89,
	armor = 90,
	passive = false,
	walk_velocity = 1.4,
	run_velocity = 2.2,
        walk_chance = 10,
        jump = false,
        jump_height = 1.1,
        stepheight = 1.1,
        fly = true,
        fly_in = "default:water_source",
        runaway = false,
        pushable = false,
        view_range = 4,
        knock_back = 0,
        damage = 10,
	fear_height = 6,
	fall_speed = -8,
	fall_damage = 15,
	water_damage = 0,
	lava_damage = 3,
	light_damage = 0,
        suffocation = false,
        floats = 0,
	owner = "",
	order = "follow",
	follow = {"mobs:meat_raw"},
        reach = 4,
        attack_chance = 30,
        attack_animals = true,
        attack_npcs = true,
        attack_players = true,
        owner_loyal = true,
        group_attack = false,
	attack_type = "dogfight",
	pathfinding = 1,
	makes_footstep_sound = true,
	sounds = {
		random = "paleotest_spinosaurus",
	},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 3, max = 5},
	},
	visual = "mesh",
	visual_size = {x=18, y=18},
	collisionbox = {-1.3, -1.0, -1.3, 1.3, 1.8, 1.3},
	textures = {
		{"paleotest_spinosaurus1.png"},
		{"paleotest_spinosaurus2.png"},
	},
	child_texture = {
		{"paleotest_spinosaurus3.png"},
	},
	mesh = "paleotest_spinosaurus.b3d",
	animation = {
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 50,
		stand_end = 110,
		walk_start = 1,
		walk_end = 40,
		punch_start = 120,
		punch_end = 150,
		punch_loop = false,
	},

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end

		if self.owner == "" then
			self.owner = clicker:get_player_name()
		else
			if self.order == "follow" then
				self.order = "stand"
			else
				self.order = "follow"

			end

		end

	end,

	do_custom = function(self, dtime, nodef)

-- Diurnal mobs sleep at night and awake at day

	if self.time_of_day > 0.2
	and self.time_of_day < 0.8 then

        self.passive = false    
        self.view_range = 4
        self.walk_chance = 10
        self.jump = true
        self.animation = animation_awake
	mobs:set_animation(self, self.animation.current)
	elseif self.time_of_day > 0.0
	and self.time_of_day < 1.0 then

        self.passive = true     
        self.view_range = 0
        self.walk_chance = 0
        self.jump = false
        self.animation = animation_sleep
	mobs:set_animation(self, self.animation.current)
	end

-- Mob changes animation and can swim in water

	local nodef = minetest.registered_nodes[self.standing_in]

        if nodef.groups.water then

        self.fly = true     
        self.fly_in = "default:water_source"
        self.floats = 0
        self.view_range = 12
        self.walk_chance = 100
        self.animation = animation_water
	elseif not self:attempt_flight_correction() then

        self.fly = false
        self.floats = 0
        self.view_range = 4
        self.walk_chance = 10
        self.animation = animation_land
                        return
		end

-- Baby mobs are passive, Tamed mobs will protect their owner

	if self.child == true then

	self.type = "animal"
	self.passive = true
        self.attack_animals = false
	self.walk_velocity = 0.7
	self.run_velocity = 0.7
			return
		end

	if self.tamed == true then

	self.type = "animal"
	self.passive = false
        self.attack_animals = false
        self.attack_monsters = false
        self.attack_players = false
        self.owner_loyal = true
			return
                end
        end,
})

local wild_spawn = minetest.settings:get_bool("wild_spawning")

if wild_spawn then

mobs:spawn({
	name = "paleotest:spinosaurus",
	nodes = "default:river_water_source",
	min_light = 14,
	interval = 60,
	chance = 8000, -- 15000
	min_height = 0,
	max_height = 200,
	day_toggle = true,
})

end

mobs:register_egg("paleotest:spinosaurus", S("Spinosaurus"), "default_sand.png", 1)

-- Spinosaurus Egg by ElCeejo

mobs:register_mob("paleotest:Spinosaurus_egg", {
	type = "nil",
	hp_min = 5,
	hp_max = 5,
	armor = 200,
	passive = true,
	walk_velocity = 0,
	run_velocity = 0,
	jump = false,
	runaway = false,
        pushable = true,
	fear_height = 5,
	fall_damage = 0,
	fall_speed = -8,
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	collisionbox = {-0.2, -0.5, -0.2, 0.2, 0, 0.2},
	visual = "mesh",
	mesh = "paleotest_egg.b3d",
	textures = {
		{"paleotest_egg3.png"},
	},
	makes_footstep_sound = false,
	animation = {
		speed_normal = 1,
		stand_start = 1,
		stand_end = 1,
		walk_start = 1,
		walk_end = 1,
	},

	do_custom = function(self, dtime)

		self.egg_timer = (self.egg_timer or 120) + dtime
		if self.egg_timer < 120 then
			return
		end
		self.egg_timer = 120

		if self.child
		or math.random(1, 100) > 1 then
			return
		end

		local pos = self.object:get_pos()

		mob = minetest.add_entity(pos, "paleotest:spinosaurus")
                ent2 = mob:get_luaentity()
		self.object:remove()

		mob:set_properties({
			textures = ent2.child_texture[1],
			visual_size = {
				x = ent2.base_size.x / 5,
				y = ent2.base_size.y / 5
			},
			collisionbox = {
				ent2.base_colbox[1] / 5,
				ent2.base_colbox[2] / 5,
				ent2.base_colbox[3] / 5,
				ent2.base_colbox[4] / 5,
				ent2.base_colbox[5] / 5,
				ent2.base_colbox[6] / 5
			},
		})

		ent2.child = true
		ent2.tamed = false
	end
})


mobs:register_egg("paleotest:Spinosaurus_egg", S("Spinosaurus Egg"), "paleotest_egg3_inv.png", 0)
