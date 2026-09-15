local ScaleManager = {}
ScaleManager.__index = ScaleManager

export type ScaleManager = setmetatable<{
    part: Part,
    size: Vector3,
    cFrame: CFrame,
}, typeof(ScaleManager)>



-- // Consturcotr //

-- // new ScaleManager() blaj
function ScaleManager.new(part: Part): ScaleManager
    local self = setmetatable({
        part = part,
        size = part.Size,
        cFrame = part.CFrame,
    }, ScaleManager)

    return self
end



-- // Getters //

-- Gets the part
function ScaleManager.getPart(self: ScaleManager)
    return self.part
end

-- Gets the size
function ScaleManager.getSize(self: ScaleManager)
    return self.size
end

-- Gets the CFrame of part
function ScaleManager.getCFrame(self: ScaleManager)
    return self.cFrame
end

-- Gets positon from cframe
function ScaleManager.getPosition(self: ScaleManager): Vector3
    return self.cFrame.Position
end

-- Gets orientation from cframe
function ScaleManager.getOrientation(self: ScaleManager): Vector3
    local rx, ry, rz = self.cFrame:ToOrientation()
    local orientation = Vector3.new(math.deg(rx), math.deg(ry), math.deg(rz))

    return orientation
end



-- // Setters //

-- Sets the part
function ScaleManager.setPart(self: ScaleManager, part: Part)
    self.part = part
end

-- Sets the size
function ScaleManager.setSize(self: ScaleManager, size: Vector3)
    self.size = size

    ScaleManager.updatePart(self)
end

-- sets the Cframe
function ScaleManager.setCFrame(self: ScaleManager, cFrame: CFrame)
    self.cFrame = cFrame

    ScaleManager.updatePart(self)
end

-- Sets Cframe based on position and orientation
function ScaleManager.setCFrameBasedOnVectors(self: ScaleManager, position: Vector3, orientation: Vector3)
    local posx: number = position.X
    local posy: number = position.Y
    local posz: number = position.Z

    local Ox: number = orientation.X
    local Oy: number = orientation.Y
    local Oz: number = orientation.Z

    self.cFrame = CFrame.new(posx, posy, posz) * CFrame.fromOrientation(math.rad(Ox), math.rad(Oy), math.rad(Oz))

    ScaleManager.updatePart(self)
end



-- // Other Methods //

-- // Scaleing methods! //

function ScaleManager.scaleFront(self: ScaleManager, amount: number)
    self.size = Vector3.new(self.size.X, self.size.Y, self.size.Z + amount)
    self.cFrame *= CFrame.new(0, 0, -amount / 2)

    ScaleManager.updatePart(self)
end

function ScaleManager.scaleBack(self:ScaleManager, amount: number)
    self.size = Vector3.new(self.size.X, self.size.Y, self.size.Z + amount)
    self.cFrame *= CFrame.new(0, 0, amount / 2)

    ScaleManager.updatePart(self)
end

function ScaleManager.scaleLeft(self: ScaleManager, amount: number)
    self.size = Vector3.new(self.size.X+ amount, self.size.Y, self.size.Z)
    self.cFrame *= CFrame.new(-amount / 2, 0, 0)

    ScaleManager.updatePart(self)
end

function ScaleManager.scaleRight(self: ScaleManager, amount: number)
    self.size = Vector3.new(self.size.X+ amount, self.size.Y, self.size.Z)
    self.cFrame *= CFrame.new(amount / 2, 0, 0)

    ScaleManager.updatePart(self)
end

function ScaleManager.scaleTop(self: ScaleManager, amount: number)
    self.size = Vector3.new(self.size.X, self.size.Y + amount, self.size.Z)
    self.cFrame *= CFrame.new(0, amount / 2, 0)

    ScaleManager.updatePart(self)
end

function ScaleManager.scaleBottom(self: ScaleManager, amount: number)
    self.size = Vector3.new(self.size.X, self.size.Y + amount, self.size.Z)
    self.cFrame *= CFrame.new(0, -amount / 2, 0)

    ScaleManager.updatePart(self)
end

-- // Scaleing methods! //

function ScaleManager.updatePart(self: ScaleManager)
    self.part.Size = self.size
    self.part.CFrame = self.cFrame
end

return ScaleManager