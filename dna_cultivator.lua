cores={"Brachiosaurus","Tyrannosaurus","Triceratops","Stegosaurus","Dilophosaurus","Velociraptor","Pteranodon","Sarcosuchus"}
cores2={"Mammoth","Elasmotherium","Smilodon","Direwolf","Procoptodon","Thylacoleo","Mosasaurus","Elasmosaurus","Dunkleosteus"}
cores3={"Horsetails","Cycad"}
local dna_cultivator_fs = "size[8,7]"
    .."image[3.25,1.75;1.7,.5;paleotest_progress_bar.png^[transformR270]"
    .."list[current_player;main;0,3;8,4;]"
    .."list[context;input;2,1.5;1,1;]"
    .."list[context;output;5,1.5;1,1;]"
    .."label[3,0.5;DNA Cultivator]"
    .."label[2.0,1;DNA]"
    .."label[5.1,1;Egg]"

local function get_active_dna_cultivator_fs(item_percent)
    return "size[8,7]"
	    .."image[3.25,1.75;1.7,.5;paleotest_progress_bar.png^[lowpart:"
	    ..(item_percent)..":paleotest_progress_bar_full.png^[transformR270]"
        .."list[current_player;main;0,3;8,4;]"
        .."list[context;input;2,1.5;1,1;]"
        .."list[context;output;5,1.5;1,1;]"
        .."label[3,0.5;DNA Cultivator]"
        .."label[2.0,1;DNA]"
        .."label[5.1,1;Egg]"
end

paleotest.dna_cultivator = {}
local dna_cultivator = paleotest.dna_cultivator
dna_cultivator.recipes = {}
function dna_cultivator.register_recipe(input, output) dna_cultivator.recipes[input] = output end

local function update_formspec(progress, goal, meta)
    local formspec

    if progress > 0 and progress <= goal then
        local item_percent = math.floor(progress / goal * 100)
        formspec = get_active_dna_cultivator_fs(item_percent)
    else
        formspec = dna_cultivator_fs
    end

    meta:set_string("formspec", formspec)
end

local function recalculate(pos)
	local meta, timer = minetest.get_meta(pos), minetest.get_node_timer(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack("input", 1)

	local k = dna_cultivator.recipes[stack:get_name()]
	if not k then return end

	timer:stop()
    update_formspec(0, 3, meta)
    timer:start(1)
end

local function do_cook_single(pos)
    local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local dna = inv:get_stack("input", 1)
    dna:set_count(1)

    if not dna_cultivator.recipes[dna:get_name()] then
        minetest.chat_send_all("dna_cultivator cooked nothing because there was nothing to cook.")
        minetest.get_node_timer(pos):stop()
        update_formspec(0, 3, meta)
    else
        inv:remove_item("input", dna)
	    local dinosaur_egg = dna_cultivator.recipes[dna:get_name()]
	    inv:add_item("output", dinosaur_egg)
    end
end

minetest.register_node("paleotest:dna_cultivator", {
	description = "DNA Cultivator",
	tiles = {
		"default_steel_block.png",
		"paleotest_dna_cultivator_bottom.png",
		"paleotest_dna_cultivator_side.png",
		"paleotest_dna_cultivator_side.png",
		"paleotest_dna_cultivator_side.png",
		"paleotest_dna_cultivator_side.png"
	},
	paramtype2 = "facedir",
	groups = {cracky = 2, tubedevice = 1, tubedevice_receiver = 1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	drawtype = "node",
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("input") and inv:is_empty("output")
	end,

	on_timer = function(pos, elapsed)
        local meta = minetest.get_meta(pos)
        local stack = meta:get_inventory():get_stack("input", 1)
        local cooking_time = meta:get_int("cooking_time") or 0
        cooking_time = cooking_time + 1
        
        if cooking_time % 100 == 0 then
            do_cook_single(pos)
        end

        update_formspec(cooking_time % 100, 100, meta)
        meta:set_int("cooking_time", cooking_time)

        if not stack:is_empty() then
            return true
        else
            meta:set_int("cooking_time", 0)
            update_formspec(0, 3, meta)
            return false
        end
	end,

	on_metadata_inventory_put = recalculate,
    on_metadata_inventory_take = recalculate,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", dna_cultivator_fs)
		local inv = meta:get_inventory()
		inv:set_size("input", 1)
        inv:set_size("output", 1)
	end,
	
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "input", drops)
        default.get_inventory_drops(pos, "output", drops)
		table.insert(drops, "paleotest:dna_cultivator")
		minetest.remove_node(pos)
		return drops
	end,

	allow_metadata_inventory_put = function(pos, list, index, stack, player)
		return dna_cultivator.recipes[stack:get_name()] and stack:get_count() or 0
	end,
})


minetest.register_craft({
	output = "paleotest:dna_cultivator",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:glass", "bucket:bucket_water", "default:glass"},
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"}
	}
})

-- Recipe Registration
for n,cor in ipairs(cores3) do
dna_cultivator.register_recipe("paleotest:"..cor.."_dna", "paleotest:"..cor.."")
end
for n,cor in ipairs(cores2) do
dna_cultivator.register_recipe("paleotest:"..cor.."_dna", "paleotest:"..cor.."_baby")
end
for n,cor in ipairs(cores) do
dna_cultivator.register_recipe("paleotest:"..cor.."_dna", "paleotest:"..cor.."_egg")
end
