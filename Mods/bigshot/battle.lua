local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

local battle = {}

mcl_mobs.register_mob("bigshot:minispamton", {
    type = "monster",
    visual = "mesh",
    mesh = "bigshot_block_spamton.obj",
    textures = { "bigshot_entity_minispamton.png" },
    texture_mods = "",
    collisionbox = { -0.2, -0.5, -0.2, 0.2, 0.2, 0.2 },
    fear_height = 4,
    hp_min = 100,
    hp_max = 100,
    breath_max = -1,
    armor = { undead = 100, fleshy = 100 },
    pathfinding = 1,
    group_attack = true,
    visual_size = { x = 0.9, y = 0.9 },
    makes_footstep_sound = true,
    sounds = {
        random = "spamton-laugh-noise",
        death = "spamton-laugh-noise",
        damage = "spamton-laugh-noise",
        distance = 16,
    },
    damage = 7,
    reach = 2,
    attack_type = "dogfight",
    view_range = 16
})
mcl_mobs:non_spawn_specific("bigshot:minispamton", "overworld", 0, 7)

local function spawn_minispamtons(pn)
    minetest.sound_play({ name = "spamton-laugh-noise" })
    local player = minetest.get_player_by_name(pn)
    for _ = 0, 10, 1 do
        local pos = player:get_pos()
        pos.x = pos.x + 10
        pos.z = pos.z + 10
        minetest.add_entity(pos, "bigshot:minispamton")
    end
end

local function lightning_strikes(pn)
    local player = minetest.get_player_by_name(pn)

    local idx = 0
    local i = 0
    local texts = {"NOW'S YOUR CHANCE",
                   "TO BE A", "[[Big Shot]]"}
    local texts_index = 1
    local function loop()
        if i >= 6 then
            player:hud_remove(idx)
            return
        end

        player:hud_remove(idx)
        idx = player:hud_add({
             hud_elem_type = "text",
             position      = {x = 0.5, y = 0.5},
             offset        = {x = 0,   y = 0},
             text          = texts[texts_index],
             alignment     = {x = 0, y = 0},
             scale         = {x = 1, y = 1},
             number        = 0xFFFFFF,
        })
        texts_index = texts_index + 1
        if texts_index > #texts then
            texts_index = 1
        end
        lightning.strike(player:get_pos())

        i = i + 1
        minetest.after(1, loop)
    end
    loop()
end

local function transfer_kromer(pn)
    local player = minetest.get_player_by_name(pn)

    local inv = player:get_inventory()
    local chosen_item = nil
    local taken = nil
    if not inv:is_empty("main") then
        repeat
            chosen_item = inv:get_stack("main", math.random(inv:get_size("main")))
            taken = inv:remove_item("main", chosen_item)
        until not taken:is_empty()
    end

    local idx = player:hud_add({
         hud_elem_type = "text",
         position      = {x = 0.5, y = 0.5},
         offset        = {x = 0,   y = 0},
         text          = S("TRANSFERING [[Kromer]]"),
         alignment     = {x = 0, y = 0},
         scale         = {x = 1, y = 1},
         number        = 0xFFFFFF,
    })

    minetest.after(18, function()
        player:hud_remove(idx)
        if taken == nil or chosen_item == nil then
            minetest.chat_send_player(pn, "NO [[Kromer]] TRANSFERED :(")
        else
            minetest.chat_send_player(pn, S("REMOVED @1 `@2`s FROM YOUR INVENTORY LMAO",
                                            taken:get_count(), chosen_item:get_name()))
        end
    end)
end

function battle.start_battle(pn)
    local functions = {transfer_kromer, spawn_minispamtons, lightning_strikes}
    local functions_index = 1

    local handle = minetest.sound_play({
        name = "now-s-your-chance-to-be-a"
    }, { loop = true })

    local i = 0
    local function loop()
        if i >= 10 then
            minetest.sound_stop(handle)
            return
        end

        (functions[functions_index])(pn)
        functions_index = functions_index + 1
        if functions_index > #functions then
            functions_index = 1
        end

        i = i + 1
        minetest.after(20, loop)
    end
    loop()
end

return battle