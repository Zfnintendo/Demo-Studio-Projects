local Block = {}
Block.__index = Block

export type ObjectType = "Part" | "ClientObject" | "ServerObject" | "LogicBlock"

export type Block = setmetatable<{
    part: Part,
    isSpecial: boolean, -- is it any other kind of special block? -- if true then ObjectType Applies
    objectType: ObjectType,
    props: {},
}, typeof(Block)>



-- // Constructor! //

--  Makes a new block
function Block.new(part: Part, isSpecial: boolean, objectType: ObjectType, props: {}): Block
    local self = setmetatable({
        part = part,
        isSpecial = isSpecial,
        objectType = objectType,
        props = props,
    }, Block)

    return self
end



-- // Getters //

-- gets part
function Block.getPart(self: Block): Part
    return self.part
end

-- gets whether it is a special block
function Block.getIsSpecial(self: Block): boolean
    return self.isSpecial
end

-- gets the object type
function Block.getObjectType(self: Block): ObjectType
    return self.objectType
end

-- gets the properties of the block
function Block.getProperties(self: Block): {}
    return self.props
end



-- // Setters //

-- sets whether it is a special block (enables the object type)
function Block.setIsSpecial(self: Block, isSpecial: boolean)
    self.isSpecial = isSpecial
end

-- sets the object type (doesnt change properties)
function Block.setObjectType(self: Block, objectType: ObjectType)
    self.objectType = objectType
end

-- sets the properties of the object
function Block.setProperties(self: Block, props: {})
    self.props = props
end

return Block