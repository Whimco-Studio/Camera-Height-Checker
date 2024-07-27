--[[
--Created Date: Wednesday October 11th 2023 12:03:58 am CEST
--Author: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
-------
--Last Modified: Thursday October 19th 2023 1:45:21 pm CEST
--Modified By: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
--]]
--// Services
local Plugin = script.Parent.Parent.Parent
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--// Interface
local Interface = Plugin.Interface
local Interface_Handler = require(Plugin.Config.Events.Interface)
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
	Page = "Home",
}

--------------------------------------------------------------------------------
--// Child Components //--
--------------------------------------------------------------------------------
local Components = Interface.Components
local BaseComponents = Components.Base
local LocalComponents = Components.Home

local ValueLabel = require(LocalComponents.ValueLabel)
local ValueInput = require(LocalComponents.ValueInput)

--------------------------------------------------------------------------------
--// Main Component //--
--------------------------------------------------------------------------------

type HomeProps = {}

return function(props: HomeProps)
	--// Value States
	local Active = Value(false)

	-- Interface_Handler:SubscribeToState(State, function()  end)

	local Home = New("Frame")({
		Name = "Meters",
		AnchorPoint = Vector2.new(0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0, 0),
		Size = UDim2.fromScale(1, 1),

		Visible = true,

		[Children] = {
			New("UIListLayout")({
				Name = "UIListLayout",
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			ValueInput({
				Descriptor = "Studs Per Meter",
				StartValue = Interface_Handler:GetState("Ratio"):get(),
				CallBack = function(Text: string)
					Interface_Handler:GetState("Ratio"):set(tonumber(Text))
				end,
			}),

			ValueLabel({
				Descriptor = "Camera Height",
				Value = Computed(function()
					return math.floor(Interface_Handler:GetState("CameraHeight"):get() + 0.5)
				end),
			}),
		},
	})

	return Home
end
