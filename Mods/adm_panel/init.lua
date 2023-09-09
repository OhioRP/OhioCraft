local modname = minetest.get_current_modname()

local S = minetest.get_translator(modname)
local FS = minetest.formspec_escape

-- Kill Formspec --
local function get_kill_formspec()
    local texts = {
        label = S("Kill a player"),
        button_submit = S("Submit")
    }

    local formspec = {
        "formspec_version[6]",
        "size[5.25,2.75]",
        "label[0.3,0.5;", FS(texts["label"]), "]",
        "field[0.3,0.8;4.7,0.8;player;;]",
        "button_exit[0.3,1.7;4.7,0.8;submit;", FS(texts["button_submit"]), "]"
    }

    return table.concat(formspec, "")
end

local function handle_adm_kill_fields(player, fields)
    if fields.submit then
        local player_target = minetest.get_player_by_name(fields.player)
        if player_target ~= nil then
            player_target:set_hp(0, { type = "set_hp" })
        else
            minetest.chat_send_player(
                player:get_player_name(),
                minetest.colorize("#FF0000", S("Invalid player"))
            )
        end
    end
end
-- End Kill Formspec --

-- Gamemode Formspec --
local function get_gamemode_formspec()
    local texts = {
        label = S("Change gamemode of a player"),
        button_submit = S("Submit"),
        default_field_player = S("<player name>"),
        default_field_gamemode = S("<gamemode>")
    }

    local formspec = {
        "formspec_version[6]",
        "size[5.25,3.8]",
        "label[0.3,0.5;", FS(texts["label"]), "]",
        "field[0.3,0.8;4.7,0.8;player;;", FS(texts["default_field_player"]), "]",
        "field[0.3,1.7;4.7,0.8;gamemode;;", FS(texts["default_field_gamemode"]), "]",
        "button_exit[0.3,2.7;4.7,0.8;submit;", FS(texts["button_submit"]), "]"
    }

    return table.concat(formspec, "")
end

local function handle_adm_gamemode_fields(player, fields)
    if fields.submit then
        local player_target = minetest.get_player_by_name(fields.player)
        if player_target ~= nil then
            local gamemode = minetest.registered_chatcommands.gamemode.func
            local gamemodes = {
                survival = "",
                creative = ""
            }
            if gamemodes[fields.gamemode] == nil then
                minetest.chat_send_player(
                    player:get_player_name(),
                    minetest.colorize("#FF0000", S("Invalid gamemode"))
                )
                return
            end
            gamemode(player:get_player_name(), fields.gamemode .. " " .. fields.player)
        else
            minetest.chat_send_player(
                player:get_player_name(),
                minetest.colorize("#FF0000", S("Invalid player"))
            )
        end
    end
end
-- End Gamemode Formspec --

-- Give Formspec --
local function get_give_formspec()
    local texts = {
        label = S("Give an item to a player"),
        button_submit = S("Submit"),
        default_field_player = S("<player name>"),
        default_field_item = S("<item>")
    }

    local formspec = {
        "formspec_version[6]",
        "size[5.25,3.8]",
        "label[0.3,0.5;", FS(texts["label"]), "]",
        "field[0.3,0.8;4.7,0.8;player;;", FS(texts["default_field_player"]), "]",
        "field[0.3,1.7;4.7,0.8;item;;", FS(texts["default_field_item"]), "]",
        "button_exit[0.3,2.7;4.7,0.8;submit;", FS(texts["button_submit"]), "]"
    }

    return table.concat(formspec, "")
end

local function handle_adm_give_fields(player, fields)
    if fields.submit then
        local player_target = minetest.get_player_by_name(fields.player)
        if player_target ~= nil then
            if minetest.registered_items[fields.item] == nil then
                minetest.chat_send_player(
                    player:get_player_name(),
                    minetest.colorize("#FF0000", S("Invalid item"))
                )
                return
            end
            player_target:get_inventory():add_item("main", fields.item .. " 1")
        else
            minetest.chat_send_player(
                player:get_player_name(),
                minetest.colorize("#FF0000", S("Invalid player"))
            )
        end
    end
end
-- End Give Formspec --

-- Set Command Formspec --
local function get_set_formspec()
    local texts = {
        label = S("Run WorldEdit's //set"),
        button_submit = S("Submit")
    }

    local formspec = {
        "formspec_version[6]",
        "size[5.25,2.75]",
        "label[0.3,0.5;", FS(texts["label"]), "]",
        "field[0.3,0.8;4.7,0.8;block;;]",
        "button_exit[0.3,1.7;4.7,0.8;submit;", FS(texts["button_submit"]), "]"
    }

    return table.concat(formspec, "")
end

local function handle_adm_set_fields(player, fields)
    if fields.submit then
        if minetest.registered_nodes[fields.block] == nil then
            minetest.chat_send_player(
                player:get_player_name(),
                minetest.colorize("#FF0000", S("Invalid block"))
            )
            return
        end
        local set = minetest.registered_chatcommands["/set"].func
        set(player:get_player_name(), fields.block)
    end
