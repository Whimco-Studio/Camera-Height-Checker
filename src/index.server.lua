--[[
--Created Date: Thursday October 19th 2023 1:22:06 pm CEST
--Author: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
-------
--Last Modified: Thursday October 19th 2023 2:02:00 pm CEST
--Modified By: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
--]]
--// Services
local RunService = game:GetService("RunService")

local toolbar = plugin:CreateToolbar("Plugin Name")
local button = toolbar:CreateButton("Button Name", "", "")

local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float, -- Widget will be initialized in floating panel
	true, -- Widget will be initially enabled
	true, -- Don't override the previous enabled state
	700, -- Default width of the floating window
	500, -- Default height of the floating window
	200, -- Minimum width of the floating window (optional)
	100 -- Minimum height of the floating window (optional)
	-- 700, -- Minimum width of the floating window (optional)
	-- 500, -- Minimum height of the floating window (optional)
)

local DockWidget = plugin:CreateDockWidgetPluginGui("DockWidget", widgetInfo)

if RunService:IsEdit() then
	local Root = require(script.Parent.Interface.Pages.Root)({})

	Root.Parent = DockWidget
end

DockWidget.Title = "Plugin Template"

button.Click:Connect(function()
	DockWidget.Enabled = not DockWidget.Enabled
end)
