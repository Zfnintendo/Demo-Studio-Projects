local PlacementManager = {}
PlacementManager.__index = PlacementManager

export type PlacementManager = setmetatable<{
    part: Part,
    position: Vector3,
    orientation: Vector3,
}, typeof(PlacementManager)>



-- // Constructorr //

-- new part stuff goes here!
function PlacementManager.new(part: Part): PlacementManager
    local self = setmetatable({
        part = part,
        position = part.Position,
        orientation = part.Orientation,
    }, PlacementManager)

    return self
end



-- // Getters //

-- Gets the part
function PlacementManager.getPart(self: PlacementManager): Part
    return self.part 
end

-- Gets the position
function PlacementManager.getPosition(self: PlacementManager): Vector3
    return self.position
end

-- Gets the orientation 
function PlacementManager.getOrientation(self: PlacementManager): Vector3
    return self.orientation
end



-- // Setters //

-- Sets the new part
function PlacementManager.setPart(self:PlacementManager, part: Part)
    self.part = part

    PlacementManager.updatePart(self)
end

-- Sets the new position 
function PlacementManager.setPosition(self: PlacementManager, newPosition: Vector3)
    self.position = newPosition

    PlacementManager.updatePart(self)
end

-- Sets the new orientation
function PlacementManager.setOrientation(self: PlacementManager, newOrientation: Vector3)
    self.orientation = newOrientation

    PlacementManager.updatePart(self)
end



-- // Other methods //

-- Gets the cframe of the part
function PlacementManager.getCFrame(self: PlacementManager): CFrame
    local Ox: number = self.orientation.X
    local Oy: number = self.orientation.Y
    local Oz: number = self.orientation.Z

    local posx: number = self.position.X
    local posy: number = self.position.Y
    local posz: number = self.position.Z

    local CF: CFrame = CFrame.new(posx, posy, posz) * CFrame.fromOrientation(math.rad(Ox), math.rad(Oy), math.rad(Oz))

    return CF

end

-- Sets the position and orientation based on cframe given
function PlacementManager.setCFrame(self: PlacementManager, cFrame: CFrame)
    local position = cFrame.Position
    local rx, ry, rz = cFrame:ToOrientation()
    local orientation = Vector3.new(math.deg(rx), math.deg(ry), math.deg(rz))

    self.position = position
    self.orientation = orientation

    PlacementManager.updatePart(self)
end

function PlacementManager.updatePart(self: PlacementManager)
    self.part.Position = self.position
    self.part.Orientation = self.orientation
end


return PlacementManager