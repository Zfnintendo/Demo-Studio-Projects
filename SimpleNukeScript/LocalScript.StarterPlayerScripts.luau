local UIS = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = ReplicatedStorage.RemoteEvent
local Camera = Workspace.CurrentCamera

local function MousePosition()

	local TWODLocation = UIS:GetMouseLocation()
	local CameraViewport = Camera:ViewportPointToRay(TWODLocation.X, TWODLocation.Y)
	local Direction = CameraViewport.Direction*10000 
	local RaycastResult = Workspace:Raycast(CameraViewport.Origin, Direction)

	if RaycastResult then
		return Vector3.new(RaycastResult.Position.X, RaycastResult.Position.Y, RaycastResult.Position.Z)
	else 
		return Vector3.new(Direction.X * 10000, Direction.Y * 10000, Direction.Z * 10000)
	end

end

UIS.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton3 then
		local Pos = MousePosition()
		print(Pos)
		RemoteEvent:FireServer(Pos)
	end
end)