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

local function get_panel_formspec()
    local texts = {
        label = S("Administrator panel"),
        button_kill = S("@1 - Kill a player", "/kill"),
        button_gamemode = S("Game mode"),
        button_give = S("@1 - Give an item to a player", "/give"),
        button_set = S("@1 - Fill an area with an specific block", "//set"),
        button_effect = S("@1 - Give an effect to a player", "/effect"),
        button_tp = S("@1 - Teleport to a coordinate or a player", "/tp"),
        button_summon = S("@1 - Summon an entity", "/summon")
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
        "button[0.3,7.9;9.9,0.8;summon;", FS(texts["button_summon"]), "]"
    }

    return table.concat(formspec, "")
end

local function handle_adm_panel_fields(player, fields)
    if fields.kill then
        ---@diagnostic disable-next-line: undefined-global
        minetest.show_formspec(player:get_player_name(), "adm_panel:kill", get_kill_formspec())
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
    end
end)

local function open_adm_panel(_, player, _)
    minetest.show_formspec(player:get_player_name(), "adm_panel:panel", get_panel_formspec())
end

minetest.register_craftitem("adm_panel:panel", {
    description = S("Administrator panel"),
    inventory_image = "adm_panel_item_panel.png",
    stack_max = 64,
    on_secondary_use = open_adm_panel,
    on_place = open_adm_panel
})
