local spamton_dialog = {}

function spamton_dialog.show(player, theme_song, callback)
local handle = nil
if theme_song then
handle = minetest.sound_play({ name = theme_song }, { loop = true })
end
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, "HEY      EVERY      !! IT'S ME!!!")
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, "EV3RY  BUDDY  'S FAVORITE [[Number 1 Rated Salesman1997]]")
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, "SPAMTON G. SPAMTON!!")
if theme_song then
minetest.sound_stop(handle)
end
if callback then
callback()
end
end)end)end)end

return spamton_dialog
