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
mcl_mobs:non_spawn_specific("mobs_mc:endermite", "overworld", 0, 7)

function battle.start_battle(pn)
    print(pn)

    local handle = minetest.sound_play({
        name = "now-s-your-chance-to-be-a"
    }, { loop = true })

    minetest.handle_async(function()
        local t0 = os.clock()
        while os.clock() - t0 <= 60 do end
    end, function()
        minetest.sound_stop(handle)
    end)
end

return battle
