function ulx.setwaypointname(calling_ply, name)
	e = calling_ply:GetEyeTrace().Entity
	if e:GetClass() == "superswaypoints_waypoint" then
		e:SetWaypointName(name)
	end
end
local setwaypointname = ulx.command("SupersWaypoints", "ulx setwaypointname", ulx.setwaypointname, "!setwaypointname") --Change category to the correct one
setwaypointname:addParam{type=ULib.cmds.StringArg, hint="name", ULib.cmds.takeRestOfLine}
setwaypointname:defaultAccess(ULib.ACCESS_ADMIN)
setwaypointname:help("Set the name of the waypoint you're looking at")

function ulx.activatewaypoint(calling_ply)
	e = calling_ply:GetEyeTrace().Entity
	if e:GetClass() == "superswaypoints_waypoint" then
		e:SetIsWaypointActive(true)
	end
end
local activatewaypoint = ulx.command("SupersWaypoints", "ulx activatewaypoint", ulx.activatewaypoint, "!activatewaypoint")--Change category to the correct one
activatewaypoint:defaultAccess(ULib.ACCESS_ADMIN)
activatewaypoint:help("Activate the waypoint you're looking at")

function ulx.deactivatewaypoint(calling_ply)
	e = calling_ply:GetEyeTrace().Entity
	if e:GetClass() == "superswaypoints_waypoint" then
		e:SetIsWaypointActive(false)
	end
end
local deactivatewaypoint = ulx.command("SupersWaypoints", "ulx deactivatewaypoint", ulx.deactivatewaypoint, "!deactivatewaypoint")--Change category to the correct one
deactivatewaypoint:defaultAccess(ULib.ACCESS_ADMIN)
deactivatewaypoint:help("Deactivate the waypoint you're looking at")

function ulx.activateallwaypoints(calling_ply)
	for key , value in pairs(ents.GetAll()) do
		if value:GetClass() == "superswaypoints_waypoint" then
			print("yay")
			value:SetIsWaypointActive(true)
		end
	end
end
local activateallwaypoints = ulx.command("SupersWaypoints", "ulx activateallwaypoints", ulx.activateallwaypoints, "!activateallwaypoints")--Change category to the correct one
activateallwaypoints:defaultAccess(ULib.ACCESS_ADMIN)
activateallwaypoints:help("Activate all the waypoints on te map")

function ulx.deactivateallwaypoints(calling_ply)
	for key , value in pairs(ents.GetAll()) do
		if value:GetClass() == "superswaypoints_waypoint" then
			value:SetIsWaypointActive(false)
		end
	end
end
local deactivateallwaypoints = ulx.command("SupersWaypoints", "ulx deactivateallwaypoints", ulx.deactivateallwaypoints, "!deactivateallwaypoints")--Change category to the correct one
deactivateallwaypoints:defaultAccess(ULib.ACCESS_ADMIN)
deactivateallwaypoints:help("Deactivate all the waypoints on te map")