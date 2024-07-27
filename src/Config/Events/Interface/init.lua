--[[
--Created Date: Monday October 2nd 2023 11:36:49 am CEST
--Author: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
-------
--Last Modified: Thursday October 19th 2023 2:01:07 pm CEST
--Modified By: Trendon Robinson at <The_Pr0fessor (Rbx), @TPr0fessor (Twitter)>
--]]
--[[
Interface

    The Interface module provides a unified approach to managing interface-related events, states, and their interactions in Roblox using Fusion. It provides functionalities like fetching BindableEvents, managing states, subscribing to state changes, and more.

SYNOPSIS

    local interfaceInstance = Interface.new()
    local mainPageState = interfaceInstance:GetState("Page")
    print(mainPageState:get())

DESCRIPTION

    The Interface module is built to provide a clear structure for managing interface-related events and states in Roblox. It leverages Fusion for state management and provides hooks for interfacing with BindableEvents and state changes. The module ensures that any subscribed events are cleaned up properly and provides a consistent API for interfacing with both states and events.

API

    function Interface.new(): Interface
    Creates a new Interface instance with default states and events.

    function Interface:Init()
    Initializes the Interface instance, generally by setting up necessary state listeners.

    function Interface:ListenToStates()
    Sets up observers for all the states in the interface to listen to state changes.

    function Interface:GetEvent(SignalName: string): BindableEvent
    Fetches a BindableEvent by its name from the Interface.

    function Interface:GetState(StateName: string): Fusion.Value<any>
    Fetches the state by its name from the Interface.

    function Interface:SetState(StateName: string, Value)
    Sets the value of a specific state in the Interface.

    function Interface:SubscribeToState(StateName: string, callback: function)
    Hooks an event listener to a specific state to listen for its changes.

    function Interface:Subscribe(SignalName: string, callback: function)
    Hooks an event listener to a specific BindableEvent to execute a callback when the event is triggered.

    function Interface:Fire(SignalName: string, ...any)
    Fires a specific BindableEvent with the provided arguments.

    function Interface:DoCleaning()
    Cleans up all tasks and listeners associated with the Interface to ensure no memory leaks.

    function Interface:Destroy()
    Completely destroys the Interface instance, disconnecting all events and clearing the object.

]]

-- Implementation of Interface.

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Plugin
local Plugin = script.Parent.Parent.Parent

--// Fusion
local Fusion = require(Plugin.Packages.Fusion)
local Value = Fusion.Value
local Observer = Fusion.Observer

--// Maid
local Maid = require(Plugin.Packages.Maid)

--// Class
local Interface = {}
Interface.__index = Interface

---
-- @description Constructs a new Interface object.
-- @return Interface - The newly created Interface instance.
--
function Interface.new()
	local info = {
		--// External

		--// Internal

		--// States
		States = {
			Page = Value("Root"),
			Ratio = Value(4),
			CameraHeight = Value(4),
		},

		--// State Subscriptions
		StateSubscriptions = {
			Page = {},
		},

		--// CleanUp
		_maid = Maid.new(),
	}

	setmetatable(info, Interface):Init()

	return info
end

---
-- @description Initializes the Interface.
--
function Interface:Init()
	-- self:ListenToStates()
end

---
-- @description Adds Observers for the States in the Interface.
--
function Interface:ListenToStates()
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
-- @description Fetches a desired BindableEvent from the Interface.
-- @param SignalName string - The name of the BindableEvent to fetch.
-- @return BindableEvent - The fetched BindableEvent.
--
function Interface:GetEvent(SignalName: string): BindableEvent
	local DesiredSignal: BindableEvent = self[SignalName]
	assert(DesiredSignal, "Bindable Event `" .. SignalName .. "` does not exist")

	return DesiredSignal
end

---
-- @description Fetches a desired State from the Interface.
-- @param StateName string - The name of the State to fetch.
-- @return Fusion.Value<any> - The fetched State.
--

function Interface:GetState(StateName: string): Fusion.Value<any>
	local DesiredState: Fusion.Value<any> = self.States[StateName]
	assert(DesiredState, "State `" .. StateName .. "` does not exist")

	return DesiredState
end

---
-- @description Sets a state value in the Interface.
-- @param StateName string - The name of the State to set.
-- @param Value any - The value to set the state to.
--
function Interface:SetState(StateName: string, Value): Fusion.Value<any>
	local DesiredState: Fusion.Value<any> = self:GetState(StateName)
	DesiredState:set(Value)
end

---
-- @description Hooks an event listener to a desired State.
-- @param StateName string - The name of the State to hook.
-- @param callback function - The function to execute when the event is triggered.
--
function Interface:SubscribeToState(State: string, callback: () -> nil)
	local DesiredState: Fusion.Value<any> = self:GetState(State)
	local StateSubscriptions = self.StateSubscriptions[State] or {}

	table.insert(StateSubscriptions, callback)
end

---
-- @description Hooks an event listener to a desired BindableEvent.
-- @param SignalName string - The name of the BindableEvent to hook.
-- @param callback function - The function to execute when the event is triggered.
--
function Interface:Subscribe(SignalName: string, callback: () -> nil)
	local DesiredSignal: BindableEvent = self:GetEvent(SignalName)
	self._maid:GiveTask(DesiredSignal.Event:Connect(callback))
end

---
-- @description Fires a BindableEvent with the provided arguments.
-- @param SignalName string - The name of the BindableEvent to fire.
-- @param ... any - The arguments to pass when firing the event.
--
function Interface:Fire(SignalName: string, ...)
	local DesiredSignal: BindableEvent = self:GetEvent(SignalName)
	DesiredSignal:Fire(...)
end

---
-- @description Cleans up all tasks and listeners associated with the Interface.
--
function Interface:DoCleaning()
	self._maid:Cleanup()
end

return Interface.new()
