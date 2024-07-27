--// Services
local Plugin = script.Parent.Parent.Parent.Parent
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--// Interface
local Interface = Plugin.Interface
local InterfaceSignals = require(Plugin.Config.Events.Interface)
local InterfaceSettings = require(Interface.Settings)
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
	StartValue: string,
	CallBack: (Text: string) -> (),
}

--// Component
local HeightValue = {}

return function(props: HeightValueProps)
	local InputRef = Value()

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

					New("TextBox")({
						[Ref] = InputRef,
						Name = "TextBox",
						FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json"),
						Text = props.StartValue,
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
						ClearTextOnFocus = true,
						[OnEvent("FocusLost")] = function(Test, Test2)
							local Text = InputRef:get().Text

							if not tonumber(Text) then
								return props.CallBack(tostring(InterfaceSignals:GetState("Ratio"):get()))
							else
								return props.CallBack(Text)
							end
						end,
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
