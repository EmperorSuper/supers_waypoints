AddCSLuaFile()

if CLIENT then
	function ENT:Draw()
		if LocalPlayer():GetMoveType()==8 then
			self:DrawModel()
		end
	end
end

function ENT:SetupDataTables()
	self:NetworkVar("String",1,"WaypointName", {KeyName = "waypoint_name", Edit = {type = "Generic", order = 1}})
	self:NetworkVar("String",2,"WaypointObjective", {KeyName = "waypoint_objective", Edit = {type = "Generic", order = 2}})
	self:NetworkVar("String",3,"WaypointNumber", {KeyName = "waypoint_number", Edit = {type = "Generic", order = 3}})
	self:NetworkVar("Bool",4,"IsWaypointActive", {KeyName = "is_waypoint_active", Edit = {type = "Boolean", order = 4}})
	self:NetworkVar("Bool",5,"ShouldDrawBlur", {KeyName = "ShouldDrawBlur", Edit = {type = "Boolean", order = 5}})
	self:NetworkVar("Bool",6,"ObjectiveBeforeName", {KeyName = "ObjectiveBeforeName", Edit = {type = "Boolean", order = 6}})
	if SERVER then
		self:SetWaypointName("WAYPOINT NAME")
		self:SetWaypointObjective("")
		self:SetIsWaypointActive(false)
		self:SetShouldDrawBlur(false)
		self:SetObjectiveBeforeName(true)
		self:SetWaypointNumber("")
	end
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	 
	    local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
		self:AddEFlags(EFL_FORCE_CHECK_TRANSMIT)
		self:SetColor(Color(220, 40, 40))
		if self:GetNWString("WaypointObjective", nil) == nil then
			self:SetWaypointObjective("")
		end
		if self:GetNWString("ObjectiveBeforeName", nil) == nil then
			self:SetObjectiveBeforeName(true)
		end
	end
	function ENT:UpdateTransmitState()
		return TRANSMIT_ALWAYS
	end
end

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Waypoint"
ENT.Category = "Super's Entities"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.Editable = true
ENT.Spawnable = true