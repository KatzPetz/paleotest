cores={"Brachiosaurus","Tyrannosaurus","Triceratops","Stegosaurus","Dilophosaurus","Velociraptor","Mosasaurus","Elasmosaurus","Dunkleosteus"}


-- Fossil Definition
for n,cor in ipairs(cores) do
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "paleotest:desert_"..cor.."_fossil_block",
		wherein        = "default:desert_stone",
		clust_scarcity = 20 * 20 * 20,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min           = -28,
		y_max           = 28,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "paleotest:"..cor.."_fossil_block",
		wherein        = "default:stone",
		clust_scarcity = 20 * 20 * 30,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -28000,
		y_max           = 0,
	})
--Fossils

minetest.register_node("paleotest:desert_"..cor.."_fossil_block", {
	description = "Desert"..cor.."Fossil Block",
	tiles = {"default_desert_stone.png^paleotest_fossil_desert_overlay.png"},
	groups = {cracky = 2, not_in_creative_inventory=1},
	drop = 'paleotest:'..cor..'_fossil',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("paleotest:"..cor.."_fossil_block", {
	description = ""..cor.." Fossil Block",
	tiles = {"default_stone.png^paleotest_fossil_overlay.png"},
	groups = {cracky = 2, not_in_creative_inventory=1},
	drop = 'paleotest:'..cor..'_fossil',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("paleotest:fossil_block", {
	description = "Fossil Block",
	tiles = {"default_stone.png^paleotest_fossil_overlay.png"},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

-- ABM

minetest.register_abm({
	nodenames = {"paleotest:fossil_block"},
	interval = 0.1,
	chance = 100,
	action = function(pos)
		pos.y=pos.y+0
		minetest.add_node(pos, {name="paleotest:Brachiosaurus_fossil_block"})
	end,
})

minetest.register_abm({
	nodenames = {"paleotest:fossil_block"},
	interval = 0.1,
	chance = 100,
	action = function(pos)
		pos.y=pos.y+0
		minetest.add_node(pos, {name="paleotest:Dilophosaurus_fossil_block"})
	end,
})

minetest.register_abm({
	nodenames = {"paleotest:fossil_block"},
	interval = 0.1,
	chance = 100,
	action = function(pos)
		pos.y=pos.y+0
		minetest.add_node(pos, {name="paleotest:Stegosaurus_fossil_block"})
	end,
})

minetest.register_abm({
	nodenames = {"paleotest:fossil_block"},
	interval = 0.1,
	chance = 100,
	action = function(pos)
		pos.y=pos.y+0
		minetest.add_node(pos, {name="paleotest:Triceratops_fossil_block"})
	end,
})

minetest.register_abm({
	nodenames = {"paleotest:fossil_block"},
	interval = 0.1,
	chance = 100,
	action = function(pos)
		pos.y=pos.y+0
		minetest.add_node(pos, {name="paleotest:Tyrannosaurus_fossil_block"})
	end,
})

minetest.register_abm({
	nodenames = {"paleotest:fossil_block"},
	interval = 0.1,
	chance = 100,
	action = function(pos)
		pos.y=pos.y+0
		minetest.add_node(pos, {name="paleotest:Velociraptor_fossil_block"})
	end,
})

-- DNA
minetest.register_craftitem("paleotest:"..cor.."_dna", {
	description = (""..cor.." DNA"),
	inventory_image = "paleotest_dna.png",
        stack_size = 1,
	groups = {not_in_creative_inventory = 1},
})

-- Fossil
minetest.register_craftitem("paleotest:"..cor.."_fossil", {
	description = (""..cor.." Fossil"),
	inventory_image = "paleotest_fossil.png",
        stack_size = 1,
	groups = {not_in_creative_inventory = 1},
})

end