end
-- End Set Command Formspec --

-- Effect Formspec --
local function get_effect_formspec()
    local texts = {
        label = S("Apply an effect to a player"),
        button_submit = S("Submit"),
        default_field_player = S("<player name>"),
        default_field_effect = S("<effect>"),
        default_field_duration = S("<duration (secs)>")
    }

    local formspec = {
        "formspec_version[6]",
        "size[5.25,4.7]",
        "label[0.3,0.5;", FS(texts["label"]), "]",
        "field[0.3,0.8;4.7,0.8;player;;", FS(texts["default_field_player"]), "]",
        "field[0.3,1.7;4.7,0.8;effect;;", FS(texts["default_field_effect"]), "]",
        "field[0.3,2.6;4.7,0.8;duration;;", FS(texts["default_field_duration"]), "]",
        "button_exit[0.3,3.6;4.7,0.8;submit;", FS(texts["button_submit"]), "]"
    }

    return table.concat(formspec, "")
end

local function handle_adm_effect_fields(player, fields)
    if fields.submit then
        local player_target = minetest.get_player_by_name(fields.player)
        if player_target ~= nil then
            if fields.effect == "" or fields.effect == nil then
                minetest.chat_send_player(
                    player:get_player_name(),
                    minetest.colorize("#FF0000", S("Invalid effect"))
                )
                return
            end
            if fields.duration:match("^%-?%d+$") == nil then
                minetest.chat_send_player(
                    player:get_player_name(),
                    minetest.colorize("#FF0000", S("Invalid duration"))
                )
                return
            end
            local effect = minetest.registered_chatcommands.effect.func
            effect(
                player_target:get_player_name(),
                fields.effect .. " " .. fields.duration
            )
        else
            minetest.chat_send_player(
                player:get_player_name(),
                minetest.colorize("#FF0000", S("Invalid player"))
            )
        end
    end
end
-- End Effect Formspec --

-- Teleport Formspec --
local function get_teleport_formspec()
    local texts = {
        label = S("Teleport to a coordinate or a player"),
        default_field_args = S("<arguments>"),
        button_submit = S("Submit"),
        label_insts = S("Arguments: ") .. minetest.registered_chatcommands.tp.params
    }

    local formspec = {
        "formspec_version[6]",
        "size[18.5,3.55]",
        "label[0.3,0.5;", FS(texts["label"]), "]",
        "field[0.3,0.8;17.9,0.8;arguments;;", FS(texts["default_field_args"]), "]",
        "button_exit[0.3,1.7;17.9,0.8;submit;", FS(texts["button_submit"]), "]",
        "label[0.3,3;", FS(texts["label_insts"]), "]"
    }

    return table.concat(formspec, "")
end

local function handle_adm_teleport_fields(player, fields)
    if fields.submit then
        local teleport = minetest.registered_chatcommands.teleport.func
        teleport(player:get_player_name(), fields.arguments)
    end
end
-- End Teleport Formspec --

-- Summon Formspec --
local function get_summon_formspec()
    local texts = {
        label = S("Summon an mob at a player"),
        button_submit = S("Submit"),
        default_field_mob = S("<mob id>"),
        default_field_player = S("<player name>")
    }

    local formspec = {
        "formspec_version[6]",
        "size[5.25,3.8]",
        "label[0.3,0.5;", FS(texts["label"]), "]",
        "field[0.3,0.8;4.7,0.8;mob;;", FS(texts["default_field_mob"]), "]",
        "field[0.3,1.7;4.7,0.8;player;;", FS(texts["default_field_player"]), "]",
        "button_exit[0.3,2.7;4.7,0.8;submit;", FS(texts["button_submit"]), "]"
    }

    return table.concat(formspec, "")
end

local function handle_adm_summon_fields(player, fields)
    if fields.submit then
        if minetest.registered_entities[fields.mob] == nil then
            minetest.chat_send_player(
                player:get_player_name(),
                minetest.colorize("#FF0000", S("Invalid mob"))
            )
            return
        end

        local player_target = minetest.get_player_by_name(fields.player)
        if player_target ~= nil then
            local summon = minetest.registered_chatcommands.summon.func
            local pos = player_target:get_pos()
            summon(
                player:get_player_name(),
                fields.mob .. " " .. pos.x .. "," .. pos.y .. "," .. pos.z
            )
        else
            minetest.chat_send_player(
                player:get_player_name(),
                minetest.colorize("#FF0000", S("Invalid player"))
            )
        end
    end
end
-- End Summon Formspec --

-- Time Formspec --
local function get_time_formspec()
    local texts = {
        label = S("Set time"),
        button_rise = S("Sunrise"),
        button_noon = S("Noon"),
        button_mid = S("Midnight"),
        button_exit = S("Exit")
    }

    local formspec = {
        "formspec_version[6]",
        "size[5.25,4.7]",
        "label[0.3,0.5;", FS(texts["label"]), "]",
        "button[0.3,0.8;4.7,0.8;rise;", FS(texts["button_rise"]), "]",
        "button[0.3,1.7;4.7,0.8;noon;", FS(texts["button_noon"]), "]",
        "button[0.3,2.6;4.7,0.8;mid;", FS(texts["button_mid"]), "]",
        "button_exit[0.3,3.6;4.7,0.8;exit;", FS(texts["button_exit"]), "]"
    }

    return table.concat(formspec, "")
