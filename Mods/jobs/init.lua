local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

minetest.register_craftitem("jobs:money", {
    description = S("Money"),
    inventory_image = "jobs_item_money.png",
    stack_max = 64
})

minetest.register_node("jobs:money_giver", {
    description = S("Money Giver"),
    tiles = { "jobs_block_moneygiver.png" },
    groups = { creative_breakable = 1 },
    mesecons = {
        effector = {
            action_on = function(pos, _)
                minetest.add_item(pos, "jobs:money")
            end,
        }
    },
    stack_max = 64
})
