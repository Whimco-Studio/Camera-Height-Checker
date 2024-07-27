--[[
--Created Date: Thursday October 19th 2023 1:22:06 pm CEST
--Author: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
-------
--Last Modified: Thursday October 19th 2023 2:02:00 pm CEST
--Modified By: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
--]]
--// Services
local RunService = game:GetService("RunService")

local toolbar = plugin:CreateToolbar("Meter Counter")
local button = toolbar:CreateButton("Meter Counter", "", "")

local Handler = require(script.Parent.Config.Events.Interface)

if RunService:IsEdit() then
	local Root = require(script.Parent.Interface.Pages.Root)({})

	local CoreGui = game:GetService("CoreGui")
	local ScreenGui = CoreGui:FindFirstChild("MetersCounter") :: ScreenGui or Instance.new("ScreenGui")

	for _, v in ScreenGui:GetChildren() do
		v:Destroy()
	end

	ScreenGui.Name = "MetersCounter"
	ScreenGui.Enabled = false

	Root.Parent = ScreenGui

	ScreenGui.Parent = CoreGui

	button.Click:Connect(function()
		ScreenGui.Enabled = not ScreenGui.Enabled
	end)
end
