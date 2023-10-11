--[[
--Created Date: Wednesday October 11th 2023 12:09:40 am CEST
--Author: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
-------
--Last Modified: Wednesday October 11th 2023 12:09:44 am CEST
--Modified By: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
--]]
--[[
BaseClass

    A short description of the module.

SYNOPSIS

    -- Lua code that showcases an overview of the API.
    local foobar = BaseClass.TopLevel('foo')
    print(foobar.Thing)

DESCRIPTION

    A detailed description of the module.

API

    -- Describes each API item using Luau type declarations.

    -- Top-level functions use the function declaration syntax.
    function ModuleName.TopLevel(thing: string): Foobar

    -- A description of Foobar.
    type Foobar = {

        -- A description of the Thing member.
        Thing: string,

        -- Each distinct item in the API is separated by \n\n.
        Member: string,

    }
]]

-- Implementation of BaseClass.

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Class
local BaseClass = {}
BaseClass.__index = BaseClass

function BaseClass.new()
	local info = {
		Connections = {},
	}
	setmetatable(info, BaseClass)
	return info
end

function BaseClass:Init() end

function BaseClass:Disconnect()
	for _, c: RBXScriptConnection in pairs(self.Connections) do
		c:Disconnect()
	end
end

function BaseClass:Destroy()
	self:Disconnect()

	setmetatable(self, nil)
	table.clear(self)
	table.freeze(self)
end

return BaseClass
