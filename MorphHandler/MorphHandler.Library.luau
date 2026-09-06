-- // Types //
export type SkinColors = {
	["HeadColor"]: Color3,
	["TorsoColor"]: Color3,
	["RightArmColor"]: Color3,
	["LeftArmColor"]: Color3,
	["RightLegColor"]: Color3,
	["LeftLegColor"]: Color3
}

export type ShirtNPants = {
	["Shirt"]: Shirt,
	["Pants"]: Pants,
	["Graphic"]: ShirtGraphic
}

export type SaveMorph = {
	["BodyColors"]: SkinColors,
	["Clothing"]: ShirtNPants,
	["Accessories"]: { Accessory }
	
}
-- // Types //

-- // MainModule //
local MorphHandler = {}

-- Saves the body colors of the player model.
function MorphHandler.SkinSaver(Player: Model): SkinColors
	
	local BodyColors = {}
	
	local PlayerBodyColors = Player:FindFirstChildWhichIsA("BodyColors")
	
	BodyColors["HeadColor"] = PlayerBodyColors.HeadColor3
	BodyColors["TorsoColor"] = PlayerBodyColors.TorsoColor3
	BodyColors["RightArmColor"] = PlayerBodyColors.RightArmColor3
	BodyColors["LeftArmColor"] = PlayerBodyColors.LeftArmColor3
	BodyColors["RightLegColor"] = PlayerBodyColors.RightLegColor3
	BodyColors["LeftLegColor"] = PlayerBodyColors.LeftLegColor3
	
	return BodyColors
	
end

-- Applies body colors based of a morph model to the selected player.
function MorphHandler.SkinApplicant(Player: Model, Morph: Model)
	
	local BodyColors: BodyColors = Morph:FindFirstChildWhichIsA("BodyColors")

	local HeadColor = BodyColors.HeadColor3
	local TorsoColor = BodyColors.TorsoColor3
	local RightArmColor = BodyColors.RightArmColor3
	local LeftArmColor = BodyColors.LeftArmColor3
	local RightLegColor = BodyColors.RightLegColor3
	local LeftLegColor = BodyColors.LeftLegColor3
	
	local PlayerBodyColors = Player:FindFirstChildWhichIsA("BodyColors")
	
	PlayerBodyColors.HeadColor3 = HeadColor
	PlayerBodyColors.TorsoColor3 = TorsoColor
	PlayerBodyColors.RightArmColor3 = RightArmColor
	PlayerBodyColors.LeftArmColor3 = LeftArmColor
	PlayerBodyColors.RightLegColor3 = RightLegColor
	PlayerBodyColors.LeftLegColor3 = LeftLegColor
	
end

-- Saves the clothing of a selected player.
function MorphHandler.SaveClothing(Player: Model): ShirtNPants
	
	local ShirtNPants = {}
	
	local Shirt = Player:FindFirstChildWhichIsA("Shirt")
	local Pants = Player:FindFirstChildWhichIsA("Pants")
	local ShirtGraphic = Player:FindFirstChildWhichIsA("ShirtGraphic")

	local PlayerShirtID = Shirt and Shirt.ShirtTemplate
	local PlayerPantsID = Pants and Pants.PantsTemplate
	local PlayerGraphicID = ShirtGraphic and ShirtGraphic.Graphic
	
	ShirtNPants["Shirt"] = PlayerShirtID
	ShirtNPants["Pants"] = PlayerPantsID
	ShirtNPants["Graphic"] = PlayerGraphicID
	
	return ShirtNPants
	
end

-- Applies the clothing of a morph model to a selected player.
function MorphHandler.ApplyClothing(Player: Model, Morph: Model) 
	
	local MorphShirt = Morph:FindFirstChildWhichIsA("Shirt")
	local MorphPants = Morph:FindFirstChildWhichIsA("Pants")
	
	local PlayerShirt = Player:FindFirstChildWhichIsA("Shirt")
	local PlayerPants = Player:FindFirstChildWhichIsA("Pants")
	
	if MorphShirt then
		if not PlayerShirt then
			PlayerShirt = Instance.new("Shirt")
			PlayerShirt.Parent = Player
		end

		PlayerShirt.ShirtTemplate = MorphShirt.ShirtTemplate
		
	elseif PlayerShirt then
		
		PlayerShirt:Destroy()
		
	end

	if MorphPants then
		if not PlayerPants then
			PlayerPants = Instance.new("Pants")
			PlayerPants.Parent = Player
		end

		PlayerPants.PantsTemplate = MorphPants.PantsTemplate
		
	elseif PlayerPants then
		
		PlayerPants:Destroy()
	
	end
	
end

-- Saves the accessories of a player.
function MorphHandler.SaveAccessories(Player: Model): { Accessory } 
	
	local PlayerChildren = Player:GetChildren()
	
	local Accessories = {}
	
	for i, Inst in PlayerChildren do
		
		if Inst:IsA("Accessory") then
			
			table.insert(Accessories, Inst:Clone())
			
		end
		
	end
	
	return Accessories
	
end

-- Removes the accessories of a selected player.
function MorphHandler.RemoveAccessories(Player: Model)
	
	local PlayerChildren = Player:GetChildren()
	
	for i, Inst in PlayerChildren do

		if Inst:IsA("Accessory") then

			Inst:Destroy()

		end

	end
	
end

-- Applies the accessories of a morph model and gives it to the selected player model.
function MorphHandler.AccessoryApplicant(Player: Model, Morph: Model)

	local MorphChildren = Morph:GetChildren()

	local Humanoid = Player:FindFirstChildWhichIsA("Humanoid")

	local TemporaryParent = {}

	for i, Inst in MorphChildren do

		if Inst:IsA("Accessory") then

			local Accessory = Inst:Clone()
			
			for i, Joint in Accessory:GetDescendants() do

				if Joint:IsA("WeldConstraint") or Joint:IsA("Weld") or Joint:IsA("Motor6D") or Joint:IsA("RigidConstraint") then
					
					Joint:Destroy()

				end

			end

			table.insert(TemporaryParent, Accessory)

		end

	end

	MorphHandler.RemoveAccessories(Player)

	for i, Accessory in TemporaryParent do
		Humanoid:AddAccessory(Accessory)
	end

end

-- Saves and removes all accessories and clothing of the player then applies the full morph of the morph model.
function MorphHandler.ApplyMorph(Player: Model, Morph: Model): SaveMorph
	
	local SavedMorph = {}
	
	SavedMorph["BodyColors"] = MorphHandler.SkinSaver(Player)
	MorphHandler.SkinApplicant(Player, Morph)
	
	SavedMorph["Clothing"] = MorphHandler.SaveClothing(Player)
	MorphHandler.ApplyClothing(Player, Morph)
	
	SavedMorph["Accessories"] = MorphHandler.SaveAccessories(Player)
	MorphHandler.AccessoryApplicant(Player, Morph)
	
	return SavedMorph	
	
end

return MorphHandler
-- // MainModule //



