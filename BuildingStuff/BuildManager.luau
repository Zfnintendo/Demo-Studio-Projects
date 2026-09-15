local BuildManager = {}
BuildManager.__index = BuildManager

type BuildState = {
    Creating: boolean,
    Moving: boolean,
    Rotating: boolean,
    Scaling: boolean,
}

export type BuildManager = setmetatable<{
    isBuilding: boolean,
    buildState: BuildState,
    humanoid: Humanoid,
}, typeof(BuildManager)>

-- // Constructoorrrr //
function BuildManager.new(Humanoid: Humanoid): BuildManager
    local BuildState: BuildState = {
        Creating = false,
        Moving = false,
        Rotating = false,
        Scaling = false,
    }

    local self = setmetatable({
        isBuilding = false,
        buildState = BuildState,
        humanoid = Humanoid,
    }, BuildManager)

    return self

end



-- // Getters //

-- Gets whether they are building
function BuildManager.getIsBuilding(self: BuildManager): boolean
    return self.isBuilding
end

-- Gets what build state they are currently in
function BuildManager.getBuildState(self: BuildManager): BuildState
    return self.buildState
end

-- Gets the humanoid that is building
function BuildManager.getHumanoid(self: BuildManager): Humanoid
    return self.humanoid
end



-- // Setters //

-- Sets Is building
function BuildManager.setIsBuilding(self: BuildManager, state: boolean)
    self.isBuilding = state
end

-- Sets build state
function BuildManager.setBuildState(self:BuildManager, state: BuildState)
    self.buildState = state
end



-- // Other methods //

-- Toggles building based on staet
function BuildManager.toggleBuilding(self: BuildManager)
    local state: boolean = BuildManager.getIsBuilding(self)

    if state then
        self.isBuilding = false
        return
    end

    self.isBuilding = true
    return

end

return BuildManager