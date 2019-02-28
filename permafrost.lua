cores={"Mammoth","Elasmotherium","Smilodon","Direwolf"}
for n,cor in ipairs(cores) do

--Permafrost

local old_minetest = minetest.settings:get_bool("old_compatible")

if old_minetest then

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "paleotest:permafrost",
		wherein        = "default:snowblock",
		clust_scarcity = 24 * 24 * 24,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -28,
		y_max           = 156,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "paleotest:permafrost",
		wherein        = "default:dirt_with_snow",
		clust_scarcity = 24 * 24 * 24,
		clust_num_ores = 9,
		clust_size     = 4,
		y_min          = -28,
		y_max           = 156,
	})

minetest.register_node("paleotest:permafrost", {
	description = "Permafrost",
	tiles = {"default_permafrost.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_dirt_defaults(),
	drop = {
		max_items = 1,
		items = {
			{
				items = {'paleotest:Mammoth_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Elasmotherium_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Smilodon_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Direwolf_bone'},
				rarity = 10,
			},
			{
				items = {'default:clay'},
			}
		}
	},
})
end

local new_minetest = minetest.settings:get_bool("new_compatible")

if new_minetest then
minetest.override_item("default:permafrost", {

	drop = {
		max_items = 1,
		items = {
			{
				items = {'paleotest:Mammoth_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Elasmotherium_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Smilodon_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Direwolf_bone'},
				rarity = 10,
			},
			{
				items = {'default:clay'},
			}
		}
	},
})

minetest.override_item("default:permafrost_with_moss", {

	drop = {
		max_items = 1,
		items = {
			{
				items = {'paleotest:Mammoth_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Elasmotherium_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Smilodon_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Direwolf_bone'},
				rarity = 10,
			},
			{
				items = {'default:clay'},
			}
		}
	},
})

minetest.override_item("default:permafrost_with_stones", {

	drop = {
		max_items = 1,
		items = {
			{
				items = {'paleotest:Mammoth_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Elasmotherium_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Smilodon_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Direwolf_bone'},
				rarity = 10,
			},
			{
				items = {'default:clay'},
			}
		}
	},
})
end

-- DNA

minetest.register_craftitem("paleotest:"..cor.."_dna", {
	description = (""..cor.." DNA"),
	inventory_image = "paleotest_dna.png",
        stack_size = 1,
	groups = {not_in_creative_inventory = 1},
})

-- Bones

minetest.register_craftitem("paleotest:"..cor.."_bone", {
	description = (""..cor.." Bone"),
	inventory_image = "paleotest_bone.png",
        stack_size = 1,
	groups = {not_in_creative_inventory = 1},
})

end
