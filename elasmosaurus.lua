
local S = mobs.intllib

-- Beached and Swimming animations

local	animation_beached = {
		speed_normal = 125,
		speed_sprint = 125,
		stand_start = 125,
		stand_end = 125,
		walk_start = 125,
		walk_end = 125,
}

local	animation_swimming = {
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 1,
		stand_end = 120,
		walk_start = 1,
		walk_end = 40,
}

-- Elasmosaurus by ElCeejo

mobs:register_mob("paleotest:elasmosaurus", {
	type = "animal",
	hp_min = 23,
	hp_max = 23,
	armor = 120,
	passive = true,
	walk_velocity = 1.5,
	run_velocity = 3.5,
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
        damage = 4,
	fear_height = 0,
	fall_speed = -8,
	fall_damage = 0,
	water_damage = 0,
	lava_damage = 3,
	light_damage = 0,
        suffocation = false,
        floats = 0,
        reach = 3,
        attack_chance = 0,
        attack_animals = false,
        attack_npcs = false,
        attack_players = false,
        owner_loyal = false,
        group_attack = false,
	attack_type = "dogfight",
	pathfinding = 1,		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 1,
		stand_end = 120,
		walk_start = 1,
		walk_end = 40,
	makes_footstep_sound = true,
	sounds = {
		random = "paleotest_elasmosaurus",
	},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 3, max = 5},
	},
	visual = "mesh",
	visual_size = {x=15, y=15},
	collisionbox = {-0.85, -0.85, -0.85, 0.85, 0.85, 0.85},
	textures = {
		{"paleotest_elasmosaurus1.png"},
		{"paleotest_elasmosaurus2.png"},
	},
	child_texture = {
		{"paleotest_elasmosaurus1.png"},
	},
	mesh = "paleotest_elasmosaurus.b3d",
	animation = {
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 1,
		stand_end = 120,
		walk_start = 1,
		walk_end = 40,
	},

	do_custom = function(self, dtime)

-- Aquatic Mobs get beached

	if not self:attempt_flight_correction() then

        self.fly = false
        self.view_range = 0
        self.walk_chance = 0
        self.animation = animation_beached
        self.pushable = true
                        return
		end

	if self:attempt_flight_correction() then

        self.fly = true
        self.view_range = 15
        self.walk_chance = 100
        self.animation = animation_swimming
        self.pushable = false
                        return
		end

-- Baby mobs are passive

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
	name = "paleotest:elasmosaurus",
	nodes = "default:water_source",
	min_light = 14,
	interval = 60,
	chance = 8000, -- 15000
	min_height = 0,
	max_height = 200,
	day_toggle = true,
})

end

mobs:register_egg("paleotest:elasmosaurus", S("Elasmosaurus"), "default_water.png", 1)

-- Elasmosaurus Baby by ElCeejo

minetest.register_craftitem("paleotest:Elasmosaurus_baby", {
	description = "Elasmosaurus Hatchling",
	inventory_image = "mobs_chicken_egg.png",
	wield_image = "mobs_chicken_egg.png",
	stack_max = 1,
	on_place = function(itemstack, placer, pointed_thing)
		local pos1=minetest.get_pointed_thing_position(pointed_thing, true)
		pos1.y=pos1.y+1.5
		core.after(0.1, function()
		mob = minetest.add_entity(pos1, "paleotest:elasmosaurus")
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
