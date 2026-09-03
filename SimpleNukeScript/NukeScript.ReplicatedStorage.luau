local Workspace = game:GetService("Workspace")
local Sfx = script.Sound

type PartsTable = {}

function FindWithinRadius(Coordinates: Vector3, Radius: number): PartsTable

	local Descendants = {}
	local FilteredDescendants = {}
	local FoundHumanoids = {}

	local NukeObject = Instance.new("Part")

	NukeObject.Position = Coordinates
	NukeObject.Size = Vector3.new(Radius * 2, Radius * 2, Radius * 2)
	NukeObject.Shape = "Block"
	NukeObject.Anchored = true
	NukeObject.Transparency = 1
	NukeObject.CanCollide = false

	NukeObject.Parent = Workspace

	Descendants = Workspace:GetPartsInPart(NukeObject)

	for i, Obj in Descendants do
		table.insert(FilteredDescendants, Obj)

		local Model = Obj:FindFirstAncestorOfClass("Model")

		if Model then
			local Humanoid = Model:FindFirstChildOfClass("Humanoid")

			if Humanoid and not FoundHumanoids[Humanoid] then
				FoundHumanoids[Humanoid] = true
				table.insert(FilteredDescendants, Humanoid)
			end
		end
	end

	NukeObject:Destroy()

	return FilteredDescendants
end



local NukeScript = {}

export type Table = {}

function NukeScript.NukeAll(NukeDuration, Damage)
	
	local PartsList = Workspace:QueryDescendants("Part")
	local HumanoidList = Workspace:QueryDescendants("Humanoid")
	local NukeDictionary = {}
	
	Sfx:Play()
	
	for i, Obj in PartsList do
		NukeDictionary[PartsList[i]] = PartsList[i].Material 
		PartsList[i].Material = "CorrodedMetal"
	end
	
	for i, Obj in HumanoidList do
		Obj.Health = Obj.Health - Damage
	end
	
	task.delay(NukeDuration, function()
		for i, Obj in PartsList do
			PartsList[i].Material = NukeDictionary[PartsList[i]]
		end
	end)

end

function NukeScript.NukeRadius(NukeDuration, Damage, Coordinates, Radius)

	local RadiusList = FindWithinRadius(Coordinates, Radius)
	local NukeDictionary = {}
	local HumanoidList = {}

	Sfx:Play()

	for i, Obj in RadiusList do
		if Obj:IsA("Humanoid") then
			if not HumanoidList[Obj] then
				HumanoidList[Obj] = true
				Obj.Health = Obj.Health - Damage
			end
		end
	end

	for i, Obj in RadiusList do
		if Obj:IsA("BasePart") then
			NukeDictionary[Obj] = Obj.Material
			Obj.Material = Enum.Material.CorrodedMetal
		end
	end

	task.delay(NukeDuration, function()
		for Obj, Material in NukeDictionary do
			if Obj and Obj.Parent and Material then
				Obj.Material = Material
			end
		end
	end)
end
return NukeScript