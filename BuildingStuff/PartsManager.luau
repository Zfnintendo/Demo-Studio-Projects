local PartsManager = {}
PartsManager.__index = PartsManager

type PartsList = { Part }

export type PartsManager = setmetatable<{
    selectedPart: Part?,
    PartsList: PartsList,
}, typeof(PartsManager)>



-- // Construcotr //
function PartsManager.new(PartsList: PartsList): PartsManager
    local self: PartsManager = setmetatable({
        selectedPart = nil,
        PartsList = PartsList,
    }, PartsManager)

    return self
end



-- // Getters //

-- gets the selected part and returns nil if none are selected
function PartsManager.getSelectedPart(self: PartsManager): Part?
    return self.selectedPart
end

-- gets the available parts to choose from
function PartsManager.getPartsList(self: PartsManager): PartsList
    return self.PartsList
end



-- // Setters //

-- Sets the selected part (does not clone)
function PartsManager.setSelectedPart(self: PartsManager, part: Part)
    self.selectedPart = part
end

-- Sets the selected part (does clone)
function PartsManager.setClonedPart(self: PartsManager, part: Part)
    self.selectedPart = part:Clone()
end

-- Sets the available parts
function PartsManager.setPartsList(self: PartsManager, PartsList: PartsList)
    self.PartsList = PartsList
end



-- // Other Methods //

-- Sets the selected part from the list (does clone) would say this is technically safer as we know what parts player would have if we ever lock some behind a gamepass
function PartsManager.setpartByList(self: PartsManager, part: Part)
    local i: number? = table.find(self.PartsList, part)

    if not i then
        warn("Hey so like the part you provided " .. part.Name .. "Was not found in the list " .. self.PartsList .. "check your work!")
        return
    end

    local refpart = self.PartsList[i]

    self.selectedPart = refpart.Clone()
end

return PartsManager