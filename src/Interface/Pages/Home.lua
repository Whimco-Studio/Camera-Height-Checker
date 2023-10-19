--[[
--Created Date: Wednesday October 11th 2023 12:03:58 am CEST
--Author: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
-------
--Last Modified: Thursday October 19th 2023 1:45:21 pm CEST
--Modified By: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
--]]
--// Services
local Plugin = script.Parent.Parent.Parent.Parent.Plugin
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
	Page = "Home",
}

--------------------------------------------------------------------------------
--// Child Components //--
--------------------------------------------------------------------------------
local Components = Interface.Components
local BaseComponents = Components.Base
local LocalComponents = Components.Home

--------------------------------------------------------------------------------
--// Main Component //--
--------------------------------------------------------------------------------

type HomeProps = {
	Id: number,
	Delay: number,
	Price: number,
}

return function(props: HomeProps)
	--// Value States
	local Active = Value(false)

	--// Signals
	InterfaceSignals:SubscribeToState("Page", function(NewPage: string)
		Active:set(NewPage == Settings.Page)
	end)

	--// Debugging
	if InterfaceSettings.AutoActive == Settings.Page then
		task.delay(0, function()
			Active:set(true)
		end)
	end

	local Home = New("Frame")({
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Visible = Computed(function()
			return Active:get()
		end),

		[Children] = {},
	})

	return Home
end
