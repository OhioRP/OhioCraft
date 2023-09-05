S = minetest.get_translator(minetest.get_current_modname())

function invisibilty_set(player, enabled)
    if enabled then
        local effect_func = minetest.registered_chatcommands.effect.func
        effect_func(player, "invisibility 999999 100")
        minetest.get_player_by_name(player):set_nametag_attributes({ text = "‎ " })
    else
        mcl_potions._reset_player_effects(minetest.get_player_by_name(player))
        minetest.get_player_by_name(player):set_nametag_attributes({ text = player })
    end
end

function disable_spectator_player(name)
    local privs = minetest.get_player_privs(name)
    privs.interact = true
    privs.dig = true
    privs.place = true
    minetest.set_player_privs(name, privs)

    invisibilty_set(name, false)
end

function enable_spectator_player(name)
    local privs = minetest.get_player_privs(name)
    privs.interact = nil
    privs.dig = nil
    privs.place = nil
    minetest.set_player_privs(name, privs)

    invisibilty_set(name, true)
end

minetest.register_on_joinplayer(function(player, prev)
    if prev == nil then
        player:get_meta():set_int("canonlives", 3)
    end

    if player:get_meta():get_int("canondead") == 1 then
        player:set_hp(20, { type = "set_hp" })
        enable_spectator_player(player:get_player_name())
    end

    local msg = S(
        "@1 Everytime you get killed by a player, you @2. If you loose all of your canon lives, you enter an \"Spectator mode\" you cannot get out of, which effectively kicks you out of the roleplay. You can check your amount of canon lives with /getcanonlives",
        minetest.colorize("#FFFF00", S("[WARNING]")),
        minetest.colorize("#FF0000", S("loose one of your canon lives")))
    minetest.chat_send_player(player:get_player_name(), msg)
end)

minetest.register_on_dieplayer(function(player, reason)
    local player_meta = player:get_meta()
    if reason.type == "punch" then
        local puncher = reason.object
        if puncher ~= nil then
            if puncher:is_player() then
                player_meta:set_int("canonlives", player_meta:get_int("canonlives") - 1)
            end
        end
    end
end)

minetest.register_on_respawnplayer(function(player)
    local player_meta = player:get_meta()
    local msg = S(
        "@1 Everytime get killed by a player, you @2. Please check your amount of canon lives with /getcanonlives",
        minetest.colorize("#FFFF00", S("[WARNING]")),
        minetest.colorize("#FF0000", S("loose one of your canon lives")))
    minetest.chat_send_player(player:get_player_name(), msg)
    minetest.chat_send_player(player:get_player_name(), msg)
    minetest.chat_send_player(player:get_player_name(), msg)

    if player_meta:get_int("canonlives") <= 0 then
        player_meta:set_int("canonlives", 0)
        player_meta:set_int("canondead", 1)

        player:set_hp(20, { type = "set_hp" })
        enable_spectator_player(player:get_player_name())

        minetest.chat_send_player(player:get_player_name(),
            minetest.colorize("#FF0000", S("[WARNING] You permanently died! Only an administrator can revive you now")))
    end
end)

-- Removing interaction capabilities from the player

minetest.register_on_player_hpchange(function(player, hp_change, _)
    if player:get_meta():get_int("canondead") == 1 then
        return 0
    end
    return hp_change
end, true)

-- Commands for interacting with canon lives

minetest.register_chatcommand("getcanonlives", {
    description = S("Get your amount of canon lives"),
    params = "",
    func = function(pn, _)
        local player_lives = tostring(minetest.get_player_by_name(pn):get_meta():get_int("canonlives"))
        minetest.chat_send_player(pn, S("You currently have @1 canon lives", player_lives))
    end
})

minetest.register_chatcommand("revive", {
    description = S("Revive a dead player (player that lost all of its canon lives)"),
    params = "<playername>",
    privs = { server = true },
    func = function(commander, params)
        local player = minetest.get_player_by_name(params)
        if player == nil then
            minetest.chat_send_player(commander, "Invalid player name")
            return
        end

        disable_spectator_player(player:get_player_name())
        player:get_meta():set_int("canonlives", 3)
        player:get_meta():set_int("canondead", 0)

        minetest.chat_send_player(player:get_player_name(),
            minetest.colorize("#00FF00", S("[WARNING] Congratulations! An administrator just revived you!")))
    end
})
