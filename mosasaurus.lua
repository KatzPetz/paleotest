
local S = mobs.intllib

-- Mosasaurus by ElCeejo

mobs:register_mob("paleotest:mosasaurus", {
	type = "monster",
	hp_min = 114,
	hp_max = 114,
	armor = 90,
	passive = false,
	walk_velocity = 1.0,
	run_velocity = 3,
        walk_chance = 100,
        jump = false,
        jump_height = 1.1,
        stepheight = 1.1,
        fly = true,
        fly_in = "default:water_source",
        runaway = false,
        pushable = false,
        view_range = 15,
        knock_back = 0,
        damage = 38,
	fear_height = 0,
	fall_speed = -8,
	fall_damage = 0,
	water_damage = 0,
	lava_damage = 3,
	light_damage = 0,
        suffocation = false,
        floats = 0,
        reach = 3,
        attack_chance = 30,
        attack_animals = true,
        attack_npcs = true,
        attack_players = true,
        owner_loyal = false,
        group_attack = false,
	attack_type = "dogfight",
	pathfinding = 1,
	makes_footstep_sound = true,
	sounds = {
		random = "paleotest_mosasaurus",
	},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 3, max = 5},
	},
	visual = "mesh",
	visual_size = {x=25, y=25},
	collisionbox = {-1.5, -1.5, -1.5, 1.5, 1.5, 1.5},
	textures = {
		{"paleotest_mosasaurus1.png"},
		{"paleotest_mosasaurus2.png"},
	},
	child_texture = {
		{"paleotest_mosasaurus1.png"},
	},
	mesh = "paleotest_mosasaurus.b3d",
	animation = {
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 1,
		stand_end = 40,
		walk_start = 1,
		walk_end = 40,
		punch_start = 50,
		punch_end = 65,
		punch_loop = false,
	},

	do_custom = function(self, dtime)

	if self.child == true then

	self.type = "animal"
	self.passive = true
        self.attack_animals = false
	self.walk_velocity = 0.7
	self.run_velocity = 0.7
			return
		end
	end,
})

local wild_spawn = minetest.settings:get_bool("wild_spawning")

if wild_spawn then

mobs:spawn({
	name = "paleotest:mosasaurus",
	nodes = "default:water_source",
	min_light = 14,
	interval = 60,
	chance = 8000, -- 15000
	min_height = 0,
	max_height = 200,
	day_toggle = true,
})

end

mobs:register_egg("paleotest:mosasaurus", S("Mosasaurus"), "default_water.png", 1)

-- Mosasaurus Baby by ElCeejo

minetest.register_craftitem("paleotest:Mosasaurus_baby", {
	description = "Mosasaurus Embryonic Sac",
	inventory_image = "paleotest_embryo.png",
	wield_image = "paleotest_embryo.png",
	stack_max = 1,
	on_place = function(itemstack, placer, pointed_thing)
		local pos1=minetest.get_pointed_thing_position(pointed_thing, true)
		pos1.y=pos1.y+1.5
		core.after(0.1, function()
		mob = minetest.add_entity(pos1, "paleotest:mosasaurus")
                ent2 = mob:get_luaentity()

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
		end)
		itemstack:take_item()
		return itemstack
	end,
})
