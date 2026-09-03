local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NukeScript = require(ReplicatedStorage.NukeScript)
local RemoteEvent = ReplicatedStorage.RemoteEvent

task.wait(5)

NukeScript.NukeAll(3,99)

RemoteEvent.OnServerEvent:Connect(function(Player, Position: Vector3)
	NukeScript.NukeRadius(3, 100, Position, 5)
end)