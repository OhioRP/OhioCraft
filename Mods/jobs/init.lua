local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

local JobTypes = {
    ONLINE_MARKETEER = 0,
}

local function job_type_human(jobtype)
    for k, v in pairs(JobTypes) do
        if jobtype == v then
            return k
        end
    end
end

minetest.register_node("jobs:laptop", {
    description = S("Laptop"),
    drawtype = "mesh",
    mesh = "jobs_block_laptop.obj",
    tiles = { "jobs_block_laptop.png" },
    _mcl_hardness = 0.3,
    paramtype2 = "facedir",
    on_rightclick = function(_, _, clicker, _, _)
        clicker:get_meta():set_int("jobs_job", JobTypes.ONLINE_MARKETEER)
        minetest.chat_send_player(clicker:get_player_name(),
            minetest.colorize("#00FF00",
                S("You now have the \"@1\" job!", job_type_human(clicker:get_meta():get_int("jobs_job")))))
    end
})

minetest.register_chatcommand("get_job", {
    params = "",
    description = S("Get your current job"),
    func = function(name, _)
        local player = minetest.get_player_by_name(name)
        minetest.chat_send_player(name,
            S("Your current job is: @1", job_type_human(player:get_meta():get_int("jobs_job"))))
    end
})
