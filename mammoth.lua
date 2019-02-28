
local S = mobs.intllib

-- Mammoth by ElCeejo

mobs:register_mob("paleotest:mammoth", {
	type = "animal",
	hp_min = 54,
	hp_max = 54,
	armor = 115,
	passive = false,
	walk_velocity = 0.8,
	run_velocity = 3,
        walk_chance = 10,
        jump = true,
        jump_height = 1.0,
        stepheight = 1.1,
        runaway = false,
        pushable = false,
        view_range = 5,
        knock_back = 0,
        damage = 13,
	fear_height = 6,
	fall_speed = -8,
	fall_damage = 20,
	water_damage = 0,
	lava_damage = 3,
	light_damage = 0,
        suffocation = false,
        floats = 1,
	follow = {"default:leaves"},
        reach = 10,
        owner_loyal = true,
	attack_type = "dogfight",
	pathfinding = 0,
	makes_footstep_sound = true,
	sounds = {
		random = "paleotest_mammoth",
	},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 6, max = 9},
	},
	visual = "mesh",
	visual_size = {x=18, y=18},
	collisionbox = {-1.2, -1.7, -1.2, 1.2, 0.8, 1.2},
	textures = {
		{"paleotest_mammoth1.png"},
		{"paleotest_mammoth2.png"},
	},
	child_texture = {
		{"paleotest_mammoth3.png"},
	},
	mesh = "paleotest_mammoth.b3d",
	animation = {
		speed_normal = 10,
		speed_sprint = 30,
		stand_start = 50,
		stand_end = 150,
		walk_start = 1,
		walk_end = 40,
		punch_start = 160,
		punch_end = 200,
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
})

local wild_spawn = minetest.settings:get_bool("wild_spawning")

if wild_spawn then

mobs:spawn({
	name = "paleotest:mammoth",
	nodes = "default:snowblock",
	min_light = 14,
	interval = 60,
	chance = 8000, -- 15000
	min_height = 0,
	max_height = 200,
	day_toggle = true,
})

end

mobs:register_egg("paleotest:mammoth", S("Mammoth"), "default_dirt.png", 1)

minetest.register_craftitem("paleotest:Mammoth_baby", {
	description = "Mammoth Calf",
	inventory_image = "mobs_chicken_egg.png",
	wield_image = "mobs_chicken_egg.png",
	stack_max = 1,
	on_place = function(itemstack, placer, pointed_thing)
		local pos1=minetest.get_pointed_thing_position(pointed_thing, true)
		pos1.y=pos1.y+1.5
		core.after(0.1, function()
		mob = minetest.add_entity(pos1, "paleotest:mammoth")
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
