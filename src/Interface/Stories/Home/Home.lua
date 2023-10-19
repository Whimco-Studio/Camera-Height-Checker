--[[
--Created Date: Wednesday October 11th 2023 12:10:29 am CEST
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

local HomeFrame = require(Pages.Home)()

return function(target: Frame)
	HomeFrame.Parent = target
	return function()
		HomeFrame:Destroy()
	end
end
