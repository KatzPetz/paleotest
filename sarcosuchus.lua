
local S = mobs.intllib

local select_animation_set = function(animation_type)
	if animation_type == "water" then
		return {
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 50,
		stand_end = 120,
		walk_start = 150,
		walk_end = 170,
		punch_start = 130,
		punch_end = 145,
		punch_loop = false,
		}
	elseif animation_type == "land" then
		return {
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 50,
		stand_end = 120,
		walk_start = 1,
		walk_end = 40,
		punch_start = 130,
		punch_end = 145,
		punch_loop = false,
		}
	end
end

-- Sarcosuchus by ElCeejo

mobs:register_mob("paleotest:sarcosuchus", {
	type = "monster",
	hp_min = 86,
	hp_max = 86,
	armor = 80,
	passive = false,
	walk_velocity = 1.0,
	run_velocity = 1.4,
        walk_chance = 5,
        jump = false,
        jump_height = 1.1,
        stepheight = 1.1,
        runaway = false,
        pushable = false,
        view_range = 4,
        knock_back = 0,
        damage = 13,
	fear_height = 6,
	fall_speed = -8,
	fall_damage = 15,
	water_damage = 0,
	lava_damage = 3,
	light_damage = 0,
        suffocation = false,
        floats = 1,
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
	pathfinding = 0,
	makes_footstep_sound = true,
	sounds = {
		random = "paleotest_sarcosuchus",
	},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 3, max = 5},
	},
	visual = "mesh",
	visual_size = {x=18, y=18},
	collisionbox = {-0.8, -1.0, -0.8, 0.8, 0.7, 0.8},
	textures = {
		{"paleotest_sarcosuchus1.png"},
		{"paleotest_sarcosuchus2.png"},
	},
	child_texture = {
		{"paleotest_sarcosuchus3.png"},
	},
	mesh = "paleotest_sarcosuchus.b3d",
	animation = {
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 50,
		stand_end = 120,
		walk_start = 1,
		walk_end = 40,
		punch_start = 130,
		punch_end = 145,
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

-- Mob changes animation and can swim in water

	local nodef = minetest.registered_nodes[self.standing_in]

	if self.fly then

		local s = self.object:get_pos()

		if not self:attempt_flight_correction() then

			self.fly = false
                        self.floats = 0

			return
		end
	end

	if nodef.groups.water then

	self.animation = select_animation_set("water")
        self.view_range = 20
        self.walk_chance = 100
        self.fall_speed = -0.2
        self.fly = true
        self.fly_in = "default:water_source"
        floats = 0
                        return
		end

	if nodef.groups.water ~= false then

	self.animation = select_animation_set("land")
        self.view_range = 4
        self.walk_chance = 10
        self.fall_speed = -8
        self.fly = false
                        return
		end

-- Behaviour for young mobs

	if self.child == true then

	self.type = "animal"
	self.passive = true
        self.attack_animals = false
	self.walk_velocity = 0.3
	self.run_velocity = 0.3
			return
		end
	end,
})

local wild_spawn = minetest.settings:get_bool("wild_spawning")

if wild_spawn then

mobs:spawn({
	name = "paleotest:sarcosuchus",
	nodes = "default:river_water_source",
	min_light = 14,
	interval = 60,
	chance = 8000, -- 15000
	min_height = 0,
	max_height = 200,
	day_toggle = true,
})

end

mobs:register_egg("paleotest:sarcosuchus", S("Sarcosuchus"), "default_sand.png", 1)

-- Sarcosuchus Egg by ElCeejo

mobs:register_mob("paleotest:Sarcosuchus_egg", {
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

		mob = minetest.add_entity(pos, "paleotest:sarcosuchus")
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


mobs:register_egg("paleotest:Sarcosuchus_egg", S("Sarcosuchus Egg"), "paleotest_egg3_inv.png", 0)
