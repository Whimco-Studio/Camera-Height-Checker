--[[
--Created Date: Wednesday October 11th 2023 12:14:55 am CEST
--Author: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
-------
--Last Modified: Thursday October 19th 2023 1:13:06 pm CEST
--Modified By: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
--]]
--// Services
local Plugin = script.Parent.Parent.Parent.Parent
local Packages = Plugin.Packages

--// Pages
local Components = Plugin.Interface.Components
local Pages = Plugin.Interface.Pages

local RootFrame = require(Pages.Root)()

return function(target: Frame)
	RootFrame.Parent = target
	return function()
		RootFrame:Destroy()
	end
end
