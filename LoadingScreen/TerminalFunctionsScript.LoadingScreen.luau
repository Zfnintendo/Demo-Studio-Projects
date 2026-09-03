local ClickSfx = script.Click

local TerminalFunction = {}

-- // Regular Functions //

-- Moves the canvas frame to the bottom, as if the user was scrolling to the bottom.
function TerminalFunction.ScrollToBottom(OutputFrame: ScrollingFrame) -- Outputs

	task.defer(function()
		OutputFrame.CanvasPosition = Vector2.new(0, math.max(0, OutputFrame.AbsoluteCanvasSize.Y))
	end)

end


-- Adds a typing text from a user without the user having to type out the text. 
function TerminalFunction.TypeLine(OutputFrame: ScrollingFrame, Output: TextLabel, Text: string)
	
	for i = 1, #Text do 
		
		Output.Text = Output.Text .. string.sub(Text, i, i)
		TerminalFunction.ScrollToBottom(OutputFrame)
		
		ClickSfx:Play()
		
		task.wait(0.001)
		
	end
	
	Output.Text = Output.Text .. "\n"
	TerminalFunction.ScrollToBottom(OutputFrame)

	task.wait(0.05)
	
end


-- Adds a text to the output and creates a new line.
function TerminalFunction.AddLine(OutputFrame: ScrollingFrame, Output: TextLabel, Text: string)
	
	Output.Text = Output.Text .. Text .. "\n"
	TerminalFunction.ScrollToBottom(OutputFrame)
	
end
-- // Regular Functions //

-- // Loading Bar Functions //

-- Creates the loading bar so long as the Frame and TextLabel are given.
function TerminalFunction.CreateLoadingBar(OutputFrame:ScrollingFrame , Output: TextLabel): TextLabel
	
	local LoadingBar = Instance.new("TextLabel")
	
	LoadingBar.Size = UDim2.new(1, -5, 0, 22)
	LoadingBar.BackgroundTransparency = 1
	LoadingBar.Text = "[░░░░░░░░░░░░░░░░░░░░] 0%"
	LoadingBar.TextColor3 = Color3.fromRGB(0,190,70)
	LoadingBar.TextSize = 15
	LoadingBar.Font = Enum.Font.Code
	LoadingBar.TextXAlignment = Enum.TextXAlignment.Left
	LoadingBar.TextYAlignment = Enum.TextYAlignment.Top
	
	LoadingBar.Parent = OutputFrame
	
	task.defer(function()
		
		LoadingBar.Position = UDim2.fromOffset(0, Output.TextBounds.Y)
		TerminalFunction.ScrollToBottom(OutputFrame)
		
	end)
	
	return LoadingBar

end


-- Updates the loading bar based on a percentage given. The percentage range should be between 0 and 100.
function TerminalFunction.UpdateLoadingBar(OutputFrame:ScrollingFrame , LoadingBar: TextLabel, Percentage: number)
	
	if not LoadingBar then
		warn("Loading Bar has not been created!")
		return
	end
	
	Percentage = math.clamp(math.floor(Percentage), 0, 100)
	
	local BarLength = 20 
	local Filled = math.floor((Percentage/100) * BarLength)
	local EmptySpace = BarLength - Filled
	
	local Bar = "[".. string.rep("█", Filled).. string.rep("░", EmptySpace).. "] ".. Percentage.. "%"
	
	LoadingBar.Text = Bar
	
	TerminalFunction.ScrollToBottom(OutputFrame)
	
end


-- Finishes the loading bar.
function TerminalFunction.FinishLoadingBar(OutputFrame:ScrollingFrame , Output: TextLabel, LoadingBar: TextLabel)
	
	if not LoadingBar then
		warn("Loading Bar has not been created!")
		return
	end
	
	local FinalText = LoadingBar.Text 

	LoadingBar:Destroy()
	
	TerminalFunction.AddLine(OutputFrame, Output, FinalText)

end
-- // Loading Bar Functions //

return TerminalFunction
