-- // Services //
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")
-- // Services //

-- // Variables & Objects //
local Player = Players.LocalPlayer
local PlayerName = Player.Name
local Assets = game:GetDescendants()
local TotalAssets = #Assets
local LoadedAssets = 0
local EnteredGame = false
local FadeEffect = script.FadeEffect
-- // Variables & Objects //

-- // Modules //
local TerminalFunction = require(script.TerminalFunctionsScript)
local LoadingConfig = require(script.LoadingConfig)
local EntryMessage = require(script.EntryMessage)
-- // Modules //

-- // Graphical User Interface //
local GUI = script.GUI
local ScreenGui = GUI.ScreenGui
local Background = ScreenGui.Background
local Terminal = Background.Terminal

local OutputFrame = Terminal.OutputFrame
local Output = OutputFrame.Output

local TitleBar = Terminal.TitleBar
local DashButton = TitleBar.DashButton
local SquareButton = TitleBar.SquareButton
local XButton = TitleBar.XButton
local Title = TitleBar.Title
-- // Graphical User Interface //

-- // Tween Info // 
local TweenInformation = TweenInfo.new(3, Enum.EasingStyle.Quad)
local TweenInformationTwo = TweenInfo.new(0.5, Enum.EasingStyle.Quad)
-- // Tween Info //

-- // Functions //

local function FadeOut()
	
	local Fade = Instance.new("Frame")
	Fade.Size = UDim2.fromScale(1, 1)
	Fade.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Fade.BackgroundTransparency = 1
	Fade.ZIndex = 10000
	Fade.Parent = ScreenGui
	
	local FadeOut = TweenService:Create(Fade, TweenInformation, {
		BackgroundColor3 = Color3.new(255,255,255),
		BackgroundTransparency = 0
	})
	
	FadeOut:Play()
	FadeEffect:Play()
	FadeOut.Completed:Wait()
	
	Background:Destroy()
	
	local FadeIn = TweenService:Create(Fade, TweenInformationTwo, {
		BackgroundTransparency = 1
	})

	FadeIn:Play()
	FadeIn.Completed:Wait()
	
	ScreenGui:Destroy()
	
end

-- Updates the progress of the loading bar
local function UpdateProgress(LoadingBar)
	
	LoadedAssets += 1
	
	local Percentage = 100
	
	Percentage = math.clamp(math.floor((LoadedAssets/TotalAssets)*100) ,0 ,100)
	
	TerminalFunction.UpdateLoadingBar(OutputFrame, LoadingBar, Percentage)
	
end
-- // Functions //

-- // Setup //
ReplicatedFirst:RemoveDefaultLoadingScreen()-- Immediately removes the default Roblox loading screen. Das what the documentation says.
UIS.MouseIconEnabled = false

Output.Font = Enum.Font.Code
DashButton.Font = Enum.Font.Code
SquareButton.Font = Enum.Font.Code
XButton.Font = Enum.Font.Code
Title.Font = Enum.Font.Code

ScreenGui.Parent = Player:WaitForChild("PlayerGui")
-- // Setup //

-- // Rest of the Code //
-- Title
TerminalFunction.TypeLine(OutputFrame, Output, LoadingConfig.TerminalName)
TerminalFunction.TypeLine(OutputFrame, Output, LoadingConfig.TerminalAuthor )

task.wait(0.4)
-- gap
TerminalFunction.TypeLine(OutputFrame, Output, "")

-- More Text
TerminalFunction.TypeLine(OutputFrame, Output, "C:\\Users\\" .. PlayerName .. "> Initializing...")
TerminalFunction.TypeLine(OutputFrame, Output, "C:\\Users\\" .. PlayerName .. "> Starting Aeternus client...")
TerminalFunction.TypeLine(OutputFrame, Output, "C:\\Users\\" .. PlayerName .. "> Connecting to Aeternal servers...")
TerminalFunction.TypeLine(OutputFrame, Output, "C:\\Users\\" .. PlayerName .. "> Loading Aeternus files...")

local LoadingBar = TerminalFunction.CreateLoadingBar(OutputFrame, Output)

ContentProvider:PreloadAsync(Assets, UpdateProgress())
TerminalFunction.UpdateLoadingBar(OutputFrame, LoadingBar, 100)

task.wait(0.2)

TerminalFunction.FinishLoadingBar(OutputFrame, Output, LoadingBar)

task.wait(0.2)

TerminalFunction.TypeLine(OutputFrame, Output, "C:\\Users\\" .. PlayerName .. "> Verifying files...")
TerminalFunction.TypeLine(OutputFrame, Output, "C:\\Users\\" .. PlayerName .. "> Initializing workspace...")
TerminalFunction.TypeLine(OutputFrame, Output, "C:\\Users\\" .. PlayerName .. "> Launch complete.")
TerminalFunction.TypeLine(OutputFrame, Output, "C:\\Users\\" .. PlayerName .. "> " .. EntryMessage(PlayerName))
TerminalFunction.TypeLine(OutputFrame, Output, "C:\\Users\\" .. PlayerName .. "> Press any key to continue.")
TerminalFunction.TypeLine(OutputFrame, Output, "C:\\Users\\" .. PlayerName .. "> █")




UIS.InputBegan:Connect(function(InputObject)
	
	if InputObject.UserInputType == Enum.UserInputType.Keyboard or 
		InputObject.UserInputType == Enum.UserInputType.MouseButton1 or 
		InputObject.UserInputType == Enum.UserInputType.MouseButton2 or 
		InputObject.UserInputType == Enum.UserInputType.MouseButton3 or  
		InputObject.UserInputType == Enum.UserInputType.Touch then

		EnteredGame = true
		
		UIS.MouseIconEnabled = true

		FadeOut()

	end
	
end)

-- // Rest of the Code //

