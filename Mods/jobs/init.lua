local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

local JobTypes = {
    NONE = 0,
    ONLINE_MARKETEER = 1,
}

local function job_type_human(jobtype)
    if jobtype == JobTypes.NONE or jobtype == nil then
        return "None :("
    end

    for k, v in pairs(JobTypes) do
        if jobtype == v then
            return k
        end
    end
end

local jobinfo_hud_id = nil
local currentjob_hud_id = nil

local function update_hud(player)
    local meta = player:get_meta()

    local offset = -100
    local padding = 20

    offset = offset + padding
    if jobinfo_hud_id == nil then
        jobinfo_hud_id = player:hud_add({
            hud_elem_type = "text",
            position      = { x = 1, y = 0.5 },
            offset        = { x = -135, y = offset },
            text          = S("Job Info"),
            alignment     = 0,
            scale         = { x = 100, y = 30 },
            number        = 0xFFFFFF,
        })
    end

    offset = offset + padding
    local currentjob_text = S("Current job: @1", job_type_human(meta:get_int("jobs_job")))
    if currentjob_hud_id == nil then
        currentjob_hud_id = player:hud_add({
            hud_elem_type = "text",
            position      = { x = 1, y = 0.5 },
            offset        = { x = -135, y = offset },
            text          = S("Current job: @1", job_type_human(meta:get_int("jobs_job"))),
            alignment     = -1,
            scale         = { x = 100, y = 30 },
            number        = 0xFFFFFF,
        })
    else
        player:hud_change(currentjob_hud_id, "text", currentjob_text)
    end
end

minetest.register_on_joinplayer(function(player, _)
    update_hud(player)
end)

minetest.register_chatcommand("get_job", {
    params = "",
    description = S("Get your current job"),
    func = function(name, _)
        local player = minetest.get_player_by_name(name)
        minetest.chat_send_player(name,
            S("Your current job is: @1", job_type_human(player:get_meta():get_int("jobs_job"))))
    end
})

minetest.register_chatcommand("clear_job", {
    params = "",
    description = S("Clear your current job"),
    func = function(name, _)
        local player = minetest.get_player_by_name(name)
        local player_meta = player:get_meta()
        player_meta:set_int("jobs_job", JobTypes.NONE)
        minetest.chat_send_player(name,
            S("Your current job is: @1", job_type_human(player_meta:get_int("jobs_job"))))
        update_hud(player)
    end
})

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
        update_hud(clicker)
    end
})
