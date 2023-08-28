S = minetest.get_translator(minetest.get_current_modname())

minetest.register_node("extras:cool", {
    on_rightclick = function(_, _, clicker, _, _)
        if clicker:is_player() then
            minetest.chat_send_player(clicker:get_player_name(), S("Did you know you've just clicked a very cool block?"))
        end
    end,
    description = S("Cool XD"),
    tiles = {
        "extras_block_cool_upndown.png",
        "extras_block_cool_upndown.png",
        "extras_block_cool_sides.png",
        "extras_block_cool_sides.png",
        "extras_block_cool_sides.png",
        "extras_block_cool_sides.png"
    },
    sounds = {
        dug = { name = "extras_block_cool_dug", gain = 4 },
        dig = { name = "extras_block_cool_dig", gain = 0.1 }
    },
    groups = { oddly_breakable_by_hand = 3 }
})

minetest.register_craft({
    type = "shaped",
    output = "portcraft:cool 1",
    recipe = {
        { "default:stick", "default:stick", "default:stick" },
        { "default:stick", "wool:white",    "default:stick" },
        { "default:stick", "default:stick", "default:stick" }
    }
})
