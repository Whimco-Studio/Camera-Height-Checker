--[[
--Created Date: Wednesday October 11th 2023 12:15:04 am CEST
--Author: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
-------
--Last Modified: Thursday October 19th 2023 2:10:56 pm CEST
--Modified By: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
--]]
--// Services
local Plugin = script.Parent.Parent.Parent
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--// Interface
local Interface = Plugin.Interface
local InterfaceSignals = require(Plugin.Config.Events.Interface)
local InterfaceSettings = require(Interface.Settings)

--// Util
local Util = Interface.Util
local Tweens = require(Util.Tweens)
local Sounds = require(Util.Sounds)
local Images = require(Util.Images)

--// Packages
local Packages = Plugin.Packages

--// Fusion
local Fusion = require(Packages.Fusion)

--// Fusion Imports
local New = Fusion.New
local Ref = Fusion.Ref
local Out = Fusion.Out
local Value = Fusion.Value
local Tween = Fusion.Tween
local OnEvent = Fusion.OnEvent
local Cleanup = Fusion.Cleanup
local Computed = Fusion.Computed
local Observer = Fusion.Observer
local Children = Fusion.Children

--// Configuration
local Settings = {
	Debug = true,
	Page = "Root",
}

--------------------------------------------------------------------------------
--// Child Components //--
--------------------------------------------------------------------------------

local Home = require(script.Parent.Home)

--------------------------------------------------------------------------------
--// Main Component //--
--------------------------------------------------------------------------------

type RootProps = {}

return function(props: RootProps)
	--// Value States
	local Active = Value(true)

	--// Signals
	RunService:UnbindFromRenderStep("CameraHeightChecker")

	local function CameraHeightChecker()
		if Active:get() then
			RunService:BindToRenderStep("CameraHeightChecker", 0, function(delta: number)
				local Camera = workspace.CurrentCamera
				local CameraHeight = Camera and Camera.CFrame.Position.Y or 0

				local StudsPerMeter = InterfaceSignals:GetState("Ratio"):get() or 1

				InterfaceSignals:SetState("CameraHeight", CameraHeight / StudsPerMeter)
			end)
		else
			RunService:UnbindFromRenderStep("CameraHeightChecker")
		end
	end

	InterfaceSignals:SubscribeToState("Page", function(NewPage: string)
		Active:set(NewPage == Settings.Page)
	end)

	CameraHeightChecker()

	local Root = New("Frame")({
		Name = "Root",
		AnchorPoint = Vector2.new(1, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.975, 0.025),
		Size = UDim2.fromOffset(303, 200),

		Visible = Computed(function()
			return Active:get()
		end),

		[Children] = {
			Home({}),
		},
	})

	return Root
end