end

local function handle_adm_time_fields(_, fields)
    if fields.rise then
        minetest.set_timeofday(0.25)
    elseif fields.noon then
        minetest.set_timeofday(0.5)
    elseif fields.mid then
        minetest.set_timeofday(0)
    elseif fields.exit then
        return
    end
end
-- End Formspec --

local function get_panel_formspec()
    local texts = {
        label = S("Administrator panel"),
        button_kill = S("@1 - Kill a player", "/kill"),
        button_gamemode = S("Game mode"),
        button_give = S("@1 - Give an item to a player", "/give"),
        button_set = S("@1 - Fill an area with an specific block", "//set"),
        button_effect = S("@1 - Give an effect to a player", "/effect"),
        button_tp = S("@1 - Teleport to a coordinate or a player", "/tp"),
        button_summon = S("@1 - Summon an entity", "/summon"),
        button_time = S("@1 - Set time", "/time")
    }

    local formspec = {
        "formspec_version[6]",
        "size[10.5,11]",
        "label[0.4,0.7;", FS(texts["label"]), "]",
        "button[0.3,1.3;9.9,0.8;kill;", FS(texts["button_kill"]), "]",
        "button[0.3,2.4;9.9,0.8;gamemode;", FS(texts["button_gamemode"]), "]",
        "button[0.3,3.5;9.9,0.8;give;", FS(texts["button_give"]), "]",
        "button[0.3,4.6;9.9,0.8;set;", FS(texts["button_set"]), "]",
        "button[0.3,5.7;9.9,0.8;effect;", FS(texts["button_effect"]), "]",
        "button[0.3,6.8;9.9,0.8;tp;", FS(texts["button_tp"]), "]",
        "button[0.3,7.9;9.9,0.8;summon;", FS(texts["button_summon"]), "]",
        "button[0.3,9;9.9,0.8;time;", FS(texts["button_time"]), "]"
    }

    return table.concat(formspec, "")
end

local function handle_adm_panel_fields(player, fields)
    if fields.kill then
        minetest.show_formspec(player:get_player_name(), "adm_panel:kill", get_kill_formspec())
    elseif fields.gamemode then
        minetest.show_formspec(player:get_player_name(), "adm_panel:gamemode", get_gamemode_formspec())
    elseif fields.give then
        minetest.show_formspec(player:get_player_name(), "adm_panel:give", get_give_formspec())
    elseif fields.set then
        minetest.show_formspec(player:get_player_name(), "adm_panel:set", get_set_formspec())
    elseif fields.effect then
        minetest.show_formspec(player:get_player_name(), "adm_panel:effect", get_effect_formspec())
    elseif fields.tp then
        minetest.show_formspec(player:get_player_name(), "adm_panel:tp", get_teleport_formspec())
    elseif fields.summon then
        minetest.show_formspec(player:get_player_name(), "adm_panel:summon", get_summon_formspec())
    elseif fields.time then
        minetest.show_formspec(player:get_player_name(), "adm_panel:time", get_time_formspec())
    end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
    local player_name = player:get_player_name()
    if not minetest.check_player_privs(player_name, { privs = true }) then
        return false
    end

    if formname == "adm_panel:panel" then
        handle_adm_panel_fields(player, fields)
    elseif formname == "adm_panel:kill" then
        handle_adm_kill_fields(player, fields)
    elseif formname == "adm_panel:gamemode" then
        handle_adm_gamemode_fields(player, fields)
    elseif formname == "adm_panel:give" then
        handle_adm_give_fields(player, fields)
    elseif formname == "adm_panel:set" then
        handle_adm_set_fields(player, fields)
    elseif formname == "adm_panel:effect" then
        handle_adm_effect_fields(player, fields)
    elseif formname == "adm_panel:tp" then
        handle_adm_teleport_fields(player, fields)
    elseif formname == "adm_panel:summon" then
        handle_adm_summon_fields(player, fields)
    elseif formname == "adm_panel:time" then
        handle_adm_time_fields(player, fields)
    end
end)

local function open_adm_panel(_, player, _)
    local privs = minetest.get_player_privs(player:get_player_name())
    privs.server = true
    privs.give = true
    privs.worldedit = true
    privs.teleport = true
    privs.interact = true
    privs.settime = true
    minetest.set_player_privs(player:get_player_name(), privs)

    minetest.show_formspec(player:get_player_name(), "adm_panel:panel", get_panel_formspec())
end

minetest.register_craftitem("adm_panel:panel", {
    description = S("Administrator panel"),
    inventory_image = "adm_panel_item_panel.png",
    stack_max = 64,
    on_secondary_use = open_adm_panel,
    on_place = open_adm_panel
})
