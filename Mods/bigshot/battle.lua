local battle = {}

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
