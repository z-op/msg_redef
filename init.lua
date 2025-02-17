--[[
msg_redef

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
