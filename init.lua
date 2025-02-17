--[[
msg_redef

License: LGPLv2+
--]]


local S = core.get_translator("msg_redef")

--Add local echo and colors
core.unregister_chatcommand("msg")
core.register_chatcommand("msg", {
	params = S("<name> <message>"),
	description = S("Send a direct message to a player"),
	privs = {shout=true},
	func = function(name, param)
		local sendto, message = param:match("^(%S+)%s(.+)$")
		if not sendto then
			return false, S("Invalid usage, see /help msg.")
		end
		if not core.get_player_by_name(sendto) then
			return false, S("The player @1 is not online.", sendto)
		end
		core.log("action", "DM from " .. name .. " to " .. sendto
				.. ": " .. message)
		message = minetest.colorize("khaki", message)
		core.chat_send_player(sendto, S("DM from @1: @2", name, message))
		core.chat_send_player(name, S("DM for @1: @2", sendto, message))
		return true
	end,
})


--Add logging and colors
core.unregister_chatcommand("me")
core.register_chatcommand("me", {
	params = S("<action>"),
	description = S("Show chat action (e.g., '/me orders a pizza' "
		.. "displays '<player name> orders a pizza')"),
	privs = {shout=true},
	func = function(name, param)
		core.log("action", "* " .. name .. " " .. param)
		param = minetest.colorize("skyblue", param)
		core.chat_send_all("* " .. name .. " " .. param)
		return true
	end,
})




if (core.settings:get("debug_log_level") == nil)
or (core.settings:get("debug_log_level") == "action")
or	(core.settings:get("debug_log_level") == "info")
or (core.settings:get("debug_log_level") == "verbose")
then

	core.log("action", "[Mod] msg_redef loaded.")
end
