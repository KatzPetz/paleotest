cores={"Procoptodon","Thylacoleo"}
for n,cor in ipairs(cores) do

minetest.override_item("default:desert_sandstone", {

	drop = {
		max_items = 1,
		items = {
			{
				items = {'paleotest:Procoptodon_bone'},
				rarity = 10,
			},
			{
				items = {'paleotest:Thylacoleo_bone'},
				rarity = 10,
			},
			{
				items = {'default:desert_sandstone'},
			}
		}
	},
})

-- Bones

minetest.register_craftitem("paleotest:"..cor.."_bone", {
	description = (""..cor.." Bone"),
	inventory_image = "paleotest_bone.png",
        stack_size = 1,
	groups = {not_in_creative_inventory = 1},
})

end
