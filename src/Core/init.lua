--[[
--Created Date: Monday October 2nd 2023 11:36:49 am CEST
--Author: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
-------
--Last Modified: Wednesday October 11th 2023 12:02:09 am CEST
--Modified By: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
--]]
--[[
Core

    The Core module provides a unified approach to managing Core-related events, states, and their interactions in Roblox using Fusion. It provides functionalities like fetching BindableEvents, managing states, subscribing to state changes, and more.

SYNOPSIS

    local CoreInstance = Core.new()
    local mainPageState = CoreInstance:GetState("Page")
    print(mainPageState:get())

DESCRIPTION

    The Core module is built to provide a clear structure for managing Core-related events and states in Roblox. It leverages Fusion for state management and provides hooks for interfacing with BindableEvents and state changes. The module ensures that any subscribed events are cleaned up properly and provides a consistent API for interfacing with both states and events.

API

    function Core.new(): Core
    Creates a new Core instance with default states and events.

    function Core:Init()
    Initializes the Core instance, generally by setting up necessary state listeners.

    function Core:ListenToStates()
    Sets up observers for all the states in the Core to listen to state changes.

    function Core:GetEvent(SignalName: string): BindableEvent
    Fetches a BindableEvent by its name from the Core.

    function Core:GetState(StateName: string): Fusion.Value<any>
    Fetches the state by its name from the Core.

    function Core:SetState(StateName: string, Value)
    Sets the value of a specific state in the Core.

    function Core:SubscribeToState(StateName: string, callback: function)
    Hooks an event listener to a specific state to listen for its changes.

    function Core:Subscribe(SignalName: string, callback: function)
    Hooks an event listener to a specific BindableEvent to execute a callback when the event is triggered.

    function Core:Fire(SignalName: string, ...any)
    Fires a specific BindableEvent with the provided arguments.

    function Core:DoCleaning()
    Cleans up all tasks and listeners associated with the Core to ensure no memory leaks.

    function Core:Destroy()
    Completely destroys the Core instance, disconnecting all events and clearing the object.

]]

-- Implementation of Core.

--// Services
local Plugin = script.Parent

--// Fusion
local Fusion = require(Plugin.Packages.Fusion)
local Value = Fusion.Value
local Observer = Fusion.Observer

--// Maid
local Maid = require(Plugin.Packages.Maid)

--// Types

--// Class
local Core = {}
Core.__index = Core

---
-- @description Constructs a new Core object.
-- @return Core - The newly created Core instance.
--
function Core.new()
	local info = {
		--// External

		--// States
		States = {},

		--// State Subscriptions
		StateSubscriptions = {},

		--// CleanUp
		_maid = Maid.new(),
	}

	setmetatable(info, Core):Init()

	return info
end

---
-- @description Initializes the Core.
--
function Core:Init()
	self:ListenToStates()
end

---
-- @description Adds Observers for the States in the Core.
--
function Core:ListenToStates()
	-- Adding Observers
	for StateName, State: Fusion.Value<any> in pairs(self.States) do
		--// LocalStateSubscriptions
		local StateSubscriptions = self.StateSubscriptions[StateName]

		local observer = Observer(State)
		self._maid:GiveTask(observer:onChange(function()
			for _, Callback: () -> nil in pairs(StateSubscriptions) do
				Callback(State:get())
			end
		end))
	end
end

---
-- @description Fetches a desired BindableEvent from the Core.
-- @param SignalName string - The name of the BindableEvent to fetch.
-- @return BindableEvent - The fetched BindableEvent.
--
function Core:GetEvent(SignalName: string): BindableEvent
	local DesiredSignal: BindableEvent = self[SignalName]
	assert(DesiredSignal, "Bindable Event `" .. SignalName .. "` does not exist")

	return DesiredSignal
end

---
-- @description Fetches a desired State from the Core.
-- @param StateName string - The name of the State to fetch.
-- @return Fusion.Value<any> - The fetched State.
--

function Core:GetState(StateName: string): Fusion.Value<any>
	local DesiredState: Fusion.Value<any> = self.States[StateName]
	assert(DesiredState, "State `" .. StateName .. "` does not exist")

	return DesiredState
end

---
-- @description Sets a state value in the Core.
-- @param StateName string - The name of the State to set.
-- @param Value any - The value to set the state to.
--
function Core:SetState(StateName: string, Value): Fusion.Value<any>
	local DesiredState: Fusion.Value<any> = self:GetState(StateName)
	DesiredState:set(Value)
end

---
-- @description Hooks an event listener to a desired State.
-- @param StateName string - The name of the State to hook.
-- @param callback function - The function to execute when the event is triggered.
--
function Core:SubscribeToState(State: string, callback: () -> nil)
	local DesiredState: Fusion.Value<any> = self:GetState(State)
	local StateSubscriptions = self.StateSubscriptions[State] or {}

	table.insert(StateSubscriptions, callback)
end

---
-- @description Hooks an event listener to a desired BindableEvent.
-- @param SignalName string - The name of the BindableEvent to hook.
-- @param callback function - The function to execute when the event is triggered.
--
function Core:Subscribe(SignalName: string, callback: () -> nil)
	local DesiredSignal: BindableEvent = self:GetEvent(SignalName)
	self._maid:GiveTask(DesiredSignal.Event:Connect(callback))
end

---
-- @description Fires a BindableEvent with the provided arguments.
-- @param SignalName string - The name of the BindableEvent to fire.
-- @param ... any - The arguments to pass when firing the event.
--
function Core:Fire(SignalName: string, ...)
	local DesiredSignal: BindableEvent = self:GetEvent(SignalName)
	DesiredSignal:Fire(...)
end

---
-- @description Cleans up all tasks and listeners associated with the Core.
--
function Core:DoCleaning()
	self._maid:Cleanup()
end

return Core.new()
