local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

local spamton_dialog = dofile(modpath .. "/spamton_dialog.lua")
local battle = dofile(modpath .. "/battle.lua")

local in_battle = false

local function register_spamton_variation(node, d)
    local def = {
        drawtype = "mesh",
        mesh = "bigshot_block_spamton.obj",
        tiles = { "bigshot_block_spamton.png" },
        groups = { creative_breakable = 1, not_in_creative_inventory = 1 }
    }
    for k, v in pairs(d) do def[k] = v end

    minetest.register_node(node, def)
end

register_spamton_variation("bigshot:spamton_creepy", {
    description = S("Spamton Creepy"),
    tiles = { "bigshot_block_spamton_creepy.png" }
})

register_spamton_variation("bigshot:spamton", {
    description = S("Spamton"),
    on_rightclick = function(_, _, clicker, _, _)
        if not in_battle then
            in_battle = true
            spamton_dialog.show(clicker:get_player_name(), "spamton", function()
                minetest.sound_play({ name = "spamton-laugh-noise" })
                minetest.handle_async(function() -- Wait until the laugh stops
                    local t0 = os.clock()
                    while os.clock() - t0 <= 2.5 do end
                end, function() -- Start the battle
                    battle.start_battle(clicker:get_player_name())
                    in_battle = false
                end)
            end)
        end
    end
})
