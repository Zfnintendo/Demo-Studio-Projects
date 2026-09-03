local NameEntry = {
	"Welcome, ",
	"Greetings, "
}

local EntryDefault = {
	"Control Your Destiny.",
	"Seize Victory."
}

local function EntryMessage(PlayerName): string
	
	local EntryPath = math.random(1, 2)

	if EntryPath == 2 then

		local Message = NameEntry[math.random(1, #NameEntry)]

		return Message .. PlayerName .. "."

	end

	return EntryDefault[math.random(1, #EntryDefault)]
	
end

return EntryMessage
