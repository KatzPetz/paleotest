paleotest = {}

local path = minetest.get_modpath("paleotest")

-- PaleoTest Blocks
dofile(path .. "/fossil_analyzer.lua")
dofile(path .. "/dna_cultivator.lua")
dofile(path .. "/fossils.lua")
dofile(path .. "/permafrost.lua")
dofile(path .. "/bones.lua")

-- PaleoTest Items

-- PaleoTest Dinosaurs
dofile(path .. "/spinosaurus.lua")
dofile(path .. "/stegosaurus.lua")
dofile(path .. "/brachiosaurus.lua")
dofile(path .. "/triceratops.lua")
dofile(path .. "/tyrannosaurus.lua")
dofile(path .. "/velociraptor.lua")

-- PaleoTest Megafauna
dofile(path .. "/mammoth.lua")
dofile(path .. "/elasmotherium.lua")
dofile(path .. "/procoptodon.lua")
dofile(path .. "/smilodon.lua")
dofile(path .. "/thylacoleo.lua")
dofile(path .. "/dire_wolf.lua")

-- PaleoTest Aquatic Animals
dofile(path .. "/mosasaurus.lua")


minetest.log("action", "[MOD] PaleoTest loaded")