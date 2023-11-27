local S = minetest.get_translator(minetest.get_current_modname())
local spamton_dialog = {}

function spamton_dialog.show(player, theme_song, callback)
local handle = nil
if theme_song then
handle = minetest.sound_play({ name = theme_song }, { loop = true, pos = minetest.get_player_by_name(player):get_pos() })
end
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S("HEY      EVERY      !! IT'S ME!!!"))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S("EV3RY  BUDDY  'S FAVORITE [[Number 1 Rated Salesman1997]]"))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('SPAMTON G. SPAMTON!!'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('WOAH!! IF IT ISN"T A...'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('LIGHT nER! HEY-HE Y HEY!!!'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S("LOOKS LIKE YOU'RE [[All Alone On A Late Night?]]"))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('ALL YOUR FRIENDS, [[Abandoned you for the slime]] YOU ARE?'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('SALES, GONE DOWN THE [[Drain]] [[Drain]]??'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('LIVING IN A GODDAMN GARBAGE CAN???'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('WELL HAVE I GOT A [[Specil Deal]] FOR LONELY [[Hearts]] LIKE YOU!!'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S("IF YOU'VE [[Lost Control Of Your Life]]"))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('THEN YOU JUST GOTTA GRAB IT BY THE [[Silly Strings]]'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('WHY BE THE [[Little Sponge]] WHO HATES ITS [[$4.99]] LIFE'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('WHEN YOU CAN BE A'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('[[BIG SHOT!!!]]'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('[[BIG SHOT!!!!]]'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('[[BIG SHOT!!!!!]]'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S("THAT'S RIGHT!! NOW'S YOUR CHANCE TO BE A [[BIG SHOT]]!!"))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('AND I HAVE JUST.'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('THE THING.'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('YOU NEED.'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S("THAT'S"))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('[[Hyperlink Blocked]].'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S("YOU WANT IT. YOU WANT [[Hyperlink Blocked]], DON'T YOU."))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('WELL HAVE I GOT A DEAL FOR YOU!!'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('ALL YOU HAVE TO DO IS SHOW ME.'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('YOUR [[HeartShapedObject]].'))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S("YOU'RE  LIGHT neR< AREN'T YOU?"))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S("YOU'VE GOT THE [[LIGHT.]] WHY DON'T YOU [[Show it off?]]"))
minetest.handle_async(function()
local t0 = os.clock()
while os.clock() - t0 <= 5 do end
end, function()
minetest.chat_send_player(player, minetest.colorize("#00FF00", "<Spamton> ") .. S('HAEAHAEAHAEAHAEAH!!'))
if theme_song then
minetest.sound_stop(handle)
end
if callback then
callback()
end
end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end

return spamton_dialog
