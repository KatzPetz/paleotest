-- Nodes

-- Electric Fence

default.register_fence_rail("paleotest:dinosaur_fence", {
	description = "Electrified Fence Wire",
	texture = "default_steel_block.png",
	inventory_image = "default_fence_rail_overlay.png^default_steel_block.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_rail_overlay.png^default_steel_block.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	material = "default:steelblock",
	connects_to = { "group:wall", "group:fence" },
	groups = {cracky = 1, level = 2},
	damage_per_second = 9,
	sounds = default.node_sound_metal_defaults()
})

walls.register("paleotest:steel", "Steel Wall", {"default_steel_block.png"},
		"default:steelblock", default.node_sound_metal_defaults())
