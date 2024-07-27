--[[
HeightValue

    A short description of the module.

SYNOPSIS

    -- Lua code that showcases an overview of the API.
    local foobar = HeightValue.TopLevel('foo')
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

-- Implementation of HeightValue.

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Modules
local Fusion = require(script.Parent.Parent.Parent.Parent.Packages.Fusion)

--// Fusion
local New = Fusion.New
local Ref = Fusion.Ref
local Out = Fusion.Out
local Value = Fusion.Value
local Tween = Fusion.Tween
local Cleanup = Fusion.Cleanup
local OnEvent = Fusion.OnEvent
local Computed = Fusion.Computed
local Observer = Fusion.Observer
local Children = Fusion.Children

--// Props
type HeightValueProps = {
	Descriptor: string,
	Value: string,
}

--// Component
local HeightValue = {}

return function(props: HeightValueProps)
	return New("Frame")({
		Name = "HeightValue",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 50),

		[Children] = {
			New("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			New("ImageLabel")({
				Name = "Height",
				Image = "rbxassetid://18671506233",
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Position = UDim2.fromScale(0.5, 0),
				Size = UDim2.fromScale(1.5, 1.5),

				[Children] = {
					New("UIAspectRatioConstraint")({
						Name = "UIAspectRatioConstraint",
						AspectRatio = 1.68,
					}),

					New("TextLabel")({
						Name = "TextLabel",
						FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json"),
						Text = props.Value,
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextScaled = true,
						TextSize = 14,
						TextWrapped = true,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(0.5, 0.409),
						Size = UDim2.fromScale(0.4, 0.317),
					}),
				},
			}),

			New("Frame")({
				Name = "Clamper",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.fromScale(0.584, 1.05),

				[Children] = {
					New("TextLabel")({
						Name = props.Descriptor,
						FontFace = Font.new(
							"rbxasset://fonts/families/FredokaOne.json",
							Enum.FontWeight.Bold,
							Enum.FontStyle.Normal
						),
						Text = props.Descriptor,
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextScaled = true,
						TextSize = 14,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Right,
						TextYAlignment = Enum.TextYAlignment.Bottom,
						AnchorPoint = Vector2.new(0, 1),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(0, 0.9),
						Size = UDim2.fromScale(1, 0.543),
					}),
				},
			}),
		},
	})
end
