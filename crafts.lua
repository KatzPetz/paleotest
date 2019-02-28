cores={"Brachiosaurus","Tyrannosaurus","Triceratops","Stegosaurus","Dilophosaurus","Velociraptor",}

-- DNA
for n,cor in ipairs(cores) do
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
