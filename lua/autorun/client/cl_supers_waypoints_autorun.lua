AddCSLuaFile()

if not CLIENT then return end

surface.CreateFont("superswaypoints_WayPointFont", {
	font = "Orbitron Regular",
	size = 40,
	antialias = true,
})
surface.CreateFont("superswaypoints_WayPointFont_Blur", {
	font = "Orbitron Regular",
	size = 40,
	blursize = 4,
	antialias = true,
})

surface.CreateFont("superswaypoints_WayPointFont2", {
	font = "Orbitron Regular",
	size = 25,
	antialias = true,
})

surface.CreateFont("superswaypoints_WayPointFont3", {
	font = "Orbitron Regular",
	size = 21,
	antialias = true,
})
surface.CreateFont("superswaypoints_WayPointFont3_Blur", {
	font = "Orbitron Regular",
	size = 21,
	blursize = 1,
	antialias = true,
})

surface.CreateFont("superswaypoints_WayPointFont3_NameBeforeOnjective", {
	font = "Orbitron Regular",
	size = 21,
	antialias = true,
})
surface.CreateFont("superswaypoints_WayPointFont3_NameBeforeOnjective_Blur", {
	font = "Orbitron Regular",
	size = 21,
	blursize = 1,
	antialias = true,
})


-- THIS IS THE OLD WAY I USED TO DO THE TEXT, KEEPING IT HERE JUST IN CASE
--[[hook.Add("PostDrawTranslucentRenderables","superswaypoints_PostDrawTranslucentRenderables",function(bDrawingDepth, bDrawingSkybox)
	if bDrawingSkybox then return end
	for key , value in pairs(ents.GetAll()) do
		if IsValid(value) and value:GetClass() == "superswaypoints_waypoint" and (value:GetIsWaypointActive() or LocalPlayer():GetMoveType()==8) then
			local nameColor = value:GetColor()
			local distanceColor = Color(200, 200, 200)
			if value:GetIsWaypointActive()==false then
				if LocalPlayer():GetMoveType()==8 then
					nameColor = Color(value:GetColor().r, value:GetColor().g, value:GetColor().b, 125)
					distanceColor = Color(200, 200, 200, 125)
				else
					return
				end
			end

			local ang = LocalPlayer():EyeAngles()

			local dis = LocalPlayer():GetPos():Distance(value:GetPos())
			dis = dis + 150

			local AllowedTextPitch = 25
			if ang.pitch > AllowedTextPitch then ang.pitch = AllowedTextPitch end
			if ang.pitch < -AllowedTextPitch then ang.pitch = -AllowedTextPitch end
			cam.Start3D2D(Vector(value:GetPos().x,value:GetPos().y,value:GetPos().z + 15),Angle(0, ang.yaw-90, (-ang.pitch*0.5)+90), dis * 0.00027)
				cam.IgnoreZ(true)
				draw.SimpleText(value:GetWaypointName(),"superswaypoints_WayPointFont",0,0,nameColor,1,1)
				if value:GetShouldDrawBlur() then
					draw.SimpleText(value:GetWaypointName(),"superswaypoints_WayPointFont_Blur",0,0,nameColor,1,1)
				end
				draw.SimpleText("Distance: " .. math.Round(LocalPlayer():GetPos():Distance(value:GetPos())/50) .. "m","superswaypoints_WayPointFont2",0, 90,distanceColor,1,1)
				cam.IgnoreZ(false)
			cam.End3D2D()
		end
	end
end)]]--
function draw.Circle( x, y, radius, seg ) -- this is just ripped off the wiki
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 )
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

hook.Remove("PostDrawTranslucentRenderables", "superswaypoints_PostDrawTranslucentRenderables")

local distanceColor = Color(200, 200, 200)
local numberColor = Color(255, 255, 255)
hook.Add("HUDPaint", "superswaypoints_HUDPaint", function()
	for key , value in pairs(ents.FindByClass("superswaypoints_waypoint")) do
		if IsValid(value) and (value:GetIsWaypointActive() or LocalPlayer():GetMoveType()==8) then
			local nameColor = value:GetColor()
			if value:GetIsWaypointActive()==false then
				if LocalPlayer():GetMoveType()==8 then
					nameColor = Color(value:GetColor().r, value:GetColor().g, value:GetColor().b, 125)
					distanceColor = Color(200, 200, 200, 125)
				else
					return
				end
			else
				distanceColor = Color(200, 200, 200)
			end
			local screenpos = value:GetPos():ToScreen()
			if (screenpos.x < (ScrW()/2 + 150) and screenpos.x > (ScrW()/2 - 150)) and (screenpos.y < (ScrH()/2 + 150) and screenpos.y > (ScrH()/2 - 150)) then
				if value.GetObjectiveBeforeName and value:GetObjectiveBeforeName() then
					draw.SimpleText(value:GetWaypointObjective(),"superswaypoints_WayPointFont3",screenpos.x,screenpos.y-25,distanceColor,1,1)
					if value:GetShouldDrawBlur() then
						draw.SimpleText(value:GetWaypointObjective(),"superswaypoints_WayPointFont3_Blur",screenpos.x,screenpos.y-25,distanceColor,1,1)
					end

					draw.SimpleText(value:GetWaypointName(),"superswaypoints_WayPointFont",screenpos.x,screenpos.y,nameColor,1,1)
					if value:GetShouldDrawBlur() then
						draw.SimpleText(value:GetWaypointName(),"superswaypoints_WayPointFont_Blur",screenpos.x,screenpos.y,nameColor,1,1)
					end

					draw.SimpleText("Distance: " .. math.Round(LocalPlayer():GetPos():Distance(value:GetPos())/50) .. "m","superswaypoints_WayPointFont2",screenpos.x,screenpos.y + 25,distanceColor,1,1)
				else
					draw.SimpleText(value:GetWaypointObjective(),"superswaypoints_WayPointFont3_NameBeforeOnjective",screenpos.x,screenpos.y,distanceColor,1,1)
					if value:GetShouldDrawBlur() then
						draw.SimpleText(value:GetWaypointObjective(),"superswaypoints_WayPointFont3_NameBeforeOnjective_Blur",screenpos.x,screenpos.y,distanceColor,1,1)
					end

					draw.SimpleText(value:GetWaypointName(),"superswaypoints_WayPointFont",screenpos.x,screenpos.y-21,nameColor,1,1)
					if value:GetShouldDrawBlur() then
						draw.SimpleText(value:GetWaypointName(),"superswaypoints_WayPointFont_Blur",screenpos.x,screenpos.y-21,nameColor,1,1)
					end

					draw.SimpleText("Distance: " .. math.Round(LocalPlayer():GetPos():Distance(value:GetPos())/50) .. "m","superswaypoints_WayPointFont2",screenpos.x,screenpos.y + 16,distanceColor,1,1)
				end
			else
				surface.SetDrawColor(nameColor)
				draw.NoTexture()
				print(value:GetWaypointNumber())
				if value:GetWaypointNumber() == "" then
					draw.Circle(math.Clamp(screenpos.x, 20, ScrW()-20), math.Clamp(screenpos.y, 20, ScrH()-20), 20, 20)
				else
					draw.Circle(math.Clamp(screenpos.x, 25, ScrW()-25), math.Clamp(screenpos.y, 25, ScrH()-25), 25, 20)
					draw.SimpleText(value:GetWaypointNumber(),"superswaypoints_WayPointFont",math.Clamp(screenpos.x, 25, ScrW()-25), math.Clamp(screenpos.y, 25, ScrH()-25)-1,numberColor,1,1)
				end
			end
		end
	end
end)