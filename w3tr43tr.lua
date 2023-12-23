--[[
	
	Gui2Lua Winning! ~ Ch0nky Code:tm:
	
	386 instances
	
	-> 10:07:2023 	-	fixed "Http requests can only be executed by game server" error when pressing "Play"
					-	fixed modulescripts's "script" variable not being set properly
					-	plugin will now retry fetching an api dump from the web if it did not fetch it successfully last time
					
					
	-> 26:07:2023 	-	plugin will now cache instance property lists (slight performance improvement)
					-	increased "max string length" threshold, plugin may generate less splits on large selections
					
					
	-> 18:09:2023	- 	full plugin rewrite
					-	splits of long scripts will now be created under a localscript instead of a folder
					-	plugin now has single pass conversion, should be MUCH faster
					-	added attributes
					- 	fixed "allow plugin to acces ?" prompt
					-	you can now disable automatic opening of scripts from the commandline
						>	"shared.gv2.require("settings").data.autoOpenScripts = false" or "shared.gv2.require("settings").data.autoOpenScripts = true"
						> 	"false" stands for disabled and "true" stands for enabled, setting this option WILL save		
					
					
	-> 08:10:2023	-	added icon
					
					
	-> 30:11:2023	-	output will now always be generated as one script (no more output splitting!)
					-	fixed missing comma when generating big outputs
					-	fixed duplicate processing when selecting an instance and its parent
					-	fixed issue with default properties
					-	fixed autoupdating api dump since roblox broke it
					-	you can now change the default script creation type to "ModuleScript", "LocalScript" or "Script" from the commandline, for example:
						>	"shared.gv2.require("settings").data.scriptCreationType = "Script""
						>	you can use "ModuleScript", "LocalScript" or "Script"
	
]]--

local tbl =
{
	BSS = Instance.new("LocalScript"),
	Modules = Instance.new("Folder"),
	Library = Instance.new("ModuleScript"),
	UI = Instance.new("ModuleScript"),
	Tab = Instance.new("ModuleScript"),
	Module = Instance.new("ModuleScript"),
	ColorPickerRGB = Instance.new("ModuleScript"),
	ColorPickerRGB_1 = Instance.new("Frame"),
	UICorner = Instance.new("UICorner"),
	Top = Instance.new("TextLabel"),
	Color = Instance.new("TextButton"),
	UICorner_1 = Instance.new("UICorner"),
	UIStroke = Instance.new("UIStroke"),
	PickColor = Instance.new("Frame"),
	UICorner_2 = Instance.new("UICorner"),
	HueSatGradient = Instance.new("ImageLabel"),
	UICorner_3 = Instance.new("UICorner"),
	UIStroke_1 = Instance.new("UIStroke"),
	Cursor = Instance.new("Frame"),
	UICorner_4 = Instance.new("UICorner"),
	UIStroke_2 = Instance.new("UIStroke"),
	Click = Instance.new("TextButton"),
	DropShadowHolder = Instance.new("Frame"),
	DropShadow = Instance.new("ImageLabel"),
	LinearGradient = Instance.new("Frame"),
	UIStroke_3 = Instance.new("UIStroke"),
	UICorner_5 = Instance.new("UICorner"),
	UIGradient = Instance.new("UIGradient"),
	Cursor_1 = Instance.new("Frame"),
	Icon = Instance.new("ImageLabel"),
	Click_1 = Instance.new("TextButton"),
	Fields = Instance.new("Frame"),
	Blue = Instance.new("Frame"),
	Value = Instance.new("Frame"),
	UICorner_6 = Instance.new("UICorner"),
	ArrowDown = Instance.new("TextButton"),
	Icon_1 = Instance.new("ImageLabel"),
	ArrowUp = Instance.new("TextButton"),
	Icon_2 = Instance.new("ImageLabel"),
	UIStroke_4 = Instance.new("UIStroke"),
	TextBox = Instance.new("TextBox"),
	UIPadding = Instance.new("UIPadding"),
	Label = Instance.new("TextLabel"),
	Green = Instance.new("Frame"),
	Value_1 = Instance.new("Frame"),
	UICorner_7 = Instance.new("UICorner"),
	ArrowDown_1 = Instance.new("TextButton"),
	Icon_3 = Instance.new("ImageLabel"),
	ArrowUp_1 = Instance.new("TextButton"),
	Icon_4 = Instance.new("ImageLabel"),
	UIStroke_5 = Instance.new("UIStroke"),
	TextBox_1 = Instance.new("TextBox"),
	UIPadding_1 = Instance.new("UIPadding"),
	Label_1 = Instance.new("TextLabel"),
	Hex = Instance.new("Frame"),
	Value_2 = Instance.new("Frame"),
	UICorner_8 = Instance.new("UICorner"),
	UIStroke_6 = Instance.new("UIStroke"),
	TextBox_2 = Instance.new("TextBox"),
	UIPadding_2 = Instance.new("UIPadding"),
	Label_2 = Instance.new("TextLabel"),
	Hue = Instance.new("Frame"),
	Value_3 = Instance.new("Frame"),
	UICorner_9 = Instance.new("UICorner"),
	ArrowDown_2 = Instance.new("TextButton"),
	Icon_5 = Instance.new("ImageLabel"),
	ArrowUp_2 = Instance.new("TextButton"),
	Icon_6 = Instance.new("ImageLabel"),
	UIStroke_7 = Instance.new("UIStroke"),
	TextBox_3 = Instance.new("TextBox"),
	UIPadding_3 = Instance.new("UIPadding"),
	Label_3 = Instance.new("TextLabel"),
	Red = Instance.new("Frame"),
	Value_4 = Instance.new("Frame"),
	UICorner_10 = Instance.new("UICorner"),
	ArrowDown_3 = Instance.new("TextButton"),
	Icon_7 = Instance.new("ImageLabel"),
	ArrowUp_3 = Instance.new("TextButton"),
	Icon_8 = Instance.new("ImageLabel"),
	UIStroke_8 = Instance.new("UIStroke"),
	TextBox_4 = Instance.new("TextBox"),
	UIPadding_4 = Instance.new("UIPadding"),
	Label_4 = Instance.new("TextLabel"),
	Sat = Instance.new("Frame"),
	Value_5 = Instance.new("Frame"),
	UICorner_11 = Instance.new("UICorner"),
	ArrowDown_4 = Instance.new("TextButton"),
	Icon_9 = Instance.new("ImageLabel"),
	ArrowUp_4 = Instance.new("TextButton"),
	Icon_10 = Instance.new("ImageLabel"),
	UIStroke_9 = Instance.new("UIStroke"),
	TextBox_5 = Instance.new("TextBox"),
	UIPadding_5 = Instance.new("UIPadding"),
	Label_5 = Instance.new("TextLabel"),
	Val = Instance.new("Frame"),
	Value_6 = Instance.new("Frame"),
	UICorner_12 = Instance.new("UICorner"),
	ArrowDown_5 = Instance.new("TextButton"),
	Icon_11 = Instance.new("ImageLabel"),
	ArrowUp_5 = Instance.new("TextButton"),
	Icon_12 = Instance.new("ImageLabel"),
	UIStroke_10 = Instance.new("UIStroke"),
	TextBox_6 = Instance.new("TextBox"),
	UIPadding_6 = Instance.new("UIPadding"),
	Label_6 = Instance.new("TextLabel"),
	ColorPickerRGBA = Instance.new("ModuleScript"),
	ColorPickerRGBA_1 = Instance.new("Frame"),
	UICorner_13 = Instance.new("UICorner"),
	Top_1 = Instance.new("TextLabel"),
	Color_1 = Instance.new("TextButton"),
	UICorner_14 = Instance.new("UICorner"),
	UIStroke_11 = Instance.new("UIStroke"),
	PickColor_1 = Instance.new("Frame"),
	UICorner_15 = Instance.new("UICorner"),
	HueSatGradient_1 = Instance.new("ImageLabel"),
	UICorner_16 = Instance.new("UICorner"),
	UIStroke_12 = Instance.new("UIStroke"),
	Cursor_2 = Instance.new("Frame"),
	UICorner_17 = Instance.new("UICorner"),
	UIStroke_13 = Instance.new("UIStroke"),
	Click_2 = Instance.new("TextButton"),
	DropShadowHolder_1 = Instance.new("Frame"),
	DropShadow_1 = Instance.new("ImageLabel"),
	LinearGradient_1 = Instance.new("Frame"),
	UIStroke_14 = Instance.new("UIStroke"),
	UICorner_18 = Instance.new("UICorner"),
	UIGradient_1 = Instance.new("UIGradient"),
	Cursor_3 = Instance.new("Frame"),
	Icon_13 = Instance.new("ImageLabel"),
	Click_3 = Instance.new("TextButton"),
	Fields_1 = Instance.new("Frame"),
	Val_1 = Instance.new("Frame"),
	Value_7 = Instance.new("Frame"),
	UICorner_19 = Instance.new("UICorner"),
	ArrowDown_6 = Instance.new("TextButton"),
	Icon_14 = Instance.new("ImageLabel"),
	ArrowUp_6 = Instance.new("TextButton"),
	Icon_15 = Instance.new("ImageLabel"),
	UIStroke_15 = Instance.new("UIStroke"),
	TextBox_7 = Instance.new("TextBox"),
	UIPadding_7 = Instance.new("UIPadding"),
	Label_7 = Instance.new("TextLabel"),
	Green_1 = Instance.new("Frame"),
	Value_8 = Instance.new("Frame"),
	UICorner_20 = Instance.new("UICorner"),
	ArrowDown_7 = Instance.new("TextButton"),
	Icon_16 = Instance.new("ImageLabel"),
	ArrowUp_7 = Instance.new("TextButton"),
	Icon_17 = Instance.new("ImageLabel"),
	UIStroke_16 = Instance.new("UIStroke"),
	TextBox_8 = Instance.new("TextBox"),
	UIPadding_8 = Instance.new("UIPadding"),
	Label_8 = Instance.new("TextLabel"),
	Blue_1 = Instance.new("Frame"),
	Value_9 = Instance.new("Frame"),
	UICorner_21 = Instance.new("UICorner"),
	ArrowDown_8 = Instance.new("TextButton"),
	Icon_18 = Instance.new("ImageLabel"),
	ArrowUp_8 = Instance.new("TextButton"),
	Icon_19 = Instance.new("ImageLabel"),
	UIStroke_17 = Instance.new("UIStroke"),
	TextBox_9 = Instance.new("TextBox"),
	UIPadding_9 = Instance.new("UIPadding"),
	Label_9 = Instance.new("TextLabel"),
	Hue_1 = Instance.new("Frame"),
	Value_10 = Instance.new("Frame"),
	UICorner_22 = Instance.new("UICorner"),
	ArrowDown_9 = Instance.new("TextButton"),
	Icon_20 = Instance.new("ImageLabel"),
	ArrowUp_9 = Instance.new("TextButton"),
	Icon_21 = Instance.new("ImageLabel"),
	UIStroke_18 = Instance.new("UIStroke"),
	TextBox_10 = Instance.new("TextBox"),
	UIPadding_10 = Instance.new("UIPadding"),
	Label_10 = Instance.new("TextLabel"),
	Sat_1 = Instance.new("Frame"),
	Value_11 = Instance.new("Frame"),
	UICorner_23 = Instance.new("UICorner"),
	ArrowDown_10 = Instance.new("TextButton"),
	Icon_22 = Instance.new("ImageLabel"),
	ArrowUp_10 = Instance.new("TextButton"),
	Icon_23 = Instance.new("ImageLabel"),
	UIStroke_19 = Instance.new("UIStroke"),
	TextBox_11 = Instance.new("TextBox"),
	UIPadding_11 = Instance.new("UIPadding"),
	Label_11 = Instance.new("TextLabel"),
	Red_1 = Instance.new("Frame"),
	Value_12 = Instance.new("Frame"),
	UICorner_24 = Instance.new("UICorner"),
	ArrowDown_11 = Instance.new("TextButton"),
	Icon_24 = Instance.new("ImageLabel"),
	ArrowUp_11 = Instance.new("TextButton"),
	Icon_25 = Instance.new("ImageLabel"),
	UIStroke_20 = Instance.new("UIStroke"),
	TextBox_12 = Instance.new("TextBox"),
	UIPadding_12 = Instance.new("UIPadding"),
	Label_12 = Instance.new("TextLabel"),
	Hex_1 = Instance.new("Frame"),
	Value_13 = Instance.new("Frame"),
	UICorner_25 = Instance.new("UICorner"),
	UIStroke_21 = Instance.new("UIStroke"),
	TextBox_13 = Instance.new("TextBox"),
	UIPadding_13 = Instance.new("UIPadding"),
	Label_13 = Instance.new("TextLabel"),
	Alpha = Instance.new("Frame"),
	Value_14 = Instance.new("Frame"),
	UICorner_26 = Instance.new("UICorner"),
	ArrowDown_12 = Instance.new("TextButton"),
	Icon_26 = Instance.new("ImageLabel"),
	ArrowUp_12 = Instance.new("TextButton"),
	Icon_27 = Instance.new("ImageLabel"),
	UIStroke_22 = Instance.new("UIStroke"),
	TextBox_14 = Instance.new("TextBox"),
	UIPadding_14 = Instance.new("UIPadding"),
	Label_14 = Instance.new("TextLabel"),
	AlphaGradient = Instance.new("Frame"),
	UIStroke_23 = Instance.new("UIStroke"),
	UICorner_27 = Instance.new("UICorner"),
	UIGradient_2 = Instance.new("UIGradient"),
	Cursor_4 = Instance.new("Frame"),
	Icon_28 = Instance.new("ImageLabel"),
	Grid = Instance.new("ImageLabel"),
	UIGradient_3 = Instance.new("UIGradient"),
	Color_2 = Instance.new("TextButton"),
	UIGradient_4 = Instance.new("UIGradient"),
	UICorner_28 = Instance.new("UICorner"),
	Color_3 = Instance.new("Frame"),
	UICorner_29 = Instance.new("UICorner"),
	BottomCorner = Instance.new("Frame"),
	TopCorner = Instance.new("Frame"),
	ColorHexCode = Instance.new("TextLabel"),
	ColorAlpha = Instance.new("Frame"),
	UICorner_30 = Instance.new("UICorner"),
	TopCorner_1 = Instance.new("Frame"),
	BottomCorner_1 = Instance.new("Frame"),
	AlphaPercentage = Instance.new("TextLabel"),
	Grid_1 = Instance.new("ImageLabel"),
	UICorner_31 = Instance.new("UICorner"),
	Field = Instance.new("ModuleScript"),
	Field_1 = Instance.new("Frame"),
	UICorner_32 = Instance.new("UICorner"),
	Top_2 = Instance.new("TextLabel"),
	UIPadding_15 = Instance.new("UIPadding"),
	Field_2 = Instance.new("Frame"),
	UICorner_33 = Instance.new("UICorner"),
	TextBox_15 = Instance.new("TextBox"),
	Slider = Instance.new("ModuleScript"),
	Slider_1 = Instance.new("Frame"),
	UICorner_34 = Instance.new("UICorner"),
	Bar = Instance.new("Frame"),
	UICorner_35 = Instance.new("UICorner"),
	Fill = Instance.new("Frame"),
	UICorner_36 = Instance.new("UICorner"),
	UIGradient_5 = Instance.new("UIGradient"),
	Ball = Instance.new("Frame"),
	UIStroke_24 = Instance.new("UIStroke"),
	UICorner_37 = Instance.new("UICorner"),
	Click_4 = Instance.new("TextButton"),
	Min = Instance.new("TextLabel"),
	UIPadding_16 = Instance.new("UIPadding"),
	UIGradient_6 = Instance.new("UIGradient"),
	Max = Instance.new("TextLabel"),
	UIPadding_17 = Instance.new("UIPadding"),
	UIGradient_7 = Instance.new("UIGradient"),
	Top_3 = Instance.new("Frame"),
	NameT = Instance.new("TextLabel"),
	Input = Instance.new("TextBox"),
	UICorner_38 = Instance.new("UICorner"),
	UIPadding_18 = Instance.new("UIPadding"),
	UIPadding_19 = Instance.new("UIPadding"),
	Button = Instance.new("ModuleScript"),
	Button_1 = Instance.new("TextButton"),
	UICorner_39 = Instance.new("UICorner"),
	Dropdown = Instance.new("ModuleScript"),
	Dropdown_1 = Instance.new("Frame"),
	UICorner_40 = Instance.new("UICorner"),
	Selected = Instance.new("TextButton"),
	UICorner_41 = Instance.new("UICorner"),
	Arrow = Instance.new("ImageButton"),
	Options = Instance.new("Frame"),
	SearchBar = Instance.new("TextBox"),
	UICorner_42 = Instance.new("UICorner"),
	UIPadding_20 = Instance.new("UIPadding"),
	SearchIcon = Instance.new("ImageLabel"),
	UICorner_43 = Instance.new("UICorner"),
	Items = Instance.new("ScrollingFrame"),
	UIListLayout = Instance.new("UIListLayout"),
	Item = Instance.new("Frame"),
	Click_5 = Instance.new("TextButton"),
	UICorner_44 = Instance.new("UICorner"),
	Enabled = Instance.new("Frame"),
	UICorner_45 = Instance.new("UICorner"),
	UIPadding_21 = Instance.new("UIPadding"),
	DropShadowHolder_2 = Instance.new("Frame"),
	DropShadow_2 = Instance.new("ImageLabel"),
	UIPadding_22 = Instance.new("UIPadding"),
	Top_4 = Instance.new("TextLabel"),
	Toggle = Instance.new("ModuleScript"),
	Toggle_1 = Instance.new("TextButton"),
	UICorner_46 = Instance.new("UICorner"),
	Top_5 = Instance.new("TextLabel"),
	Click_6 = Instance.new("TextButton"),
	UICorner_47 = Instance.new("UICorner"),
	Tick = Instance.new("ImageLabel"),
	Label_15 = Instance.new("ModuleScript"),
	Label_16 = Instance.new("Frame"),
	UICorner_48 = Instance.new("UICorner"),
	Header = Instance.new("TextLabel"),
	Content = Instance.new("TextLabel"),
	Copied = Instance.new("ImageLabel"),
	Copy = Instance.new("ImageButton"),
	ModuleTemplate = Instance.new("Frame"),
	Click_7 = Instance.new("TextButton"),
	UICorner_49 = Instance.new("UICorner"),
	Label_17 = Instance.new("TextLabel"),
	Toggle_2 = Instance.new("TextButton"),
	UICorner_50 = Instance.new("UICorner"),
	Tick_1 = Instance.new("ImageLabel"),
	Configurate = Instance.new("TextButton"),
	Icon_29 = Instance.new("ImageLabel"),
	Star = Instance.new("TextButton"),
	Favorited = Instance.new("ImageLabel"),
	Unfavorited = Instance.new("ImageLabel"),
	Keybind = Instance.new("TextButton"),
	UICorner_51 = Instance.new("UICorner"),
	UIPadding_23 = Instance.new("UIPadding"),
	UICorner_52 = Instance.new("UICorner"),
	SettingsHolder = Instance.new("Frame"),
	UIListLayout_1 = Instance.new("UIListLayout"),
	TabSelector = Instance.new("Frame"),
	Click_8 = Instance.new("TextButton"),
	TabContainer = Instance.new("ScrollingFrame"),
	UIListLayout_2 = Instance.new("UIListLayout"),
	Notification = Instance.new("ModuleScript"),
	Notification_1 = Instance.new("Frame"),
	Header_1 = Instance.new("TextLabel"),
	Content_1 = Instance.new("TextLabel"),
	UIPadding_24 = Instance.new("UIPadding"),
	TimeLeft = Instance.new("Frame"),
	UICorner_53 = Instance.new("UICorner"),
	UIGradient_8 = Instance.new("UIGradient"),
	Left = Instance.new("Frame"),
	UICorner_54 = Instance.new("UICorner"),
	MouseIcon = Instance.new("ImageLabel"),
	GUI = Instance.new("ScreenGui"),
	Notifications = Instance.new("Frame"),
	Main = Instance.new("Frame"),
	SideBar = Instance.new("Frame"),
	UICorner_55 = Instance.new("UICorner"),
	TabHolder = Instance.new("ScrollingFrame"),
	UIListLayout_3 = Instance.new("UIListLayout"),
	TopBar = Instance.new("Frame"),
	UICorner_56 = Instance.new("UICorner"),
	Title = Instance.new("TextLabel"),
	UIPadding_25 = Instance.new("UIPadding"),
	Settings = Instance.new("ImageButton"),
	TabHolder_1 = Instance.new("Frame"),
	UICorner_57 = Instance.new("UICorner"),
	SearchBar_1 = Instance.new("TextBox"),
	UICorner_58 = Instance.new("UICorner"),
	UIPadding_26 = Instance.new("UIPadding"),
	SearchIcon_1 = Instance.new("ImageLabel"),
	Star_1 = Instance.new("TextButton"),
	Favorited_1 = Instance.new("ImageLabel"),
	Unfavorited_1 = Instance.new("ImageLabel"),
	TabContainer_1 = Instance.new("ScrollingFrame"),
	UIListLayout_4 = Instance.new("UIListLayout"),
	SearchFrame = Instance.new("Frame"),
	UICorner_59 = Instance.new("UICorner"),
	UICorner_60 = Instance.new("UICorner"),
	DropShadowHolder_3 = Instance.new("Frame"),
	DropShadow_3 = Instance.new("ImageLabel"),
	Modules_1 = Instance.new("Folder"),
	Dragger = Instance.new("ModuleScript"),
	Resizer = Instance.new("ModuleScript"),
	SaveManager = Instance.new("ModuleScript"),
	UIHover = Instance.new("ModuleScript"),
	UIClick = Instance.new("ModuleScript"),
	Signal = Instance.new("ModuleScript"),
	SynchronousTaskManager = Instance.new("ModuleScript"),
	Proxy = Instance.new("ModuleScript"),
	ModuleLoader = Instance.new("ModuleScript"),
	Tabs = Instance.new("Folder"),
	Main_1 = Instance.new("Folder"),
	AutoFarm = Instance.new("ModuleScript"),
	AutoDig = Instance.new("ModuleScript")
}

tbl.BSS.Name = "BSS"
tbl.BSS.Parent = game:GetService("StarterPlayer").StarterPlayerScripts

tbl.Modules.Name = "Modules"
tbl.Modules.Parent = tbl.BSS

tbl.Library.Name = "Library"
tbl.Library.Parent = tbl.Modules

tbl.UI.Name = "UI"
tbl.UI.Parent = tbl.Library

tbl.Tab.Name = "Tab"
tbl.Tab.Parent = tbl.UI

tbl.Module.Name = "Module"
tbl.Module.Parent = tbl.Tab

tbl.ColorPickerRGB.Name = "ColorPickerRGB"
tbl.ColorPickerRGB.Parent = tbl.Module

tbl.ColorPickerRGB_1.Active = true
tbl.ColorPickerRGB_1.BorderSizePixel = 0
tbl.ColorPickerRGB_1.Size = UDim2.new(1, 0, 0, 28)
tbl.ColorPickerRGB_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ColorPickerRGB_1.Name = "ColorPickerRGB"
tbl.ColorPickerRGB_1.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.ColorPickerRGB_1.Parent = tbl.ColorPickerRGB

tbl.UICorner.CornerRadius = UDim.new(0, 6)
tbl.UICorner.Parent = tbl.ColorPickerRGB_1

tbl.Top.Active = true
tbl.Top.ZIndex = 2
tbl.Top.BorderSizePixel = 0
tbl.Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Top.AnchorPoint = Vector2.new(0, 0.5)
tbl.Top.TextSize = 12
tbl.Top.Name = "Top"
tbl.Top.Size = UDim2.new(0, 120, 0, 16)
tbl.Top.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Top.Text = "RGB Color Picker"
tbl.Top.Position = UDim2.new(0, 10, 0.5, 0)
tbl.Top.BackgroundTransparency = 1
tbl.Top.TextXAlignment = Enum.TextXAlignment.Left
tbl.Top.Parent = tbl.ColorPickerRGB_1

tbl.Color.ZIndex = 2
tbl.Color.BorderSizePixel = 0
tbl.Color.AutoButtonColor = false
tbl.Color.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Color.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Color.Position = UDim2.new(1, -7, 0.5, 0)
tbl.Color.AnchorPoint = Vector2.new(1, 0.5)
tbl.Color.TextSize = 13
tbl.Color.Size = UDim2.new(1, -15, 0, 16)
tbl.Color.Name = "Color"
tbl.Color.TextColor3 = Color3.fromRGB(60, 62, 64)
tbl.Color.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Color.Text = "#FFFFFF"
tbl.Color.Selectable = false
tbl.Color.Parent = tbl.ColorPickerRGB_1

tbl.UICorner_1.CornerRadius = UDim.new(0, 6)
tbl.UICorner_1.Parent = tbl.Color

tbl.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke.Thickness = 2
tbl.UIStroke.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke.Parent = tbl.Color

tbl.PickColor.Active = true
tbl.PickColor.ZIndex = 3
tbl.PickColor.BorderSizePixel = 0
tbl.PickColor.Size = UDim2.new(0, 210, 0, 0)
tbl.PickColor.Position = UDim2.new(0, 0, 0, 20)
tbl.PickColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.PickColor.ClipsDescendants = true
tbl.PickColor.Name = "PickColor"
tbl.PickColor.BackgroundColor3 = Color3.fromRGB(28, 29, 31)
tbl.PickColor.Parent = tbl.Color

tbl.UICorner_2.CornerRadius = UDim.new(0, 6)
tbl.UICorner_2.Parent = tbl.PickColor

tbl.HueSatGradient.Active = true
tbl.HueSatGradient.ZIndex = 3
tbl.HueSatGradient.BorderSizePixel = 0
tbl.HueSatGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.HueSatGradient.Image = "rbxassetid://14431054985"
tbl.HueSatGradient.Size = UDim2.new(1, -40, 0, 100)
tbl.HueSatGradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.HueSatGradient.Name = "HueSatGradient"
tbl.HueSatGradient.BackgroundTransparency = 1
tbl.HueSatGradient.Position = UDim2.new(0, 5, 0, 5)
tbl.HueSatGradient.Parent = tbl.PickColor

tbl.UICorner_3.CornerRadius = UDim.new(0, 4)
tbl.UICorner_3.Parent = tbl.HueSatGradient

tbl.UIStroke_1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_1.Thickness = 2
tbl.UIStroke_1.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_1.Parent = tbl.HueSatGradient

tbl.Cursor.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Cursor.Active = true
tbl.Cursor.ZIndex = 3
tbl.Cursor.BorderSizePixel = 0
tbl.Cursor.Size = UDim2.new(0, 6, 0, 6)
tbl.Cursor.Position = UDim2.new(1, 0, 1, 0)
tbl.Cursor.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Cursor.Name = "Cursor"
tbl.Cursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Cursor.Parent = tbl.HueSatGradient

tbl.UICorner_4.CornerRadius = UDim.new(1, 0)
tbl.UICorner_4.Parent = tbl.Cursor

tbl.UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_2.Thickness = 1.5
tbl.UIStroke_2.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_2.Parent = tbl.Cursor

tbl.Click.ZIndex = 3
tbl.Click.BorderSizePixel = 0
tbl.Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Click.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Click.TextSize = 14
tbl.Click.Size = UDim2.new(1, 0, 1, 0)
tbl.Click.Name = "Click"
tbl.Click.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click.Text = ""
tbl.Click.BackgroundTransparency = 1
tbl.Click.Parent = tbl.HueSatGradient

tbl.DropShadowHolder.Active = true
tbl.DropShadowHolder.ZIndex = 2
tbl.DropShadowHolder.BorderSizePixel = 0
tbl.DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
tbl.DropShadowHolder.BackgroundTransparency = 1
tbl.DropShadowHolder.Visible = false
tbl.DropShadowHolder.Name = "DropShadowHolder"
tbl.DropShadowHolder.Parent = tbl.PickColor

tbl.DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
tbl.DropShadow.Active = true
tbl.DropShadow.ZIndex = 2
tbl.DropShadow.BorderSizePixel = 0
tbl.DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
tbl.DropShadow.ScaleType = Enum.ScaleType.Slice
tbl.DropShadow.ImageTransparency = 0.5
tbl.DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.DropShadow.Image = "rbxassetid://6014261993"
tbl.DropShadow.Size = UDim2.new(1, 47, 1, 47)
tbl.DropShadow.Name = "DropShadow"
tbl.DropShadow.BackgroundTransparency = 1
tbl.DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.DropShadow.Parent = tbl.DropShadowHolder

tbl.LinearGradient.AnchorPoint = Vector2.new(1, 0)
tbl.LinearGradient.Active = true
tbl.LinearGradient.ZIndex = 3
tbl.LinearGradient.BorderSizePixel = 0
tbl.LinearGradient.Size = UDim2.new(0, 20, 0, 100)
tbl.LinearGradient.Position = UDim2.new(1, -5, 0, 5)
tbl.LinearGradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.LinearGradient.Name = "LinearGradient"
tbl.LinearGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.LinearGradient.Parent = tbl.PickColor

tbl.UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_3.Thickness = 2
tbl.UIStroke_3.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_3.Parent = tbl.LinearGradient

tbl.UICorner_5.CornerRadius = UDim.new(0, 4)
tbl.UICorner_5.Parent = tbl.LinearGradient

tbl.UIGradient.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }
tbl.UIGradient.Rotation = 270
tbl.UIGradient.Parent = tbl.LinearGradient

tbl.Cursor_1.AnchorPoint = Vector2.new(0, 0.5)
tbl.Cursor_1.Active = true
tbl.Cursor_1.ZIndex = 3
tbl.Cursor_1.BorderSizePixel = 0
tbl.Cursor_1.Size = UDim2.new(0, 10, 0, 10)
tbl.Cursor_1.Position = UDim2.new(1, 0, 0, 0)
tbl.Cursor_1.BackgroundTransparency = 1
tbl.Cursor_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Cursor_1.Name = "Cursor"
tbl.Cursor_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Cursor_1.Parent = tbl.LinearGradient

tbl.Icon.Active = true
tbl.Icon.ZIndex = 3
tbl.Icon.BorderSizePixel = 0
tbl.Icon.ScaleType = Enum.ScaleType.Fit
tbl.Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon.AnchorPoint = Vector2.new(0, 0.5)
tbl.Icon.Image = "rbxassetid://14431841400"
tbl.Icon.Size = UDim2.new(0, 8, 0, 5)
tbl.Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon.Name = "Icon"
tbl.Icon.Rotation = 90
tbl.Icon.BackgroundTransparency = 1
tbl.Icon.Position = UDim2.new(0, -2, 0.5, 0)
tbl.Icon.Parent = tbl.Cursor_1

tbl.Click_1.ZIndex = 3
tbl.Click_1.BorderSizePixel = 0
tbl.Click_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Click_1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Click_1.TextSize = 14
tbl.Click_1.Size = UDim2.new(1, 0, 1, 0)
tbl.Click_1.Name = "Click"
tbl.Click_1.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_1.Text = ""
tbl.Click_1.BackgroundTransparency = 1
tbl.Click_1.Parent = tbl.LinearGradient

tbl.Fields.Active = true
tbl.Fields.ZIndex = 3
tbl.Fields.BorderSizePixel = 0
tbl.Fields.Size = UDim2.new(1, 0, 1, -110)
tbl.Fields.Position = UDim2.new(0, 0, 0, 110)
tbl.Fields.BackgroundTransparency = 1
tbl.Fields.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Fields.Name = "Fields"
tbl.Fields.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Fields.Parent = tbl.PickColor

tbl.Blue.Active = true
tbl.Blue.ZIndex = 3
tbl.Blue.BorderSizePixel = 0
tbl.Blue.Size = UDim2.new(0, 80, 0, 16)
tbl.Blue.Position = UDim2.new(0, 115, 0, 57)
tbl.Blue.BackgroundTransparency = 1
tbl.Blue.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Blue.Name = "Blue"
tbl.Blue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Blue.Parent = tbl.Fields

tbl.Value.AnchorPoint = Vector2.new(1, 0)
tbl.Value.Active = true
tbl.Value.ZIndex = 3
tbl.Value.BorderSizePixel = 0
tbl.Value.Size = UDim2.new(0, 45, 0, 16)
tbl.Value.Position = UDim2.new(1, 0, 0, 0)
tbl.Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value.Name = "Value"
tbl.Value.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value.Parent = tbl.Blue

tbl.UICorner_6.CornerRadius = UDim.new(0, 4)
tbl.UICorner_6.Parent = tbl.Value

tbl.ArrowDown.ZIndex = 3
tbl.ArrowDown.BorderSizePixel = 0
tbl.ArrowDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown.TextSize = 12
tbl.ArrowDown.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown.Name = "ArrowDown"
tbl.ArrowDown.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown.Text = ""
tbl.ArrowDown.TextTransparency = 1
tbl.ArrowDown.BackgroundTransparency = 1
tbl.ArrowDown.Selectable = false
tbl.ArrowDown.Parent = tbl.Value

tbl.Icon_1.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_1.Active = true
tbl.Icon_1.ZIndex = 3
tbl.Icon_1.BorderSizePixel = 0
tbl.Icon_1.ScaleType = Enum.ScaleType.Fit
tbl.Icon_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_1.Selectable = true
tbl.Icon_1.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_1.Image = "rbxassetid://14431841400"
tbl.Icon_1.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_1.Name = "Icon"
tbl.Icon_1.BackgroundTransparency = 1
tbl.Icon_1.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_1.Parent = tbl.ArrowDown

tbl.ArrowUp.ZIndex = 3
tbl.ArrowUp.BorderSizePixel = 0
tbl.ArrowUp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp.TextSize = 12
tbl.ArrowUp.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp.Name = "ArrowUp"
tbl.ArrowUp.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp.Text = ""
tbl.ArrowUp.TextTransparency = 1
tbl.ArrowUp.BackgroundTransparency = 1
tbl.ArrowUp.Selectable = false
tbl.ArrowUp.Parent = tbl.Value

tbl.Icon_2.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_2.Active = true
tbl.Icon_2.ZIndex = 3
tbl.Icon_2.BorderSizePixel = 0
tbl.Icon_2.ScaleType = Enum.ScaleType.Fit
tbl.Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_2.Selectable = true
tbl.Icon_2.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_2.Image = "rbxassetid://14431841400"
tbl.Icon_2.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_2.Name = "Icon"
tbl.Icon_2.Rotation = 180
tbl.Icon_2.BackgroundTransparency = 1
tbl.Icon_2.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_2.Parent = tbl.ArrowUp

tbl.UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_4.Thickness = 2
tbl.UIStroke_4.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_4.Parent = tbl.Value

tbl.TextBox.TextWrapped = true
tbl.TextBox.ZIndex = 3
tbl.TextBox.BorderSizePixel = 0
tbl.TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox.BackgroundTransparency = 1
tbl.TextBox.TextSize = 11
tbl.TextBox.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox.Text = "255"
tbl.TextBox.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox.ClearTextOnFocus = false
tbl.TextBox.Parent = tbl.Value

tbl.UIPadding.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding.Parent = tbl.TextBox

tbl.Label.Active = true
tbl.Label.ZIndex = 3
tbl.Label.BorderSizePixel = 0
tbl.Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label.AnchorPoint = Vector2.new(1, 0)
tbl.Label.TextSize = 12
tbl.Label.Name = "Label"
tbl.Label.Size = UDim2.new(0, 30, 0, 15)
tbl.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label.Text = "Blue:"
tbl.Label.Position = UDim2.new(1, -50, 0, 0)
tbl.Label.BackgroundTransparency = 1
tbl.Label.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label.Parent = tbl.Blue

tbl.Green.Active = true
tbl.Green.ZIndex = 3
tbl.Green.BorderSizePixel = 0
tbl.Green.Size = UDim2.new(0, 80, 0, 16)
tbl.Green.Position = UDim2.new(0, 115, 0, 31)
tbl.Green.BackgroundTransparency = 1
tbl.Green.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Green.Name = "Green"
tbl.Green.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Green.Parent = tbl.Fields

tbl.Value_1.AnchorPoint = Vector2.new(1, 0)
tbl.Value_1.Active = true
tbl.Value_1.ZIndex = 3
tbl.Value_1.BorderSizePixel = 0
tbl.Value_1.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_1.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_1.Name = "Value"
tbl.Value_1.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_1.Parent = tbl.Green

tbl.UICorner_7.CornerRadius = UDim.new(0, 4)
tbl.UICorner_7.Parent = tbl.Value_1

tbl.ArrowDown_1.ZIndex = 3
tbl.ArrowDown_1.BorderSizePixel = 0
tbl.ArrowDown_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_1.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_1.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_1.TextSize = 12
tbl.ArrowDown_1.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_1.Name = "ArrowDown"
tbl.ArrowDown_1.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_1.Text = ""
tbl.ArrowDown_1.TextTransparency = 1
tbl.ArrowDown_1.BackgroundTransparency = 1
tbl.ArrowDown_1.Selectable = false
tbl.ArrowDown_1.Parent = tbl.Value_1

tbl.Icon_3.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_3.Active = true
tbl.Icon_3.ZIndex = 3
tbl.Icon_3.BorderSizePixel = 0
tbl.Icon_3.ScaleType = Enum.ScaleType.Fit
tbl.Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_3.Selectable = true
tbl.Icon_3.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_3.Image = "rbxassetid://14431841400"
tbl.Icon_3.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_3.Name = "Icon"
tbl.Icon_3.BackgroundTransparency = 1
tbl.Icon_3.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_3.Parent = tbl.ArrowDown_1

tbl.ArrowUp_1.ZIndex = 3
tbl.ArrowUp_1.BorderSizePixel = 0
tbl.ArrowUp_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_1.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_1.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_1.TextSize = 12
tbl.ArrowUp_1.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_1.Name = "ArrowUp"
tbl.ArrowUp_1.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_1.Text = ""
tbl.ArrowUp_1.TextTransparency = 1
tbl.ArrowUp_1.BackgroundTransparency = 1
tbl.ArrowUp_1.Selectable = false
tbl.ArrowUp_1.Parent = tbl.Value_1

tbl.Icon_4.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_4.Active = true
tbl.Icon_4.ZIndex = 3
tbl.Icon_4.BorderSizePixel = 0
tbl.Icon_4.ScaleType = Enum.ScaleType.Fit
tbl.Icon_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_4.Selectable = true
tbl.Icon_4.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_4.Image = "rbxassetid://14431841400"
tbl.Icon_4.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_4.Name = "Icon"
tbl.Icon_4.Rotation = 180
tbl.Icon_4.BackgroundTransparency = 1
tbl.Icon_4.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_4.Parent = tbl.ArrowUp_1

tbl.UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_5.Thickness = 2
tbl.UIStroke_5.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_5.Parent = tbl.Value_1

tbl.TextBox_1.TextWrapped = true
tbl.TextBox_1.ZIndex = 3
tbl.TextBox_1.BorderSizePixel = 0
tbl.TextBox_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_1.BackgroundTransparency = 1
tbl.TextBox_1.TextSize = 11
tbl.TextBox_1.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_1.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_1.Text = "255"
tbl.TextBox_1.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_1.ClearTextOnFocus = false
tbl.TextBox_1.Parent = tbl.Value_1

tbl.UIPadding_1.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_1.Parent = tbl.TextBox_1

tbl.Label_1.Active = true
tbl.Label_1.ZIndex = 3
tbl.Label_1.BorderSizePixel = 0
tbl.Label_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_1.AnchorPoint = Vector2.new(1, 0)
tbl.Label_1.TextSize = 12
tbl.Label_1.Name = "Label"
tbl.Label_1.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_1.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_1.Text = "Green:"
tbl.Label_1.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_1.BackgroundTransparency = 1
tbl.Label_1.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_1.Parent = tbl.Green

tbl.Hex.Active = true
tbl.Hex.ZIndex = 3
tbl.Hex.BorderSizePixel = 0
tbl.Hex.Size = UDim2.new(0, 95, 0, 16)
tbl.Hex.Position = UDim2.new(0, 5, 0, 83)
tbl.Hex.BackgroundTransparency = 1
tbl.Hex.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Hex.Name = "Hex"
tbl.Hex.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Hex.Parent = tbl.Fields

tbl.Value_2.AnchorPoint = Vector2.new(1, 0)
tbl.Value_2.Active = true
tbl.Value_2.ZIndex = 3
tbl.Value_2.BorderSizePixel = 0
tbl.Value_2.Size = UDim2.new(0, 55, 0, 16)
tbl.Value_2.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_2.Name = "Value"
tbl.Value_2.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_2.Parent = tbl.Hex

tbl.UICorner_8.CornerRadius = UDim.new(0, 4)
tbl.UICorner_8.Parent = tbl.Value_2

tbl.UIStroke_6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_6.Thickness = 2
tbl.UIStroke_6.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_6.Parent = tbl.Value_2

tbl.TextBox_2.ZIndex = 3
tbl.TextBox_2.BorderSizePixel = 0
tbl.TextBox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_2.BackgroundTransparency = 1
tbl.TextBox_2.TextSize = 11
tbl.TextBox_2.Size = UDim2.new(1, 0, 0, 15)
tbl.TextBox_2.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_2.Text = "#FFFFFF"
tbl.TextBox_2.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_2.ClearTextOnFocus = false
tbl.TextBox_2.Parent = tbl.Value_2

tbl.UIPadding_2.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_2.Parent = tbl.TextBox_2

tbl.Label_2.Active = true
tbl.Label_2.ZIndex = 3
tbl.Label_2.BorderSizePixel = 0
tbl.Label_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_2.AnchorPoint = Vector2.new(1, 0)
tbl.Label_2.TextSize = 12
tbl.Label_2.Name = "Label"
tbl.Label_2.Size = UDim2.new(0, 40, 0, 15)
tbl.Label_2.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_2.Text = "Hex:"
tbl.Label_2.Position = UDim2.new(1, -60, 0, 0)
tbl.Label_2.BackgroundTransparency = 1
tbl.Label_2.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_2.Parent = tbl.Hex

tbl.Hue.Active = true
tbl.Hue.ZIndex = 3
tbl.Hue.BorderSizePixel = 0
tbl.Hue.Size = UDim2.new(0, 80, 0, 16)
tbl.Hue.Position = UDim2.new(0, 10, 0, 5)
tbl.Hue.BackgroundTransparency = 1
tbl.Hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Hue.Name = "Hue"
tbl.Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Hue.Parent = tbl.Fields

tbl.Value_3.AnchorPoint = Vector2.new(1, 0)
tbl.Value_3.Active = true
tbl.Value_3.ZIndex = 3
tbl.Value_3.BorderSizePixel = 0
tbl.Value_3.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_3.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_3.Name = "Value"
tbl.Value_3.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_3.Parent = tbl.Hue

tbl.UICorner_9.CornerRadius = UDim.new(0, 4)
tbl.UICorner_9.Parent = tbl.Value_3

tbl.ArrowDown_2.ZIndex = 3
tbl.ArrowDown_2.BorderSizePixel = 0
tbl.ArrowDown_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_2.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_2.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_2.TextSize = 12
tbl.ArrowDown_2.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_2.Name = "ArrowDown"
tbl.ArrowDown_2.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_2.Text = ""
tbl.ArrowDown_2.TextTransparency = 1
tbl.ArrowDown_2.BackgroundTransparency = 1
tbl.ArrowDown_2.Selectable = false
tbl.ArrowDown_2.Parent = tbl.Value_3

tbl.Icon_5.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_5.Active = true
tbl.Icon_5.ZIndex = 3
tbl.Icon_5.BorderSizePixel = 0
tbl.Icon_5.ScaleType = Enum.ScaleType.Fit
tbl.Icon_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_5.Selectable = true
tbl.Icon_5.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_5.Image = "rbxassetid://14431841400"
tbl.Icon_5.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_5.Name = "Icon"
tbl.Icon_5.BackgroundTransparency = 1
tbl.Icon_5.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_5.Parent = tbl.ArrowDown_2

tbl.ArrowUp_2.ZIndex = 3
tbl.ArrowUp_2.BorderSizePixel = 0
tbl.ArrowUp_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_2.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_2.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_2.TextSize = 12
tbl.ArrowUp_2.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_2.Name = "ArrowUp"
tbl.ArrowUp_2.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_2.Text = ""
tbl.ArrowUp_2.TextTransparency = 1
tbl.ArrowUp_2.BackgroundTransparency = 1
tbl.ArrowUp_2.Selectable = false
tbl.ArrowUp_2.Parent = tbl.Value_3

tbl.Icon_6.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_6.Active = true
tbl.Icon_6.ZIndex = 3
tbl.Icon_6.BorderSizePixel = 0
tbl.Icon_6.ScaleType = Enum.ScaleType.Fit
tbl.Icon_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_6.Selectable = true
tbl.Icon_6.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_6.Image = "rbxassetid://14431841400"
tbl.Icon_6.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_6.Name = "Icon"
tbl.Icon_6.Rotation = 180
tbl.Icon_6.BackgroundTransparency = 1
tbl.Icon_6.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_6.Parent = tbl.ArrowUp_2

tbl.UIStroke_7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_7.Thickness = 2
tbl.UIStroke_7.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_7.Parent = tbl.Value_3

tbl.TextBox_3.TextWrapped = true
tbl.TextBox_3.ZIndex = 3
tbl.TextBox_3.BorderSizePixel = 0
tbl.TextBox_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_3.BackgroundTransparency = 1
tbl.TextBox_3.TextSize = 11
tbl.TextBox_3.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_3.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_3.Text = "359"
tbl.TextBox_3.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_3.ClearTextOnFocus = false
tbl.TextBox_3.Parent = tbl.Value_3

tbl.UIPadding_3.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_3.Parent = tbl.TextBox_3

tbl.Label_3.Active = true
tbl.Label_3.ZIndex = 3
tbl.Label_3.BorderSizePixel = 0
tbl.Label_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_3.AnchorPoint = Vector2.new(1, 0)
tbl.Label_3.TextSize = 12
tbl.Label_3.Name = "Label"
tbl.Label_3.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_3.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_3.Text = "Hue:"
tbl.Label_3.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_3.BackgroundTransparency = 1
tbl.Label_3.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_3.Parent = tbl.Hue

tbl.Red.Active = true
tbl.Red.ZIndex = 3
tbl.Red.BorderSizePixel = 0
tbl.Red.Size = UDim2.new(0, 80, 0, 16)
tbl.Red.Position = UDim2.new(0, 115, 0, 5)
tbl.Red.BackgroundTransparency = 1
tbl.Red.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Red.Name = "Red"
tbl.Red.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Red.Parent = tbl.Fields

tbl.Value_4.AnchorPoint = Vector2.new(1, 0)
tbl.Value_4.Active = true
tbl.Value_4.ZIndex = 3
tbl.Value_4.BorderSizePixel = 0
tbl.Value_4.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_4.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_4.Name = "Value"
tbl.Value_4.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_4.Parent = tbl.Red

tbl.UICorner_10.CornerRadius = UDim.new(0, 4)
tbl.UICorner_10.Parent = tbl.Value_4

tbl.ArrowDown_3.ZIndex = 3
tbl.ArrowDown_3.BorderSizePixel = 0
tbl.ArrowDown_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_3.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_3.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_3.TextSize = 12
tbl.ArrowDown_3.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_3.Name = "ArrowDown"
tbl.ArrowDown_3.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_3.Text = ""
tbl.ArrowDown_3.TextTransparency = 1
tbl.ArrowDown_3.BackgroundTransparency = 1
tbl.ArrowDown_3.Selectable = false
tbl.ArrowDown_3.Parent = tbl.Value_4

tbl.Icon_7.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_7.Active = true
tbl.Icon_7.ZIndex = 3
tbl.Icon_7.BorderSizePixel = 0
tbl.Icon_7.ScaleType = Enum.ScaleType.Fit
tbl.Icon_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_7.Selectable = true
tbl.Icon_7.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_7.Image = "rbxassetid://14431841400"
tbl.Icon_7.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_7.Name = "Icon"
tbl.Icon_7.BackgroundTransparency = 1
tbl.Icon_7.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_7.Parent = tbl.ArrowDown_3

tbl.ArrowUp_3.ZIndex = 3
tbl.ArrowUp_3.BorderSizePixel = 0
tbl.ArrowUp_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_3.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_3.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_3.TextSize = 12
tbl.ArrowUp_3.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_3.Name = "ArrowUp"
tbl.ArrowUp_3.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_3.Text = ""
tbl.ArrowUp_3.TextTransparency = 1
tbl.ArrowUp_3.BackgroundTransparency = 1
tbl.ArrowUp_3.Selectable = false
tbl.ArrowUp_3.Parent = tbl.Value_4

tbl.Icon_8.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_8.Active = true
tbl.Icon_8.ZIndex = 3
tbl.Icon_8.BorderSizePixel = 0
tbl.Icon_8.ScaleType = Enum.ScaleType.Fit
tbl.Icon_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_8.Selectable = true
tbl.Icon_8.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_8.Image = "rbxassetid://14431841400"
tbl.Icon_8.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_8.Name = "Icon"
tbl.Icon_8.Rotation = 180
tbl.Icon_8.BackgroundTransparency = 1
tbl.Icon_8.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_8.Parent = tbl.ArrowUp_3

tbl.UIStroke_8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_8.Thickness = 2
tbl.UIStroke_8.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_8.Parent = tbl.Value_4

tbl.TextBox_4.TextWrapped = true
tbl.TextBox_4.ZIndex = 3
tbl.TextBox_4.BorderSizePixel = 0
tbl.TextBox_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_4.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_4.BackgroundTransparency = 1
tbl.TextBox_4.TextSize = 11
tbl.TextBox_4.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_4.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_4.Text = "255"
tbl.TextBox_4.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_4.ClearTextOnFocus = false
tbl.TextBox_4.Parent = tbl.Value_4

tbl.UIPadding_4.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_4.Parent = tbl.TextBox_4

tbl.Label_4.Active = true
tbl.Label_4.ZIndex = 3
tbl.Label_4.BorderSizePixel = 0
tbl.Label_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_4.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_4.AnchorPoint = Vector2.new(1, 0)
tbl.Label_4.TextSize = 12
tbl.Label_4.Name = "Label"
tbl.Label_4.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_4.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_4.Text = "Red:"
tbl.Label_4.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_4.BackgroundTransparency = 1
tbl.Label_4.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_4.Parent = tbl.Red

tbl.Sat.Active = true
tbl.Sat.ZIndex = 3
tbl.Sat.BorderSizePixel = 0
tbl.Sat.Size = UDim2.new(0, 80, 0, 16)
tbl.Sat.Position = UDim2.new(0, 10, 0, 31)
tbl.Sat.BackgroundTransparency = 1
tbl.Sat.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Sat.Name = "Sat"
tbl.Sat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Sat.Parent = tbl.Fields

tbl.Value_5.AnchorPoint = Vector2.new(1, 0)
tbl.Value_5.Active = true
tbl.Value_5.ZIndex = 3
tbl.Value_5.BorderSizePixel = 0
tbl.Value_5.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_5.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_5.Name = "Value"
tbl.Value_5.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_5.Parent = tbl.Sat

tbl.UICorner_11.CornerRadius = UDim.new(0, 4)
tbl.UICorner_11.Parent = tbl.Value_5

tbl.ArrowDown_4.ZIndex = 3
tbl.ArrowDown_4.BorderSizePixel = 0
tbl.ArrowDown_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_4.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_4.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_4.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_4.TextSize = 12
tbl.ArrowDown_4.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_4.Name = "ArrowDown"
tbl.ArrowDown_4.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_4.Text = ""
tbl.ArrowDown_4.TextTransparency = 1
tbl.ArrowDown_4.BackgroundTransparency = 1
tbl.ArrowDown_4.Selectable = false
tbl.ArrowDown_4.Parent = tbl.Value_5

tbl.Icon_9.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_9.Active = true
tbl.Icon_9.ZIndex = 3
tbl.Icon_9.BorderSizePixel = 0
tbl.Icon_9.ScaleType = Enum.ScaleType.Fit
tbl.Icon_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_9.Selectable = true
tbl.Icon_9.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_9.Image = "rbxassetid://14431841400"
tbl.Icon_9.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_9.Name = "Icon"
tbl.Icon_9.BackgroundTransparency = 1
tbl.Icon_9.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_9.Parent = tbl.ArrowDown_4

tbl.ArrowUp_4.ZIndex = 3
tbl.ArrowUp_4.BorderSizePixel = 0
tbl.ArrowUp_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_4.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_4.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_4.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_4.TextSize = 12
tbl.ArrowUp_4.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_4.Name = "ArrowUp"
tbl.ArrowUp_4.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_4.Text = ""
tbl.ArrowUp_4.TextTransparency = 1
tbl.ArrowUp_4.BackgroundTransparency = 1
tbl.ArrowUp_4.Selectable = false
tbl.ArrowUp_4.Parent = tbl.Value_5

tbl.Icon_10.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_10.Active = true
tbl.Icon_10.ZIndex = 3
tbl.Icon_10.BorderSizePixel = 0
tbl.Icon_10.ScaleType = Enum.ScaleType.Fit
tbl.Icon_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_10.Selectable = true
tbl.Icon_10.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_10.Image = "rbxassetid://14431841400"
tbl.Icon_10.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_10.Name = "Icon"
tbl.Icon_10.Rotation = 180
tbl.Icon_10.BackgroundTransparency = 1
tbl.Icon_10.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_10.Parent = tbl.ArrowUp_4

tbl.UIStroke_9.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_9.Thickness = 2
tbl.UIStroke_9.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_9.Parent = tbl.Value_5

tbl.TextBox_5.TextWrapped = true
tbl.TextBox_5.ZIndex = 3
tbl.TextBox_5.BorderSizePixel = 0
tbl.TextBox_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_5.BackgroundTransparency = 1
tbl.TextBox_5.TextSize = 11
tbl.TextBox_5.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_5.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_5.Text = "255"
tbl.TextBox_5.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_5.ClearTextOnFocus = false
tbl.TextBox_5.Parent = tbl.Value_5

tbl.UIPadding_5.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_5.Parent = tbl.TextBox_5

tbl.Label_5.Active = true
tbl.Label_5.ZIndex = 3
tbl.Label_5.BorderSizePixel = 0
tbl.Label_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_5.AnchorPoint = Vector2.new(1, 0)
tbl.Label_5.TextSize = 12
tbl.Label_5.Name = "Label"
tbl.Label_5.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_5.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_5.Text = "Sat:"
tbl.Label_5.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_5.BackgroundTransparency = 1
tbl.Label_5.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_5.Parent = tbl.Sat

tbl.Val.Active = true
tbl.Val.ZIndex = 3
tbl.Val.BorderSizePixel = 0
tbl.Val.Size = UDim2.new(0, 80, 0, 16)
tbl.Val.Position = UDim2.new(0, 10, 0, 57)
tbl.Val.BackgroundTransparency = 1
tbl.Val.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Val.Name = "Val"
tbl.Val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Val.Parent = tbl.Fields

tbl.Value_6.AnchorPoint = Vector2.new(1, 0)
tbl.Value_6.Active = true
tbl.Value_6.ZIndex = 3
tbl.Value_6.BorderSizePixel = 0
tbl.Value_6.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_6.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_6.Name = "Value"
tbl.Value_6.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_6.Parent = tbl.Val

tbl.UICorner_12.CornerRadius = UDim.new(0, 4)
tbl.UICorner_12.Parent = tbl.Value_6

tbl.ArrowDown_5.ZIndex = 3
tbl.ArrowDown_5.BorderSizePixel = 0
tbl.ArrowDown_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_5.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_5.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_5.TextSize = 12
tbl.ArrowDown_5.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_5.Name = "ArrowDown"
tbl.ArrowDown_5.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_5.Text = ""
tbl.ArrowDown_5.TextTransparency = 1
tbl.ArrowDown_5.BackgroundTransparency = 1
tbl.ArrowDown_5.Selectable = false
tbl.ArrowDown_5.Parent = tbl.Value_6

tbl.Icon_11.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_11.Active = true
tbl.Icon_11.ZIndex = 3
tbl.Icon_11.BorderSizePixel = 0
tbl.Icon_11.ScaleType = Enum.ScaleType.Fit
tbl.Icon_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_11.Selectable = true
tbl.Icon_11.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_11.Image = "rbxassetid://14431841400"
tbl.Icon_11.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_11.Name = "Icon"
tbl.Icon_11.BackgroundTransparency = 1
tbl.Icon_11.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_11.Parent = tbl.ArrowDown_5

tbl.ArrowUp_5.ZIndex = 3
tbl.ArrowUp_5.BorderSizePixel = 0
tbl.ArrowUp_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_5.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_5.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_5.TextSize = 12
tbl.ArrowUp_5.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_5.Name = "ArrowUp"
tbl.ArrowUp_5.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_5.Text = ""
tbl.ArrowUp_5.TextTransparency = 1
tbl.ArrowUp_5.BackgroundTransparency = 1
tbl.ArrowUp_5.Selectable = false
tbl.ArrowUp_5.Parent = tbl.Value_6

tbl.Icon_12.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_12.Active = true
tbl.Icon_12.ZIndex = 3
tbl.Icon_12.BorderSizePixel = 0
tbl.Icon_12.ScaleType = Enum.ScaleType.Fit
tbl.Icon_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_12.Selectable = true
tbl.Icon_12.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_12.Image = "rbxassetid://14431841400"
tbl.Icon_12.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_12.Name = "Icon"
tbl.Icon_12.Rotation = 180
tbl.Icon_12.BackgroundTransparency = 1
tbl.Icon_12.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_12.Parent = tbl.ArrowUp_5

tbl.UIStroke_10.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_10.Thickness = 2
tbl.UIStroke_10.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_10.Parent = tbl.Value_6

tbl.TextBox_6.TextWrapped = true
tbl.TextBox_6.ZIndex = 3
tbl.TextBox_6.BorderSizePixel = 0
tbl.TextBox_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_6.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_6.BackgroundTransparency = 1
tbl.TextBox_6.TextSize = 11
tbl.TextBox_6.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_6.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_6.Text = "255"
tbl.TextBox_6.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_6.ClearTextOnFocus = false
tbl.TextBox_6.Parent = tbl.Value_6

tbl.UIPadding_6.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_6.Parent = tbl.TextBox_6

tbl.Label_6.Active = true
tbl.Label_6.ZIndex = 3
tbl.Label_6.BorderSizePixel = 0
tbl.Label_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_6.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_6.AnchorPoint = Vector2.new(1, 0)
tbl.Label_6.TextSize = 12
tbl.Label_6.Name = "Label"
tbl.Label_6.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_6.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_6.Text = "Val:"
tbl.Label_6.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_6.BackgroundTransparency = 1
tbl.Label_6.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_6.Parent = tbl.Val

tbl.ColorPickerRGBA.Name = "ColorPickerRGBA"
tbl.ColorPickerRGBA.Parent = tbl.Module

tbl.ColorPickerRGBA_1.Active = true
tbl.ColorPickerRGBA_1.BorderSizePixel = 0
tbl.ColorPickerRGBA_1.Size = UDim2.new(1, 0, 0, 28)
tbl.ColorPickerRGBA_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ColorPickerRGBA_1.Name = "ColorPickerRGBA"
tbl.ColorPickerRGBA_1.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.ColorPickerRGBA_1.Parent = tbl.ColorPickerRGBA

tbl.UICorner_13.CornerRadius = UDim.new(0, 6)
tbl.UICorner_13.Parent = tbl.ColorPickerRGBA_1

tbl.Top_1.Active = true
tbl.Top_1.ZIndex = 2
tbl.Top_1.BorderSizePixel = 0
tbl.Top_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Top_1.AnchorPoint = Vector2.new(0, 0.5)
tbl.Top_1.TextSize = 12
tbl.Top_1.Name = "Top"
tbl.Top_1.Size = UDim2.new(0, 120, 0, 16)
tbl.Top_1.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Top_1.Text = "RGBA Color Picker"
tbl.Top_1.Position = UDim2.new(0, 10, 0.5, 0)
tbl.Top_1.BackgroundTransparency = 1
tbl.Top_1.TextXAlignment = Enum.TextXAlignment.Left
tbl.Top_1.Parent = tbl.ColorPickerRGBA_1

tbl.Color_1.ZIndex = 2
tbl.Color_1.BorderSizePixel = 0
tbl.Color_1.AutoButtonColor = false
tbl.Color_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Color_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Color_1.Position = UDim2.new(1, -7, 0.5, 0)
tbl.Color_1.AnchorPoint = Vector2.new(1, 0.5)
tbl.Color_1.TextSize = 13
tbl.Color_1.Size = UDim2.new(1, -135, 0, 16)
tbl.Color_1.Name = "Color"
tbl.Color_1.TextColor3 = Color3.fromRGB(60, 62, 64)
tbl.Color_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Color_1.Text = ""
tbl.Color_1.BackgroundTransparency = 1
tbl.Color_1.Selectable = false
tbl.Color_1.Parent = tbl.ColorPickerRGBA_1

tbl.UICorner_14.CornerRadius = UDim.new(0, 6)
tbl.UICorner_14.Parent = tbl.Color_1

tbl.UIStroke_11.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_11.Thickness = 2
tbl.UIStroke_11.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_11.Parent = tbl.Color_1

tbl.PickColor_1.Active = true
tbl.PickColor_1.ZIndex = 3
tbl.PickColor_1.BorderSizePixel = 0
tbl.PickColor_1.Size = UDim2.new(0, 210, 0, 0)
tbl.PickColor_1.Position = UDim2.new(0, 0, 0, 20)
tbl.PickColor_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.PickColor_1.ClipsDescendants = true
tbl.PickColor_1.Name = "PickColor"
tbl.PickColor_1.BackgroundColor3 = Color3.fromRGB(28, 29, 31)
tbl.PickColor_1.Parent = tbl.Color_1

tbl.UICorner_15.CornerRadius = UDim.new(0, 6)
tbl.UICorner_15.Parent = tbl.PickColor_1

tbl.HueSatGradient_1.Active = true
tbl.HueSatGradient_1.ZIndex = 3
tbl.HueSatGradient_1.BorderSizePixel = 0
tbl.HueSatGradient_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.HueSatGradient_1.Image = "rbxassetid://14431054985"
tbl.HueSatGradient_1.Size = UDim2.new(1, -70, 0, 100)
tbl.HueSatGradient_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.HueSatGradient_1.Name = "HueSatGradient"
tbl.HueSatGradient_1.BackgroundTransparency = 1
tbl.HueSatGradient_1.Position = UDim2.new(0, 5, 0, 5)
tbl.HueSatGradient_1.Parent = tbl.PickColor_1

tbl.UICorner_16.CornerRadius = UDim.new(0, 4)
tbl.UICorner_16.Parent = tbl.HueSatGradient_1

tbl.UIStroke_12.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_12.Thickness = 2
tbl.UIStroke_12.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_12.Parent = tbl.HueSatGradient_1

tbl.Cursor_2.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Cursor_2.Active = true
tbl.Cursor_2.ZIndex = 3
tbl.Cursor_2.BorderSizePixel = 0
tbl.Cursor_2.Size = UDim2.new(0, 6, 0, 6)
tbl.Cursor_2.Position = UDim2.new(1, 0, 1, 0)
tbl.Cursor_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Cursor_2.Name = "Cursor"
tbl.Cursor_2.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
tbl.Cursor_2.Parent = tbl.HueSatGradient_1

tbl.UICorner_17.CornerRadius = UDim.new(1, 0)
tbl.UICorner_17.Parent = tbl.Cursor_2

tbl.UIStroke_13.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_13.Thickness = 1.5
tbl.UIStroke_13.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_13.Parent = tbl.Cursor_2

tbl.Click_2.ZIndex = 3
tbl.Click_2.BorderSizePixel = 0
tbl.Click_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Click_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Click_2.TextSize = 14
tbl.Click_2.Size = UDim2.new(1, 0, 1, 0)
tbl.Click_2.Name = "Click"
tbl.Click_2.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_2.Text = ""
tbl.Click_2.BackgroundTransparency = 1
tbl.Click_2.Parent = tbl.HueSatGradient_1

tbl.DropShadowHolder_1.Active = true
tbl.DropShadowHolder_1.ZIndex = 2
tbl.DropShadowHolder_1.BorderSizePixel = 0
tbl.DropShadowHolder_1.Size = UDim2.new(1, 0, 1, 0)
tbl.DropShadowHolder_1.BackgroundTransparency = 1
tbl.DropShadowHolder_1.Visible = false
tbl.DropShadowHolder_1.Name = "DropShadowHolder"
tbl.DropShadowHolder_1.Parent = tbl.PickColor_1

tbl.DropShadow_1.ImageColor3 = Color3.fromRGB(0, 0, 0)
tbl.DropShadow_1.Active = true
tbl.DropShadow_1.ZIndex = 2
tbl.DropShadow_1.BorderSizePixel = 0
tbl.DropShadow_1.SliceCenter = Rect.new(49, 49, 450, 450)
tbl.DropShadow_1.ScaleType = Enum.ScaleType.Slice
tbl.DropShadow_1.ImageTransparency = 0.5
tbl.DropShadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.DropShadow_1.Image = "rbxassetid://6014261993"
tbl.DropShadow_1.Size = UDim2.new(1, 47, 1, 47)
tbl.DropShadow_1.Name = "DropShadow"
tbl.DropShadow_1.BackgroundTransparency = 1
tbl.DropShadow_1.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.DropShadow_1.Parent = tbl.DropShadowHolder_1

tbl.LinearGradient_1.AnchorPoint = Vector2.new(1, 0)
tbl.LinearGradient_1.Active = true
tbl.LinearGradient_1.ZIndex = 3
tbl.LinearGradient_1.BorderSizePixel = 0
tbl.LinearGradient_1.Size = UDim2.new(0, 20, 0, 100)
tbl.LinearGradient_1.Position = UDim2.new(1, -35, 0, 5)
tbl.LinearGradient_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.LinearGradient_1.Name = "LinearGradient"
tbl.LinearGradient_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.LinearGradient_1.Parent = tbl.PickColor_1

tbl.UIStroke_14.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_14.Thickness = 2
tbl.UIStroke_14.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_14.Parent = tbl.LinearGradient_1

tbl.UICorner_18.CornerRadius = UDim.new(0, 4)
tbl.UICorner_18.Parent = tbl.LinearGradient_1

tbl.UIGradient_1.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }
tbl.UIGradient_1.Rotation = 270
tbl.UIGradient_1.Parent = tbl.LinearGradient_1

tbl.Cursor_3.AnchorPoint = Vector2.new(0, 0.5)
tbl.Cursor_3.Active = true
tbl.Cursor_3.ZIndex = 3
tbl.Cursor_3.BorderSizePixel = 0
tbl.Cursor_3.Size = UDim2.new(0, 10, 0, 10)
tbl.Cursor_3.Position = UDim2.new(1, 0, 0, 0)
tbl.Cursor_3.BackgroundTransparency = 1
tbl.Cursor_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Cursor_3.Name = "Cursor"
tbl.Cursor_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Cursor_3.Parent = tbl.LinearGradient_1

tbl.Icon_13.Active = true
tbl.Icon_13.ZIndex = 3
tbl.Icon_13.BorderSizePixel = 0
tbl.Icon_13.ScaleType = Enum.ScaleType.Fit
tbl.Icon_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_13.AnchorPoint = Vector2.new(0, 0.5)
tbl.Icon_13.Image = "rbxassetid://14431841400"
tbl.Icon_13.Size = UDim2.new(0, 8, 0, 5)
tbl.Icon_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_13.Name = "Icon"
tbl.Icon_13.Rotation = 90
tbl.Icon_13.BackgroundTransparency = 1
tbl.Icon_13.Position = UDim2.new(0, -2, 0.5, 0)
tbl.Icon_13.Parent = tbl.Cursor_3

tbl.Click_3.ZIndex = 3
tbl.Click_3.BorderSizePixel = 0
tbl.Click_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Click_3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Click_3.TextSize = 14
tbl.Click_3.Size = UDim2.new(1, 0, 1, 0)
tbl.Click_3.Name = "Click"
tbl.Click_3.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_3.Text = ""
tbl.Click_3.BackgroundTransparency = 1
tbl.Click_3.Parent = tbl.LinearGradient_1

tbl.Fields_1.Active = true
tbl.Fields_1.ZIndex = 3
tbl.Fields_1.BorderSizePixel = 0
tbl.Fields_1.Size = UDim2.new(1, 0, 1, -110)
tbl.Fields_1.Position = UDim2.new(0, 0, 0, 110)
tbl.Fields_1.BackgroundTransparency = 1
tbl.Fields_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Fields_1.Name = "Fields"
tbl.Fields_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Fields_1.Parent = tbl.PickColor_1

tbl.Val_1.Active = true
tbl.Val_1.ZIndex = 3
tbl.Val_1.BorderSizePixel = 0
tbl.Val_1.Size = UDim2.new(0, 80, 0, 16)
tbl.Val_1.Position = UDim2.new(0, 10, 0, 57)
tbl.Val_1.BackgroundTransparency = 1
tbl.Val_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Val_1.Name = "Val"
tbl.Val_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Val_1.Parent = tbl.Fields_1

tbl.Value_7.AnchorPoint = Vector2.new(1, 0)
tbl.Value_7.Active = true
tbl.Value_7.ZIndex = 3
tbl.Value_7.BorderSizePixel = 0
tbl.Value_7.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_7.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_7.Name = "Value"
tbl.Value_7.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_7.Parent = tbl.Val_1

tbl.UICorner_19.CornerRadius = UDim.new(0, 4)
tbl.UICorner_19.Parent = tbl.Value_7

tbl.ArrowDown_6.ZIndex = 3
tbl.ArrowDown_6.BorderSizePixel = 0
tbl.ArrowDown_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_6.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_6.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_6.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_6.TextSize = 12
tbl.ArrowDown_6.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_6.Name = "ArrowDown"
tbl.ArrowDown_6.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_6.Text = ""
tbl.ArrowDown_6.TextTransparency = 1
tbl.ArrowDown_6.BackgroundTransparency = 1
tbl.ArrowDown_6.Selectable = false
tbl.ArrowDown_6.Parent = tbl.Value_7

tbl.Icon_14.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_14.Active = true
tbl.Icon_14.ZIndex = 3
tbl.Icon_14.BorderSizePixel = 0
tbl.Icon_14.ScaleType = Enum.ScaleType.Fit
tbl.Icon_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_14.Selectable = true
tbl.Icon_14.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_14.Image = "rbxassetid://14431841400"
tbl.Icon_14.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_14.Name = "Icon"
tbl.Icon_14.BackgroundTransparency = 1
tbl.Icon_14.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_14.Parent = tbl.ArrowDown_6

tbl.ArrowUp_6.ZIndex = 3
tbl.ArrowUp_6.BorderSizePixel = 0
tbl.ArrowUp_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_6.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_6.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_6.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_6.TextSize = 12
tbl.ArrowUp_6.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_6.Name = "ArrowUp"
tbl.ArrowUp_6.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_6.Text = ""
tbl.ArrowUp_6.TextTransparency = 1
tbl.ArrowUp_6.BackgroundTransparency = 1
tbl.ArrowUp_6.Selectable = false
tbl.ArrowUp_6.Parent = tbl.Value_7

tbl.Icon_15.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_15.Active = true
tbl.Icon_15.ZIndex = 3
tbl.Icon_15.BorderSizePixel = 0
tbl.Icon_15.ScaleType = Enum.ScaleType.Fit
tbl.Icon_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_15.Selectable = true
tbl.Icon_15.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_15.Image = "rbxassetid://14431841400"
tbl.Icon_15.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_15.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_15.Name = "Icon"
tbl.Icon_15.Rotation = 180
tbl.Icon_15.BackgroundTransparency = 1
tbl.Icon_15.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_15.Parent = tbl.ArrowUp_6

tbl.UIStroke_15.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_15.Thickness = 2
tbl.UIStroke_15.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_15.Parent = tbl.Value_7

tbl.TextBox_7.TextWrapped = true
tbl.TextBox_7.ZIndex = 3
tbl.TextBox_7.BorderSizePixel = 0
tbl.TextBox_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_7.BackgroundTransparency = 1
tbl.TextBox_7.TextSize = 11
tbl.TextBox_7.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_7.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_7.Text = "255"
tbl.TextBox_7.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_7.ClearTextOnFocus = false
tbl.TextBox_7.Parent = tbl.Value_7

tbl.UIPadding_7.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_7.Parent = tbl.TextBox_7

tbl.Label_7.Active = true
tbl.Label_7.ZIndex = 3
tbl.Label_7.BorderSizePixel = 0
tbl.Label_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_7.AnchorPoint = Vector2.new(1, 0)
tbl.Label_7.TextSize = 12
tbl.Label_7.Name = "Label"
tbl.Label_7.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_7.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_7.Text = "Val:"
tbl.Label_7.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_7.BackgroundTransparency = 1
tbl.Label_7.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_7.Parent = tbl.Val_1

tbl.Green_1.Active = true
tbl.Green_1.ZIndex = 3
tbl.Green_1.BorderSizePixel = 0
tbl.Green_1.Size = UDim2.new(0, 80, 0, 16)
tbl.Green_1.Position = UDim2.new(0, 115, 0, 31)
tbl.Green_1.BackgroundTransparency = 1
tbl.Green_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Green_1.Name = "Green"
tbl.Green_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Green_1.Parent = tbl.Fields_1

tbl.Value_8.AnchorPoint = Vector2.new(1, 0)
tbl.Value_8.Active = true
tbl.Value_8.ZIndex = 3
tbl.Value_8.BorderSizePixel = 0
tbl.Value_8.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_8.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_8.Name = "Value"
tbl.Value_8.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_8.Parent = tbl.Green_1

tbl.UICorner_20.CornerRadius = UDim.new(0, 4)
tbl.UICorner_20.Parent = tbl.Value_8

tbl.ArrowDown_7.ZIndex = 3
tbl.ArrowDown_7.BorderSizePixel = 0
tbl.ArrowDown_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_7.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_7.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_7.TextSize = 12
tbl.ArrowDown_7.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_7.Name = "ArrowDown"
tbl.ArrowDown_7.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_7.Text = ""
tbl.ArrowDown_7.TextTransparency = 1
tbl.ArrowDown_7.BackgroundTransparency = 1
tbl.ArrowDown_7.Selectable = false
tbl.ArrowDown_7.Parent = tbl.Value_8

tbl.Icon_16.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_16.Active = true
tbl.Icon_16.ZIndex = 3
tbl.Icon_16.BorderSizePixel = 0
tbl.Icon_16.ScaleType = Enum.ScaleType.Fit
tbl.Icon_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_16.Selectable = true
tbl.Icon_16.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_16.Image = "rbxassetid://14431841400"
tbl.Icon_16.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_16.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_16.Name = "Icon"
tbl.Icon_16.BackgroundTransparency = 1
tbl.Icon_16.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_16.Parent = tbl.ArrowDown_7

tbl.ArrowUp_7.ZIndex = 3
tbl.ArrowUp_7.BorderSizePixel = 0
tbl.ArrowUp_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_7.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_7.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_7.TextSize = 12
tbl.ArrowUp_7.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_7.Name = "ArrowUp"
tbl.ArrowUp_7.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_7.Text = ""
tbl.ArrowUp_7.TextTransparency = 1
tbl.ArrowUp_7.BackgroundTransparency = 1
tbl.ArrowUp_7.Selectable = false
tbl.ArrowUp_7.Parent = tbl.Value_8

tbl.Icon_17.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_17.Active = true
tbl.Icon_17.ZIndex = 3
tbl.Icon_17.BorderSizePixel = 0
tbl.Icon_17.ScaleType = Enum.ScaleType.Fit
tbl.Icon_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_17.Selectable = true
tbl.Icon_17.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_17.Image = "rbxassetid://14431841400"
tbl.Icon_17.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_17.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_17.Name = "Icon"
tbl.Icon_17.Rotation = 180
tbl.Icon_17.BackgroundTransparency = 1
tbl.Icon_17.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_17.Parent = tbl.ArrowUp_7

tbl.UIStroke_16.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_16.Thickness = 2
tbl.UIStroke_16.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_16.Parent = tbl.Value_8

tbl.TextBox_8.TextWrapped = true
tbl.TextBox_8.ZIndex = 3
tbl.TextBox_8.BorderSizePixel = 0
tbl.TextBox_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_8.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_8.BackgroundTransparency = 1
tbl.TextBox_8.TextSize = 11
tbl.TextBox_8.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_8.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_8.Text = "255"
tbl.TextBox_8.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_8.ClearTextOnFocus = false
tbl.TextBox_8.Parent = tbl.Value_8

tbl.UIPadding_8.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_8.Parent = tbl.TextBox_8

tbl.Label_8.Active = true
tbl.Label_8.ZIndex = 3
tbl.Label_8.BorderSizePixel = 0
tbl.Label_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_8.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_8.AnchorPoint = Vector2.new(1, 0)
tbl.Label_8.TextSize = 12
tbl.Label_8.Name = "Label"
tbl.Label_8.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_8.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_8.Text = "Green:"
tbl.Label_8.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_8.BackgroundTransparency = 1
tbl.Label_8.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_8.Parent = tbl.Green_1

tbl.Blue_1.Active = true
tbl.Blue_1.ZIndex = 3
tbl.Blue_1.BorderSizePixel = 0
tbl.Blue_1.Size = UDim2.new(0, 80, 0, 16)
tbl.Blue_1.Position = UDim2.new(0, 115, 0, 57)
tbl.Blue_1.BackgroundTransparency = 1
tbl.Blue_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Blue_1.Name = "Blue"
tbl.Blue_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Blue_1.Parent = tbl.Fields_1

tbl.Value_9.AnchorPoint = Vector2.new(1, 0)
tbl.Value_9.Active = true
tbl.Value_9.ZIndex = 3
tbl.Value_9.BorderSizePixel = 0
tbl.Value_9.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_9.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_9.Name = "Value"
tbl.Value_9.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_9.Parent = tbl.Blue_1

tbl.UICorner_21.CornerRadius = UDim.new(0, 4)
tbl.UICorner_21.Parent = tbl.Value_9

tbl.ArrowDown_8.ZIndex = 3
tbl.ArrowDown_8.BorderSizePixel = 0
tbl.ArrowDown_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_8.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_8.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_8.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_8.TextSize = 12
tbl.ArrowDown_8.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_8.Name = "ArrowDown"
tbl.ArrowDown_8.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_8.Text = ""
tbl.ArrowDown_8.TextTransparency = 1
tbl.ArrowDown_8.BackgroundTransparency = 1
tbl.ArrowDown_8.Selectable = false
tbl.ArrowDown_8.Parent = tbl.Value_9

tbl.Icon_18.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_18.Active = true
tbl.Icon_18.ZIndex = 3
tbl.Icon_18.BorderSizePixel = 0
tbl.Icon_18.ScaleType = Enum.ScaleType.Fit
tbl.Icon_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_18.Selectable = true
tbl.Icon_18.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_18.Image = "rbxassetid://14431841400"
tbl.Icon_18.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_18.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_18.Name = "Icon"
tbl.Icon_18.BackgroundTransparency = 1
tbl.Icon_18.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_18.Parent = tbl.ArrowDown_8

tbl.ArrowUp_8.ZIndex = 3
tbl.ArrowUp_8.BorderSizePixel = 0
tbl.ArrowUp_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_8.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_8.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_8.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_8.TextSize = 12
tbl.ArrowUp_8.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_8.Name = "ArrowUp"
tbl.ArrowUp_8.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_8.Text = ""
tbl.ArrowUp_8.TextTransparency = 1
tbl.ArrowUp_8.BackgroundTransparency = 1
tbl.ArrowUp_8.Selectable = false
tbl.ArrowUp_8.Parent = tbl.Value_9

tbl.Icon_19.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_19.Active = true
tbl.Icon_19.ZIndex = 3
tbl.Icon_19.BorderSizePixel = 0
tbl.Icon_19.ScaleType = Enum.ScaleType.Fit
tbl.Icon_19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_19.Selectable = true
tbl.Icon_19.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_19.Image = "rbxassetid://14431841400"
tbl.Icon_19.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_19.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_19.Name = "Icon"
tbl.Icon_19.Rotation = 180
tbl.Icon_19.BackgroundTransparency = 1
tbl.Icon_19.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_19.Parent = tbl.ArrowUp_8

tbl.UIStroke_17.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_17.Thickness = 2
tbl.UIStroke_17.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_17.Parent = tbl.Value_9

tbl.TextBox_9.TextWrapped = true
tbl.TextBox_9.ZIndex = 3
tbl.TextBox_9.BorderSizePixel = 0
tbl.TextBox_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_9.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_9.BackgroundTransparency = 1
tbl.TextBox_9.TextSize = 11
tbl.TextBox_9.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_9.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_9.Text = "255"
tbl.TextBox_9.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_9.ClearTextOnFocus = false
tbl.TextBox_9.Parent = tbl.Value_9

tbl.UIPadding_9.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_9.Parent = tbl.TextBox_9

tbl.Label_9.Active = true
tbl.Label_9.ZIndex = 3
tbl.Label_9.BorderSizePixel = 0
tbl.Label_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_9.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_9.AnchorPoint = Vector2.new(1, 0)
tbl.Label_9.TextSize = 12
tbl.Label_9.Name = "Label"
tbl.Label_9.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_9.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_9.Text = "Blue:"
tbl.Label_9.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_9.BackgroundTransparency = 1
tbl.Label_9.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_9.Parent = tbl.Blue_1

tbl.Hue_1.Active = true
tbl.Hue_1.ZIndex = 3
tbl.Hue_1.BorderSizePixel = 0
tbl.Hue_1.Size = UDim2.new(0, 80, 0, 16)
tbl.Hue_1.Position = UDim2.new(0, 10, 0, 5)
tbl.Hue_1.BackgroundTransparency = 1
tbl.Hue_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Hue_1.Name = "Hue"
tbl.Hue_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Hue_1.Parent = tbl.Fields_1

tbl.Value_10.AnchorPoint = Vector2.new(1, 0)
tbl.Value_10.Active = true
tbl.Value_10.ZIndex = 3
tbl.Value_10.BorderSizePixel = 0
tbl.Value_10.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_10.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_10.Name = "Value"
tbl.Value_10.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_10.Parent = tbl.Hue_1

tbl.UICorner_22.CornerRadius = UDim.new(0, 4)
tbl.UICorner_22.Parent = tbl.Value_10

tbl.ArrowDown_9.ZIndex = 3
tbl.ArrowDown_9.BorderSizePixel = 0
tbl.ArrowDown_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_9.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_9.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_9.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_9.TextSize = 12
tbl.ArrowDown_9.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_9.Name = "ArrowDown"
tbl.ArrowDown_9.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_9.Text = ""
tbl.ArrowDown_9.TextTransparency = 1
tbl.ArrowDown_9.BackgroundTransparency = 1
tbl.ArrowDown_9.Selectable = false
tbl.ArrowDown_9.Parent = tbl.Value_10

tbl.Icon_20.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_20.Active = true
tbl.Icon_20.ZIndex = 3
tbl.Icon_20.BorderSizePixel = 0
tbl.Icon_20.ScaleType = Enum.ScaleType.Fit
tbl.Icon_20.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_20.Selectable = true
tbl.Icon_20.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_20.Image = "rbxassetid://14431841400"
tbl.Icon_20.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_20.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_20.Name = "Icon"
tbl.Icon_20.BackgroundTransparency = 1
tbl.Icon_20.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_20.Parent = tbl.ArrowDown_9

tbl.ArrowUp_9.ZIndex = 3
tbl.ArrowUp_9.BorderSizePixel = 0
tbl.ArrowUp_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_9.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_9.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_9.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_9.TextSize = 12
tbl.ArrowUp_9.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_9.Name = "ArrowUp"
tbl.ArrowUp_9.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_9.Text = ""
tbl.ArrowUp_9.TextTransparency = 1
tbl.ArrowUp_9.BackgroundTransparency = 1
tbl.ArrowUp_9.Selectable = false
tbl.ArrowUp_9.Parent = tbl.Value_10

tbl.Icon_21.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_21.Active = true
tbl.Icon_21.ZIndex = 3
tbl.Icon_21.BorderSizePixel = 0
tbl.Icon_21.ScaleType = Enum.ScaleType.Fit
tbl.Icon_21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_21.Selectable = true
tbl.Icon_21.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_21.Image = "rbxassetid://14431841400"
tbl.Icon_21.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_21.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_21.Name = "Icon"
tbl.Icon_21.Rotation = 180
tbl.Icon_21.BackgroundTransparency = 1
tbl.Icon_21.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_21.Parent = tbl.ArrowUp_9

tbl.UIStroke_18.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_18.Thickness = 2
tbl.UIStroke_18.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_18.Parent = tbl.Value_10

tbl.TextBox_10.TextWrapped = true
tbl.TextBox_10.ZIndex = 3
tbl.TextBox_10.BorderSizePixel = 0
tbl.TextBox_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_10.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_10.BackgroundTransparency = 1
tbl.TextBox_10.TextSize = 11
tbl.TextBox_10.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_10.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_10.Text = "359"
tbl.TextBox_10.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_10.ClearTextOnFocus = false
tbl.TextBox_10.Parent = tbl.Value_10

tbl.UIPadding_10.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_10.Parent = tbl.TextBox_10

tbl.Label_10.Active = true
tbl.Label_10.ZIndex = 3
tbl.Label_10.BorderSizePixel = 0
tbl.Label_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_10.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_10.AnchorPoint = Vector2.new(1, 0)
tbl.Label_10.TextSize = 12
tbl.Label_10.Name = "Label"
tbl.Label_10.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_10.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_10.Text = "Hue:"
tbl.Label_10.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_10.BackgroundTransparency = 1
tbl.Label_10.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_10.Parent = tbl.Hue_1

tbl.Sat_1.Active = true
tbl.Sat_1.ZIndex = 3
tbl.Sat_1.BorderSizePixel = 0
tbl.Sat_1.Size = UDim2.new(0, 80, 0, 16)
tbl.Sat_1.Position = UDim2.new(0, 10, 0, 31)
tbl.Sat_1.BackgroundTransparency = 1
tbl.Sat_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Sat_1.Name = "Sat"
tbl.Sat_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Sat_1.Parent = tbl.Fields_1

tbl.Value_11.AnchorPoint = Vector2.new(1, 0)
tbl.Value_11.Active = true
tbl.Value_11.ZIndex = 3
tbl.Value_11.BorderSizePixel = 0
tbl.Value_11.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_11.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_11.Name = "Value"
tbl.Value_11.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_11.Parent = tbl.Sat_1

tbl.UICorner_23.CornerRadius = UDim.new(0, 4)
tbl.UICorner_23.Parent = tbl.Value_11

tbl.ArrowDown_10.ZIndex = 3
tbl.ArrowDown_10.BorderSizePixel = 0
tbl.ArrowDown_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_10.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_10.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_10.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_10.TextSize = 12
tbl.ArrowDown_10.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_10.Name = "ArrowDown"
tbl.ArrowDown_10.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_10.Text = ""
tbl.ArrowDown_10.TextTransparency = 1
tbl.ArrowDown_10.BackgroundTransparency = 1
tbl.ArrowDown_10.Selectable = false
tbl.ArrowDown_10.Parent = tbl.Value_11

tbl.Icon_22.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_22.Active = true
tbl.Icon_22.ZIndex = 3
tbl.Icon_22.BorderSizePixel = 0
tbl.Icon_22.ScaleType = Enum.ScaleType.Fit
tbl.Icon_22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_22.Selectable = true
tbl.Icon_22.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_22.Image = "rbxassetid://14431841400"
tbl.Icon_22.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_22.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_22.Name = "Icon"
tbl.Icon_22.BackgroundTransparency = 1
tbl.Icon_22.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_22.Parent = tbl.ArrowDown_10

tbl.ArrowUp_10.ZIndex = 3
tbl.ArrowUp_10.BorderSizePixel = 0
tbl.ArrowUp_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_10.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_10.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_10.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_10.TextSize = 12
tbl.ArrowUp_10.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_10.Name = "ArrowUp"
tbl.ArrowUp_10.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_10.Text = ""
tbl.ArrowUp_10.TextTransparency = 1
tbl.ArrowUp_10.BackgroundTransparency = 1
tbl.ArrowUp_10.Selectable = false
tbl.ArrowUp_10.Parent = tbl.Value_11

tbl.Icon_23.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_23.Active = true
tbl.Icon_23.ZIndex = 3
tbl.Icon_23.BorderSizePixel = 0
tbl.Icon_23.ScaleType = Enum.ScaleType.Fit
tbl.Icon_23.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_23.Selectable = true
tbl.Icon_23.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_23.Image = "rbxassetid://14431841400"
tbl.Icon_23.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_23.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_23.Name = "Icon"
tbl.Icon_23.Rotation = 180
tbl.Icon_23.BackgroundTransparency = 1
tbl.Icon_23.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_23.Parent = tbl.ArrowUp_10

tbl.UIStroke_19.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_19.Thickness = 2
tbl.UIStroke_19.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_19.Parent = tbl.Value_11

tbl.TextBox_11.TextWrapped = true
tbl.TextBox_11.ZIndex = 3
tbl.TextBox_11.BorderSizePixel = 0
tbl.TextBox_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_11.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_11.BackgroundTransparency = 1
tbl.TextBox_11.TextSize = 11
tbl.TextBox_11.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_11.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_11.Text = "255"
tbl.TextBox_11.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_11.ClearTextOnFocus = false
tbl.TextBox_11.Parent = tbl.Value_11

tbl.UIPadding_11.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_11.Parent = tbl.TextBox_11

tbl.Label_11.Active = true
tbl.Label_11.ZIndex = 3
tbl.Label_11.BorderSizePixel = 0
tbl.Label_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_11.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_11.AnchorPoint = Vector2.new(1, 0)
tbl.Label_11.TextSize = 12
tbl.Label_11.Name = "Label"
tbl.Label_11.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_11.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_11.Text = "Sat:"
tbl.Label_11.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_11.BackgroundTransparency = 1
tbl.Label_11.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_11.Parent = tbl.Sat_1

tbl.Red_1.Active = true
tbl.Red_1.ZIndex = 3
tbl.Red_1.BorderSizePixel = 0
tbl.Red_1.Size = UDim2.new(0, 80, 0, 16)
tbl.Red_1.Position = UDim2.new(0, 115, 0, 5)
tbl.Red_1.BackgroundTransparency = 1
tbl.Red_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Red_1.Name = "Red"
tbl.Red_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Red_1.Parent = tbl.Fields_1

tbl.Value_12.AnchorPoint = Vector2.new(1, 0)
tbl.Value_12.Active = true
tbl.Value_12.ZIndex = 3
tbl.Value_12.BorderSizePixel = 0
tbl.Value_12.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_12.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_12.Name = "Value"
tbl.Value_12.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_12.Parent = tbl.Red_1

tbl.UICorner_24.CornerRadius = UDim.new(0, 4)
tbl.UICorner_24.Parent = tbl.Value_12

tbl.ArrowDown_11.ZIndex = 3
tbl.ArrowDown_11.BorderSizePixel = 0
tbl.ArrowDown_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_11.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_11.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_11.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_11.TextSize = 12
tbl.ArrowDown_11.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_11.Name = "ArrowDown"
tbl.ArrowDown_11.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_11.Text = ""
tbl.ArrowDown_11.TextTransparency = 1
tbl.ArrowDown_11.BackgroundTransparency = 1
tbl.ArrowDown_11.Selectable = false
tbl.ArrowDown_11.Parent = tbl.Value_12

tbl.Icon_24.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_24.Active = true
tbl.Icon_24.ZIndex = 3
tbl.Icon_24.BorderSizePixel = 0
tbl.Icon_24.ScaleType = Enum.ScaleType.Fit
tbl.Icon_24.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_24.Selectable = true
tbl.Icon_24.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_24.Image = "rbxassetid://14431841400"
tbl.Icon_24.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_24.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_24.Name = "Icon"
tbl.Icon_24.BackgroundTransparency = 1
tbl.Icon_24.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_24.Parent = tbl.ArrowDown_11

tbl.ArrowUp_11.ZIndex = 3
tbl.ArrowUp_11.BorderSizePixel = 0
tbl.ArrowUp_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_11.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_11.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_11.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_11.TextSize = 12
tbl.ArrowUp_11.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_11.Name = "ArrowUp"
tbl.ArrowUp_11.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_11.Text = ""
tbl.ArrowUp_11.TextTransparency = 1
tbl.ArrowUp_11.BackgroundTransparency = 1
tbl.ArrowUp_11.Selectable = false
tbl.ArrowUp_11.Parent = tbl.Value_12

tbl.Icon_25.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_25.Active = true
tbl.Icon_25.ZIndex = 3
tbl.Icon_25.BorderSizePixel = 0
tbl.Icon_25.ScaleType = Enum.ScaleType.Fit
tbl.Icon_25.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_25.Selectable = true
tbl.Icon_25.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_25.Image = "rbxassetid://14431841400"
tbl.Icon_25.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_25.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_25.Name = "Icon"
tbl.Icon_25.Rotation = 180
tbl.Icon_25.BackgroundTransparency = 1
tbl.Icon_25.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_25.Parent = tbl.ArrowUp_11

tbl.UIStroke_20.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_20.Thickness = 2
tbl.UIStroke_20.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_20.Parent = tbl.Value_12

tbl.TextBox_12.TextWrapped = true
tbl.TextBox_12.ZIndex = 3
tbl.TextBox_12.BorderSizePixel = 0
tbl.TextBox_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_12.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_12.BackgroundTransparency = 1
tbl.TextBox_12.TextSize = 11
tbl.TextBox_12.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_12.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_12.Text = "255"
tbl.TextBox_12.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_12.ClearTextOnFocus = false
tbl.TextBox_12.Parent = tbl.Value_12

tbl.UIPadding_12.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_12.Parent = tbl.TextBox_12

tbl.Label_12.Active = true
tbl.Label_12.ZIndex = 3
tbl.Label_12.BorderSizePixel = 0
tbl.Label_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_12.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_12.AnchorPoint = Vector2.new(1, 0)
tbl.Label_12.TextSize = 12
tbl.Label_12.Name = "Label"
tbl.Label_12.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_12.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_12.Text = "Red:"
tbl.Label_12.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_12.BackgroundTransparency = 1
tbl.Label_12.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_12.Parent = tbl.Red_1

tbl.Hex_1.Active = true
tbl.Hex_1.ZIndex = 3
tbl.Hex_1.BorderSizePixel = 0
tbl.Hex_1.Size = UDim2.new(0, 95, 0, 16)
tbl.Hex_1.Position = UDim2.new(0, 5, 0, 83)
tbl.Hex_1.BackgroundTransparency = 1
tbl.Hex_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Hex_1.Name = "Hex"
tbl.Hex_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Hex_1.Parent = tbl.Fields_1

tbl.Value_13.AnchorPoint = Vector2.new(1, 0)
tbl.Value_13.Active = true
tbl.Value_13.ZIndex = 3
tbl.Value_13.BorderSizePixel = 0
tbl.Value_13.Size = UDim2.new(0, 55, 0, 16)
tbl.Value_13.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_13.Name = "Value"
tbl.Value_13.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_13.Parent = tbl.Hex_1

tbl.UICorner_25.CornerRadius = UDim.new(0, 4)
tbl.UICorner_25.Parent = tbl.Value_13

tbl.UIStroke_21.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_21.Thickness = 2
tbl.UIStroke_21.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_21.Parent = tbl.Value_13

tbl.TextBox_13.ZIndex = 3
tbl.TextBox_13.BorderSizePixel = 0
tbl.TextBox_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_13.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_13.BackgroundTransparency = 1
tbl.TextBox_13.TextSize = 11
tbl.TextBox_13.Size = UDim2.new(1, 0, 0, 15)
tbl.TextBox_13.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_13.Text = "#FFFFFF"
tbl.TextBox_13.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_13.ClearTextOnFocus = false
tbl.TextBox_13.Parent = tbl.Value_13

tbl.UIPadding_13.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_13.Parent = tbl.TextBox_13

tbl.Label_13.Active = true
tbl.Label_13.ZIndex = 3
tbl.Label_13.BorderSizePixel = 0
tbl.Label_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_13.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_13.AnchorPoint = Vector2.new(1, 0)
tbl.Label_13.TextSize = 12
tbl.Label_13.Name = "Label"
tbl.Label_13.Size = UDim2.new(0, 40, 0, 15)
tbl.Label_13.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_13.Text = "Hex:"
tbl.Label_13.Position = UDim2.new(1, -60, 0, 0)
tbl.Label_13.BackgroundTransparency = 1
tbl.Label_13.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_13.Parent = tbl.Hex_1

tbl.Alpha.Active = true
tbl.Alpha.ZIndex = 3
tbl.Alpha.BorderSizePixel = 0
tbl.Alpha.Size = UDim2.new(0, 80, 0, 16)
tbl.Alpha.Position = UDim2.new(0, 115, 0, 83)
tbl.Alpha.BackgroundTransparency = 1
tbl.Alpha.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Alpha.Name = "Alpha"
tbl.Alpha.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Alpha.Parent = tbl.Fields_1

tbl.Value_14.AnchorPoint = Vector2.new(1, 0)
tbl.Value_14.Active = true
tbl.Value_14.ZIndex = 3
tbl.Value_14.BorderSizePixel = 0
tbl.Value_14.Size = UDim2.new(0, 45, 0, 16)
tbl.Value_14.Position = UDim2.new(1, 0, 0, 0)
tbl.Value_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Value_14.Name = "Value"
tbl.Value_14.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.Value_14.Parent = tbl.Alpha

tbl.UICorner_26.CornerRadius = UDim.new(0, 4)
tbl.UICorner_26.Parent = tbl.Value_14

tbl.ArrowDown_12.ZIndex = 3
tbl.ArrowDown_12.BorderSizePixel = 0
tbl.ArrowDown_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowDown_12.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowDown_12.Position = UDim2.new(1, 0, 1, 0)
tbl.ArrowDown_12.AnchorPoint = Vector2.new(1, 1)
tbl.ArrowDown_12.TextSize = 12
tbl.ArrowDown_12.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowDown_12.Name = "ArrowDown"
tbl.ArrowDown_12.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowDown_12.Text = ""
tbl.ArrowDown_12.TextTransparency = 1
tbl.ArrowDown_12.BackgroundTransparency = 1
tbl.ArrowDown_12.Selectable = false
tbl.ArrowDown_12.Parent = tbl.Value_14

tbl.Icon_26.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_26.Active = true
tbl.Icon_26.ZIndex = 3
tbl.Icon_26.BorderSizePixel = 0
tbl.Icon_26.ScaleType = Enum.ScaleType.Fit
tbl.Icon_26.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_26.Selectable = true
tbl.Icon_26.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_26.Image = "rbxassetid://14431841400"
tbl.Icon_26.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_26.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_26.Name = "Icon"
tbl.Icon_26.BackgroundTransparency = 1
tbl.Icon_26.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_26.Parent = tbl.ArrowDown_12

tbl.ArrowUp_12.ZIndex = 3
tbl.ArrowUp_12.BorderSizePixel = 0
tbl.ArrowUp_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ArrowUp_12.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ArrowUp_12.Position = UDim2.new(1, 0, 0, 0)
tbl.ArrowUp_12.AnchorPoint = Vector2.new(1, 0)
tbl.ArrowUp_12.TextSize = 12
tbl.ArrowUp_12.Size = UDim2.new(0, 15, 0.5, 0)
tbl.ArrowUp_12.Name = "ArrowUp"
tbl.ArrowUp_12.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ArrowUp_12.Text = ""
tbl.ArrowUp_12.TextTransparency = 1
tbl.ArrowUp_12.BackgroundTransparency = 1
tbl.ArrowUp_12.Selectable = false
tbl.ArrowUp_12.Parent = tbl.Value_14

tbl.Icon_27.ImageColor3 = Color3.fromRGB(200, 200, 200)
tbl.Icon_27.Active = true
tbl.Icon_27.ZIndex = 3
tbl.Icon_27.BorderSizePixel = 0
tbl.Icon_27.ScaleType = Enum.ScaleType.Fit
tbl.Icon_27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_27.Selectable = true
tbl.Icon_27.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_27.Image = "rbxassetid://14431841400"
tbl.Icon_27.Size = UDim2.new(0, 4, 0, 3)
tbl.Icon_27.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_27.Name = "Icon"
tbl.Icon_27.Rotation = 180
tbl.Icon_27.BackgroundTransparency = 1
tbl.Icon_27.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_27.Parent = tbl.ArrowUp_12

tbl.UIStroke_22.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_22.Thickness = 2
tbl.UIStroke_22.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_22.Parent = tbl.Value_14

tbl.TextBox_14.ZIndex = 3
tbl.TextBox_14.BorderSizePixel = 0
tbl.TextBox_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_14.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.TextBox_14.BackgroundTransparency = 1
tbl.TextBox_14.TextSize = 11
tbl.TextBox_14.Size = UDim2.new(0, 30, 0, 15)
tbl.TextBox_14.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_14.Text = "100%"
tbl.TextBox_14.TextXAlignment = Enum.TextXAlignment.Left
tbl.TextBox_14.ClearTextOnFocus = false
tbl.TextBox_14.Parent = tbl.Value_14

tbl.UIPadding_14.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_14.Parent = tbl.TextBox_14

tbl.Label_14.Active = true
tbl.Label_14.ZIndex = 3
tbl.Label_14.BorderSizePixel = 0
tbl.Label_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_14.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Label_14.AnchorPoint = Vector2.new(1, 0)
tbl.Label_14.TextSize = 12
tbl.Label_14.Name = "Label"
tbl.Label_14.Size = UDim2.new(0, 30, 0, 15)
tbl.Label_14.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_14.Text = "Alpha:"
tbl.Label_14.Position = UDim2.new(1, -50, 0, 0)
tbl.Label_14.BackgroundTransparency = 1
tbl.Label_14.TextXAlignment = Enum.TextXAlignment.Right
tbl.Label_14.Parent = tbl.Alpha

tbl.AlphaGradient.AnchorPoint = Vector2.new(1, 0)
tbl.AlphaGradient.Active = true
tbl.AlphaGradient.ZIndex = 4
tbl.AlphaGradient.BorderSizePixel = 0
tbl.AlphaGradient.Size = UDim2.new(0, 20, 0, 100)
tbl.AlphaGradient.Position = UDim2.new(1, -5, 0, 5)
tbl.AlphaGradient.BackgroundTransparency = 1
tbl.AlphaGradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.AlphaGradient.Name = "AlphaGradient"
tbl.AlphaGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.AlphaGradient.Parent = tbl.PickColor_1

tbl.UIStroke_23.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl.UIStroke_23.Thickness = 2
tbl.UIStroke_23.Color = Color3.fromRGB(60, 62, 64)
tbl.UIStroke_23.Parent = tbl.AlphaGradient

tbl.UICorner_27.CornerRadius = UDim.new(0, 4)
tbl.UICorner_27.Parent = tbl.AlphaGradient

tbl.UIGradient_2.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }
tbl.UIGradient_2.Rotation = 270
tbl.UIGradient_2.Parent = tbl.AlphaGradient

tbl.Cursor_4.AnchorPoint = Vector2.new(0, 0.5)
tbl.Cursor_4.Active = true
tbl.Cursor_4.ZIndex = 5
tbl.Cursor_4.BorderSizePixel = 0
tbl.Cursor_4.Size = UDim2.new(0, 10, 0, 10)
tbl.Cursor_4.Position = UDim2.new(1, 0, 0, 0)
tbl.Cursor_4.BackgroundTransparency = 1
tbl.Cursor_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Cursor_4.Name = "Cursor"
tbl.Cursor_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Cursor_4.Parent = tbl.AlphaGradient

tbl.Icon_28.Active = true
tbl.Icon_28.ZIndex = 5
tbl.Icon_28.BorderSizePixel = 0
tbl.Icon_28.ScaleType = Enum.ScaleType.Fit
tbl.Icon_28.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_28.AnchorPoint = Vector2.new(0, 0.5)
tbl.Icon_28.Image = "rbxassetid://14431841400"
tbl.Icon_28.Size = UDim2.new(0, 8, 0, 5)
tbl.Icon_28.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_28.Name = "Icon"
tbl.Icon_28.Rotation = 90
tbl.Icon_28.BackgroundTransparency = 1
tbl.Icon_28.Position = UDim2.new(0, -2, 0.5, 0)
tbl.Icon_28.Parent = tbl.Cursor_4

tbl.Grid.Active = true
tbl.Grid.ZIndex = 3
tbl.Grid.BorderSizePixel = 0
tbl.Grid.ScaleType = Enum.ScaleType.Tile
tbl.Grid.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Grid.Image = "rbxassetid://14434090503"
tbl.Grid.TileSize = UDim2.new(0, 20, 0, 20)
tbl.Grid.Size = UDim2.new(1, 0, 1, 0)
tbl.Grid.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Grid.Name = "Grid"
tbl.Grid.ResampleMode = Enum.ResamplerMode.Pixelated
tbl.Grid.BackgroundTransparency = 1
tbl.Grid.Parent = tbl.AlphaGradient

tbl.UIGradient_3.Transparency = NumberSequence.new{ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }
tbl.UIGradient_3.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 130, 130)) }
tbl.UIGradient_3.Rotation = 90
tbl.UIGradient_3.Parent = tbl.Grid

tbl.Color_2.ZIndex = 4
tbl.Color_2.BorderSizePixel = 0
tbl.Color_2.AutoButtonColor = false
tbl.Color_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Color_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Color_2.TextSize = 14
tbl.Color_2.Size = UDim2.new(1, 0, 1, 0)
tbl.Color_2.Name = "Color"
tbl.Color_2.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Color_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Color_2.Text = ""
tbl.Color_2.Selectable = false
tbl.Color_2.Parent = tbl.AlphaGradient

tbl.UIGradient_4.Transparency = NumberSequence.new{ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }
tbl.UIGradient_4.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200)) }
tbl.UIGradient_4.Rotation = 90
tbl.UIGradient_4.Parent = tbl.Color_2

tbl.UICorner_28.CornerRadius = UDim.new(0, 4)
tbl.UICorner_28.Parent = tbl.Color_2

tbl.Color_3.AnchorPoint = Vector2.new(1, 0)
tbl.Color_3.Active = true
tbl.Color_3.ZIndex = 2
tbl.Color_3.BorderSizePixel = 0
tbl.Color_3.Size = UDim2.new(0.5, 8, 1, 0)
tbl.Color_3.Position = UDim2.new(1, 0, 0, 0)
tbl.Color_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Color_3.Name = "Color"
tbl.Color_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Color_3.Parent = tbl.Color_1

tbl.UICorner_29.CornerRadius = UDim.new(0, 6)
tbl.UICorner_29.Parent = tbl.Color_3

tbl.BottomCorner.AnchorPoint = Vector2.new(0, 1)
tbl.BottomCorner.Active = true
tbl.BottomCorner.ZIndex = 2
tbl.BottomCorner.BorderSizePixel = 0
tbl.BottomCorner.Size = UDim2.new(0, 8, 0, 8)
tbl.BottomCorner.Position = UDim2.new(0, 0, 1, 0)
tbl.BottomCorner.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.BottomCorner.Name = "BottomCorner"
tbl.BottomCorner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.BottomCorner.Parent = tbl.Color_3

tbl.TopCorner.Active = true
tbl.TopCorner.ZIndex = 2
tbl.TopCorner.BorderSizePixel = 0
tbl.TopCorner.Size = UDim2.new(0, 8, 0, 8)
tbl.TopCorner.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TopCorner.Name = "TopCorner"
tbl.TopCorner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TopCorner.Parent = tbl.Color_3

tbl.ColorHexCode.Active = true
tbl.ColorHexCode.ZIndex = 2
tbl.ColorHexCode.BorderSizePixel = 0
tbl.ColorHexCode.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ColorHexCode.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.ColorHexCode.TextSize = 13
tbl.ColorHexCode.Name = "ColorHexCode"
tbl.ColorHexCode.Size = UDim2.new(1, 0, 1, 0)
tbl.ColorHexCode.TextColor3 = Color3.fromRGB(60, 62, 64)
tbl.ColorHexCode.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ColorHexCode.Text = "#FFFFFF"
tbl.ColorHexCode.BackgroundTransparency = 1
tbl.ColorHexCode.Parent = tbl.Color_3

tbl.ColorAlpha.Active = true
tbl.ColorAlpha.ZIndex = 2
tbl.ColorAlpha.BorderSizePixel = 0
tbl.ColorAlpha.Size = UDim2.new(0.5, 0, 1, 0)
tbl.ColorAlpha.BackgroundTransparency = 0.45
tbl.ColorAlpha.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ColorAlpha.Name = "ColorAlpha"
tbl.ColorAlpha.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.ColorAlpha.Parent = tbl.Color_1

tbl.UICorner_30.CornerRadius = UDim.new(0, 6)
tbl.UICorner_30.Parent = tbl.ColorAlpha

tbl.TopCorner_1.AnchorPoint = Vector2.new(1, 0)
tbl.TopCorner_1.Active = true
tbl.TopCorner_1.ZIndex = 2
tbl.TopCorner_1.BorderSizePixel = 0
tbl.TopCorner_1.Size = UDim2.new(0, 8, 0, 8)
tbl.TopCorner_1.Position = UDim2.new(1, 0, 0, 0)
tbl.TopCorner_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TopCorner_1.Visible = false
tbl.TopCorner_1.Name = "TopCorner"
tbl.TopCorner_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TopCorner_1.Parent = tbl.ColorAlpha

tbl.BottomCorner_1.AnchorPoint = Vector2.new(1, 1)
tbl.BottomCorner_1.Active = true
tbl.BottomCorner_1.ZIndex = 2
tbl.BottomCorner_1.BorderSizePixel = 0
tbl.BottomCorner_1.Size = UDim2.new(0, 8, 0, 8)
tbl.BottomCorner_1.Position = UDim2.new(1, 0, 1, 0)
tbl.BottomCorner_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.BottomCorner_1.Visible = false
tbl.BottomCorner_1.Name = "BottomCorner"
tbl.BottomCorner_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.BottomCorner_1.Parent = tbl.ColorAlpha

tbl.AlphaPercentage.Active = true
tbl.AlphaPercentage.ZIndex = 2
tbl.AlphaPercentage.BorderSizePixel = 0
tbl.AlphaPercentage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.AlphaPercentage.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.AlphaPercentage.TextSize = 13
tbl.AlphaPercentage.Name = "AlphaPercentage"
tbl.AlphaPercentage.Size = UDim2.new(1, 0, 1, 0)
tbl.AlphaPercentage.TextColor3 = Color3.fromRGB(60, 62, 64)
tbl.AlphaPercentage.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.AlphaPercentage.Text = "65%"
tbl.AlphaPercentage.BackgroundTransparency = 1
tbl.AlphaPercentage.Parent = tbl.ColorAlpha

tbl.Grid_1.Active = true
tbl.Grid_1.BorderSizePixel = 0
tbl.Grid_1.ScaleType = Enum.ScaleType.Tile
tbl.Grid_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Grid_1.Image = "rbxassetid://14434056199"
tbl.Grid_1.TileSize = UDim2.new(0, 16, 0, 16)
tbl.Grid_1.Size = UDim2.new(1.1, 0, 1, 0)
tbl.Grid_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Grid_1.Name = "Grid"
tbl.Grid_1.ResampleMode = Enum.ResamplerMode.Pixelated
tbl.Grid_1.BackgroundTransparency = 1
tbl.Grid_1.Parent = tbl.ColorAlpha

tbl.UICorner_31.CornerRadius = UDim.new(0, 6)
tbl.UICorner_31.Parent = tbl.Grid_1

tbl.Field.Name = "Field"
tbl.Field.Parent = tbl.Module

tbl.Field_1.Active = true
tbl.Field_1.BorderSizePixel = 0
tbl.Field_1.Size = UDim2.new(1, 0, 0, 45)
tbl.Field_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Field_1.Name = "Field"
tbl.Field_1.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.Field_1.Parent = tbl.Field

tbl.UICorner_32.CornerRadius = UDim.new(0, 6)
tbl.UICorner_32.Parent = tbl.Field_1

tbl.Top_2.Active = true
tbl.Top_2.BorderSizePixel = 0
tbl.Top_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top_2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Top_2.TextSize = 12
tbl.Top_2.Name = "Top"
tbl.Top_2.AutomaticSize = Enum.AutomaticSize.X
tbl.Top_2.Size = UDim2.new(0, 0, 0, 16)
tbl.Top_2.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Top_2.Text = "Field"
tbl.Top_2.BackgroundTransparency = 1
tbl.Top_2.TextXAlignment = Enum.TextXAlignment.Left
tbl.Top_2.Parent = tbl.Field_1

tbl.UIPadding_15.PaddingTop = UDim.new(0, 4)
tbl.UIPadding_15.PaddingLeft = UDim.new(0, 10)
tbl.UIPadding_15.Parent = tbl.Top_2

tbl.Field_2.AnchorPoint = Vector2.new(0.5, 1)
tbl.Field_2.Active = true
tbl.Field_2.BorderSizePixel = 0
tbl.Field_2.Size = UDim2.new(1, -10, 0, 19)
tbl.Field_2.Position = UDim2.new(0.5, 0, 1, -5)
tbl.Field_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Field_2.Name = "Field"
tbl.Field_2.BackgroundColor3 = Color3.fromRGB(22, 23, 25)
tbl.Field_2.Parent = tbl.Field_1

tbl.UICorner_33.CornerRadius = UDim.new(0, 6)
tbl.UICorner_33.Parent = tbl.Field_2

tbl.TextBox_15.BorderSizePixel = 0
tbl.TextBox_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_15.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.TextBox_15.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.TextBox_15.BackgroundTransparency = 1
tbl.TextBox_15.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.TextBox_15.TextSize = 12
tbl.TextBox_15.ClipsDescendants = true
tbl.TextBox_15.Size = UDim2.new(1, 0, 1, 0)
tbl.TextBox_15.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.TextBox_15.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TextBox_15.Text = ""
tbl.TextBox_15.ClearTextOnFocus = false
tbl.TextBox_15.Parent = tbl.Field_2

tbl.Slider.Name = "Slider"
tbl.Slider.Parent = tbl.Module

tbl.Slider_1.Active = true
tbl.Slider_1.BorderSizePixel = 0
tbl.Slider_1.Size = UDim2.new(1, 0, 0, 45)
tbl.Slider_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Slider_1.Name = "Slider"
tbl.Slider_1.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.Slider_1.Parent = tbl.Slider

tbl.UICorner_34.CornerRadius = UDim.new(0, 6)
tbl.UICorner_34.Parent = tbl.Slider_1

tbl.Bar.AnchorPoint = Vector2.new(0.5, 1)
tbl.Bar.Active = true
tbl.Bar.BorderSizePixel = 0
tbl.Bar.Size = UDim2.new(1, -20, 0, 4)
tbl.Bar.Position = UDim2.new(0.5, 0, 1, -8)
tbl.Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Bar.Name = "Bar"
tbl.Bar.BackgroundColor3 = Color3.fromRGB(67, 68, 70)
tbl.Bar.Parent = tbl.Slider_1

tbl.UICorner_35.Parent = tbl.Bar

tbl.Fill.Active = true
tbl.Fill.BorderSizePixel = 0
tbl.Fill.Size = UDim2.new(0, 0, 1, 0)
tbl.Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Fill.Name = "Fill"
tbl.Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Fill.Parent = tbl.Bar

tbl.UICorner_36.Parent = tbl.Fill

tbl.UIGradient_5.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 128, 85)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 178)) }
tbl.UIGradient_5.Parent = tbl.Fill

tbl.Ball.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Ball.Active = true
tbl.Ball.BorderSizePixel = 0
tbl.Ball.Size = UDim2.new(0, 7, 0, 7)
tbl.Ball.Position = UDim2.new(1, 0, 0.5, 0)
tbl.Ball.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Ball.Name = "Ball"
tbl.Ball.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Ball.Parent = tbl.Fill

tbl.UIStroke_24.Color = Color3.fromRGB(200, 200, 200)
tbl.UIStroke_24.Parent = tbl.Ball

tbl.UICorner_37.CornerRadius = UDim.new(1, 0)
tbl.UICorner_37.Parent = tbl.Ball

tbl.Click_4.BorderSizePixel = 0
tbl.Click_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Click_4.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Click_4.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Click_4.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Click_4.TextSize = 14
tbl.Click_4.Size = UDim2.new(2.5, 0, 2.5, 0)
tbl.Click_4.Name = "Click"
tbl.Click_4.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_4.Text = ""
tbl.Click_4.BackgroundTransparency = 1
tbl.Click_4.Parent = tbl.Ball

tbl.Min.Active = true
tbl.Min.BorderSizePixel = 0
tbl.Min.TextYAlignment = Enum.TextYAlignment.Bottom
tbl.Min.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Min.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Min.AnchorPoint = Vector2.new(0, 1)
tbl.Min.TextSize = 13
tbl.Min.Name = "Min"
tbl.Min.Size = UDim2.new(0, 100, 0, 16)
tbl.Min.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Min.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Min.Text = "1"
tbl.Min.Position = UDim2.new(0, 0, 0, -1)
tbl.Min.BackgroundTransparency = 1
tbl.Min.TextXAlignment = Enum.TextXAlignment.Left
tbl.Min.Parent = tbl.Bar

tbl.UIPadding_16.PaddingBottom = UDim.new(0, 1)
tbl.UIPadding_16.Parent = tbl.Min

tbl.UIGradient_6.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.435233, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150)) }
tbl.UIGradient_6.Enabled = false
tbl.UIGradient_6.Rotation = 90
tbl.UIGradient_6.Parent = tbl.Min

tbl.Max.Active = true
tbl.Max.BorderSizePixel = 0
tbl.Max.TextYAlignment = Enum.TextYAlignment.Bottom
tbl.Max.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Max.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Max.AnchorPoint = Vector2.new(1, 1)
tbl.Max.TextSize = 13
tbl.Max.Name = "Max"
tbl.Max.Size = UDim2.new(0, 100, 0, 16)
tbl.Max.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Max.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Max.Text = "1000"
tbl.Max.Position = UDim2.new(1, 0, 0, -1)
tbl.Max.BackgroundTransparency = 1
tbl.Max.TextXAlignment = Enum.TextXAlignment.Right
tbl.Max.Parent = tbl.Bar

tbl.UIPadding_17.PaddingBottom = UDim.new(0, 1)
tbl.UIPadding_17.Parent = tbl.Max

tbl.UIGradient_7.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.435233, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150)) }
tbl.UIGradient_7.Enabled = false
tbl.UIGradient_7.Rotation = 90
tbl.UIGradient_7.Parent = tbl.Max

tbl.Top_3.Active = true
tbl.Top_3.BorderSizePixel = 0
tbl.Top_3.Size = UDim2.new(1, -10, 0, 16)
tbl.Top_3.Position = UDim2.new(0, 0, 0, -1)
tbl.Top_3.BackgroundTransparency = 1
tbl.Top_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Top_3.Name = "Top"
tbl.Top_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top_3.Parent = tbl.Slider_1

tbl.NameT.Active = true
tbl.NameT.BorderSizePixel = 0
tbl.NameT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.NameT.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.NameT.TextSize = 12
tbl.NameT.Name = "NameT"
tbl.NameT.AutomaticSize = Enum.AutomaticSize.X
tbl.NameT.Size = UDim2.new(0, 30, 1, 0)
tbl.NameT.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.NameT.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.NameT.Text = "fdfgsgfsgfgfdgdf"
tbl.NameT.BackgroundTransparency = 1
tbl.NameT.TextXAlignment = Enum.TextXAlignment.Left
tbl.NameT.Parent = tbl.Top_3

tbl.Input.BorderSizePixel = 0
tbl.Input.Selectable = false
tbl.Input.BackgroundColor3 = Color3.fromRGB(49, 50, 54)
tbl.Input.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Input.Position = UDim2.new(0, 40, 0, 0)
tbl.Input.AutomaticSize = Enum.AutomaticSize.X
tbl.Input.TextSize = 10
tbl.Input.Size = UDim2.new(0, 30, 1, 0)
tbl.Input.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Input.Text = "000000000000000000000000"
tbl.Input.Name = "Input"
tbl.Input.Parent = tbl.Top_3

tbl.UICorner_38.CornerRadius = UDim.new(0, 6)
tbl.UICorner_38.Parent = tbl.Input

tbl.UIPadding_18.PaddingRight = UDim.new(0, 5)
tbl.UIPadding_18.PaddingLeft = UDim.new(0, 5)
tbl.UIPadding_18.Parent = tbl.Input

tbl.UIPadding_19.PaddingTop = UDim.new(0, 4)
tbl.UIPadding_19.PaddingLeft = UDim.new(0, 10)
tbl.UIPadding_19.Parent = tbl.Top_3

tbl.Button.Name = "Button"
tbl.Button.Parent = tbl.Module

tbl.Button_1.BorderSizePixel = 0
tbl.Button_1.AutoButtonColor = false
tbl.Button_1.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.Button_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Button_1.TextSize = 12
tbl.Button_1.Size = UDim2.new(1, 0, 0, 28)
tbl.Button_1.Name = "Button"
tbl.Button_1.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Button_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Button_1.Parent = tbl.Button

tbl.UICorner_39.CornerRadius = UDim.new(0, 6)
tbl.UICorner_39.Parent = tbl.Button_1

tbl.Dropdown.Name = "Dropdown"
tbl.Dropdown.Parent = tbl.Module

tbl.Dropdown_1.Active = true
tbl.Dropdown_1.BorderSizePixel = 0
tbl.Dropdown_1.Size = UDim2.new(1, 0, 0, 28)
tbl.Dropdown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Dropdown_1.Name = "Dropdown"
tbl.Dropdown_1.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.Dropdown_1.Parent = tbl.Dropdown

tbl.UICorner_40.CornerRadius = UDim.new(0, 6)
tbl.UICorner_40.Parent = tbl.Dropdown_1

tbl.Selected.BorderSizePixel = 0
tbl.Selected.AutoButtonColor = false
tbl.Selected.BackgroundColor3 = Color3.fromRGB(38, 40, 43)
tbl.Selected.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Selected.Position = UDim2.new(1, -5, 0.5, 0)
tbl.Selected.AnchorPoint = Vector2.new(1, 0.5)
tbl.Selected.TextSize = 12
tbl.Selected.Size = UDim2.new(1, -85, 0, 20)
tbl.Selected.Name = "Selected"
tbl.Selected.TextColor3 = Color3.fromRGB(185, 185, 185)
tbl.Selected.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Selected.Text = "Selected"
tbl.Selected.TextXAlignment = Enum.TextXAlignment.Left
tbl.Selected.Selectable = false
tbl.Selected.Parent = tbl.Dropdown_1

tbl.UICorner_41.CornerRadius = UDim.new(0, 6)
tbl.UICorner_41.Parent = tbl.Selected

tbl.Arrow.BorderSizePixel = 0
tbl.Arrow.BackgroundColor3 = Color3.fromRGB(49, 52, 56)
tbl.Arrow.AnchorPoint = Vector2.new(1, 0.5)
tbl.Arrow.Image = "rbxassetid://14422218995"
tbl.Arrow.Size = UDim2.new(0, 20, 0, 20)
tbl.Arrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Arrow.Name = "Arrow"
tbl.Arrow.BackgroundTransparency = 1
tbl.Arrow.Position = UDim2.new(1, -1, 0.5, 0)
tbl.Arrow.Parent = tbl.Selected

tbl.Options.Active = true
tbl.Options.ZIndex = 3
tbl.Options.BorderSizePixel = 0
tbl.Options.Size = UDim2.new(1, 10, 0, 0)
tbl.Options.Position = UDim2.new(0, -10, 0, 0)
tbl.Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Options.ClipsDescendants = true
tbl.Options.Name = "Options"
tbl.Options.BackgroundColor3 = Color3.fromRGB(28, 29, 31)
tbl.Options.Parent = tbl.Selected

tbl.SearchBar.ZIndex = 3
tbl.SearchBar.BorderSizePixel = 0
tbl.SearchBar.Selectable = false
tbl.SearchBar.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.SearchBar.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.SearchBar.Position = UDim2.new(0, 5, 0, 25)
tbl.SearchBar.PlaceholderText = "Search for an option..."
tbl.SearchBar.TextSize = 14
tbl.SearchBar.ClipsDescendants = true
tbl.SearchBar.Size = UDim2.new(1, -10, 0, 25)
tbl.SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.SearchBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.SearchBar.Text = ""
tbl.SearchBar.Name = "SearchBar"
tbl.SearchBar.TextXAlignment = Enum.TextXAlignment.Left
tbl.SearchBar.Parent = tbl.Options

tbl.UICorner_42.CornerRadius = UDim.new(0, 6)
tbl.UICorner_42.Parent = tbl.SearchBar

tbl.UIPadding_20.PaddingLeft = UDim.new(0, 28)
tbl.UIPadding_20.Parent = tbl.SearchBar

tbl.SearchIcon.Active = true
tbl.SearchIcon.ZIndex = 3
tbl.SearchIcon.BorderSizePixel = 0
tbl.SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.SearchIcon.Image = "rbxassetid://14422634325"
tbl.SearchIcon.Size = UDim2.new(0, 25, 0, 25)
tbl.SearchIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.SearchIcon.Name = "SearchIcon"
tbl.SearchIcon.BackgroundTransparency = 1
tbl.SearchIcon.Position = UDim2.new(0, -28, 0, 0)
tbl.SearchIcon.Parent = tbl.SearchBar

tbl.UICorner_43.CornerRadius = UDim.new(0, 6)
tbl.UICorner_43.Parent = tbl.Options

tbl.Items.ZIndex = 3
tbl.Items.BorderSizePixel = 0
tbl.Items.CanvasSize = UDim2.new(0, 0, 0, 0)
tbl.Items.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
tbl.Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Items.AutomaticCanvasSize = Enum.AutomaticSize.Y
tbl.Items.AutomaticSize = Enum.AutomaticSize.X
tbl.Items.Size = UDim2.new(1, 0, 1, -60)
tbl.Items.ScrollBarImageColor3 = Color3.fromRGB(83, 85, 88)
tbl.Items.BackgroundTransparency = 1
tbl.Items.Active = true
tbl.Items.ScrollBarThickness = 3
tbl.Items.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Items.Name = "Items"
tbl.Items.Position = UDim2.new(0, 0, 0, 55)
tbl.Items.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
tbl.Items.Parent = tbl.Options

tbl.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
tbl.UIListLayout.Padding = UDim.new(0, 5)
tbl.UIListLayout.Parent = tbl.Items

tbl.Item.Active = true
tbl.Item.ZIndex = 3
tbl.Item.BorderSizePixel = 0
tbl.Item.Size = UDim2.new(1, 0, 0, 20)
tbl.Item.BackgroundTransparency = 1
tbl.Item.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Item.Visible = false
tbl.Item.Name = "Item"
tbl.Item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Item.Parent = tbl.Items

tbl.Click_5.ZIndex = 3
tbl.Click_5.BorderSizePixel = 0
tbl.Click_5.AutoButtonColor = false
tbl.Click_5.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.Click_5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Click_5.Position = UDim2.new(0.5, 0, 0, 0)
tbl.Click_5.AnchorPoint = Vector2.new(0.5, 0)
tbl.Click_5.TextSize = 12
tbl.Click_5.Size = UDim2.new(1, -10, 0, 20)
tbl.Click_5.Name = "Click"
tbl.Click_5.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Click_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_5.Parent = tbl.Item

tbl.UICorner_44.CornerRadius = UDim.new(0, 6)
tbl.UICorner_44.Parent = tbl.Click_5

tbl.Enabled.AnchorPoint = Vector2.new(1, 0.5)
tbl.Enabled.Active = true
tbl.Enabled.ZIndex = 3
tbl.Enabled.BorderSizePixel = 0
tbl.Enabled.Size = UDim2.new(0, 8, 0, 8)
tbl.Enabled.Position = UDim2.new(1, -10, 0.5, 0)
tbl.Enabled.BackgroundTransparency = 1
tbl.Enabled.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Enabled.Name = "Enabled"
tbl.Enabled.BackgroundColor3 = Color3.fromRGB(0, 255, 178)
tbl.Enabled.Parent = tbl.Click_5

tbl.UICorner_45.CornerRadius = UDim.new(1, 0)
tbl.UICorner_45.Parent = tbl.Enabled

tbl.UIPadding_21.PaddingBottom = UDim.new(0, 5)
tbl.UIPadding_21.PaddingRight = UDim.new(0, 5)
tbl.UIPadding_21.Parent = tbl.Items

tbl.DropShadowHolder_2.Active = true
tbl.DropShadowHolder_2.ZIndex = 2
tbl.DropShadowHolder_2.BorderSizePixel = 0
tbl.DropShadowHolder_2.Size = UDim2.new(1, 0, 1, -20)
tbl.DropShadowHolder_2.Position = UDim2.new(0, 0, 0, 20)
tbl.DropShadowHolder_2.BackgroundTransparency = 1
tbl.DropShadowHolder_2.Name = "DropShadowHolder"
tbl.DropShadowHolder_2.Parent = tbl.Options

tbl.DropShadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
tbl.DropShadow_2.Active = true
tbl.DropShadow_2.ZIndex = 2
tbl.DropShadow_2.BorderSizePixel = 0
tbl.DropShadow_2.SliceCenter = Rect.new(49, 49, 450, 450)
tbl.DropShadow_2.ScaleType = Enum.ScaleType.Slice
tbl.DropShadow_2.ImageTransparency = 0.5
tbl.DropShadow_2.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.DropShadow_2.Image = "rbxassetid://6014261993"
tbl.DropShadow_2.Size = UDim2.new(1, 47, 1, 47)
tbl.DropShadow_2.Name = "DropShadow"
tbl.DropShadow_2.BackgroundTransparency = 1
tbl.DropShadow_2.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.DropShadow_2.Parent = tbl.DropShadowHolder_2

tbl.UIPadding_22.PaddingLeft = UDim.new(0, 10)
tbl.UIPadding_22.Parent = tbl.Selected

tbl.Top_4.Active = true
tbl.Top_4.BorderSizePixel = 0
tbl.Top_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top_4.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Top_4.AnchorPoint = Vector2.new(0, 0.5)
tbl.Top_4.TextSize = 12
tbl.Top_4.Name = "Top"
tbl.Top_4.Size = UDim2.new(0, 120, 0, 16)
tbl.Top_4.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Top_4.Text = "Dropdown"
tbl.Top_4.Position = UDim2.new(0, 10, 0.5, 0)
tbl.Top_4.BackgroundTransparency = 1
tbl.Top_4.TextXAlignment = Enum.TextXAlignment.Left
tbl.Top_4.Parent = tbl.Dropdown_1

tbl.Toggle.Name = "Toggle"
tbl.Toggle.Parent = tbl.Module

tbl.Toggle_1.BorderSizePixel = 0
tbl.Toggle_1.AutoButtonColor = false
tbl.Toggle_1.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.Toggle_1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Toggle_1.TextSize = 14
tbl.Toggle_1.Size = UDim2.new(1, 0, 0, 28)
tbl.Toggle_1.Name = "Toggle"
tbl.Toggle_1.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Toggle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Toggle_1.Text = ""
tbl.Toggle_1.Selectable = false
tbl.Toggle_1.Parent = tbl.Toggle

tbl.UICorner_46.CornerRadius = UDim.new(0, 6)
tbl.UICorner_46.Parent = tbl.Toggle_1

tbl.Top_5.Active = true
tbl.Top_5.BorderSizePixel = 0
tbl.Top_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top_5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Top_5.AnchorPoint = Vector2.new(0, 0.5)
tbl.Top_5.TextSize = 12
tbl.Top_5.Name = "Top"
tbl.Top_5.Size = UDim2.new(0, 120, 0, 16)
tbl.Top_5.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Top_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Top_5.Text = "Toggle"
tbl.Top_5.Position = UDim2.new(0, 10, 0.5, 0)
tbl.Top_5.BackgroundTransparency = 1
tbl.Top_5.TextXAlignment = Enum.TextXAlignment.Left
tbl.Top_5.Parent = tbl.Toggle_1

tbl.Click_6.BorderSizePixel = 0
tbl.Click_6.AutoButtonColor = false
tbl.Click_6.BackgroundColor3 = Color3.fromRGB(83, 85, 88)
tbl.Click_6.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Click_6.Position = UDim2.new(1, -25, 0.5, 0)
tbl.Click_6.AnchorPoint = Vector2.new(0, 0.5)
tbl.Click_6.TextSize = 14
tbl.Click_6.Size = UDim2.new(0, 20, 0, 20)
tbl.Click_6.Name = "Click"
tbl.Click_6.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_6.Text = ""
tbl.Click_6.Selectable = false
tbl.Click_6.Parent = tbl.Toggle_1

tbl.UICorner_47.CornerRadius = UDim.new(0, 6)
tbl.UICorner_47.Parent = tbl.Click_6

tbl.Tick.Active = true
tbl.Tick.BorderSizePixel = 0
tbl.Tick.ScaleType = Enum.ScaleType.Fit
tbl.Tick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Tick.ImageTransparency = 1
tbl.Tick.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Tick.Image = "rbxassetid://14396562503"
tbl.Tick.Size = UDim2.new(0.5, 0, 0.5, 0)
tbl.Tick.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Tick.Name = "Tick"
tbl.Tick.BackgroundTransparency = 1
tbl.Tick.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Tick.Parent = tbl.Click_6

tbl.Label_15.Name = "Label"
tbl.Label_15.Parent = tbl.Module

tbl.Label_16.Active = true
tbl.Label_16.BorderSizePixel = 0
tbl.Label_16.Size = UDim2.new(1, 0, 0, 45)
tbl.Label_16.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_16.Name = "Label"
tbl.Label_16.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.Label_16.Parent = tbl.Label_15

tbl.UICorner_48.CornerRadius = UDim.new(0, 6)
tbl.UICorner_48.Parent = tbl.Label_16

tbl.Header.Active = true
tbl.Header.BorderSizePixel = 0
tbl.Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Header.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Header.TextSize = 14
tbl.Header.Name = "Header"
tbl.Header.Size = UDim2.new(1, -40, 0, 15)
tbl.Header.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Header.Text = "Header"
tbl.Header.Position = UDim2.new(0, 10, 0, 5)
tbl.Header.BackgroundTransparency = 1
tbl.Header.TextXAlignment = Enum.TextXAlignment.Left
tbl.Header.Parent = tbl.Label_16

tbl.Content.TextWrapped = true
tbl.Content.Active = true
tbl.Content.BorderSizePixel = 0
tbl.Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Content.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Content.TextSize = 12
tbl.Content.Name = "Content"
tbl.Content.AutomaticSize = Enum.AutomaticSize.Y
tbl.Content.Size = UDim2.new(1, -10, 0, 15)
tbl.Content.TextColor3 = Color3.fromRGB(220, 220, 220)
tbl.Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Content.Text = "Content"
tbl.Content.Position = UDim2.new(0, 10, 0, 25)
tbl.Content.BackgroundTransparency = 1
tbl.Content.TextXAlignment = Enum.TextXAlignment.Left
tbl.Content.Parent = tbl.Label_16

tbl.Copied.BorderSizePixel = 0
tbl.Copied.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Copied.ImageTransparency = 1
tbl.Copied.AnchorPoint = Vector2.new(1, 0)
tbl.Copied.Image = "rbxassetid://14742528737"
tbl.Copied.Size = UDim2.new(0, 16, 0, 16)
tbl.Copied.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Copied.Name = "Copied"
tbl.Copied.BackgroundTransparency = 1
tbl.Copied.Position = UDim2.new(1, -5, 0, 5)
tbl.Copied.Parent = tbl.Label_16

tbl.Copy.Active = false
tbl.Copy.BorderSizePixel = 0
tbl.Copy.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Copy.Visible = false
tbl.Copy.Selectable = false
tbl.Copy.AnchorPoint = Vector2.new(1, 0)
tbl.Copy.Image = "rbxassetid://14742492906"
tbl.Copy.Size = UDim2.new(0, 16, 0, 16)
tbl.Copy.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Copy.Name = "Copy"
tbl.Copy.BackgroundTransparency = 1
tbl.Copy.Position = UDim2.new(1, -5, 0, 5)
tbl.Copy.Parent = tbl.Label_16

tbl.ModuleTemplate.Active = true
tbl.ModuleTemplate.BorderSizePixel = 0
tbl.ModuleTemplate.Size = UDim2.new(1, -5, 0, 30)
tbl.ModuleTemplate.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.ModuleTemplate.Name = "ModuleTemplate"
tbl.ModuleTemplate.BackgroundColor3 = Color3.fromRGB(21, 23, 28)
tbl.ModuleTemplate.Parent = tbl.Module

tbl.Click_7.ZIndex = 2
tbl.Click_7.BorderSizePixel = 0
tbl.Click_7.AutoButtonColor = false
tbl.Click_7.BackgroundColor3 = Color3.fromRGB(23, 28, 36)
tbl.Click_7.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Click_7.Position = UDim2.new(0.5, 0, 0, 0)
tbl.Click_7.AnchorPoint = Vector2.new(0.5, 0)
tbl.Click_7.TextSize = 14
tbl.Click_7.Size = UDim2.new(1, 0, 0, 30)
tbl.Click_7.Name = "Click"
tbl.Click_7.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_7.Text = ""
tbl.Click_7.Selectable = false
tbl.Click_7.Parent = tbl.ModuleTemplate

tbl.UICorner_49.CornerRadius = UDim.new(0, 6)
tbl.UICorner_49.Parent = tbl.Click_7

tbl.Label_17.Active = true
tbl.Label_17.ZIndex = 2
tbl.Label_17.BorderSizePixel = 0
tbl.Label_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_17.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Label_17.TextSize = 14
tbl.Label_17.Name = "Label"
tbl.Label_17.Size = UDim2.new(0, 150, 0, 20)
tbl.Label_17.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Label_17.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Label_17.Text = "Auto-Farm"
tbl.Label_17.Position = UDim2.new(0, 31, 0, 5)
tbl.Label_17.BackgroundTransparency = 1
tbl.Label_17.TextXAlignment = Enum.TextXAlignment.Left
tbl.Label_17.Parent = tbl.Click_7

tbl.Toggle_2.ZIndex = 2
tbl.Toggle_2.BorderSizePixel = 0
tbl.Toggle_2.AutoButtonColor = false
tbl.Toggle_2.BackgroundColor3 = Color3.fromRGB(83, 85, 88)
tbl.Toggle_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Toggle_2.Position = UDim2.new(1, -25, 0, 5)
tbl.Toggle_2.TextSize = 14
tbl.Toggle_2.Size = UDim2.new(0, 20, 0, 20)
tbl.Toggle_2.Name = "Toggle"
tbl.Toggle_2.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Toggle_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Toggle_2.Text = ""
tbl.Toggle_2.Selectable = false
tbl.Toggle_2.Parent = tbl.Click_7

tbl.UICorner_50.CornerRadius = UDim.new(0, 6)
tbl.UICorner_50.Parent = tbl.Toggle_2

tbl.Tick_1.Active = true
tbl.Tick_1.ZIndex = 2
tbl.Tick_1.BorderSizePixel = 0
tbl.Tick_1.ScaleType = Enum.ScaleType.Fit
tbl.Tick_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Tick_1.ImageTransparency = 1
tbl.Tick_1.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Tick_1.Image = "rbxassetid://14396562503"
tbl.Tick_1.Size = UDim2.new(0.5, 0, 0.5, 0)
tbl.Tick_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Tick_1.Name = "Tick"
tbl.Tick_1.BackgroundTransparency = 1
tbl.Tick_1.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Tick_1.Parent = tbl.Toggle_2

tbl.Configurate.ZIndex = 2
tbl.Configurate.BorderSizePixel = 0
tbl.Configurate.AutoButtonColor = false
tbl.Configurate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Configurate.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Configurate.Position = UDim2.new(1, 10, 0, 5)
tbl.Configurate.TextSize = 14
tbl.Configurate.Size = UDim2.new(0, 20, 0, 20)
tbl.Configurate.Name = "Configurate"
tbl.Configurate.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Configurate.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Configurate.Text = ""
tbl.Configurate.TextTransparency = 1
tbl.Configurate.BackgroundTransparency = 1
tbl.Configurate.Selectable = false
tbl.Configurate.Parent = tbl.Click_7

tbl.Icon_29.Active = true
tbl.Icon_29.ZIndex = 2
tbl.Icon_29.BorderSizePixel = 0
tbl.Icon_29.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Icon_29.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Icon_29.Image = "rbxassetid://14396857686"
tbl.Icon_29.Size = UDim2.new(0, 16, 0, 15)
tbl.Icon_29.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Icon_29.Name = "Icon"
tbl.Icon_29.BackgroundTransparency = 1
tbl.Icon_29.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Icon_29.Parent = tbl.Configurate

tbl.Star.ZIndex = 2
tbl.Star.BorderSizePixel = 0
tbl.Star.AutoButtonColor = false
tbl.Star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Star.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Star.Position = UDim2.new(0, 5, 0, 5)
tbl.Star.TextSize = 14
tbl.Star.Size = UDim2.new(0, 20, 0, 20)
tbl.Star.Name = "Star"
tbl.Star.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Star.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Star.Text = ""
tbl.Star.BackgroundTransparency = 1
tbl.Star.Parent = tbl.Click_7

tbl.Favorited.Active = true
tbl.Favorited.ZIndex = 2
tbl.Favorited.BorderSizePixel = 0
tbl.Favorited.ScaleType = Enum.ScaleType.Fit
tbl.Favorited.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Favorited.ImageTransparency = 1
tbl.Favorited.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Favorited.Image = "rbxassetid://14406026270"
tbl.Favorited.Size = UDim2.new(0, 15, 0, 15)
tbl.Favorited.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Favorited.Name = "Favorited"
tbl.Favorited.BackgroundTransparency = 1
tbl.Favorited.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Favorited.Parent = tbl.Star

tbl.Unfavorited.Active = true
tbl.Unfavorited.ZIndex = 2
tbl.Unfavorited.BorderSizePixel = 0
tbl.Unfavorited.ScaleType = Enum.ScaleType.Fit
tbl.Unfavorited.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Unfavorited.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Unfavorited.Image = "rbxassetid://14396855086"
tbl.Unfavorited.Size = UDim2.new(0, 15, 0, 15)
tbl.Unfavorited.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Unfavorited.Name = "Unfavorited"
tbl.Unfavorited.BackgroundTransparency = 1
tbl.Unfavorited.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Unfavorited.Parent = tbl.Star

tbl.Keybind.ZIndex = 2
tbl.Keybind.BorderSizePixel = 0
tbl.Keybind.AutoButtonColor = false
tbl.Keybind.BackgroundColor3 = Color3.fromRGB(41, 51, 65)
tbl.Keybind.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Keybind.Position = UDim2.new(1, -30, 0, 5)
tbl.Keybind.AutomaticSize = Enum.AutomaticSize.X
tbl.Keybind.AnchorPoint = Vector2.new(1, 0)
tbl.Keybind.TextSize = 14
tbl.Keybind.Size = UDim2.new(0, 20, 0, 20)
tbl.Keybind.Name = "Keybind"
tbl.Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Keybind.Text = "..."
tbl.Keybind.Selectable = false
tbl.Keybind.Parent = tbl.Click_7

tbl.UICorner_51.CornerRadius = UDim.new(0, 6)
tbl.UICorner_51.Parent = tbl.Keybind

tbl.UIPadding_23.PaddingRight = UDim.new(0, 4)
tbl.UIPadding_23.PaddingLeft = UDim.new(0, 4)
tbl.UIPadding_23.Parent = tbl.Keybind

tbl.UICorner_52.CornerRadius = UDim.new(0, 6)
tbl.UICorner_52.Parent = tbl.ModuleTemplate

tbl.SettingsHolder.AnchorPoint = Vector2.new(0.5, 1)
tbl.SettingsHolder.Active = true
tbl.SettingsHolder.BorderSizePixel = 0
tbl.SettingsHolder.Size = UDim2.new(1, -10, 0, 0)
tbl.SettingsHolder.Position = UDim2.new(0.5, 0, 0, 25)
tbl.SettingsHolder.BackgroundTransparency = 1
tbl.SettingsHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.SettingsHolder.ClipsDescendants = true
tbl.SettingsHolder.Name = "SettingsHolder"
tbl.SettingsHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.SettingsHolder.Parent = tbl.ModuleTemplate

tbl.UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
tbl.UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Bottom
tbl.UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
tbl.UIListLayout_1.Padding = UDim.new(0, 5)
tbl.UIListLayout_1.Parent = tbl.SettingsHolder

tbl.TabSelector.Active = true
tbl.TabSelector.BorderSizePixel = 0
tbl.TabSelector.Size = UDim2.new(1, 0, 0, 20)
tbl.TabSelector.BackgroundTransparency = 1
tbl.TabSelector.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TabSelector.Name = "TabSelector"
tbl.TabSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TabSelector.Parent = tbl.Tab

tbl.Click_8.TextWrapped = true
tbl.Click_8.BorderSizePixel = 0
tbl.Click_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Click_8.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Click_8.TextSize = 14
tbl.Click_8.Size = UDim2.new(1, 0, 1, 0)
tbl.Click_8.Name = "Click"
tbl.Click_8.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Click_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Click_8.Text = "Main"
tbl.Click_8.TextTransparency = 0.7
tbl.Click_8.BackgroundTransparency = 1
tbl.Click_8.TextXAlignment = Enum.TextXAlignment.Left
tbl.Click_8.Selectable = false
tbl.Click_8.Parent = tbl.TabSelector

tbl.TabContainer.ScrollingDirection = Enum.ScrollingDirection.Y
tbl.TabContainer.BorderSizePixel = 0
tbl.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
tbl.TabContainer.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
tbl.TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TabContainer.Size = UDim2.new(1, -15, 1, -45)
tbl.TabContainer.ScrollBarImageColor3 = Color3.fromRGB(83, 85, 88)
tbl.TabContainer.BackgroundTransparency = 1
tbl.TabContainer.Active = true
tbl.TabContainer.ScrollBarThickness = 3
tbl.TabContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TabContainer.Name = "TabContainer"
tbl.TabContainer.Position = UDim2.new(0, 10, 1, 45)
tbl.TabContainer.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
tbl.TabContainer.Parent = tbl.Tab

tbl.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
tbl.UIListLayout_2.Padding = UDim.new(0, 5)
tbl.UIListLayout_2.Parent = tbl.TabContainer

tbl.Notification.Name = "Notification"
tbl.Notification.Parent = tbl.UI

tbl.Notification_1.AnchorPoint = Vector2.new(0, 1)
tbl.Notification_1.BorderSizePixel = 0
tbl.Notification_1.Size = UDim2.new(0.975, 0, 0, 55)
tbl.Notification_1.Position = UDim2.new(1.2, 0, 1, 0)
tbl.Notification_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Notification_1.Name = "Notification"
tbl.Notification_1.BackgroundColor3 = Color3.fromRGB(14, 17, 22)
tbl.Notification_1.Parent = tbl.Notification

tbl.Header_1.Active = true
tbl.Header_1.BorderSizePixel = 0
tbl.Header_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Header_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
tbl.Header_1.TextSize = 14
tbl.Header_1.Name = "Header"
tbl.Header_1.Size = UDim2.new(1, -40, 0, 15)
tbl.Header_1.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Header_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Header_1.Text = "Header"
tbl.Header_1.Position = UDim2.new(0, 10, 0, 5)
tbl.Header_1.BackgroundTransparency = 1
tbl.Header_1.TextXAlignment = Enum.TextXAlignment.Left
tbl.Header_1.Parent = tbl.Notification_1

tbl.Content_1.TextWrapped = true
tbl.Content_1.Active = true
tbl.Content_1.BorderSizePixel = 0
tbl.Content_1.RichText = true
tbl.Content_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Content_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Content_1.TextSize = 12
tbl.Content_1.Name = "Content"
tbl.Content_1.Size = UDim2.new(1, -10, 1, -30)
tbl.Content_1.TextColor3 = Color3.fromRGB(220, 220, 220)
tbl.Content_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Content_1.Text = "Content"
tbl.Content_1.Position = UDim2.new(0, 10, 0, 25)
tbl.Content_1.BackgroundTransparency = 1
tbl.Content_1.TextXAlignment = Enum.TextXAlignment.Left
tbl.Content_1.Parent = tbl.Notification_1

tbl.UIPadding_24.PaddingBottom = UDim.new(0, 10)
tbl.UIPadding_24.Parent = tbl.Content_1

tbl.TimeLeft.AnchorPoint = Vector2.new(0, 1)
tbl.TimeLeft.BorderSizePixel = 0
tbl.TimeLeft.Size = UDim2.new(1, 0, 0, 20)
tbl.TimeLeft.Position = UDim2.new(0, 0, 1, 0)
tbl.TimeLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TimeLeft.ClipsDescendants = true
tbl.TimeLeft.Name = "TimeLeft"
tbl.TimeLeft.BackgroundColor3 = Color3.fromRGB(35, 43, 55)
tbl.TimeLeft.Parent = tbl.Notification_1

tbl.UICorner_53.CornerRadius = UDim.new(0, 6)
tbl.UICorner_53.Parent = tbl.TimeLeft

tbl.UIGradient_8.Transparency = NumberSequence.new{ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.749, 1), NumberSequenceKeypoint.new(0.75, 0), NumberSequenceKeypoint.new(1, 0) }
tbl.UIGradient_8.Rotation = 90
tbl.UIGradient_8.Parent = tbl.TimeLeft

tbl.Left.AnchorPoint = Vector2.new(1, 1)
tbl.Left.BorderSizePixel = 0
tbl.Left.Size = UDim2.new(0, 5, 0, 5)
tbl.Left.Position = UDim2.new(1, 0, 1, 0)
tbl.Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Left.Name = "Left"
tbl.Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Left.Parent = tbl.TimeLeft

tbl.UICorner_54.CornerRadius = UDim.new(0, 6)
tbl.UICorner_54.Parent = tbl.Notification_1

tbl.MouseIcon.Active = true
tbl.MouseIcon.ZIndex = 10
tbl.MouseIcon.BorderSizePixel = 0
tbl.MouseIcon.ScaleType = Enum.ScaleType.Fit
tbl.MouseIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.MouseIcon.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.MouseIcon.Image = "rbxassetid://14753494134"
tbl.MouseIcon.Size = UDim2.new(0, 25, 0, 25)
tbl.MouseIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.MouseIcon.Name = "MouseIcon"
tbl.MouseIcon.BackgroundTransparency = 1
tbl.MouseIcon.Parent = tbl.UI

tbl.GUI.Enabled = false
tbl.GUI.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
tbl.GUI.ResetOnSpawn = false
tbl.GUI.IgnoreGuiInset = true
tbl.GUI.Name = "GUI"
tbl.GUI.Parent = tbl.UI

tbl.Notifications.AnchorPoint = Vector2.new(1, 0.5)
tbl.Notifications.BorderSizePixel = 0
tbl.Notifications.Size = UDim2.new(0.25, 0, 1, -10)
tbl.Notifications.Position = UDim2.new(1, 0, 0.5, 0)
tbl.Notifications.BackgroundTransparency = 1
tbl.Notifications.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Notifications.ClipsDescendants = true
tbl.Notifications.Name = "Notifications"
tbl.Notifications.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Notifications.Parent = tbl.GUI

tbl.Main.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Main.Active = true
tbl.Main.BorderSizePixel = 0
tbl.Main.Size = UDim2.new(0.4, 0, 0.45, 0)
tbl.Main.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Main.BackgroundTransparency = 0.5
tbl.Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Main.Name = "Main"
tbl.Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
tbl.Main.Parent = tbl.GUI

tbl.SideBar.AnchorPoint = Vector2.new(0, 1)
tbl.SideBar.Active = true
tbl.SideBar.BorderSizePixel = 0
tbl.SideBar.Size = UDim2.new(0, 120, 1, -37)
tbl.SideBar.Position = UDim2.new(3.17891e-08, 0, 1, 0)
tbl.SideBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.SideBar.Name = "SideBar"
tbl.SideBar.BackgroundColor3 = Color3.fromRGB(14, 17, 22)
tbl.SideBar.Parent = tbl.Main

tbl.UICorner_55.CornerRadius = UDim.new(0, 6)
tbl.UICorner_55.Parent = tbl.SideBar

tbl.TabHolder.ScrollingDirection = Enum.ScrollingDirection.Y
tbl.TabHolder.BorderSizePixel = 0
tbl.TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
tbl.TabHolder.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
tbl.TabHolder.AnchorPoint = Vector2.new(0.5, 0)
tbl.TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TabHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
tbl.TabHolder.Size = UDim2.new(0.7, 0, 0.7, 0)
tbl.TabHolder.BackgroundTransparency = 1
tbl.TabHolder.Active = true
tbl.TabHolder.ScrollBarThickness = 3
tbl.TabHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TabHolder.Name = "TabHolder"
tbl.TabHolder.Position = UDim2.new(0.5, 0, 0, 8)
tbl.TabHolder.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
tbl.TabHolder.Parent = tbl.SideBar

tbl.UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
tbl.UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
tbl.UIListLayout_3.Padding = UDim.new(0, 3)
tbl.UIListLayout_3.Parent = tbl.TabHolder

tbl.TopBar.Active = true
tbl.TopBar.BorderSizePixel = 0
tbl.TopBar.Size = UDim2.new(1, 0, 0, 30)
tbl.TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TopBar.Name = "TopBar"
tbl.TopBar.BackgroundColor3 = Color3.fromRGB(14, 17, 22)
tbl.TopBar.Parent = tbl.Main

tbl.UICorner_56.CornerRadius = UDim.new(0, 6)
tbl.UICorner_56.Parent = tbl.TopBar

tbl.Title.TextWrapped = true
tbl.Title.Active = true
tbl.Title.BorderSizePixel = 0
tbl.Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
tbl.Title.TextSize = 14
tbl.Title.Name = "Title"
tbl.Title.Size = UDim2.new(0, 200, 1, 0)
tbl.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Title.Text = "BioHazard Hub | AFS-X"
tbl.Title.BackgroundTransparency = 1
tbl.Title.TextXAlignment = Enum.TextXAlignment.Left
tbl.Title.Parent = tbl.TopBar

tbl.UIPadding_25.PaddingLeft = UDim.new(0, 9)
tbl.UIPadding_25.Parent = tbl.Title

tbl.Settings.SizeConstraint = Enum.SizeConstraint.RelativeYY
tbl.Settings.BorderSizePixel = 0
tbl.Settings.Modal = true
tbl.Settings.AutoButtonColor = false
tbl.Settings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Settings.AnchorPoint = Vector2.new(1, 0)
tbl.Settings.Image = "rbxassetid://14480870736"
tbl.Settings.Size = UDim2.new(1, 0, 1, 0)
tbl.Settings.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Settings.Name = "Settings"
tbl.Settings.BackgroundTransparency = 1
tbl.Settings.Position = UDim2.new(1, 0, 0, 0)
tbl.Settings.Parent = tbl.TopBar

tbl.TabHolder_1.AnchorPoint = Vector2.new(0, 1)
tbl.TabHolder_1.Active = true
tbl.TabHolder_1.BorderSizePixel = 0
tbl.TabHolder_1.Size = UDim2.new(1, -127, 1, -37)
tbl.TabHolder_1.Position = UDim2.new(0, 127, 1, 0)
tbl.TabHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TabHolder_1.ClipsDescendants = true
tbl.TabHolder_1.Name = "TabHolder"
tbl.TabHolder_1.BackgroundColor3 = Color3.fromRGB(14, 17, 22)
tbl.TabHolder_1.Parent = tbl.Main

tbl.UICorner_57.CornerRadius = UDim.new(0, 6)
tbl.UICorner_57.Parent = tbl.TabHolder_1

tbl.SearchBar_1.ZIndex = 3
tbl.SearchBar_1.BorderSizePixel = 0
tbl.SearchBar_1.Selectable = false
tbl.SearchBar_1.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
tbl.SearchBar_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.SearchBar_1.Position = UDim2.new(0, 10, 0, 10)
tbl.SearchBar_1.PlaceholderText = "Search for a module..."
tbl.SearchBar_1.TextSize = 14
tbl.SearchBar_1.ClipsDescendants = true
tbl.SearchBar_1.Size = UDim2.new(1, -20, 0, 25)
tbl.SearchBar_1.TextColor3 = Color3.fromRGB(255, 255, 255)
tbl.SearchBar_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.SearchBar_1.Text = ""
tbl.SearchBar_1.Name = "SearchBar"
tbl.SearchBar_1.TextXAlignment = Enum.TextXAlignment.Left
tbl.SearchBar_1.Parent = tbl.TabHolder_1

tbl.UICorner_58.CornerRadius = UDim.new(0, 6)
tbl.UICorner_58.Parent = tbl.SearchBar_1

tbl.UIPadding_26.PaddingLeft = UDim.new(0, 28)
tbl.UIPadding_26.Parent = tbl.SearchBar_1

tbl.SearchIcon_1.Active = true
tbl.SearchIcon_1.ZIndex = 3
tbl.SearchIcon_1.BorderSizePixel = 0
tbl.SearchIcon_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.SearchIcon_1.Image = "rbxassetid://14422634325"
tbl.SearchIcon_1.Size = UDim2.new(0, 25, 0, 25)
tbl.SearchIcon_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.SearchIcon_1.Name = "SearchIcon"
tbl.SearchIcon_1.BackgroundTransparency = 1
tbl.SearchIcon_1.Position = UDim2.new(0, -28, 0, 0)
tbl.SearchIcon_1.Parent = tbl.SearchBar_1

tbl.Star_1.ZIndex = 3
tbl.Star_1.BorderSizePixel = 0
tbl.Star_1.AutoButtonColor = false
tbl.Star_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Star_1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
tbl.Star_1.Position = UDim2.new(1, -25, 0.5, 0)
tbl.Star_1.AnchorPoint = Vector2.new(0, 0.5)
tbl.Star_1.TextSize = 14
tbl.Star_1.Size = UDim2.new(0, 20, 0, 20)
tbl.Star_1.Name = "Star"
tbl.Star_1.TextColor3 = Color3.fromRGB(0, 0, 0)
tbl.Star_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Star_1.Text = ""
tbl.Star_1.BackgroundTransparency = 1
tbl.Star_1.Parent = tbl.SearchBar_1

tbl.Favorited_1.Active = true
tbl.Favorited_1.ZIndex = 3
tbl.Favorited_1.BorderSizePixel = 0
tbl.Favorited_1.ScaleType = Enum.ScaleType.Fit
tbl.Favorited_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Favorited_1.ImageTransparency = 1
tbl.Favorited_1.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Favorited_1.Image = "rbxassetid://14406026270"
tbl.Favorited_1.Size = UDim2.new(0, 15, 0, 15)
tbl.Favorited_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Favorited_1.Name = "Favorited"
tbl.Favorited_1.BackgroundTransparency = 1
tbl.Favorited_1.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Favorited_1.Parent = tbl.Star_1

tbl.Unfavorited_1.Active = true
tbl.Unfavorited_1.ZIndex = 3
tbl.Unfavorited_1.BorderSizePixel = 0
tbl.Unfavorited_1.ScaleType = Enum.ScaleType.Fit
tbl.Unfavorited_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.Unfavorited_1.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.Unfavorited_1.Image = "rbxassetid://14396855086"
tbl.Unfavorited_1.Size = UDim2.new(0, 15, 0, 15)
tbl.Unfavorited_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.Unfavorited_1.Name = "Unfavorited"
tbl.Unfavorited_1.BackgroundTransparency = 1
tbl.Unfavorited_1.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.Unfavorited_1.Parent = tbl.Star_1

tbl.TabContainer_1.ScrollingDirection = Enum.ScrollingDirection.Y
tbl.TabContainer_1.BorderSizePixel = 0
tbl.TabContainer_1.CanvasSize = UDim2.new(0, 0, 0, 0)
tbl.TabContainer_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
tbl.TabContainer_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbl.TabContainer_1.Size = UDim2.new(1, -15, 1, -45)
tbl.TabContainer_1.ScrollBarImageColor3 = Color3.fromRGB(83, 85, 88)
tbl.TabContainer_1.BackgroundTransparency = 1
tbl.TabContainer_1.Active = true
tbl.TabContainer_1.ScrollBarThickness = 3
tbl.TabContainer_1.Visible = false
tbl.TabContainer_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.TabContainer_1.Name = "TabContainer"
tbl.TabContainer_1.Position = UDim2.new(0, 10, 0, 45)
tbl.TabContainer_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
tbl.TabContainer_1.Parent = tbl.TabHolder_1

tbl.UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
tbl.UIListLayout_4.Padding = UDim.new(0, 5)
tbl.UIListLayout_4.Parent = tbl.TabContainer_1

tbl.SearchFrame.Active = true
tbl.SearchFrame.ZIndex = 2
tbl.SearchFrame.BorderSizePixel = 0
tbl.SearchFrame.Size = UDim2.new(1, 0, 0, 45)
tbl.SearchFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
tbl.SearchFrame.Visible = false
tbl.SearchFrame.Name = "SearchFrame"
tbl.SearchFrame.BackgroundColor3 = Color3.fromRGB(14, 17, 22)
tbl.SearchFrame.Parent = tbl.TabHolder_1

tbl.UICorner_59.CornerRadius = UDim.new(0, 6)
tbl.UICorner_59.Parent = tbl.SearchFrame

tbl.UICorner_60.CornerRadius = UDim.new(0, 6)
tbl.UICorner_60.Parent = tbl.Main

tbl.DropShadowHolder_3.Active = true
tbl.DropShadowHolder_3.ZIndex = 0
tbl.DropShadowHolder_3.BorderSizePixel = 0
tbl.DropShadowHolder_3.Size = UDim2.new(1, 0, 1, 0)
tbl.DropShadowHolder_3.BackgroundTransparency = 1
tbl.DropShadowHolder_3.BorderColor3 = Color3.fromRGB(27, 42, 53)
tbl.DropShadowHolder_3.Name = "DropShadowHolder"
tbl.DropShadowHolder_3.Parent = tbl.Main

tbl.DropShadow_3.ImageColor3 = Color3.fromRGB(0, 0, 0)
tbl.DropShadow_3.Active = true
tbl.DropShadow_3.ZIndex = 0
tbl.DropShadow_3.BorderSizePixel = 0
tbl.DropShadow_3.SliceCenter = Rect.new(49, 49, 450, 450)
tbl.DropShadow_3.ScaleType = Enum.ScaleType.Slice
tbl.DropShadow_3.ImageTransparency = 0.5
tbl.DropShadow_3.AnchorPoint = Vector2.new(0.5, 0.5)
tbl.DropShadow_3.Image = "rbxassetid://6014261993"
tbl.DropShadow_3.Size = UDim2.new(1, 47, 1, 47)
tbl.DropShadow_3.Name = "DropShadow"
tbl.DropShadow_3.BackgroundTransparency = 1
tbl.DropShadow_3.Position = UDim2.new(0.5, 0, 0.5, 0)
tbl.DropShadow_3.Parent = tbl.DropShadowHolder_3

tbl.Modules_1.Name = "Modules"
tbl.Modules_1.Parent = tbl.Library

tbl.Dragger.Name = "Dragger"
tbl.Dragger.Parent = tbl.Modules_1

tbl.Resizer.Name = "Resizer"
tbl.Resizer.Parent = tbl.Modules_1

tbl.SaveManager.Name = "SaveManager"
tbl.SaveManager.Parent = tbl.Modules_1

tbl.UIHover.Name = "UIHover"
tbl.UIHover.Parent = tbl.Modules_1

tbl.UIClick.Name = "UIClick"
tbl.UIClick.Parent = tbl.Modules_1

tbl.Signal.Name = "Signal"
tbl.Signal:SetAttribute("Version", "1.0")
tbl.Signal.Parent = tbl.Modules

tbl.SynchronousTaskManager.Name = "SynchronousTaskManager"
tbl.SynchronousTaskManager:SetAttribute("Version", "1.0")
tbl.SynchronousTaskManager.Parent = tbl.Modules

tbl.Proxy.Name = "Proxy"
tbl.Proxy:SetAttribute("Version", "1.0")
tbl.Proxy.Parent = tbl.Modules

tbl.ModuleLoader.Name = "ModuleLoader"
tbl.ModuleLoader.Parent = tbl.Modules

tbl.Tabs.Name = "Tabs"
tbl.Tabs.Parent = tbl.BSS

tbl.Main_1.Name = "Main"
tbl.Main_1.Parent = tbl.Tabs

tbl.AutoFarm.Name = "AutoFarm"
tbl.AutoFarm.Parent = tbl.Main_1

tbl.AutoDig.Name = "AutoDig"
tbl.AutoDig.Parent = tbl.Main_1
 
local modules, cache = {}, {}
		
local o_require = require;
local function require(module)
	local real, cached = modules[module], cache[module]
	
	if cached then return cached end
	
	if not real then return o_require(module) end
	
	cache[module] = real()
	
	return cache[module]
end

modules[tbl.Library] = function()
	local script = tbl.Library

	local modules = script.Modules
	
	shared.libraryVars = {
		window = nil	
	}
	
	-- op
	shared.requireModule = function(moduleName)
		local module = modules:FindFirstChild(moduleName)
		
		if not module then
			error(string.format("Module %s does not exist", moduleName))
		end
		
		local success, result = pcall(require, module)
		
		if not success then
			error(string.format("There was an error requiring module %s: %s", moduleName, result))
		end
		
		return result
	end
	
	return require(script.UI) -- forward UI module
	
end

modules[tbl.UI] = function()
	local script = tbl.UI

	local tweenService = game:GetService("TweenService")
	local userInputService = game:GetService("UserInputService")
	local contentProvider = game:GetService("ContentProvider")
	
	local saveManager = shared.requireModule("SaveManager")
	
	local UIData = {
		currentConfig = nil,
		currentKeybind = nil,
	}
	
	local storedUIData = saveManager:ReadGlobalData("UIData")
	
	if storedUIData then
		UIData = storedUIData
	else
		saveManager:WriteGlobalData("UIData", UIData)
	end
	
	if UIData.currentConfig then
		saveManager:SetConfig(UIData.currentConfig, true)
	else
		-- fresh savedata
		
		UIData.currentConfig = "Config-#1"
		
		saveManager:CreateConfig(UIData.currentConfig, true)
		
		saveManager:WriteGlobalData("UIData", UIData)
		
		saveManager:SaveGlobalData()
	end
	
	local UI = {}
	UI.__index = UI
	
	UI.new = function(config)
		config = config or {}
		
		local self = setmetatable({
			-- arguments
			name = config.name,
			
			-- internal variables
			settingsOpen = false,
			mouseIcon = nil,
			gui = nil,
			
			tabs = {},
		}, UI)
		
		shared.libraryVars.window = self
		
		local isExploit = pcall(function()
			return game:GetService("CoreGui").Name
		end)
		
		-- create gui
		self.gui, self.mouseIcon = script.GUI:Clone(), script.MouseIcon:Clone()
		
		--preload images
		
		local preload = {}
		
		for _, descendant in self.gui:GetDescendants() do
			if descendant.ClassName ~= "ImageButton" or descendant.ClassName ~= "ImageLabel" then continue end
			table.insert(preload, descendant)
		end
		
		contentProvider:PreloadAsync(preload)
		--contentProvider:PreloadAsync(self.gui:GetDescendants())
	
		self.gui.Enabled = true
		
		self.gui.Main.TopBar.Title.Text = self.name
		self.gui.Parent = if isExploit then gethui() else game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	
		-- parent mouse
		self.mouseIcon.Parent = self.gui
	
		-- initialize drag
		local drag = shared.requireModule("Dragger").new(self.gui.Main.TopBar, self.gui.Main)
		drag:Enable()
	
		-- called when the mouse enters or leaves a resize bound
		local function onResizeStateChanged(isResizing)
			if isResizing then
				drag:Disable()
			else
				drag:Enable()
			end
		end
	
		-- initialize resizer
		shared.requireModule("Resizer").new(self.gui.Main, UDim2.fromScale(0.286, 0.31), UDim2.fromScale(0.8, 0.8), self.mouseIcon, onResizeStateChanged):Enable()
		
		local function setSettingsTab(enabled)
			local tweenInfo = TweenInfo.new(
				0.5,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			)
	
			if enabled then
				local rotationTween = tweenService:Create(self.gui.Main.TopBar.Settings, tweenInfo, {
					Rotation = -180
				})
	
				rotationTween:Play()
			else
				local rotationTween = tweenService:Create(self.gui.Main.TopBar.Settings, tweenInfo, {
					Rotation = 0
				})
	
				rotationTween:Play()
			end
		end
		
		-- create settings tab (this kinda sucks code-wise...)
		local settingsTab = self:CreateTab({
			name = "Settings",
			isSettings = true,
			
			callback = function(enabled)
				if enabled then return end
				
				self.settingsOpen = false
				
				setSettingsTab(false)
			end
		})
		
		-- gui handler
		self.gui.Main.TopBar.Settings.MouseButton1Click:Connect(function()
			if self.settingsOpen then return end
			
			self.settingsOpen = true
			
			setSettingsTab(true)
			
			settingsTab:SetEnabled(true, nil)
		end)
		
		-- presets module
		do
			local configSettings = settingsTab:CreateModule("Settings-Configurations", {
				name = "Configurations",
				inactive = true
			})
	
			local resetToDefault = configSettings:CreateButton({
				name = "Clear Current Config",
	
				callback = function()
					saveManager:ClearCurrentConfig()
				end
			})
	
			local currentlyActiveConfig = configSettings:CreateLabel({ name = "", text = "" })
	
			local function updateActiveConfig()
				currentlyActiveConfig:Set({
					name = "Currently Active Config",
	
					text = string.format([[You are currently using the config "%s"]], saveManager:GetCurrentConfig())
				})
			end
	
			local configOptions = configSettings:CreateDropdown("Settings-Configurations-SavedConfigurations", {
				name = "Saved Configurations",
				canDisableSingleSelf = false,
				readWriteGlobal = true,
	
				callback = function(selected)
					local configName = selected[1]
	
					UIData.currentConfig = configName
					
					saveManager:SaveCurrentConfig()
					
					local success, result = pcall(function()
						saveManager:SetConfig(configName)
					end)
	
					updateActiveConfig()
	
					saveManager:SaveGlobalData()
				end,
			})
	
			local function updateConfigOptions()
				local configNames = {}
	
				for configName in saveManager:GetAllConfigData() do
					configNames[#configNames + 1] = configName
				end
	
				configOptions:Update(configNames)
				configOptions:Set({ UIData.currentConfig })
			end
	
			local newConfigName = configSettings:CreateField("Settings-Configurations-NameOfNewConfig", {
				name = "Name Of New Config",
				removeTextOnFocusLost = false,
				readWriteGlobal = true,
			})
	
			local saveAsNewConfig = configSettings:CreateButton({
				name = "Create New Config",
	
				callback = function()
					saveManager:SaveCurrentConfig()
					
					local configName = newConfigName:Get()
	
					UIData.currentConfig = configName
					
					saveManager:CreateConfig(configName, true)
	
					updateActiveConfig()
					updateConfigOptions()
	
					saveManager:SaveGlobalData()
				end
			})
	
			local saveAsNewConfig = configSettings:CreateButton({
				name = "Clone Current Config",
	
				callback = function()
					saveManager:SaveCurrentConfig()
					
					local configName = newConfigName:Get()
	
					saveManager:CreateConfig(configName, false)
	
					UIData.currentConfig = configName
	
					updateActiveConfig()
					updateConfigOptions()
	
					saveManager:SaveGlobalData()
				end
			})
	
			updateActiveConfig()
			updateConfigOptions()
		end
		
		-- keybind settings
		do
			local keybindSettings = settingsTab:CreateModule("Settings-Keybinds", {
				name = "Keybinds",
				inactive = true
			})
			
			local pickingKeybind, keybind = false, UIData.currentKeybind
			
			local currentKeybind = keybindSettings:CreateLabel({
				name = "Currently Active Keybind",
				
				text = if keybind then string.format([[You are currently using the keybind "%s"]], tostring(keybind)) else "You do not have a keybind selected"
			})
			
			local selectKeybind = keybindSettings:CreateButton({
				name = "Select New Keybind",
				
				callback = function()
					pickingKeybind = true
					
					currentKeybind:Set({
						name = "Currently Active Keybind",
	
						text = "..."
					})
				end
			})
			
			local clearKeybind = keybindSettings:CreateButton({
				name = "Clear Keybind",
	
				callback = function()
					keybind = nil
					
					currentKeybind:Set({
						name = "Currently Active Keybind",
	
						text = "You do not have a keybind selected"
					})
				end
			})
			
			userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
				if pickingKeybind and input.UserInputType == Enum.UserInputType.Keyboard then
					pickingKeybind = false
					
					keybind = input.KeyCode
					UIData.currentKeybind = input.KeyCode
					
					currentKeybind:Set({
						name = "Currently Active Keybind",
	
						text = string.format([[You are currently using the keybind "%s"]], tostring(keybind))
					})
					
					saveManager:SaveGlobalData()
					
					return
				end
				
				if input.KeyCode == keybind and not userInputService:GetFocusedTextBox() then
					self.gui.Enabled = not self.gui.Enabled
					
					saveManager:SaveCurrentConfig()
				end
			end)
		end
		
		-- notification settings
		do
			local credits = settingsTab:CreateModule("Settings-Notifications", {
				name = "Notifications",
				inactive = true
			})
			
			credits:CreateToggle("setings-module-notifications", {
				name = "Module Notifications",
			})
		end
		
		
		-- credits
		do
			local credits = settingsTab:CreateModule("Settings-Credits", {
				name = "Credits",
				inactive = true
			})
			
			credits:CreateLabel({
				name = "Provided to you by:",
				
				text = "@.ch0nky - Scripting, Designing\n@b1ohaz4rd - Scripting Logic, Scripting, Designing\n@relsakata - Contributing to UI"
			})
		end
		
		return self
	end
	
	function UI:CreateTab(config)
		local tab = require(script.Tab).new(self.gui, config)
		self.tabs[tab.name] = tab
		
		return tab
	end
	
	function UI:Notify(config)
		return require(script.Notification).new(self.gui, config):Notify()
	end
	
	return UI
	
end

modules[tbl.Tab] = function()
	local script = tbl.Tab

	local tweenService = game:GetService("TweenService")
	
	-- global storage
	local global = {
		tabCount = 0,
		currentActiveTab = nil,
	}
	
	local Tab = {}
	Tab.__index = Tab
	
	Tab.new = function(gui, config)
		config = config or {}
	
		local self = setmetatable({
			-- args
			gui = gui,
			name = config.name,
			enabled = config.enabled,
			isSettings = config.isSettings,
			callback = config.callback or function()end,
	
			-- internal variables
			tab = nil,
			tabSelector = nil,
			index = nil,
			modules = {}
		}, Tab)
	
		self.tab, self.tabSelector = script.TabContainer:Clone(), script.TabSelector:Clone()
	
		global.tabCount += 1
		self.index = global.tabCount
	
		self.tabSelector.Click.Text = self.name
	
		-- parent clones
		self.tabSelector.Parent = self.gui.Main.SideBar.TabHolder
		self.tab.Parent = self.gui.Main.TabHolder
	
		-- callback
		local function enableSelf()
			if global.currentActiveTab == self then return end
	
			self:SetEnabled(true, global.currentActiveTab)
		end
		
		--[[local function toggleSelf()
			if global.currentActiveTab == self then
				self:SetEnabled(false, global.currentActiveTab)
			else
				self:SetEnabled(true, global.currentActiveTab)
			end
		end]]
		
		if self.isSettings then
			self.tabSelector.Visible = false
			--self.gui.Main.TopBar.Settings.MouseButton1Click:Connect(toggleSelf)
		else
			self.tabSelector.Click.MouseButton1Click:Connect(enableSelf)
		end
	
		self:InitSearch()
		
		self:SetEnabled(self.enabled, global.currentActiveTab)
		
		return self
	end
	
	function Tab:InitSearch()
		if self.isSettings then return end
		
		local tweenInfo = TweenInfo.new(
			0.25,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
	
		local searchBar = self.gui.Main.TabHolder.SearchBar
		local star = searchBar.Star
		local favIcon, unfavIcon = star.Favorited, star.Unfavorited
	
		local openedFav = false
	
		searchBar:GetPropertyChangedSignal("Text"):Connect(function()
			if not self.enabled then return end
	
			local inputText = string.upper(searchBar.Text)
	
			for _, module in self.modules do
				if inputText == "" or string.find(string.upper(module.name), inputText) then
					module.moduleGui.Visible = true
				else
					module.moduleGui.Visible = false
				end
			end
		end)
	
		star.MouseButton1Click:Connect(function()
			if not self.enabled then return end
			openedFav = not openedFav
	
			tweenService:Create(favIcon, tweenInfo, { ImageTransparency = if openedFav then 0 else 1 }):Play()
			tweenService:Create(unfavIcon, tweenInfo, { ImageTransparency = if openedFav then 1 else 0 }):Play()
	
			for _, module in self.modules do
				if openedFav then
					if module.moduleData.favorited then continue end
					module.moduleGui.Visible = false
				else
					module.moduleGui.Visible = true
				end
			end
		end)
	end
	
	function Tab:SetEnabled(enabled, previous)
		if global.currentActiveTab and enabled then
			local activeTab = global.currentActiveTab
			
			global.currentActiveTab = nil -- stack overflow
			
			activeTab:SetEnabled(false, self)
		end
		
		local tweenDirection = 1
	
		local tweenInfo = TweenInfo.new(
			0.45,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
	
		local tweenDirection = 0
	
		tweenDirection = previous and previous.index < self.index
		
		-- settings tab
		local tabYOffset = if self.isSettings then 10 else 45
		
		-- tween search bar
		if self.isSettings then
			local searchBarTween = tweenService:Create(self.gui.Main.TabHolder.SearchBar, tweenInfo, {
				Position = if enabled then UDim2.fromOffset(10, -35) else UDim2.fromOffset(10, 10)
			})
	
			searchBarTween:Play()
		end
		
		-- for tweendirection
		if enabled then
			self.tab.Position = UDim2.new(0, 10, 1 * (if tweenDirection then 1 else -1), tabYOffset)
		end
	
		-- tween tab content
		local tabContentTween = tweenService:Create(self.tab, tweenInfo, {
			Position = if enabled then UDim2.new(0, 10, 0, tabYOffset) else UDim2.new(0, 10, if tweenDirection then 2 else -1, tabYOffset)
		})
	
		tabContentTween:Play()
	
		-- tween tab selector
		local tabSelectorTween = tweenService:Create(self.tabSelector.Click, tweenInfo, {
			TextTransparency = if enabled then 0 else 0.7
		})
	
		tabSelectorTween:Play()
	
		self.enabled = enabled
		
		if self.enabled then
			global.currentActiveTab = self
		end
		
		self.callback(self.enabled)
	end
	
	function Tab:CreateModule(saveFlag, config)
		local module = require(script.Module).new(self.tab, saveFlag, config)
		
		self.modules[module.name] = module
	
		return module
	end
	
	return Tab
	
end

modules[tbl.Module] = function()
	local script = tbl.Module

	local tweenService = game:GetService("TweenService")
	local userInputService = game:GetService("UserInputService")
	
	local saveManager = shared.requireModule("SaveManager")
	local UIHover = shared.requireModule("UIHover")
	local UIClick = shared.requireModule("UIClick")
	
	local global = {
		moduleDebounce = nil,
		configDebounce = nil,
		moduleRegistry = {},
	}
	
	local Module = {}
	Module.__index = Module
	
	Module.new = function(tab, saveFlag, config)
		config = config or {}
		
		local self = setmetatable({
			-- args
			tab = tab,
			name = config.name,
			keybind = config.keybind or nil,
			callback = config.callback or function() end,
			inactive = config.inactive,
			
			-- savedata
			flag = saveFlag,
			
			moduleData = {
				enabled = false,
				favorited = false,
				keybind = nil,
			}, -- default data
	
			-- internal variables
			configFrame = nil,
			configFrameInfo = nil,
			moduleDebounce = tick(),
			configDebounce = tick(),
			favoriteDebounce = tick(),
			moduleHasSettings = false,
			configEnabled = false,
			isPickingKeybind = false,
		}, Module)
		
		-- read save data
		local storedModuleData = saveManager:ReadCurrentConfig(self.flag)
		
		if storedModuleData then
			self.moduleData = storedModuleData
		else
			saveManager:WriteCurrentConfig(self.flag, self.moduleData)
		end
		
		-- on changed
		saveManager.configChanged.Event:Connect(function(name, revertToDefaultIfNotFound)
			storedModuleData = saveManager:ReadCurrentConfig(self.flag)
			
			if storedModuleData then
				self.moduleData = storedModuleData
				
			elseif revertToDefaultIfNotFound then
				self.moduleData = {
					enabled = false,
					favorited = false,
					keybind = nil,
				} -- recreate default data table so we dont update reference to old table...
			else
				self.moduleData = {
					enabled = self.moduleData.enabled,
					favorited = self.moduleData.favorited,
					keybind = self.moduleData.keybind,
				} -- copy of table
			end
			
			self:SetEnabled(self.moduleData.enabled)
			self:SetFavorited(self.moduleData.favorited)
			
			if self.moduleData.keybind then
				self.moduleGui.Click.Keybind.Text = self.moduleData.keybind.Name
			else
				self.moduleGui.Click.Keybind.Text = "..."
			end
			
			-- write settings
			saveManager:WriteCurrentConfig(self.flag, self.moduleData)
		end)
		
		self.moduleGui = script.ModuleTemplate:Clone()
		
		UIHover:AddHover("BackgroundColor3", { self.moduleGui.Click })
		UIClick:AddClick("BackgroundColor3", { self.moduleGui.Click })
		
		if self.inactive then
			self.moduleGui.Click.Configurate.Visible = false
			self.moduleGui.Click.Keybind.Visible = false
			self.moduleGui.Click.Star.Visible = false
			self.moduleGui.Click.Toggle.Visible = false
			
			self.moduleGui.Click.Label.Position = UDim2.fromOffset(11, 5)
		end
		
		self.configFrame = self.moduleGui
		self.settingsHolderFrame = self.configFrame.SettingsHolder
	
		self.moduleGui.Click.Label.Text = self.name
		self.moduleGui.Parent = self.tab
	
		-- update canvassize
		self.tab.CanvasSize = UDim2.new(0, 0, 0, self.tab.CanvasSize.Y.Offset + self.moduleGui.Click.Size.Y.Offset + 25)
	
		-- table shared between settings of this module
		self.configFrameInfo = {
			moduleInstance = self,
			size = 0, -- size of settings frame
			activeGui = nil, -- active gui (colorpicker, dropdown, etc)
		}
	
		-- callbacks
		local function toggleModule()
			if (tick() - self.moduleDebounce) < 0.08 then return end
			self.moduleDebounce = tick()
	
			self.moduleData.enabled = not self.moduleData.enabled
		
			self:SetEnabled(self.moduleData.enabled)
			
			saveManager:SaveCurrentConfig()
		end
	
		local function toggleConfig()
			if (tick() - self.configDebounce) < 0.08 then return end
			self.configDebounce = tick()
	
			self.configEnabled = not self.configEnabled
			
			self:SetConfigEnabled(self.configEnabled)
			
			saveManager:SaveCurrentConfig()
		end
		
		local function toggleFavorite()
			if (tick() - self.favoriteDebounce) < 0.08 then return end
			self.favoriteDebounce = tick()
	
			self.moduleData.favorited = not self.moduleData.favorited
	
			self:SetFavorited(self.moduleData.favorited)
			
			saveManager:SaveCurrentConfig()
		end
		
		if not self.inactive then
			self.moduleGui.Click.MouseButton1Click:Connect(toggleModule) -- module
			self.moduleGui.Click.MouseButton2Click:Connect(toggleConfig) -- config
		else
			self.moduleGui.Click.MouseButton1Click:Connect(toggleConfig) -- config
			self.moduleGui.Click.MouseButton2Click:Connect(toggleConfig) -- config
		end
	
		self.moduleGui.Click.Toggle.MouseButton1Click:Connect(toggleModule)
		self.moduleGui.Click.Configurate.MouseButton1Click:Connect(toggleConfig)
	
		self.moduleGui.Click.Star.MouseButton1Click:Connect(toggleFavorite)
		
		self:InitKeybind()
		-- .MiddleClick?
		
		-- set module state (at the end of function bc everything is initialized now)
		self:SetEnabled(self.moduleData.enabled)
		self:SetFavorited(self.moduleData.favorited)
		
		return self
	end
	
	function Module:Get()
		return self.moduleData.enabled
	end
	
	function Module:Set(...)
		return self:SetEnabled(...)
	end
	
	function Module:SetEnabled(enabled)
		self.moduleData.enabled = enabled
		
		local toggleButton = self.moduleGui.Click.Toggle
	
		local tweenInfo = TweenInfo.new(
			0.08,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
		
		-- tween tick
		local tickTween = tweenService:Create(toggleButton.Tick, tweenInfo, {
			ImageTransparency = if enabled then 0 else 1
		})
	
		tickTween:Play()
	
		-- tween toggle
		local toggleTween = tweenService:Create(toggleButton, tweenInfo, {
			BackgroundColor3 = if enabled then Color3.fromRGB(0, 255, 178) else Color3.fromRGB(83, 85, 88)
		})
	
		toggleTween:Play()
		
		self.callback(self.moduleData.enabled)
	end
	
	function Module:SetConfigEnabled(enabled)
		self.configEnabled = enabled
		
		if not self.moduleHasSettings then return end
		
		if not enabled and self.configFrameInfo.activeGui then
			self.configFrameInfo.activeGui:SetEnabled(false)
		end
		
		local tweenInfo = TweenInfo.new(
			0.25,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
		
		local configTween = tweenService:Create(self.configFrame, tweenInfo, {
			Size = if enabled then UDim2.new(1, -5, 0, self.configFrameInfo.size) else UDim2.new(1, -5, 0, self.moduleGui.Click.Size.Y.Offset)
		})
		
		-- tween frame
		configTween:Play()
		
		local settingsHolderTween = tweenService:Create(self.settingsHolderFrame, tweenInfo, {
			Size = if enabled then UDim2.new(1, -10, 1, 0) else UDim2.new(1, -10, 0, 0),
			Position = if enabled then UDim2.new(0.5, 0, 0, self.configFrameInfo.size - 5) else UDim2.new(0.5, 0, 0, self.moduleGui.Click.AbsoluteSize.Y - 5)
		})
	
		-- tween holder
		settingsHolderTween:Play()
		
		local canvasSize = if enabled then UDim2.fromOffset(0, self.tab.CanvasSize.Y.Offset + self.configFrameInfo.size) else UDim2.fromOffset(0, self.tab.CanvasSize.Y.Offset - self.configFrameInfo.size)
		local canvasPosition = 0
		
		-- do the canvas size math
		local configFramePosY = self.configFrame.AbsolutePosition.Y - self.tab.AbsolutePosition.Y
		
		if (configFramePosY + self.configFrameInfo.size) > self.tab.AbsoluteSize.Y and enabled then
			canvasPosition = (configFramePosY + self.configFrameInfo.size) - self.tab.AbsoluteSize.Y + 5
		end
		
		local canvasTween = tweenService:Create(self.tab, tweenInfo, {
			CanvasSize = canvasSize,
			CanvasPosition = Vector2.new(0, self.tab.CanvasPosition.Y + canvasPosition) -- autoscroll
		})
		
		-- account for canvas
		canvasTween:Play()
	end
	
	function Module:SetFavorited(favorited)
		self.moduleData.favorited = favorited
		
		local tweenInfo = TweenInfo.new(
			0.25,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
		
		local star = self.moduleGui.Click.Star
		local favIcon, unfavIcon = star.Favorited, star.Unfavorited
		
		local favTween = tweenService:Create(favIcon, tweenInfo, {
			ImageTransparency = if favorited then 0 else 1
		})
		
		favTween:Play()
		
		local unfavTween = tweenService:Create(unfavIcon, tweenInfo, {
			ImageTransparency = if favorited then 1 else 0
		})
	
		unfavTween:Play()
	end
	
	function Module:InitKeybind()
		local keybind = self.moduleGui.Click.Keybind
		
		if self.moduleData.keybind then
			keybind.Text = self.moduleData.keybind.Name
		end
		
		local tweenInfo = TweenInfo.new(
			0.05,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
		
		keybind.MouseButton1Click:Connect(function()
			if self.isPicking then return end
			
			self.isPicking = true
			
			local textTween = tweenService:Create(keybind, tweenInfo, {
				TextTransparency = 1
			})
			
			textTween:Play()
		end)
		
		userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
			if gameProcessedEvent then return end
			
			if self.isPicking and input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.Backspace then
					keybind.Text = "..."
	
					self.moduleData.keybind = nil
				else
					keybind.Text = input.KeyCode.Name
	
					self.moduleData.keybind = input.KeyCode
				end
				
				self.isPicking = false
				
				local textTween = tweenService:Create(keybind, tweenInfo, {
					TextTransparency = 0
				})
	
				textTween:Play()
				
				return
			end
			
			if input.KeyCode == self.moduleData.keybind then
				self.moduleData.enabled = not self.moduleData.enabled
				
				self:SetEnabled(self.moduleData.enabled)
				
				--if next(saveManager:ReadCurrentConfig("setings-module-notifications")) == nil or (not saveManager:ReadCurrentConfig("setings-module-notifications")["enabled"]) then return end
				if not saveManager:ReadCurrentConfig("setings-module-notifications").enabled then return end
				
				shared.libraryVars.window:Notify({
					title = `{self.name} has been {if self.moduleData.enabled then "enabled" else "disabled"}!`,
					content = "Module State Change",
					mode = if self.moduleData.enabled then "Success" else "Error",
					duration = 2,
				})
			end
		end)
	end
	
	function Module:Callback(callback)
		self.callback = callback
	end
	
	-- create functions
	local function createClass(self, class, saveFlag, config)
		if not self.moduleHasSettings then
			self.moduleHasSettings = true
			self.configFrameInfo.size = self.moduleGui.Size.Y.Offset + 5
			
			self.moduleGui.Click.Configurate.Position = UDim2.new(1, -50, 0, 5)
			self.moduleGui.Click.Keybind.Position = UDim2.new(1, -55, 0, 5)
		end -- enable settings
		
		local class = require(class).new(self.settingsHolderFrame, self.configFrameInfo, saveFlag, config)
		
		self[saveFlag] = class
		
		return class
	end
	
	function Module:CreateLabel(config)
		return createClass(self, script.Label, config)
	end
	
	function Module:CreateButton(config)
		return createClass(self, script.Button, config)
	end
	
	function Module:CreateField(saveFlag, config)
		return createClass(self, script.Field, saveFlag, config)
	end
	
	function Module:CreateToggle(saveFlag, config)
		return createClass(self, script.Toggle, saveFlag, config)
	end
	
	function Module:CreateSlider(saveFlag, config)
		return createClass(self, script.Slider, saveFlag, config)
	end
	
	function Module:CreateDropdown(saveFlag, config)
		return createClass(self, script.Dropdown, saveFlag, config)
	end
	
	function Module:CreatePickerRGB(saveFlag, config)
		return createClass(self, script.ColorPickerRGB, saveFlag, config)
	end
	
	function Module:CreatePickerRGBA(saveFlag, config)
		return createClass(self, script.ColorPickerRGBA, saveFlag, config)
	end
	
	return Module
	
end

modules[tbl.ColorPickerRGB] = function()
	local script = tbl.ColorPickerRGB

	local tweenService = game:GetService("TweenService")
	local textService = game:GetService("TextService")
	local guiService = game:GetService("GuiService")
	local userInputService = game:GetService("UserInputService")
	
	local saveManager = shared.requireModule("SaveManager")
	
	local function formatNumber(text)
		local result, replaced = string.gsub(text, "%D", "")
	
		return result -- we only want result
	end
	
	local function formatHex(text)
		return string.match(text, "(#%x*)")
	end
	
	
	
	local ColorPickerRGB = {}
	ColorPickerRGB.__index = ColorPickerRGB
	
	ColorPickerRGB.new = function(configFrame, configFrameInfo, saveFlag, config)
		config = config or {}
		
		local self = setmetatable({
			-- args
			configFrame = configFrame,
			configFrameInfo = configFrameInfo,
			name = config.name,
			callback = config.callback or function()end,
			readWriteGlobal = config.readWriteGlobal,
			
			flag = saveFlag,
			
			colorPickerData = {
				color = config.color or Color3.fromHSV(0, 0, 1),
			},
			
			config = config, -- backup config for default settings
			
			-- internal variables
			enabled = false,
			colorPickerGui = nil,
			colorOpenTween = nil,
			colorDebounce = tick(),
			settingColor = false,
			huesatGradientHoldingMouse1 = false,
			linearGradientHoldingMouse1 = false,
		}, ColorPickerRGB)
		
		-- shitty
		local readData = function(...)
			if self.readWriteGlobal then
				return saveManager:ReadGlobalData(...)
			else
				return saveManager:ReadCurrentConfig(...)
			end
		end
	
		-- shitty
		local writeData = function(...)
			if self.readWriteGlobal then
				return saveManager:WriteGlobalData(...)
			else
				return saveManager:WriteCurrentConfig(...)
			end
		end
		
		-- read save data
		local storedColorPickerData = readData(self.flag)
	
		if storedColorPickerData then
			self.colorPickerData = storedColorPickerData
		else
			writeData(self.flag, self.colorPickerData)
		end
		
		-- on changed
		saveManager.configChanged.Event:Connect(function(name, revertToDefaultIfNotFound)
			if self.readWriteGlobal then return end		
			
			storedColorPickerData = readData(self.flag)
	
			if storedColorPickerData then
				self.colorPickerData = storedColorPickerData
				
			elseif revertToDefaultIfNotFound then
				self.colorPickerData = {
					color = self.config.color or Color3.fromHSV(0, 0, 1),
				} -- revert to defaults
			else
				self.colorPickerData = {
					color = self.colorPickerData.color,
				} -- copy
			end
			
			self:SetColor(self.colorPickerData.color:ToHSV())
			
			writeData(self.flag, self.colorPickerData)
		end)
		
		self.colorPickerGui = script.ColorPickerRGB:Clone()
		
		self.configFrameInfo.size += self.colorPickerGui.Size.Y.Offset + 5
		
		self.colorPickerGui.Top.Text = self.name
		
		local textSize = textService:GetTextSize(self.name, self.colorPickerGui.Top.TextSize, Enum.Font.Gotham, Vector2.new()) -- FONT MANAGER NEEDED
		
		self.colorPickerGui.Color.Size = UDim2.new(1, -15 - textSize.X - 10, 0, 16)
		
		self.colorPickerGui.Parent = self.configFrame
		
		-- toggle
		local function onToggle()
			if (tick() - self.colorDebounce) < 0.21 then return end
			self.colorDebounce = tick()
			
			self.enabled = not self.enabled
			
			self:SetEnabled(self.enabled)
		end
		
		local function onInputEnded(input, gameProcessedEvent)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				--userInputService.MouseIconEnabled = true
	
				self.huesatGradientHoldingMouse1 = false
				self.linearGradientHoldingMouse1 = false
			end
		end
		
		local function onInputChanged(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement and (self.huesatGradientHoldingMouse1 or self.linearGradientHoldingMouse1) then
				--userInputService.MouseIconEnabled = false
				
				local pickColorFrame = self.colorPickerGui.Color.PickColor
				
				local huesatGradientFrame = pickColorFrame.HueSatGradient
				local linearGradientFrame = pickColorFrame.LinearGradient
				
				if self.huesatGradientHoldingMouse1 then
					local absolutePosition = huesatGradientFrame.AbsolutePosition
					local absoluteSize = huesatGradientFrame.AbsoluteSize
					
					local mouseDelta = Vector2.new(input.Position.X, input.Position.Y) - absolutePosition
	
					local scaleX = math.clamp(mouseDelta.X / absoluteSize.X, 0, 1)
					local scaleY = math.clamp(mouseDelta.Y / absoluteSize.Y, 0, 1)
	
					self:SetColor(scaleX, 1 - scaleY, 1 - linearGradientFrame.Cursor.Position.Y.Scale)
				elseif self.linearGradientHoldingMouse1 then -- atp its true anyway but whatever
					local absolutePosition = linearGradientFrame.AbsolutePosition
					local absoluteSize = linearGradientFrame.AbsoluteSize
	
					local mouseDelta = Vector2.new(input.Position.X, input.Position.Y) - absolutePosition
					
					local scaleY = math.clamp(mouseDelta.Y / absoluteSize.Y, 0, 1)
					
					self:SetColor(huesatGradientFrame.Cursor.Position.X.Scale, 1 - huesatGradientFrame.Cursor.Position.Y.Scale, 1 - scaleY)
				end
			end
		end
		
		-- hue saturation
		local function onPickColorStart(mouseX, mouseY)
			self.huesatGradientHoldingMouse1 = true
			
			onInputChanged{
				UserInputType = Enum.UserInputType.MouseMovement,
				Position = Vector3.new(mouseX, mouseY - guiService:GetGuiInset().Y, 0)
			}
		end
	
		-- linear gradient
		local function onLinearGradientStart(mouseX, mouseY)
			self.linearGradientHoldingMouse1 = true
			
			onInputChanged{
				UserInputType = Enum.UserInputType.MouseMovement,
				Position = Vector3.new(mouseX, mouseY - guiService:GetGuiInset().Y, 0)
			}
		end
		
		self.colorPickerGui.Color.MouseButton1Click:Connect(onToggle)
		self.colorPickerGui.Color.MouseButton2Click:Connect(onToggle)
		
		self.colorPickerGui.Color.PickColor.HueSatGradient.Click.MouseButton1Down:Connect(onPickColorStart)
		self.colorPickerGui.Color.PickColor.LinearGradient.Click.MouseButton1Down:Connect(onLinearGradientStart)
		
		userInputService.InputEnded:Connect(onInputEnded)
		userInputService.InputChanged:Connect(onInputChanged)
		
		-- field events
		local fields = self.colorPickerGui.Color.PickColor.Fields
		
		local function createRGBSetCallback(parent)
			local value = parent.Value
			local textBox = value.TextBox
			
			local red = fields.Red.Value.TextBox
			local green = fields.Green.Value.TextBox
			local blue = fields.Blue.Value.TextBox
			
			local function onRGBSet()
				if self.settingColor then return end
				
				textBox.Text = formatNumber(textBox.Text)
				
				local R = tonumber(red.Text) or 0
				local G = tonumber(green.Text) or 0
				local B = tonumber(blue.Text) or 0
				
				local rgb = Color3.fromRGB(math.clamp(R, 0, 255), math.clamp(G , 0, 255), math.clamp(B, 0, 255))
				
				self:SetColor(rgb:ToHSV())
			end
			
			textBox:GetPropertyChangedSignal("Text"):Connect(onRGBSet)
			
			value.ArrowUp.MouseButton1Click:Connect(function()
				local new = tonumber(textBox.Text) + 1
				
				if new > 255 then
					new = 0
				end
				
				textBox.Text = new
			end)
			
			value.ArrowDown.MouseButton1Click:Connect(function()
				local new = tonumber(textBox.Text) - 1
	
				if new < 0 then
					new = 255
				end
	
				textBox.Text = new
			end)
		end
		
		local function createHSVSetCallback(parent, max)
			local value = parent.Value
			local textBox = value.TextBox
	
			local hue = fields.Hue.Value.TextBox
			local sat = fields.Sat.Value.TextBox
			local val = fields.Val.Value.TextBox
			
			local function onHSVSet()
				if self.settingColor then return end
				
				textBox.Text = formatNumber(textBox.Text)
				
				local H = tonumber(hue.Text) or 0
				local S = tonumber(sat.Text) or 0
				local V = tonumber(val.Text) or 0
				
				self:SetColor(math.clamp(H, 0, 359) / 360, math.clamp(S , 0, 255) / 255, math.clamp(V, 0, 255) / 255)
			end
			
			textBox:GetPropertyChangedSignal("Text"):Connect(onHSVSet)
			
			value.ArrowUp.MouseButton1Click:Connect(function()
				local new = tonumber(textBox.Text) + 1
	
				if new > max then
					new = 0
				end
	
				textBox.Text = new
			end)
	
			value.ArrowDown.MouseButton1Click:Connect(function()
				local new = tonumber(textBox.Text) - 1
	
				if new < 0 then
					new = max
				end
	
				textBox.Text = new
			end)
		end
		
		createRGBSetCallback(fields.Red)
		createRGBSetCallback(fields.Green)
		createRGBSetCallback(fields.Blue)
		
		createHSVSetCallback(fields.Hue, 359)
		createHSVSetCallback(fields.Sat, 255)
		createHSVSetCallback(fields.Val, 255)
		
		local hex = fields.Hex.Value.TextBox
		
		hex:GetPropertyChangedSignal("Text"):Connect(function()
			if self.settingColor then return end
			
			hex.Text = formatHex(hex.Text) or ""
			
			local success, hex = pcall(Color3.fromHex, hex.Text)
			
			if success then
				self:SetColor(hex:ToHSV())
			end
		end)
		
		-- default color
		self:SetColor(self.colorPickerData.color:ToHSV())
		
		return self
	end
	
	function ColorPickerRGB:SetEnabled(enabled, isTransfer)
		self.enabled = enabled -- seems redundant but is required
		
		if enabled then
			if self.configFrameInfo.activeGui and self.configFrameInfo.activeGui ~= self then
				self.configFrameInfo.activeGui:SetEnabled(false, true)
			end
			
			self.configFrameInfo.activeGui = self
			
		elseif not enabled and self.configFrameInfo.activeGui == self then
			self.configFrameInfo.activeGui = nil
		end
		
		local tweenInfo = TweenInfo.new(
			0.2,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
		
		if self.colorOpenTween then
			self.colorOpenTween:Pause()
		end
		
		self.colorOpenTween = tweenService:Create(self.colorPickerGui.Color.PickColor, tweenInfo, {
			Size = if enabled then UDim2.fromOffset(210, 215) else UDim2.fromOffset(210, 0)
		})
		
		if enabled then
			self.configFrame.ClipsDescendants = false
		end
		
		self.colorOpenTween.Completed:Connect(function()
			self.colorOpenTween = nil
			
			if not enabled and not isTransfer then
				self.configFrame.ClipsDescendants = true
			end
		end)
		
		self.colorOpenTween:Play() 
		
		local tab = self.configFrame.Parent.Parent
		
		local canvasSize = if enabled then UDim2.fromOffset(0, tab.CanvasSize.Y.Offset + 215) else UDim2.fromOffset(0, tab.CanvasSize.Y.Offset - 215)
		local canvasPosition = 0
		
		local pickerPosY = self.colorPickerGui.Color.PickColor.AbsolutePosition.Y
		local pickerSizeY = self.colorPickerGui.Color.PickColor.AbsoluteSize.Y
		local pickColorPos = pickerPosY - tab.AbsolutePosition.Y
		
		if (pickColorPos + 215) > tab.AbsoluteSize.Y and enabled then
			canvasPosition = (pickColorPos + 215) - tab.AbsoluteSize.Y + 20
		end
		
		local canvasTween = tweenService:Create(tab, tweenInfo, {
			CanvasSize = canvasSize,
			CanvasPosition = Vector2.new(0, tab.CanvasPosition.Y + canvasPosition) -- autoscroll
		})
	
		-- account for canvas
		if not isTransfer then
			canvasTween:Play()
		end
	end
	
	function ColorPickerRGB:Get()
		return self.colorPickerData.color
	end
	
	function ColorPickerRGB:Set(...)
		return self:SetColor(...)
	end
	
	function ColorPickerRGB:SetColor(H, S, V)
		self.settingColor = true -- instant crash if we dont set this
		
		local pickColorFrame = self.colorPickerGui.Color.PickColor
	
		local huesatGradientFrame = pickColorFrame.HueSatGradient
		local linearGradientFrame = pickColorFrame.LinearGradient
		
		local color = Color3.fromHSV(H, S, V)
		
		local tweenInfo = TweenInfo.new(
			0.1,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out
		)
		
		local huesatCursorTween = tweenService:Create(huesatGradientFrame.Cursor, tweenInfo, {
			Position = UDim2.fromScale(H, 1 - S),
			BackgroundColor3 = Color3.fromHSV(H, S, 1)
		})
		
		-- tween huesat cursor
		huesatCursorTween:Play()
		
		local linearGradientTween = tweenService:Create(linearGradientFrame.Cursor, tweenInfo, {
			Position = UDim2.fromScale(1, 1 - V)
		})
		
		-- tween lineargradient cursor
		linearGradientTween:Play()
		
		-- linear gradient color (cant tween colorsequence)
		linearGradientFrame.UIGradient.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(H, S, 1))
		}
	
		local colorTween = tweenService:Create(self.colorPickerGui.Color, tweenInfo, {
			BackgroundColor3 = color
		})
		
		-- tween color bar (todo: text color)
		colorTween:Play()
		
		-- set fields
		local fields = pickColorFrame.Fields
		
		local function getTextBox(field)
			local focused, textbox = userInputService:GetFocusedTextBox(), field.Value.TextBox
			
			return if focused == textbox then {} else textbox
		end
		
		getTextBox(fields.Hue).Text = math.round(math.clamp(H * 360, 0, 359))
		getTextBox(fields.Sat).Text = math.round(S * 255)
		getTextBox(fields.Val).Text = math.round(V * 255)
		
		getTextBox(fields.Red).Text = math.round(color.R * 255)
		getTextBox(fields.Green).Text = math.round(color.G * 255)
		getTextBox(fields.Blue).Text = math.round(color.B * 255)
		
		local colorHex = string.upper(color:ToHex())
		
		getTextBox(fields.Hex).Text = "#" .. colorHex
		
		self.colorPickerGui.Color.Text = "#" .. colorHex
		
		-- callback
		self.callback(color)
		self.colorPickerData.color = color
		
		-- reset text callbacks
		self.settingColor = false
	end
	
	return ColorPickerRGB
	
end

modules[tbl.ColorPickerRGBA] = function()
	local script = tbl.ColorPickerRGBA

	local tweenService = game:GetService("TweenService")
	local textService = game:GetService("TextService")
	local guiService = game:GetService("GuiService")
	local userInputService = game:GetService("UserInputService")
	
	local saveManager = shared.requireModule("SaveManager")
	
	local function formatNumber(text)
		local result, replaced = string.gsub(text, "%D", "")
		
		return result -- we only want result
	end
	
	local function formatHex(text)
		return string.match(text, "(#%x*)")
	end
	
	local ColorPickerRGBA = {}
	ColorPickerRGBA.__index = ColorPickerRGBA
	
	ColorPickerRGBA.new = function(configFrame, configFrameInfo, saveFlag, config)
		config = config or {}
	
		local self = setmetatable({
			-- args
			configFrame = configFrame,
			configFrameInfo = configFrameInfo,
			name = config.name,
			callback = config.callback or function()end,
			readWriteGlobal = config.readWriteGlobal,
			
			flag = saveFlag,
			
			colorPickerData = {
				color = config.color or Color3.fromHSV(0, 0, 1),
				opacity = config.opacity or 1,
			},
	
			config = config, -- backup config for default settings
	
			-- internal variables
			enabled = false,
			colorPickerGui = nil,
			colorOpenTween = nil,
			colorDebounce = tick(),
			settingColor = false,
			huesatGradientHoldingMouse1 = false,
			linearGradientHoldingMouse1 = false,
			alphaGradientHoldingMouse1 = false,
		}, ColorPickerRGBA)
		
		-- shitty
		local readData = function(...)
			if self.readWriteGlobal then
				return saveManager:ReadGlobalData(...)
			else
				return saveManager:ReadCurrentConfig(...)
			end
		end
	
		-- shitty
		local writeData = function(...)
			if self.readWriteGlobal then
				return saveManager:WriteGlobalData(...)
			else
				return saveManager:WriteCurrentConfig(...)
			end
		end
		
		-- read save data
		local storedColorPickerData = readData(self.flag)
	
		if storedColorPickerData then
			self.colorPickerData = storedColorPickerData
		else
			writeData(self.flag, self.colorPickerData)
		end
	
		-- on changed
		saveManager.configChanged.Event:Connect(function(name, revertToDefaultIfNotFound)
			if self.readWriteGlobal then return end
			
			storedColorPickerData = readData(self.flag)
	
			if storedColorPickerData then
				self.colorPickerData = storedColorPickerData
				
			elseif revertToDefaultIfNotFound then
				self.colorPickerData = {
					color = self.config.color or Color3.fromHSV(0, 0, 1),
					opacity = self.config.opacity or 1,
				} -- revert to defaults
			else
				self.colorPickerData = {
					color = self.colorPickerData.color,
					opacity = self.colorPickerData.opacity,
				} -- copy
			end
			
			local H, S, V = self.colorPickerData.color:ToHSV()
	
			self:SetColor(H, S, V, self.colorPickerData.opacity)
			
			writeData(self.flag, self.colorPickerData)
		end)
		
		self.colorPickerGui = script.ColorPickerRGBA:Clone()
		
		self.configFrameInfo.size += self.colorPickerGui.Size.Y.Offset + 5
	
		self.colorPickerGui.Top.Text = self.name
	
		local textSize = textService:GetTextSize(self.name, self.colorPickerGui.Top.TextSize, Enum.Font.Gotham, Vector2.new()) -- FONT MANAGER NEEDED
	
		self.colorPickerGui.Color.Size = UDim2.new(1, -15 - textSize.X - 10, 0, 16)
	
		self.colorPickerGui.Parent = self.configFrame
	
		-- toggle
		local function onToggle()
			if (tick() - self.colorDebounce) < 0.21 then return end
			self.colorDebounce = tick()
	
			self.enabled = not self.enabled
	
			self:SetEnabled(self.enabled)
		end
	
		local function onInputEnded(input, gameProcessedEvent)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				--userInputService.MouseIconEnabled = true
	
				self.huesatGradientHoldingMouse1 = false
				self.linearGradientHoldingMouse1 = false
				self.alphaGradientHoldingMouse1 = false
			end
		end
	
		local function onInputChanged(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement and (self.huesatGradientHoldingMouse1 or self.linearGradientHoldingMouse1 or self.alphaGradientHoldingMouse1) then
				--userInputService.MouseIconEnabled = false
	
				local pickColorFrame = self.colorPickerGui.Color.PickColor
	
				local huesatGradientFrame = pickColorFrame.HueSatGradient
				local linearGradientFrame = pickColorFrame.LinearGradient
				local alphaGradientFrame = pickColorFrame.AlphaGradient
	
				if self.huesatGradientHoldingMouse1 then
					local absolutePosition = huesatGradientFrame.AbsolutePosition
					local absoluteSize = huesatGradientFrame.AbsoluteSize
	
					local mouseDelta = Vector2.new(input.Position.X, input.Position.Y) - absolutePosition
	
					local scaleX = math.clamp(mouseDelta.X / absoluteSize.X, 0, 1)
					local scaleY = math.clamp(mouseDelta.Y / absoluteSize.Y, 0, 1)
	
					self:SetColor(scaleX, 1 - scaleY, 1 - linearGradientFrame.Cursor.Position.Y.Scale, 1 - alphaGradientFrame.Cursor.Position.Y.Scale)
				elseif self.linearGradientHoldingMouse1 then
					local absolutePosition = linearGradientFrame.AbsolutePosition
					local absoluteSize = linearGradientFrame.AbsoluteSize
	
					local mouseDelta = Vector2.new(input.Position.X, input.Position.Y) - absolutePosition
	
					local scaleY = math.clamp(mouseDelta.Y / absoluteSize.Y, 0, 1)
	
					self:SetColor(huesatGradientFrame.Cursor.Position.X.Scale, 1 - huesatGradientFrame.Cursor.Position.Y.Scale, 1 - scaleY, 1 - alphaGradientFrame.Cursor.Position.Y.Scale)
				elseif self.alphaGradientHoldingMouse1 then
					local absolutePosition = alphaGradientFrame.AbsolutePosition
					local absoluteSize = alphaGradientFrame.AbsoluteSize
	
					local mouseDelta = Vector2.new(input.Position.X, input.Position.Y) - absolutePosition
	
					local scaleY = math.clamp(mouseDelta.Y / absoluteSize.Y, 0, 1)
	
					self:SetColor(huesatGradientFrame.Cursor.Position.X.Scale, 1 - huesatGradientFrame.Cursor.Position.Y.Scale, 1 - linearGradientFrame.Cursor.Position.Y.Scale, 1 - scaleY)
				end
			end
		end	
		
		-- hue saturation
		local function onPickColorStart(mouseX, mouseY)
			self.huesatGradientHoldingMouse1 = true		
	
			onInputChanged{
				UserInputType = Enum.UserInputType.MouseMovement,
				Position = Vector3.new(mouseX, mouseY - guiService:GetGuiInset().Y, 0)
			}
		end
	
		-- linear gradient
		local function onLinearGradientStart(mouseX, mouseY)
			self.linearGradientHoldingMouse1 = true
	
			onInputChanged{
				UserInputType = Enum.UserInputType.MouseMovement,
				Position = Vector3.new(mouseX, mouseY - guiService:GetGuiInset().Y, 0)
			}
		end
	
		-- alpha gradient
		local function onAlphaGradientStart(mouseX, mouseY)
			self.alphaGradientHoldingMouse1 = true
	
			onInputChanged{
				UserInputType = Enum.UserInputType.MouseMovement,
				Position = Vector3.new(mouseX, mouseY - guiService:GetGuiInset().Y, 0)
			}
		end
		
		self.colorPickerGui.Color.MouseButton1Click:Connect(onToggle)
		self.colorPickerGui.Color.MouseButton2Click:Connect(onToggle)
	
		self.colorPickerGui.Color.PickColor.HueSatGradient.Click.MouseButton1Down:Connect(onPickColorStart)
		self.colorPickerGui.Color.PickColor.LinearGradient.Click.MouseButton1Down:Connect(onLinearGradientStart)
		self.colorPickerGui.Color.PickColor.AlphaGradient.Color.MouseButton1Down:Connect(onAlphaGradientStart)
		
	
		userInputService.InputEnded:Connect(onInputEnded)
		userInputService.InputChanged:Connect(onInputChanged)
	
		-- field events
		local fields = self.colorPickerGui.Color.PickColor.Fields
	
		local function createRGBSetCallback(parent)
			local value = parent.Value
			local textBox = value.TextBox
	
			local red = fields.Red.Value.TextBox
			local green = fields.Green.Value.TextBox
			local blue = fields.Blue.Value.TextBox
			local alpha = fields.Alpha.Value.TextBox
	
			local function onRGBSet()
				if self.settingColor then return end
	
				textBox.Text = formatNumber(textBox.Text)
	
				local R = tonumber(red.Text) or 0
				local G = tonumber(green.Text) or 0
				local B = tonumber(blue.Text) or 0
				local A = tonumber(formatNumber(alpha.Text)) or 0
	
				local rgb = Color3.fromRGB(math.clamp(R, 0, 255), math.clamp(G , 0, 255), math.clamp(B, 0, 255))
				
				local H, S, V = rgb:ToHSV()
				
				self:SetColor(H, S, V, math.clamp(A, 0, 100) / 100)
			end
	
			textBox:GetPropertyChangedSignal("Text"):Connect(onRGBSet)
	
			value.ArrowUp.MouseButton1Click:Connect(function()
				local new = tonumber(textBox.Text) + 1
	
				if new > 255 then
					new = 0
				end
	
				textBox.Text = new
			end)
	
			value.ArrowDown.MouseButton1Click:Connect(function()
				local new = tonumber(textBox.Text) - 1
	
				if new < 0 then
					new = 255
				end
	
				textBox.Text = new
			end)
		end
	
		local function createHSVSetCallback(parent, max, suffix)
			local value = parent.Value
			local textBox = value.TextBox
	
			local hue = fields.Hue.Value.TextBox
			local sat = fields.Sat.Value.TextBox
			local val = fields.Val.Value.TextBox
			local alpha = fields.Alpha.Value.TextBox
	
			local function onHSVSet()
				if self.settingColor then return end
	
				textBox.Text = formatNumber(textBox.Text) .. (suffix or "")
	
				local H = tonumber(hue.Text) or 0
				local S = tonumber(sat.Text) or 0
				local V = tonumber(val.Text) or 0
				local A = tonumber(formatNumber(alpha.Text)) or 0
	
				self:SetColor(math.clamp(H, 0, 359) / 360, math.clamp(S , 0, 255) / 255, math.clamp(V, 0, 255) / 255, math.clamp(A, 0, 100) / 100)
			end
	
			textBox:GetPropertyChangedSignal("Text"):Connect(onHSVSet)
	
			value.ArrowUp.MouseButton1Click:Connect(function()
				local new = tonumber(formatNumber(textBox.Text)) + 1
	
				if new > max then
					new = 0
				end
	
				textBox.Text = new
			end)
	
			value.ArrowDown.MouseButton1Click:Connect(function()
				local new = tonumber(formatNumber(textBox.Text)) - 1
	
				if new < 0 then
					new = max
				end
	
				textBox.Text = new
			end)
		end
	
		createRGBSetCallback(fields.Red)
		createRGBSetCallback(fields.Green)
		createRGBSetCallback(fields.Blue)
	
		createHSVSetCallback(fields.Hue, 359)
		createHSVSetCallback(fields.Sat, 255)
		createHSVSetCallback(fields.Val, 255)
		createHSVSetCallback(fields.Alpha, 100, "%")
	
		local hex = fields.Hex.Value.TextBox
	
		hex:GetPropertyChangedSignal("Text"):Connect(function()
			if self.settingColor then return end
	
			hex.Text = formatHex(hex.Text) or ""
	
			local success, hex = pcall(Color3.fromHex, hex.Text)
	
			if success then
				local H, S, V = hex:ToHSV()
				
				self:SetColor(H, S, V, self.opacity)
			end
		end)
	
		-- default color
		local H, S, V = self.colorPickerData.color:ToHSV()
		
		self:SetColor(H, S, V, self.colorPickerData.opacity)
		
		return self
	end
	
	function ColorPickerRGBA:SetEnabled(enabled, isTransfer)
		self.enabled = enabled -- seems redundant but is required
		
		if enabled then
			if self.configFrameInfo.activeGui and self.configFrameInfo.activeGui ~= self then
				self.configFrameInfo.activeGui:SetEnabled(false, true)
			end
	
			self.configFrameInfo.activeGui = self
	
		elseif not enabled and self.configFrameInfo.activeGui == self then
			self.configFrameInfo.activeGui = nil
		end
		
		local tweenInfo = TweenInfo.new(
			0.2,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
	
		if self.colorOpenTween then
			self.colorOpenTween:Pause()
		end
	
		self.colorOpenTween = tweenService:Create(self.colorPickerGui.Color.PickColor, tweenInfo, {
			Size = if enabled then UDim2.fromOffset(210, 215) else UDim2.fromOffset(210, 0)
		})
	
		if enabled then
			self.configFrame.ClipsDescendants = false
		--[[else
			local pickColor = self.colorPickerGui.Color.PickColor
			
			pickColor.ClipsDescendants = true
			
			pickColor.DropShadowHolder.DropShadow.ImageTransparency = 1]]
		end
	
		self.colorOpenTween.Completed:Connect(function()
			self.colorOpenTween = nil
	
			if not enabled and not isTransfer then
				self.configFrame.ClipsDescendants = true
			--[[else
				local pickColor = self.colorPickerGui.Color.PickColor
	
				pickColor.ClipsDescendants = false
	
				local dropShadowTween = tweenService:Create(pickColor.DropShadowHolder.DropShadow, tweenInfo, {
					ImageTransparency = 0
				})
				
				dropShadowTween:Play()]]
			end
		end)
	
		self.colorOpenTween:Play() 
	
		local tab = self.configFrame.Parent.Parent
	
		local canvasSize = if enabled then UDim2.fromOffset(0, tab.CanvasSize.Y.Offset + 215) else UDim2.fromOffset(0, tab.CanvasSize.Y.Offset - 215)
		local canvasPosition = 0
	
		local pickerPosY = self.colorPickerGui.Color.PickColor.AbsolutePosition.Y
		local pickerSizeY = self.colorPickerGui.Color.PickColor.AbsoluteSize.Y
		local pickColorPos = pickerPosY - tab.AbsolutePosition.Y
	
		if (pickColorPos + 215) > tab.AbsoluteSize.Y and enabled then
			canvasPosition = (pickColorPos + 215) - tab.AbsoluteSize.Y + 20
		end
	
		local canvasTween = tweenService:Create(tab, tweenInfo, {
			CanvasSize = canvasSize,
			CanvasPosition = Vector2.new(0, tab.CanvasPosition.Y + canvasPosition) -- autoscroll
		})
	
		-- account for canvas
		if not isTransfer then
			canvasTween:Play()
		end
	end
	
	function ColorPickerRGBA:Get()
		return self.colorPickerData.color, self.colorPickerData.opacity
	end
	
	function ColorPickerRGBA:Set(...)
		return self:SetColor(...)
	end
	
	function ColorPickerRGBA:SetColor(H, S, V, opacity)
		self.settingColor = true -- instant crash if we dont set this
	
		local pickColorFrame = self.colorPickerGui.Color.PickColor
	
		local huesatGradientFrame = pickColorFrame.HueSatGradient
		local linearGradientFrame = pickColorFrame.LinearGradient
		local alphaGradientFrame = pickColorFrame.AlphaGradient
	
		local color = Color3.fromHSV(H, S, V)
	
		local tweenInfo = TweenInfo.new(
			0.1,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out
		)
	
		local huesatCursorTween = tweenService:Create(huesatGradientFrame.Cursor, tweenInfo, {
			Position = UDim2.fromScale(H, 1 - S),
			BackgroundColor3 = Color3.fromHSV(H, S, 1)
		})
	
		-- tween huesat cursor
		huesatCursorTween:Play()
	
		local linearGradientTween = tweenService:Create(linearGradientFrame.Cursor, tweenInfo, {
			Position = UDim2.fromScale(1, 1 - V)
		})
	
		-- tween lineargradient cursor
		linearGradientTween:Play()
		
		-- linear gradient color (cant tween colorsequence)
		linearGradientFrame.UIGradient.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(H, S, 1))
		}
		
		local alphaTween = tweenService:Create(alphaGradientFrame.Cursor, tweenInfo, {
			Position = UDim2.fromScale(1, 1 - opacity)
		})
	
		-- tween alpha cursor
		alphaTween:Play()
	
		local colorTween = tweenService:Create(self.colorPickerGui.Color.Color, tweenInfo, {
			BackgroundColor3 = color
		})
	
		-- tween color bar (todo: text color)
		colorTween:Play()
		
		local colorTopCornerTween = tweenService:Create(self.colorPickerGui.Color.Color.TopCorner, tweenInfo, {
			BackgroundColor3 = color
		})
	
		-- tween color bar top corner (ew)
		colorTopCornerTween:Play()
		
		local colorBottomCornerTween = tweenService:Create(self.colorPickerGui.Color.Color.BottomCorner, tweenInfo, {
			BackgroundColor3 = color
		})
	
		-- tween color bar bottom corner (ew)
		colorBottomCornerTween:Play()
		
		local alphaColorTween = tweenService:Create(self.colorPickerGui.Color.ColorAlpha, tweenInfo, {
			BackgroundColor3 = color,
			Transparency = 1 - opacity
		})
	
		-- tween alpha color bar (todo: text color)
		alphaColorTween:Play()
		
		local alphaColorTopCornerTween = tweenService:Create(self.colorPickerGui.Color.ColorAlpha.TopCorner, tweenInfo, {
			BackgroundColor3 = color,
			Transparency = 1 - opacity
		})
	
		-- tween alpha color bar top corner (ew)
		alphaColorTopCornerTween:Play()
		
		local alphaColorBottomCornerTween = tweenService:Create(self.colorPickerGui.Color.ColorAlpha.BottomCorner, tweenInfo, {
			BackgroundColor3 = color,
			Transparency = 1 - opacity
		})
	
		-- tween alpha color bar bottom corner (ew)
		alphaColorBottomCornerTween:Play()
		
		-- set alpha gradient color (cant tween colorsequence)
		alphaGradientFrame.Color.UIGradient.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, color),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
		}
	
		-- set fields
		local fields = pickColorFrame.Fields
	
		local function getTextBox(field)
			local focused, textbox = userInputService:GetFocusedTextBox(), field.Value.TextBox
	
			return if focused == textbox then {} else textbox
		end
	
		getTextBox(fields.Hue).Text = math.round(math.clamp(H * 360, 0, 359))
		getTextBox(fields.Sat).Text = math.round(S * 255)
		getTextBox(fields.Val).Text = math.round(V * 255)
	
		getTextBox(fields.Red).Text = math.round(color.R * 255)
		getTextBox(fields.Green).Text = math.round(color.G * 255)
		getTextBox(fields.Blue).Text = math.round(color.B * 255)
		
		local colorHex = string.upper(color:ToHex())
	
		getTextBox(fields.Hex).Text = "#" .. colorHex
	
		self.colorPickerGui.Color.Color.ColorHexCode.Text = "#" .. colorHex
		
		local opacityString = math.round(opacity * 100) .. "%"
		
		getTextBox(fields.Alpha).Text = opacityString
		
		self.colorPickerGui.Color.ColorAlpha.AlphaPercentage.Text = opacityString
	
		-- callback
		self.callback(color, opacity)
		self.colorPickerData.color = color
		self.colorPickerData.opacity = opacity
	
		-- reset text callbacks
		self.settingColor = false
	end
	
	return ColorPickerRGBA
	
end

modules[tbl.Field] = function()
	local script = tbl.Field

	local saveManager = shared.requireModule("SaveManager")
	
	local Field = {}
	Field.__index = Field
	
	-- ARGS: {Name, Placeholder Text, NumbersOnly, CharacterLimit, OnEnter, RemoveTextAfterFocusLost, Callback}
	
	Field.new = function(configFrame, configFrameInfo, saveFlag, config)
		config = config or {}
	
		local self = setmetatable({
			-- args
			name = config.name or "",
			placeholderText = config.placeholderText or "",
			numbersOnly = config.numbersOnly,
			characterLimit = config.characterLimit,
			onEnter = config.onEnter,
			removeTextOnFocusLost = config.removeTextOnFocusLost,
			callback = config.callback or function() end,
			readWriteGlobal = config.readWriteGlobal,
			
			flag = saveFlag,
			
			fieldData = {
				text = "",
			},
			
			config = config,
	
			-- internal variables
			configFrame = configFrame,
			configFrameInfo = configFrameInfo,
			field = nil,
			value = nil,
		}, Field)
		
		-- shitty
		local readData = function(...)
			if self.readWriteGlobal then
				return saveManager:ReadGlobalData(...)
			else
				return saveManager:ReadCurrentConfig(...)
			end
		end
	
		-- shitty
		local writeData = function(...)
			if self.readWriteGlobal then
				return saveManager:WriteGlobalData(...)
			else
				return saveManager:WriteCurrentConfig(...)
			end
		end
		
		-- read save data
		local storedFieldData = readData(self.flag)
	
		if storedFieldData then
			self.fieldData = storedFieldData
		else
			writeData(self.flag, self.fieldData)
		end
	
		-- on changed
		saveManager.configChanged.Event:Connect(function(name, revertToDefaultIfNotFound)
			if self.readWriteGlobal then return end
			
			storedFieldData = readData(self.flag)
			
			if storedFieldData then
				self.fieldData = storedFieldData
			elseif revertToDefaultIfNotFound then
				self.fieldData = {
					text = ""	
				} -- revert to defaults
			else
				self.fieldData = {
					text = self.fieldData.text
				}
			end
			
			self:Set(self.fieldData.text)
			
			writeData(self.flag, self.fieldData)
		end)
		
		self.field = script.Field:Clone()
		self.field.Parent = self.configFrame
		
		local textbox = self.field.Field.TextBox
		
		self.field.Top.Text = self.name
		textbox.PlaceholderText = self.placeholderText
		
		self.configFrameInfo.size += self.field.Size.Y.Offset + 5
		
		if self.numbersOnly or self.characterLimit then
			textbox:GetPropertyChangedSignal("Text"):Connect(function()
				if textbox.Text == "" then return end 
				if self.characterLimit then textbox.Text = string.sub(textbox.Text, 1, self.characterLimit) end
				if self.numbersOnly then textbox.Text = string.gsub(textbox.Text, "%D+", "") end
				
				self.fieldData.text = textbox.Text
			end)
		end
		
		textbox.FocusLost:Connect(function(enterPressed)
			if self.onEnter and not enterPressed then
				if self.removeTextOnFocusLost then
					self:Set("")
					return
				end
			end
			
			self.callback(textbox.Text)
			self.fieldData.text = textbox.Text
		end)
		
		self:Set(self.fieldData.text)
		
		return self
	end
	
	function Field:Set(value)
		self.field.Field.TextBox.Text = value
		self.fieldData.text = value
	end
	
	function Field:Get(value)
		return self.fieldData.text
	end
	
	return Field
	
end

modules[tbl.Slider] = function()
	local script = tbl.Slider

	local tweenService = game:GetService("TweenService")
	local userInputService = game:GetService("UserInputService")
	
	local saveManager = shared.requireModule("SaveManager")
	
	-- local functions
	local function step(n, step)
		return math.round(n / step) * step
	end
	
	-- lib
	local Slider = {}
	Slider.__index = Slider
	
	Slider.new = function(configFrame, configFrameInfo, saveFlag, config)
		config = config or {}
		
		local self = setmetatable({
			-- args
			default = config.default or 0,
			step = config.step,
			name = config.name,
			min = config.min,
			max = config.max,
			callback = config.callback or function()end,
			readWriteGlobal = config.readWriteGlobal,
			-- ..
			
			flag = saveFlag,
			
			sliderData = {
				value = config.default or 0
			},
			
			config = config,
			
			-- internal variables
			enabled = false,
			configFrame = configFrame,
			configFrameInfo = configFrameInfo,
			sliderInstance = nil,
			SliderDragging = false,
			connection = nil,
		}, Slider)
		
		-- shitty
		local readData = function(...)
			if self.readWriteGlobal then
				return saveManager:ReadGlobalData(...)
			else
				return saveManager:ReadCurrentConfig(...)
			end
		end
	
		-- shitty
		local writeData = function(...)
			if self.readWriteGlobal then
				return saveManager:WriteGlobalData(...)
			else
				return saveManager:WriteCurrentConfig(...)
			end
		end
		
		-- read save data
		local storedSliderData = readData(self.flag)
	
		if storedSliderData then
			self.sliderData = storedSliderData
		else
			writeData(self.flag, self.sliderData)
		end
	
		-- on changed
		saveManager.configChanged.Event:Connect(function(name, revertToDefaultIfNotFound)
			if self.readWriteGlobal then return end
			
			storedSliderData = readData(self.flag)
	
			if storedSliderData then
				self.sliderData = storedSliderData
			elseif revertToDefaultIfNotFound then
				self.sliderData = {
					value = self.default	
				} -- revert to defaults
			else
				self.sliderData = {
					value = self.sliderData.value
				}
			end
			
			self:Set(self.sliderData.value)
			
			writeData(self.flag, self.sliderData)
		end)
		
		self.sliderInstance = script.Slider:Clone()
		self.sliderInstance.Bar.Min.Text = self.min
		self.sliderInstance.Bar.Max.Text = self.max
		self.sliderInstance.Parent = self.configFrame
		self.configFrameInfo.size += self.sliderInstance.Size.Y.Offset + 5
		self.sliderInstance.Top.NameT.Text = self.name
		
		self.sliderInstance.Top.Input.Position = UDim2.new(self.sliderInstance.Top.Input.Position.X.Scale, self.sliderInstance.Top.NameT.AbsoluteSize.X + 10, self.sliderInstance.Top.Input.Position.Y.Scale, self.sliderInstance.Top.Input.Position.Y.Offset)
		
		self.sliderInstance.Bar.Fill.Ball.Click.MouseButton1Down:Connect(function()
			self.SliderDragging = true
		end)
		
		userInputService.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				self.SliderDragging = false
			end
		end)
		
		self.textConnection = self.sliderInstance.Top.Input:GetPropertyChangedSignal("Text"):Connect(function()
			if not tonumber(self.sliderInstance.Top.Input.Text) then return end
			self:Set(tonumber(self.sliderInstance.Top.Input.Text), self.step)
		end)
		
		self.connection = userInputService.InputChanged:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement and self.SliderDragging then
				local mouse = game.Players.LocalPlayer:GetMouse()
				local Percentage = math.clamp((mouse.X - self.sliderInstance.Bar.Fill.AbsolutePosition.X) / self.sliderInstance.Bar.AbsoluteSize.X, 0, 1)
				self.sliderData.value = step(((self.max - self.min) * Percentage) + self.min, self.step)
	
				tweenService:Create(self.sliderInstance.Bar.Fill, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(Percentage, 0, self.sliderInstance.Bar.Fill.Size.Y.Scale, self.sliderInstance.Bar.Fill.Size.Y.Offset)}):Play()
				self.sliderInstance.Top.Input.Text = self.sliderData.value
				self.callback(self.sliderData.value)
			end
		end)
		
		self:Set(self.sliderData.value)
		
		return self
	end
	
	function Slider:Get()
		return self.sliderData.value
	end
	
	function Slider:Set(value)
		self.sliderData.value = value
		local Percentage = math.clamp((self.sliderData.value - self.min) / (self.max - self.min), 0, 1)
	
		tweenService:Create(self.sliderInstance.Bar.Fill, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(Percentage, 0, self.sliderInstance.Bar.Fill.Size.Y.Scale, self.sliderInstance.Bar.Fill.Size.Y.Offset)}):Play()
		self.sliderInstance.Top.Input.Text = self.sliderData.value
		self.callback(self.sliderData.value)
	end
	
	return Slider
	
end

modules[tbl.Button] = function()
	local script = tbl.Button

	local UIHover = shared.requireModule("UIHover")
	local UIClick = shared.requireModule("UIClick")
	
	local Button = {}
	Button.__index = Button
	
	Button.new = function(configFrame, configFrameInfo, config) -- saveFlag, 
		config = config or {}
		
		local self = setmetatable({
			-- args
			name = config.name,
			callback = config.callback,
			
			--flag = saveFlag,
			
			-- internal variables
			configFrame = configFrame,
			configFrameInfo = configFrameInfo,
			button = nil
		}, Button)
		
		self.button = script.Button:Clone()
		
		UIHover:AddHover("BackgroundColor3", { self.button })
		UIClick:AddClick("BackgroundColor3", { self.button })
		
		self.button.Text = self.name
		self.configFrameInfo.size += self.button.Size.Y.Offset + 5
		self.button.Parent = self.configFrame
	
		self.button.MouseButton1Click:Connect(function()
			self.callback()
		end)
		
		return self
	end
	
	function Button:Set(config)
		config = config or {}
		
		self.button.Text = config.name or ""
		self.callback = config.callback or self.callback
	end
	
	return Button
	
end

modules[tbl.Dropdown] = function()
	local script = tbl.Dropdown

	local tweenService = game:GetService("TweenService")
	local textService = game:GetService("TextService")
	
	local saveManager = shared.requireModule("SaveManager")
	local UIHover = shared.requireModule("UIHover")
	local UIClick = shared.requireModule("UIClick")
	
	local tweenInfo = TweenInfo.new(
		0.2,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out
	)
	
	local Dropdown = {}
	Dropdown.__index = Dropdown
	
	Dropdown.new = function(configFrame, configFrameInfo, saveFlag, config)
		config = config or {}
		
		local self = setmetatable({
			-- args
			name = config.name or "",
			options = config.options or {},
			multiSelection = config.multiSelection,
			canDisableSingleSelf = config.canDisableSingleSelf,
			callback = config.callback or function() end,
			readWriteGlobal = config.readWriteGlobal,
			
			flag = saveFlag,
			
			dropdownData = {
				selected = {}
			},
			
			config = config,
	
			-- internal variables
			configFrame = configFrame,
			configFrameInfo = configFrameInfo,
			dropdown = nil,
			itemTemplate = nil,
			selectedOption = {},
			openTween = nil,
			enabled = false,
			debounce = tick()
		}, Dropdown)
		
		-- shitty
		local readData = function(...)
			if self.readWriteGlobal then
				return saveManager:ReadGlobalData(...)
			else
				return saveManager:ReadCurrentConfig(...)
			end
		end
		
		-- shitty
		local writeData = function(...)
			if self.readWriteGlobal then
				return saveManager:WriteGlobalData(...)
			else
				return saveManager:WriteCurrentConfig(...)
			end
		end
		
		-- read save data
		local storedDropdownData = readData(self.flag)
	
		if storedDropdownData then
			self.dropdownData = storedDropdownData
		else
			writeData(self.flag, self.dropdownData)
		end
	
		-- on changed
		saveManager.configChanged.Event:Connect(function(name, revertToDefaultIfNotFound)
			if self.readWriteGlobal then return end
			
			storedDropdownData = readData(self.flag)
	
			if storedDropdownData then
				self.dropdownData = storedDropdownData
				
			elseif revertToDefaultIfNotFound then
				self.dropdownData = {
					selected = {}	
				} -- revert to defaults
			else
				local copyOfSelected = {}
	
				for index, value in self.dropdownData.selected do
					copyOfSelected[index] = value -- have to copy values
				end
				
				self.dropdownData = {
					selected = copyOfSelected	
				} -- revert to defaults
			end
			
			local copyOfSelected = {}
	
			for index, value in self.dropdownData.selected do
				copyOfSelected[index] = value -- thanks xzyn
			end
	
			self:Set(copyOfSelected)
			
			writeData(self.flag, self.dropdownData)
		end)
		
		self.dropdown = script.Dropdown:Clone()
		
		UIHover:AddHover("BackgroundColor3", { self.dropdown.Selected })
		UIClick:AddClick("BackgroundColor3", { self.dropdown.Selected })
		
		self.itemTemplate = self.dropdown.Selected.Options.Items.Item
		self.itemTemplate.Parent = nil -- thanks xzyn
		
		local textSize = textService:GetTextSize(self.name, self.dropdown.Top.TextSize, Enum.Font.Gotham, Vector2.new()) -- FONT MANAGER NEEDED
	
		self.dropdown.Selected.Size = UDim2.new(1, -15 - textSize.X - 10, 0, 16)
		
		self.dropdown.Parent = configFrame
		
		self.dropdown.Top.Text = self.name
		
		configFrameInfo.size += self.dropdown.Size.Y.Offset + 5
		
		local options = self.dropdown.Selected.Options
		for _, option in self.options do
			self:InitOption(option)
		end
		
		local function onToggle()
			if (tick() - self.debounce) < 0.21 then return end
			self.debounce = tick()
			
			self.enabled = not self.enabled
			self:SetEnabled(self.enabled)
		end
		
		self.dropdown.Selected.MouseButton1Click:Connect(onToggle)
		self.dropdown.Selected.MouseButton2Click:Connect(onToggle)
		
		self:InitSearch()
		
		-- settings
		local copyOfSelected = {}
	
		for index, value in self.dropdownData.selected do
			copyOfSelected[index] = value -- thanks xzyn
		end
	
		self:Set(copyOfSelected)
		
		return self
	end
	
	function Dropdown:InitSearch()
		local searchBar = self.dropdown.Selected.Options.SearchBar
	
		searchBar:GetPropertyChangedSignal("Text"):Connect(function()
			local inputText = string.upper(searchBar.Text)
	
			for _, child in self.dropdown.Selected.Options.Items:GetChildren() do
				if child.ClassName ~= "Frame" or child:GetAttribute("Template") then continue end
				if inputText == "" or string.find(string.upper(child.Name), inputText) then
					child.Visible = true
				else
					child.Visible = false
				end
			end
		end)
	end
	
	function Dropdown:SetEnabled(enabled, isTransfer)
		self.enabled = enabled -- seems redundant but is required
		
		if enabled then
			if self.configFrameInfo.activeGui and self.configFrameInfo.activeGui ~= self then
				self.configFrameInfo.activeGui:SetEnabled(false, true)
			end
	
			self.configFrameInfo.activeGui = self
	
		elseif not enabled and self.configFrameInfo.activeGui == self then
			self.configFrameInfo.activeGui = nil
		end
		
		local options = self.dropdown.Selected.Options
		local size = 155
		
		if self.openTween then
			self.openTween:Pause()
		end
		
		self.openTween = tweenService:Create(self.dropdown.Selected.Options, tweenInfo, {
			Size = if enabled then UDim2.new(1, 10, 0, size) else UDim2.new(1, 10, 0, 0)
		})
		
		if enabled then
			self.configFrame.ClipsDescendants = false
			
			self.dropdown.Selected.ZIndex = 4
			self.dropdown.Selected.Arrow.ZIndex = 4
		end
		
		self.openTween.Completed:Connect(function()
			self.colorOpenTween = nil
			
			if not enabled then
				if not isTransfer then
					self.configFrame.ClipsDescendants = true
				end
				
				self.dropdown.Selected.ZIndex = 1
				self.dropdown.Selected.Arrow.ZIndex = 1
			end
		end)
		
		self.openTween:Play() 
		tweenService:Create(self.dropdown.Selected.Arrow, tweenInfo, { Rotation = if enabled then 180 else 0 }):Play()
		
		local tab = self.configFrame.Parent.Parent
	
		local canvasSize = if enabled then UDim2.fromOffset(0, tab.CanvasSize.Y.Offset + size) else UDim2.fromOffset(0, tab.CanvasSize.Y.Offset - size)
		local canvasPosition = 0
	
		local pickerPosY = self.dropdown.Selected.Options.AbsolutePosition.Y
		local pickerSizeY = self.dropdown.Selected.Options.AbsoluteSize.Y
		local pickColorPos = pickerPosY - tab.AbsolutePosition.Y
	
		if (pickColorPos + size) > tab.AbsoluteSize.Y and enabled then
			canvasPosition = (pickColorPos + size) - tab.AbsoluteSize.Y + 20
		end
	
		local canvasTween = tweenService:Create(tab, tweenInfo, {
			CanvasSize = canvasSize,
			CanvasPosition = Vector2.new(0, tab.CanvasPosition.Y + canvasPosition) -- autoscroll
		})
	
		-- account for canvas
		if not isTransfer then
			canvasTween:Play()
		end
	end
	
	function Dropdown:Update(newOptions)
		table.clear(self.options)
		table.clear(self.selectedOption)
		table.clear(self.dropdownData.selected)
		for _, child in self.dropdown.Selected.Options.Items:GetChildren() do
			if child.ClassName ~= "Frame" then continue end
			child:Destroy()
		end
		
		local options = self.dropdown.Selected.Options
		for _, option in newOptions do
			table.insert(self.options, option) -- thanks xzyn
			
			self:InitOption(option)
		end
		
		self:Set(self.dropdownData.selected)
	end
	
	function Dropdown:Set(optionsToSet)
		local options = self.dropdown.Selected.Options
		table.clear(self.selectedOption)
		table.clear(self.dropdownData.selected)
		for _, option in self.options do
			local optionInstance = options.Items:FindFirstChild(option)
			if table.find(optionsToSet, option) and not table.find(self.selectedOption, optionInstance) then
				tweenService:Create(optionInstance.Click.Enabled, tweenInfo, { BackgroundTransparency = 0 }):Play()
				table.insert(self.selectedOption, optionInstance)
				table.insert(self.dropdownData.selected, option)
			else
				tweenService:Create(optionInstance.Click.Enabled, tweenInfo, { BackgroundTransparency = 1 }):Play()
				if table.find(self.selectedOption, optionInstance) then
					table.remove(self.selectedOption, table.find(self.selectedOption, optionInstance))
					table.remove(self.dropdownData.selected, table.find(self.dropdownData.selected, option))
				end
			end
		end
	end
	
	function Dropdown:Get()
		return self.dropdownData.selected
	end
	
	function Dropdown:InitOption(option)
		local options = self.dropdown.Selected.Options
		local clonedOption = self.itemTemplate:Clone()
		clonedOption.Name = option
		clonedOption.Click.Text = option
		clonedOption.Visible = true
		clonedOption.Parent = options.Items
		
		UIHover:AddHover("BackgroundColor3", { clonedOption.Click })
		UIClick:AddClick("BackgroundColor3", { clonedOption.Click })
	
		clonedOption.Click.MouseButton1Click:Connect(function()
			if not self.multiSelection and #self.selectedOption == 1 then
				if self.selectedOption[1] ~= clonedOption then
					tweenService:Create(self.selectedOption[1].Click.Enabled, tweenInfo, { BackgroundTransparency = 1 }):Play()
					table.remove(self.selectedOption, 1)
					table.insert(self.selectedOption, clonedOption)
					table.remove(self.dropdownData.selected, 1)
					table.insert(self.dropdownData.selected, option)
					tweenService:Create(clonedOption.Click.Enabled, tweenInfo, { BackgroundTransparency = 0 }):Play()
					
				elseif self.canDisableSingleSelf then
					tweenService:Create(self.selectedOption[1].Click.Enabled, tweenInfo, { BackgroundTransparency = 1 }):Play()
					table.remove(self.selectedOption, 1)
					table.remove(self.dropdownData.selected, 1)
				end
			else
				if table.find(self.selectedOption, clonedOption) then
					table.remove(self.selectedOption, table.find(self.selectedOption, clonedOption))
					table.remove(self.dropdownData.selected, table.find(self.dropdownData.selected, option))
					tweenService:Create(clonedOption.Click.Enabled, tweenInfo, { BackgroundTransparency = 1 }):Play()
				else
					table.insert(self.selectedOption, clonedOption)
					table.insert(self.dropdownData.selected, option)
					tweenService:Create(clonedOption.Click.Enabled, tweenInfo, { BackgroundTransparency = 0 }):Play()
				end
			end
			
			self.callback(self.dropdownData.selected)
		end)
	end
	
	return Dropdown
	
end

modules[tbl.Toggle] = function()
	local script = tbl.Toggle

	local tweenService = game:GetService("TweenService")
	
	local saveManager = shared.requireModule("SaveManager")
	local UIHover = shared.requireModule("UIHover")
	local UIClick = shared.requireModule("UIClick")
	
	local tweenInfo = TweenInfo.new(
		0.08,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out
	)
	
	local Toggle = {}
	Toggle.__index = Toggle
	
	Toggle.new = function(configFrame, configFrameInfo, saveFlag, config)
		config = config or {}
	
		local self = setmetatable({
			-- args
			name = config.name or "",
			callback = config.callback or function() end,
			readWriteGlobal = config.readWriteGlobal,
			
			flag = saveFlag,
			
			toggleData = {
				enabled = config.enabled,
			},
			
			config = config,
	
			-- internal variables
			configFrame = configFrame,
			configFrameInfo = configFrameInfo,
			toggleInstance = nil,
		}, Toggle)
		
		-- shitty
		local readData = function(...)
			if self.readWriteGlobal then
				return saveManager:ReadGlobalData(...)
			else
				return saveManager:ReadCurrentConfig(...)
			end
		end
	
		-- shitty
		local writeData = function(...)
			if self.readWriteGlobal then
				return saveManager:WriteGlobalData(...)
			else
				return saveManager:WriteCurrentConfig(...)
			end
		end
		
		-- read save data
		local storedToggleData = readData(self.flag)
	
		if storedToggleData then
			self.toggleData = storedToggleData
		else
			writeData(self.flag, self.toggleData)
		end
	
		-- on changed
		saveManager.configChanged.Event:Connect(function(name, revertToDefaultIfNotFound)
			if self.readWriteGlobal then return end
			
			storedToggleData = readData(self.flag)
	
			if storedToggleData then
				self.toggleData = storedToggleData
			elseif revertToDefaultIfNotFound then
				self.toggleData = {
					enabled = self.config.enabled	
				} -- revert to defaults
			else
				self.toggleData = {
					enabled = self.toggleData.enabled
				}
			end
			
			self:Set(self.toggleData.enabled)
			
			writeData(self.flag, self.toggleData)
		end)
	
		self.toggleInstance = script.Toggle:Clone()
		
		UIHover:AddHover("BackgroundColor3", { self.toggleInstance })
		UIClick:AddClick("BackgroundColor3", { self.toggleInstance })
		
		self.toggleInstance.Parent = self.configFrame
		
		self.toggleInstance.Top.Text = self.name
		self.configFrameInfo.size += self.toggleInstance.Size.Y.Offset + 5
		
		self.toggleInstance.Click.Tick.ImageTransparency = if self.toggleData.enabled then 0 else 1
		self.toggleInstance.Click.BackgroundColor3 = if self.toggleData.enabled then Color3.fromRGB(0, 255, 178) else Color3.fromRGB(83, 85, 88)
		
		local function onClick()
			self.toggleData.enabled = not self.toggleData.enabled
	
			tweenService:Create(self.toggleInstance.Click.Tick, tweenInfo, {
				ImageTransparency = if self.toggleData.enabled then 0 else 1
			}):Play()
	
			tweenService:Create(self.toggleInstance.Click, tweenInfo, {
				BackgroundColor3 = if self.toggleData.enabled then Color3.fromRGB(0, 255, 178) else Color3.fromRGB(83, 85, 88)
			}):Play()
	
			self.callback(self.toggleData.enabled)
		end
		
		self.toggleInstance.MouseButton1Click:Connect(onClick)
		self.toggleInstance.Click.MouseButton1Click:Connect(onClick)
	
		return self
	end
	
	function Toggle:Set(value)
		--if self.toggleData.enabled == value then return end --maybe not needed?
		self.toggleData.enabled = value
		
		tweenService:Create(self.toggleInstance.Click.Tick, tweenInfo, {
			ImageTransparency = if self.toggleData.enabled then 0 else 1
		}):Play()
	
		tweenService:Create(self.toggleInstance.Click, tweenInfo, {
			BackgroundColor3 = if self.toggleData.enabled then Color3.fromRGB(0, 255, 178) else Color3.fromRGB(83, 85, 88)
		}):Play()
		
		self.callback(self.toggleData.enabled)
	end
	
	function Toggle:Get()
		return self.toggleData.enabled
	end
	
	return Toggle
	
end

modules[tbl.Label_15] = function()
	local script = tbl.Label_15

	local tweenService = game:GetService("TweenService")
	local textService = game:GetService("TextService")
	
	local Label = {}
	Label.__index = Label
	
	Label.new = function(configFrame, configFrameInfo, config) -- saveFlag, 
		config = config or {}
		
		local self = setmetatable({
			-- args
			name = config.name,
			text = config.text,
			copyable = config.copyable or false,
			
			-- internal variables
			configFrame = configFrame,
			configFrameInfo = configFrameInfo,
			textDelta = nil,
			copyDebounce = tick(),
			label = nil
		}, Label)
		
		self.label = script.Label:Clone()
		
		self.label.Header.Text = self.name
		self.label.Content.Text = self.text
		
		local basesize = self.label.AbsoluteSize
		
		local textSize = textService:GetTextSize(self.text, 12, Enum.Font.Gotham, basesize)
		
		self.textDelta = textSize.Y + 30
		
		self.configFrameInfo.size += self.textDelta + 5
		self.label.Size = UDim2.new(1, 0, 0, self.textDelta)
		
		self.label.Parent = self.configFrame
		
		local copy = self.label.Copy
		local copied = self.label.Copied
		
		if self.copyable then
			copy.Visible = true
		end
		
		local function tweenImageTransparency(instance, transparency)
			local tweenInfo = TweenInfo.new(
				0.1,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			)
			
			local tween = tweenService:Create(instance, tweenInfo, {
				ImageTransparency = transparency
			})
			
			tween:Play()
		end
		
		copy.MouseButton1Click:Connect(function()
			if (tick() - self.copyDebounce) < 0.6 then return end
			self.copyDebounce = tick()
			
			if setclipboard then
				setclipboard(self.text)
			end
			
			tweenImageTransparency(copy, 1)
			
			task.wait(0.05)
			
			tweenImageTransparency(copied, 0)
			
			task.wait(0.5)
	
			tweenImageTransparency(copied, 1)
			
			task.wait(0.05)
	
			tweenImageTransparency(copy, 0)
		end)
		
		return self
	end
	
	function Label:Set(config)
		config = config or {}
		
		self.name = config.name
		self.text = config.text
		
		self.label.Header.Text = config.name
		self.label.Content.Text = config.text
		
		local textSize = textService:GetTextSize(self.text, 12, Enum.Font.Gotham, self.label.AbsoluteSize)
	
		self.configFrameInfo.size = self.configFrameInfo.size - self.textDelta + textSize.Y + 30
		self.label.Size = UDim2.new(1, 0, 0, textSize.Y + 30)
		
		self.textDelta = textSize.Y + 30
	end
	
	return Label
	
end

modules[tbl.Notification] = function()
	local script = tbl.Notification

	local tweenService = game:GetService("TweenService")
	local textService = game:GetService("TextService")
	
	local notificationTemplate = script.Notification
	
	local modes = {
		["Success"] = Color3.fromRGB(0, 255, 115),
		["Warn"] = Color3.fromRGB(255, 213, 75),
		["Error"] = Color3.fromRGB(255, 0, 68),
		["Neutral"] = Color3.fromRGB(35, 43, 55)
	}
	
	local queue = {}
	
	local Notification = {}
	Notification.__index = Notification
	
	Notification.new = function(gui, config)
		config = config or {}
		
		local self = setmetatable({
			title = config.title or "",
			content = config.content or "",
			mode = config.mode or "Neutral",
			duration = config.duration or 5,
			
			gui = gui,
			notification = nil,
			position = nil,
		}, Notification)
		
		self.notification = notificationTemplate:Clone()
		
		self.position = self.notification.Position
		
		self.notification.Header.Text = self.title
		self.notification.Content.Text = self.content
		
		self.notification.TimeLeft.BackgroundColor3 = modes[self.mode]
		self.notification.TimeLeft.Left.BackgroundColor3 = modes[self.mode]
		
		local textSize = textService:GetTextSize(self.content, 12, Enum.Font.Gotham, Vector2.new(self.gui.AbsoluteSize.X * 0.975, math.huge)) -- richtext fixes things...
		
		self.notification.Size = UDim2.new(0.975, 0, 0, textSize.Y + 32)
		
		return self
	end
	
	function Notification:Notify()
		local shiftTweenInfo = TweenInfo.new(
			0.3,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out
		)
		
		local entryTweenInfo = TweenInfo.new(
			0.2,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		)
		
		table.insert(queue, 1, self)
		
		local entryTween = tweenService:Create(self.notification, entryTweenInfo, {
			Position = UDim2.new(0, 0, 1, 0)
		})
	
		entryTween:Play()
		
		for i = 2, #queue do
			queue[i].position = UDim2.new(0, 0, 1, queue[i].position.Y.Offset - self.notification.Size.Y.Offset - 5) -- delta is offset from bottom so it is negative
			
			-- adjust queue
			local shiftTween = tweenService:Create(queue[i].notification, shiftTweenInfo, {
				Position = queue[i].position
			})
			
			shiftTween:Play()
		end
		
		-- parent
		self.notification.Parent = self.gui.Notifications
		
		-- tween time left animation
		local timeLeftTweenInfo = TweenInfo.new(
			self.duration,
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.InOut
		)
		
		local tween = tweenService:Create(self.notification.TimeLeft, timeLeftTweenInfo, {
			Size = UDim2.new(0, 0, 0, 20)
		})
		
		tween:Play()
		
		tween.Completed:Connect(function()
			local index = table.find(queue, self)
			
			table.remove(queue, index)
			
			local shiftTween = tweenService:Create(self.notification, entryTweenInfo, {
				Position = UDim2.new(1.2, 0, 1, self.notification.Position.Y.Offset)
			})
			
			shiftTween.Completed:Connect(function()
				self.notification:Destroy()
			end)
			
			shiftTween:Play()
			
			for i = index, #queue do
				queue[i].position = UDim2.new(0, 0, 1, queue[i].position.Y.Offset + self.notification.Size.Y.Offset + 5)
	
				-- adjust queue
				local shiftTween = tweenService:Create(queue[i].notification, shiftTweenInfo, {
					Position = queue[i].position
				})
	
				shiftTween:Play()
			end
		end)
	end
	
	return Notification
	
end

modules[tbl.Dragger] = function()
	local script = tbl.Dragger

	local userInputService = game:GetService("UserInputService")
	local tweenService = game:GetService("TweenService")
	
	local tweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	
	--------------------------------------------
	
	local dragger = {}
	dragger.__index = dragger
	
	dragger.new = function(dragPoint, main)
		return setmetatable({
			dragPoint = dragPoint,
			main = main,
	
			enabled = false,
			dpInputBegan = nil, -- dp = dragging input
			dpInputChanged = nil,
			uisInputChanged = nil,
			uisInputEnded = nil,
			currentlyRunningTween = nil,
	
			--dragging = nil,
			--dragInput = nil,
			--mousePos = nil,
			--framePos = nil
		}, dragger)
	end
	
	function dragger:Enable()
		if self.enabled then return end
	
		self.enabled = true
	
		local dragging, dragInput, mousePos, framePos = nil, nil, nil, nil
	
		--------------------------------------------
	
		local function onDragInputBegan(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	
			dragging, mousePos, framePos = true, input.Position, self.main.Position
		end	
	
		local function onDragInputChanged(input)
			if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
	
			dragInput = input
		end
	
		local function onInputChanged(input)
			if input ~= dragInput or (not dragging) then return end
	
			local delta = input.Position - mousePos
	
			self.currentlyRunningTween = tweenService:Create(self.main, tweenInfo, {
				Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
			})
	
			self.currentlyRunningTween:Play()
		end
	
		local function onInputEnded(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	
			dragging = false
		end
	
		--------------------------------------------
	
		self.dpInputBegan = self.dragPoint.InputBegan:Connect(onDragInputBegan)
		self.dpInputChanged = self.dragPoint.InputChanged:Connect(onDragInputChanged)
		self.uisInputChanged = userInputService.InputChanged:Connect(onInputChanged)
		self.uisInputEnded = userInputService.InputEnded:Connect(onInputEnded)
	end
	
	function dragger:Disable()
		if not self.enabled then return end
	
		self.enabled = false
	
		self.dpInputBegan:Disconnect(); self.dpInputBegan = nil
		self.dpInputChanged:Disconnect(); self.dpInputChanged = nil
		self.uisInputChanged:Disconnect(); self.uisInputChanged = nil
		self.uisInputEnded:Disconnect(); self.uisInputEnded = nil
	
		if self.currentlyRunningTween then -- might not exist
			self.currentlyRunningTween:Pause(); self.currentlyRunningTween = nil
		end
	end
	
	return dragger
	
end

modules[tbl.Resizer] = function()
	local script = tbl.Resizer

	-- written by ch0nky
	
	local userInputService = game:GetService("UserInputService")
	local tweenService = game:GetService("TweenService")
	local guiService = game:GetService("GuiService")
	
	-- local functions
	local function isMouseWithinBounds(topLeft, bottomRight, mouse)
		local mouseX, mouseY = mouse.X, mouse.Y
	
		if mouseX > topLeft.X and mouseX < bottomRight.X and mouseY > topLeft.Y and mouseY < bottomRight.Y then
			return true
		end
	
		return false
	end
	
	local function setAnchorPointWithoutMoving(guiObject, anchorPoint)
		local parent = guiObject.Parent
	
		local parentSize, parentPosition = parent.AbsoluteSize, parent.AbsolutePosition
		local guiSize, guiPosition = guiObject.AbsoluteSize, guiObject.AbsolutePosition
	
		guiPosition = guiPosition - parentPosition
	
		local correctionOffsetX = guiSize.X * anchorPoint.X
		local correctionOffsetY = guiSize.Y * anchorPoint.Y
	
		guiObject.AnchorPoint = anchorPoint
		guiObject.Position = UDim2.fromScale((guiPosition.X + correctionOffsetX) / parentSize.X, (guiPosition.Y + correctionOffsetY) / parentSize.Y)
	end
	
	local function convertOffsetToScale(guiObject, _UDim2)
		local parentSize = guiObject.Parent.AbsoluteSize
	
		local scaleX = 1 / parentSize.X * _UDim2.X.Offset
		local scaleY = 1 / parentSize.Y * _UDim2.Y.Offset
	
		return Vector2.new(scaleX, scaleY)
	end
	
	local function convertScaleToOffset(guiObject, _UDim2)
		local parentSize = guiObject.Parent.AbsoluteSize
	
		local offsetX = parentSize.X * _UDim2.X.Scale
		local offsetY = parentSize.Y * _UDim2.Y.Scale
	
		return Vector2.new(offsetX, offsetY)
	end
	
	local function getUDim2AsOffset(guiObject, _UDim2)
		return Vector2.new(_UDim2.X.Offset, _UDim2.Y.Offset) + convertScaleToOffset(guiObject, _UDim2)
	end
	
	local function getUDim2AsScale(guiObject, _UDim2)
		return Vector2.new(_UDim2.X.Scale, _UDim2.Y.Scale) + convertOffsetToScale(guiObject, _UDim2)
	end
	
	-- "states"
	local opposingAnchorPoints = {
		-- faces
		left = Vector2.new(1, 0.5),
		right = Vector2.new(0, 0.5),
		top = Vector2.new(0.5, 1),
		bottom = Vector2.new(0.5, 0),
	
		-- corners
		topLeft = Vector2.new(1, 1),
		topRight = Vector2.new(0, 1),
		bottomLeft = Vector2.new(1, 0),
		bottomRight = Vector2.new(0, 0)
	}
	
	-- mouse rotation states
	local mouseIconRotations = {
		horizontal = 0,
		vertical = 90,
	
		diagonalLeft = 45,
		diagonalRight = 315
	}
	
	-- library
	local Resizer = {}
	Resizer.__index = Resizer
	
	function Resizer.new(frame, minimumSize, maximumSize, fakeMouse, resizeStateChangedCallback)
		return setmetatable({
			-- args
			frame = frame,
			minimumSize = minimumSize,
			maximumSize = maximumSize,
			fakeMouse = fakeMouse,
			resizeStateChangedCallback = resizeStateChangedCallback or function()end,
			
			-- internal variables
			enabled = false,
			onMouseMoveConnection = nil,
			onInputBegan = nil,
			onInputEnded = nil,
			onCurrentCameraChanged = nil,
			mouse1DownPosition = nil,
			currentlyRunningBodyTween = nil,
			currentlyRunningMouseTween = nil,
			turboResize = nil,
			frameSize = nil,
			opposingAnchorPoint = nil,
			currentCamera = nil,
			resetState = nil,
		}, Resizer)
	end
	
	function Resizer:Enable()
		if self.enabled then return end
	
		self.enabled = true
		
		-- reset function
		self.resetState = function()
			self.opposingAnchorPoint = nil
	
			-- re-enable mouse icon
			userInputService.MouseIconEnabled = true
	
			-- hide icon
			self.fakeMouse.Visible = false
		end
	
		-- camera
		self.currentCamera = workspace.CurrentCamera
	
		self.onCurrentCameraChanged = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			self.currentCamera = workspace.CurrentCamera -- just in case...
		end)
	
		-- mouse state
		self.onInputBegan = userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
			if input.UserInputType == Enum.UserInputType.MouseButton1 and self.opposingAnchorPoint then
				-- prevent async issues
				if self.currentlyRunningBodyTween then
					self.currentlyRunningBodyTween:Pause()
				end
				
				-- yeah
				self.resizeStateChangedCallback(true)
				
				self.mouse1DownPosition = input.Position
	
				-- anchorpoint math
				setAnchorPointWithoutMoving(self.frame, self.opposingAnchorPoint)
	
				-- set fields
				self.frameSize = self.frame.Size
			elseif input.KeyCode == Enum.KeyCode.LeftShift then
				self.turboResize = true
			end
		end)
	
		self.onInputEnded = userInputService.InputEnded:Connect(function(input, gameProcessedEvent)
			if input.UserInputType == Enum.UserInputType.MouseButton1 and self.mouse1DownPosition then
				self.mouse1DownPosition = nil
				
				-- yeah
				self.resizeStateChangedCallback(false)
				
				-- v nice
				self.resetState()
				
				-- retard proofing...
				if self.currentlyRunningMouseTween then
					self.currentlyRunningMouseTween:Pause()
				end
			elseif input.KeyCode == Enum.KeyCode.LeftShift then
				self.turboResize = false
			end
		end)
			
		-- main
		self.onMouseMoveConnection = userInputService.InputChanged:Connect(function(input, gameProcessedEvent)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				local mouse = input.Position
				
				local guiInset = guiService:GetGuiInset()
				
				if self.opposingAnchorPoint and self.mouse1DownPosition then
					local mouseDelta, fakeMouseDelta = mouse - self.mouse1DownPosition, mouse - self.mouse1DownPosition
					
					-- turbo resize lol
					if self.turboResize then
						mouseDelta *= 2
						
						fakeMouseDelta *= 2
					end
					
					-- exclusion
					if self.opposingAnchorPoint == opposingAnchorPoints.left or self.opposingAnchorPoint == opposingAnchorPoints.right then
						mouseDelta *= Vector3.new(1, 0, 0)
						
						-- fakeMousePos = Vector3.new(fakeMousePos.X, self.mouse1DownPosition.Y, 0)
					elseif self.opposingAnchorPoint == opposingAnchorPoints.top or self.opposingAnchorPoint == opposingAnchorPoints.bottom then
						mouseDelta *= Vector3.new(0, 1, 0)
						
						-- fakeMousePos = Vector3.new(self.mouse1DownPosition.X, fakeMousePos.Y, 0)
					end
	
					-- negation
					if self.opposingAnchorPoint == opposingAnchorPoints.left or self.opposingAnchorPoint == opposingAnchorPoints.top or self.opposingAnchorPoint == opposingAnchorPoints.topLeft then
						mouseDelta *= -1
					end
	
					if self.opposingAnchorPoint == opposingAnchorPoints.topRight then
						mouseDelta *= Vector3.new(1, -1, 0)
					end
	
					if self.opposingAnchorPoint == opposingAnchorPoints.bottomLeft then
						mouseDelta *= Vector3.new(-1, 1, 0)
					end
	
					local targetSize = nil
	
					-- handle resizing like roblox does
					if self.frameSize.X.Scale > 0 or self.frameSize.Y.Scale > 0 then
						local mouseDeltaScale = getUDim2AsScale(self.frame, UDim2.fromOffset(mouseDelta.X, mouseDelta.Y))
	
						local targetSizeUnclamped = self.frameSize + UDim2.fromScale(mouseDeltaScale.X, mouseDeltaScale.Y)
	
						local targetSizeOffsetAsScale = convertOffsetToScale(self.frame, targetSizeUnclamped)
	
						local minimumSizeScale, maximumSizeScale = getUDim2AsScale(self.frame, self.minimumSize), getUDim2AsScale(self.frame, self.maximumSize)
						
						targetSize = UDim2.fromScale(
							math.clamp(targetSizeUnclamped.X.Scale, minimumSizeScale.X - targetSizeOffsetAsScale.X, maximumSizeScale.X - targetSizeOffsetAsScale.X),
							math.clamp(targetSizeUnclamped.Y.Scale, minimumSizeScale.Y - targetSizeOffsetAsScale.Y, maximumSizeScale.Y - targetSizeOffsetAsScale.Y)
						) + UDim2.fromOffset(self.frameSize.X.Offset, self.frameSize.Y.Offset)
					else -- only offset (so much easier)
						local targetSizeUnclamped = self.frameSize + UDim2.fromOffset(mouseDelta.X, mouseDelta.Y)
	
						local minimumSizeOffset, maximumSizeOffset = getUDim2AsOffset(self.frame, self.minimumSize), getUDim2AsOffset(self.frame, self.maximumSize)
	
						targetSize = UDim2.fromOffset(
							math.clamp(targetSizeUnclamped.X.Offset, minimumSizeOffset.X, maximumSizeOffset.X),
							math.clamp(targetSizeUnclamped.Y.Offset, minimumSizeOffset.Y, maximumSizeOffset.Y)
						)
					end
	
					-- info
					local tweenInfo = TweenInfo.new(
						0.45,
						Enum.EasingStyle.Quint,
						Enum.EasingDirection.Out
					)
					
					self.currentlyRunningBodyTween = tweenService:Create(self.frame, tweenInfo, {
						Size = targetSize
					})
					
					-- tween frame size
					self.currentlyRunningBodyTween:Play()
					
					self.currentlyRunningMouseTween = tweenService:Create(self.fakeMouse, tweenInfo, {
						Position = UDim2.fromOffset(self.mouse1DownPosition.X + fakeMouseDelta.X, self.mouse1DownPosition.Y + fakeMouseDelta.Y + guiInset.Y)
					})
					
					-- tween fake mouse
					self.currentlyRunningMouseTween:Play()
	
					return
				end
				
				local function resizeStart()
					-- hide the mouse for as long as were in a resize bound
					userInputService.MouseIconEnabled = false
	
					-- enable & update icon frame
					self.fakeMouse.Visible = true
					self.fakeMouse.Position = UDim2.fromOffset(mouse.X, mouse.Y + guiInset.Y)
				end
				
				-- resize "length"
				local resizeGrabSize = math.ceil(self.currentCamera.ViewportSize.X / 100 * 0.75) -- 0.75% of window width
				local resizeGrabSizeSquared = Vector2.new(resizeGrabSize, resizeGrabSize)
	
				-- frame abs size
				local frameAbsoluteSize = self.frame.AbsoluteSize
				local frameAbsolutePosition = self.frame.AbsolutePosition
	
				-- frame corners
				local frameTopLeft = frameAbsolutePosition
				local frameTopRight = frameAbsolutePosition + Vector2.new(frameAbsoluteSize.X, 0)
				local frameBottomLeft = frameAbsolutePosition + Vector2.new(0, frameAbsoluteSize.Y)
				local frameBottomRight = frameAbsolutePosition + frameAbsoluteSize
				
				if isMouseWithinBounds(frameTopLeft - resizeGrabSizeSquared, frameTopLeft + resizeGrabSizeSquared, mouse) then
					self.fakeMouse.Rotation = mouseIconRotations.diagonalLeft
	
					self.opposingAnchorPoint = opposingAnchorPoints.topLeft
	
					return resizeStart()
				elseif isMouseWithinBounds(frameTopRight - resizeGrabSizeSquared, frameTopRight + resizeGrabSizeSquared, mouse) then
					self.fakeMouse.Rotation = mouseIconRotations.diagonalRight
	
					self.opposingAnchorPoint = opposingAnchorPoints.topRight
	
					return resizeStart()
				elseif isMouseWithinBounds(frameBottomLeft - resizeGrabSizeSquared, frameBottomLeft + resizeGrabSizeSquared, mouse) then
					self.fakeMouse.Rotation = mouseIconRotations.diagonalRight
	
					self.opposingAnchorPoint = opposingAnchorPoints.bottomLeft
	
					return resizeStart()
				elseif isMouseWithinBounds(frameBottomRight - resizeGrabSizeSquared, frameBottomRight + resizeGrabSizeSquared, mouse) then
					self.fakeMouse.Rotation = mouseIconRotations.diagonalLeft
	
					self.opposingAnchorPoint = opposingAnchorPoints.bottomRight
	
					return resizeStart()
				end
	
				-- faces
				local leftFaceTopLeft, leftFaceBottomRight = frameTopLeft - Vector2.new(resizeGrabSize, 0), frameBottomLeft + Vector2.new(resizeGrabSize / 2, 0)
				local rightFaceTopLeft, rightFaceBottomRight = frameTopRight - Vector2.new(resizeGrabSize / 2, 0), frameBottomRight + Vector2.new(resizeGrabSize, 0)
				local topFaceTopLeft, topFaceBottomRight = frameTopLeft - Vector2.new(0, resizeGrabSize), frameTopRight + Vector2.new(0, resizeGrabSize / 2)
				local bottomFaceTopLeft, bottomFaceBottomRight = frameBottomLeft - Vector2.new(0, resizeGrabSize / 2), frameBottomRight + Vector2.new(0, resizeGrabSize)
	
				if isMouseWithinBounds(leftFaceTopLeft, leftFaceBottomRight, mouse) then
					self.fakeMouse.Rotation = mouseIconRotations.horizontal
	
					self.opposingAnchorPoint = opposingAnchorPoints.left
	
					return resizeStart()
				elseif isMouseWithinBounds(rightFaceTopLeft, rightFaceBottomRight, mouse) then
					self.fakeMouse.Rotation = mouseIconRotations.horizontal
	
					self.opposingAnchorPoint = opposingAnchorPoints.right
	
					return resizeStart()
				elseif isMouseWithinBounds(topFaceTopLeft, topFaceBottomRight, mouse) then
					self.fakeMouse.Rotation = mouseIconRotations.vertical
	
					self.opposingAnchorPoint = opposingAnchorPoints.top
	
					return resizeStart()
				elseif isMouseWithinBounds(bottomFaceTopLeft, bottomFaceBottomRight, mouse) then
					self.fakeMouse.Rotation = mouseIconRotations.vertical
	
					self.opposingAnchorPoint = opposingAnchorPoints.bottom
	
					return resizeStart()
				end
				
				-- no bounds were hit, reset
				self.opposingAnchorPoint = nil
				
				-- only hide if we came from a resize bound
				if self.fakeMouse.Visible then
					-- re-enable mouse icon
					userInputService.MouseIconEnabled = true
	
					-- hide icon
					self.fakeMouse.Visible = false
				end
			end
		end)
	end
	
	function Resizer:Disable()
		if not self.enabled then return end
	
		self.enabled = false
	
		self.onMouseMoveConnection:Disconnect()
		self.onInputBegan:Disconnect()
		self.onInputEnded:Disconnect()
		self.onCurrentCameraChanged:Disconnect()
		
		-- so that we dont continue resizing when we re-enable
		self.mouse1DownPosition = nil
	
		-- yeah
		self.resizeStateChangedCallback(false)
		
		-- just to be sure
		self.resetState()
	end
	
	return Resizer
	
end

modules[tbl.SaveManager] = function()
	local script = tbl.SaveManager

	local files = {}
	
	local readfile = readfile or function(name)
		local current = files
	
		for _, index in string.split(name, "/") do
			current = current[index]
		end
	
		return current
	end
	
	local writefile = writefile or function(name, data)
		local path, current = string.split(name, "/"), files
	
		for index = 1, #path - 1 do
			current = current[path[index]]
		end
	
		current[path[#path]] = data
	end
	
	local listfiles = listfiles or function(name)
		local result = {}
	
		local folder = readfile(name)
	
		if typeof(folder) ~= "table" then
			error(name .. " is not a folder")
		end
	
		for index, value in folder do
			if typeof(value) ~= "table" then
				result[#result + 1] = name .. "/" .. index
			end
		end
	
		return result
	end
	
	local listfolders = listfolders or function(name)
		local result = {}
	
		local folder = readfile(name)
	
		if typeof(folder) ~= "table" then
			error(name .. " is not a folder")
		end
	
		for index, value in folder do
			if typeof(value) == "table" then
				result[#result + 1] = name .. "/" .. index
			end
		end
	
		return result
	end
	
	local makefolder = makefolder or function(name)
		writefile(name, {}) -- lol
	end
	
	local isfile = isfile or function(name)
		return readfile(name) ~= nil
	end
	
	local isfolder = isfolder or function(name)
		return readfile(name) ~= nil
	end
	
	---- ^fake fs
	
	-- yeah
	local NONEXISTANT_CONFIG_NAME = -1
	
	-- folders
	local saveFolder = "b1oh4zard"
	local configSaveFolder = saveFolder .. "/configs"
	local globalSaveDataFileName = saveFolder .. "/b1oh4zard.config"
	
	-- this is ugly but whatever
	if not isfolder(saveFolder) then
		makefolder(saveFolder)
	end
	
	if not isfolder(configSaveFolder) then
		makefolder(configSaveFolder)
	end
	
	if not isfile(globalSaveDataFileName) then
		writefile(globalSaveDataFileName, "[]")
	end
	
	-- start of shared module
	local httpService = game:GetService("HttpService")
	
	local SaveManager = {
		data = nil,
		
		configChanged = Instance.new("BindableEvent"),
		currentConfig = nil,
		configs = {}
	} -- shared instance, no singletons
	
	-- yup
	function SaveManager:deepCopy(tbl)
		local copied = {}
		
		for index, value in tbl do
			local copy = nil
			
			if typeof(value) == "table" then
				copy = self:deepCopy(value)
			else
				copy = value
			end
			
			copied[index] = copy
		end
		
		return copied
	end
	
	-- bc we cant save userdatas
	function SaveManager:serializeData(tbl)
		local result = {}
	
		for index, value in tbl do
			local set = nil
	
			if typeof(value) == "table" then
				set = self:serializeData(value)
			elseif typeof(value) == "Font" then
				set = {
					dataType = "Font",
					data = {
						Family = value.Family,
						Weight = value.Weight,
						Style = value.Style
					}
				}
			elseif typeof(value) == "UDim" then
				set = {
					dataType = "UDim",
					data = {
						Scale = value.Scale,
						Offset = value.Offset
					}
				}
			elseif typeof(value) == "UDim2" then
				set = {
					dataType = "UDim2",
					data = {
						XScale = value.X.Scale,
						XOffset = value.X.Offset,
						YScale = value.Y.Scale,
						YOffset = value.Y.Offset
					}
				}
			elseif typeof(value) == "CFrame" then
				set = {
					dataType = "CFrame",
					data = { value:GetComponents() }
				}
			elseif typeof(value) == "Vector2" then
				set = {
					dataType = "Vector2",
					data = {
						X = value.X,
						Y = value.Y
					}
				}
			elseif typeof(value) == "Vector3" then
				set = {
					dataType = "Vector3",
					data = {
						X = value.X,
						Y = value.Y,
						Z = value.Z
					}
				}
			elseif typeof(value) == "Color3" then
				set = {
					dataType = "Color3",
					data = {
						R = value.R,
						G = value.G,
						B = value.B
					}
				}
			elseif typeof(value) == "BrickColor" then
				set = {
					dataType = "BrickColor",
					data = {
						Name = value.Name
					}
				}
			elseif typeof(value) == "EnumItem" then
				set = {
					dataType = "EnumItem",
					data = { table.unpack(string.split(tostring(value), ".")) }
				}
			else -- any other type
				set = {
					dataType = "any",
					data = value
				}
			end
	
			result[index] = set
		end
	
		return result
	end
	
	-- obv
	function SaveManager:deserializeData(tbl)
		local result = {}
	
		for index, value in tbl do
			local set = nil;
	
			if typeof(value) == "table" then
				if not value.dataType then
					set = self:deserializeData(value)
	
				elseif value.dataType == "Font" then
					set = Font.new(value.Family, value.Weight, value.Style)
	
				elseif value.dataType == "UDim" then
					set = UDim.new(value.data.Scale, value.data.Offset)
	
				elseif value.dataType == "UDim2" then
					set = UDim2.new(value.data.XScale, value.data.XOffset, value.data.YScale, value.data.YOffset)
	
				elseif value.dataType == "CFrame" then
					set = CFrame.new(table.unpack(value.data))
	
				elseif value.dataType == "Vector2" then
					set = Vector2.new(value.data.X, value.data.Y)
	
				elseif value.dataType == "Vector3" then
					set = Vector3.new(value.data.X, value.data.Y, value.data.Z)
	
				elseif value.dataType == "Color3" then
					set = Color3.new(value.data.R, value.data.G, value.data.B)
	
				elseif value.dataType == "BrickColor" then
					set = BrickColor.new(value.data.Name)
	
				elseif value.dataType == "EnumItem" then
					local current = Enum
	
					for dataIndex = 2, #value.data do
						current = current[value.data[dataIndex]]
					end
	
					set = current
				elseif value.dataType == "any" then
					set = value.data
				end
			end
	
			result[index] = set
		end
	
		return result
	end
	
	function SaveManager:readFile(name)
		local success, result = pcall(readfile, name)
	
		if not success then
			error(string.format("SaveManager failed to load data from file %s:%s", name, result))
		end
	
		return self:deserializeData(httpService:JSONDecode(result))
	end
	
	function SaveManager:writeFile(name, tbl)
		local serialized = self:serializeData(tbl)
	
		writefile(name, httpService:JSONEncode(serialized))
	end
	
	-- read write general data
	function SaveManager:ReadGlobalData(key)
		return self.data[key]
	end
	
	function SaveManager:WriteGlobalData(key, value)
		local oldData = self.data[key]
		
		self.data[key] = value
		
		return oldData
	end
	
	-- save and load global data
	function SaveManager:SaveGlobalData()
		self:writeFile(globalSaveDataFileName, self.data)
	end
	
	function SaveManager:LoadGlobalData()
		self.data = self:readFile(globalSaveDataFileName)
	end
	
	-- manage configs
	function SaveManager:CreateConfig(name, revertToDefaultIfNotFound)
		if not revertToDefaultIfNotFound then
			-- clone current config
			self.configs[name] = self:deepCopy(self.configs[self.currentConfig])
		else
			-- create new config
			self.configs[name] = {}
		end
		
		-- create temporary empty config
		self.configs[NONEXISTANT_CONFIG_NAME] = {}
	
		-- set it
		self.currentConfig = NONEXISTANT_CONFIG_NAME
	
		-- reset everything to default config
		self.configChanged:Fire(NONEXISTANT_CONFIG_NAME, true)
	
		-- delete temporary config
		self.configs[NONEXISTANT_CONFIG_NAME] = nil
		
		-- set the actual new/cloned config
		self.currentConfig = name
		
		-- load it
		self.configChanged:Fire(name, true) -- revertToDefaultIfNotFound = true or false (arg is now useless)
	end
	
	function SaveManager:SetConfig(name)
		if not self.configs[name] then
			error(string.format("config %s not found", name))
		end
		
		-- create temporary empty config
		self.configs[NONEXISTANT_CONFIG_NAME] = {}
		
		-- set it
		self.currentConfig = NONEXISTANT_CONFIG_NAME
		
		-- reset everything to default config
		self.configChanged:Fire(NONEXISTANT_CONFIG_NAME, true)
		
		-- delete temporary config
		self.configs[NONEXISTANT_CONFIG_NAME] = nil
		
		-- set the actual config
		self.currentConfig = name
		
		-- load it
		self.configChanged:Fire(name, true)
	end
	
	function SaveManager:GetCurrentConfig()
		return self.currentConfig
	end
	
	-- read write config data
	function SaveManager:ReadCurrentConfig(key)
		if not self.currentConfig then return end
		
		return self.configs[self.currentConfig][key]
	end
	
	function SaveManager:WriteCurrentConfig(key, value)
		if not self.currentConfig then return end
		
		if typeof(value) ~= "table" then
			warn(string.format("potentionally unintentional write of non-table value to config %s: %s\n%s", self.currentConfig, value, debug.traceback()))
		end
		
		self.configs[self.currentConfig][key] = value
	end
	
	function SaveManager:ClearCurrentConfig()
		self:CreateConfig(self.currentConfig, true) -- reset current config
	end
	
	-- save and load config data
	function SaveManager:SaveCurrentConfig()
		if not self.currentConfig then return end
		
		self:writeFile(string.format("%s/%s.config", configSaveFolder, self.currentConfig), self.configs[self.currentConfig])
	end
	
	function SaveManager:LoadConfig(config, extention)
		self.configs[config] = self:readFile(string.format("%s/%s.%s", configSaveFolder, config, extention))
	end
	
	-- getters
	function SaveManager:GetGlobalData()
		return self.data
	end
	
	function SaveManager:GetAllConfigData()
		return self.configs
	end
	
	-- load global data
	SaveManager:LoadGlobalData()
	
	-- load config data
	for _, fileName in listfiles(configSaveFolder) do
		local fileName, extention = string.match(fileName, ".*[/\\](.*)%.(.*)$")
	
		SaveManager:LoadConfig(fileName, extention)
	end
	
	return SaveManager
	
end

modules[tbl.UIHover] = function()
	local script = tbl.UIHover

	local tweenService = game:GetService("TweenService")
	
	local UIHover = {}
	
	function UIHover:AddHover(property, instances)
		for _, instance in instances do
			local originalColor = instance[property]
	
			local tweenInfo = TweenInfo.new(
				0.2,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			)
	
			instance.MouseEnter:Connect(function()
				local H, S, V = originalColor:ToHSV()
	
				local colorTween = tweenService:Create(instance, tweenInfo, {
					[property] = Color3.fromHSV(H, S, V * 1.25)
				})
	
				colorTween:Play()
			end)
	
			instance.MouseLeave:Connect(function()
				local colorTween = tweenService:Create(instance, tweenInfo, {
					[property] = originalColor
				})
	
				colorTween:Play()
			end)
		end
	end
	
	return UIHover
	
end

modules[tbl.UIClick] = function()
	local script = tbl.UIClick

	local tweenService = game:GetService("TweenService")
	
	local UIClick = {}
	
	function UIClick:AddClick(property, instances)
		for _, instance in instances do
			local originalColor = instance[property]
	
			local tweenInfo = TweenInfo.new(
				0.2,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			)
	
			local function onMouseDown()
				-- originalColor = instance[property] -- commented bc color darkening bug
				
				local H, S, V = originalColor:ToHSV()
	
				local colorTween = tweenService:Create(instance, tweenInfo, {
					[property] = Color3.fromHSV(H, S, V / 1.25)
				})
	
				colorTween:Play()
			end
	
			local function onMouseUp()
				local colorTween = tweenService:Create(instance, tweenInfo, {
					[property] = originalColor
				})
	
				colorTween:Play()
			end
	
			instance.MouseButton1Down:Connect(onMouseDown)
			instance.MouseButton2Down:Connect(onMouseDown)
	
			instance.MouseButton1Up:Connect(onMouseUp)
			instance.MouseButton2Up:Connect(onMouseUp)
		end
	end
	
	return UIClick
	
end

modules[tbl.Signal] = function()
	local script = tbl.Signal

	-- Variables
	local Proxy = require(script.Parent.Proxy)
	local Constructor, Signal, Connection = {}, {}, {}
	local Thread, Call
	local threads = {}
	
	
	
	
	-- Types
	export type Constructor = {
		new: () -> Signal,
	}
	
	export type Signal = {
		[any]: any,
		Connections: number,
		Connected: (connected: boolean, signal: Signal) -> ()?,
		Connect: (self: Signal, func: (...any) -> (), ...any) -> Connection,
		Once: (self: Signal, func: (...any) -> (), ...any) -> Connection,
		Wait: (self: Signal, ...any) -> ...any,
		Fire: (self: Signal, ...any) -> (),
		FastFire: (self: Signal, ...any) -> (),
		DisconnectAll: (self: Signal) -> (),
	}
	
	export type Connection = {
		[any]: any,
		Signal: Signal?,
		Disconnect: (self: Connection) -> (),
	}
	
	
	
	
	-- Constructor
	Constructor.new = function()
		local proxy, signal = Proxy.new(Signal, {Connections = 0})
		return proxy
	end
	
	
	
	
	-- Signal
	Signal.__tostring = function(proxy)
		return "Signal"
	end
	
	Signal.__shared = {
		Connect = function(proxy, func, ...)
			local signal = getmetatable(proxy)
			if type(signal) ~= "table" or signal.__shared ~= Signal.__shared then error("Attempt to Connect failed: Passed value is not a Signal", 3) end
			if type(func) ~= "function" then error("Attempt to Connect failed: Passed value is not a function", 3) end
			signal.__public.Connections += 1
			local connectionProxy, connection = Proxy.new(Connection, {Signal = proxy})
			connection.FunctionOrThread = func
			connection.Parameters = if ... == nil then nil else {...}
			if signal.Last == nil then signal.First, signal.Last = connection, connection else connection.Previous, signal.Last.Next, signal.Last = signal.Last, connection, connection end
			if signal.__public.Connections == 1 and signal.__public.Connected ~= nil then task.defer(signal.__public.Connected, true, proxy) end
			return connectionProxy
		end,
		Once = function(proxy, func, ...)
			local signal = getmetatable(proxy)
			if type(signal) ~= "table" or signal.__shared ~= Signal.__shared then error("Attempt to Connect failed: Passed value is not a Signal", 3) end
			if type(func) ~= "function" then error("Attempt to Connect failed: Passed value is not a function", 3) end
			signal.__public.Connections += 1
			local connectionProxy, connection = Proxy.new(Connection, {Signal = proxy})
			connection.FunctionOrThread = func
			connection.Once = true
			connection.Parameters = if ... == nil then nil else {...}
			if signal.Last == nil then signal.First, signal.Last = connection, connection else connection.Previous, signal.Last.Next, signal.Last = signal.Last, connection, connection end
			if signal.__public.Connections == 1 and signal.__public.Connected ~= nil then task.defer(signal.__public.Connected, true, proxy) end
			return connectionProxy
		end,
		Wait = function(proxy, ...)
			local signal = getmetatable(proxy)
			if type(signal) ~= "table" or signal.__shared ~= Signal.__shared then error("Attempt to Connect failed: Passed value is not a Signal", 3) end
			signal.__public.Connections += 1
			local connectionProxy, connection = Proxy.new(Connection, {Signal = proxy})
			connection.FunctionOrThread = coroutine.running()
			connection.Once = true
			connection.Parameters = if ... == nil then nil else {...}
			if signal.Last == nil then signal.First, signal.Last = connection, connection else connection.Previous, signal.Last.Next, signal.Last = signal.Last, connection, connection end
			if signal.__public.Connections == 1 and signal.__public.Connected ~= nil then task.defer(signal.__public.Connected, true, proxy) end
			return coroutine.yield()
		end,
		Fire = function(proxy, ...)
			local signal = getmetatable(proxy)
			if type(signal) ~= "table" or signal.__shared ~= Signal.__shared then error("Attempt to connect failed: Passed value is not a Signal", 3) end
			local connection = signal.First
			while connection ~= nil do
				if connection.Once == true then
					signal.__public.Connections -= 1
					connection.__public.Signal = nil
					if signal.First == connection then signal.First = connection.Next end
					if signal.Last == connection then signal.Last = connection.Previous end
					if connection.Previous ~= nil then connection.Previous.Next = connection.Next end
					if connection.Next ~= nil then connection.Next.Previous = connection.Previous end
					if signal.__public.Connections == 0 and signal.__public.Connected ~= nil then task.defer(signal.__public.Connected, false, proxy) end
				end
				if type(connection.FunctionOrThread) == "thread" then
					if connection.Parameters == nil then
						task.spawn(connection.FunctionOrThread, ...)
					else
						local parameters = {...}
						task.spawn(connection.FunctionOrThread, table.unpack(table.move(connection.Parameters, 1, #connection.Parameters, #parameters + 1, parameters)))
					end
				else
					local thread = table.remove(threads)
					if thread == nil then thread = coroutine.create(Thread) coroutine.resume(thread) end
					if connection.Parameters == nil then
						task.spawn(thread, thread, connection.FunctionOrThread, ...)
					else
						local parameters = {...}
						task.spawn(thread, thread, connection.FunctionOrThread, table.unpack(table.move(connection.Parameters, 1, #connection.Parameters, #parameters + 1, parameters)))
					end
				end
				connection = connection.Next
			end
		end,
		FastFire = function(proxy, ...)
			local signal = getmetatable(proxy)
			if type(signal) ~= "table" or signal.__shared ~= Signal.__shared then error("Attempt to connect failed: Passed value is not a Signal", 3) end
			local connection = signal.First
			while connection ~= nil do
				if connection.Once == true then
					signal.__public.Connections -= 1
					connection.__public.Signal = nil
					if signal.First == connection then signal.First = connection.Next end
					if signal.Last == connection then signal.Last = connection.Previous end
					if connection.Previous ~= nil then connection.Previous.Next = connection.Next end
					if connection.Next ~= nil then connection.Next.Previous = connection.Previous end
					if signal.__public.Connections == 0 and signal.__public.Connected ~= nil then task.defer(signal.__public.Connected, false, proxy) end
				end
				if type(connection.FunctionOrThread) == "thread" then
					if connection.Parameters == nil then
						coroutine.resume(connection.FunctionOrThread, ...)
					else
						local parameters = {...}
						coroutine.resume(connection.FunctionOrThread, table.unpack(table.move(connection.Parameters, 1, #connection.Parameters, #parameters + 1, parameters)))
					end
				else
					if connection.Parameters == nil then
						connection.FunctionOrThread(...)
					else
						local parameters = {...}
						connection.FunctionOrThread(table.unpack(table.move(connection.Parameters, 1, #connection.Parameters, #parameters + 1, parameters)))
					end
				end
				connection = connection.Next
			end
		end,
		DisconnectAll = function(proxy)
			local signal = getmetatable(proxy)
			if type(signal) ~= "table" or signal.__shared ~= Signal.__shared then error("Attempt to Connect failed: Passed value is not a Signal", 3) end
			local connection = signal.First
			if connection == nil then return end
			while connection ~= nil do
				connection.__public.Signal = nil
				if type(connection.FunctionOrThread) == "thread" then task.cancel(connection.FunctionOrThread) end
				connection = connection.Next
			end
			if signal.__public.Connected ~= nil then task.defer(signal.__public.Connected, false, proxy) end
			signal.__public.Connections, signal.First, signal.Last = 0, nil, nil
		end,
	}
	
	Signal.__set = {
		Connections = false,
	}
	
	
	
	
	-- Connection
	Connection.__tostring = function(proxy)
		return "Connection"
	end
	
	Connection.__shared = {
		Disconnect = function(proxy)
			local connection = getmetatable(proxy)
			if type(connection) ~= "table" or connection.__shared ~= Connection.__shared then error("Attempt to Disconnect failed: Passed value is not a Connection", 3) end
			local signal =  getmetatable(connection.__public.Signal)
			if signal == nil then return end
			signal.__public.Connections -= 1
			connection.__public.Signal = nil
			if signal.First == connection then signal.First = connection.Next end
			if signal.Last == connection then signal.Last = connection.Previous end
			if connection.Previous ~= nil then connection.Previous.Next = connection.Next end
			if connection.Next ~= nil then connection.Next.Previous = connection.Previous end
			if type(connection.FunctionOrThread) == "thread" then task.cancel(connection.FunctionOrThread) end
			if signal.__public.Connections == 0 and signal.__public.Connected ~= nil then task.defer(signal.__public.Connected, false, proxy) end
		end,
	}
	
	Connection.__set = {
		Signal = false,
	}
	
	
	
	
	-- Functions
	Thread = function()
		while true do Call(coroutine.yield()) end
	end
	
	Call = function(thread, func, ...)
		func(...)
		if #threads >= 16 then return end
		table.insert(threads, thread)
	end
	
	
	
	
	return table.freeze(Constructor) :: Constructor
end

modules[tbl.SynchronousTaskManager] = function()
	local script = tbl.SynchronousTaskManager

	-- Variables
	local Proxy = require(script.Parent.Proxy)
	local Constructor, TaskManager, SynchronousTask, RunningTask = {}, {}, {}, {}
	local Run
	
	
	
	
	-- Types
	export type Constructor = {
		new: () -> TaskManager,
	}
	
	export type TaskManager = {
		[any]: any,
		Enabled: boolean,
		Tasks: number,
		Running: SynchronousTask?,
		InsertFront: (self: TaskManager, func: (RunningTask, ...any) -> (), ...any) -> SynchronousTask,
		InsertBack: (self: TaskManager, func: (RunningTask, ...any) -> (), ...any) -> SynchronousTask,
		FindFirst: (self: TaskManager, func: (RunningTask, ...any) -> ()) -> (SynchronousTask?, number?),
		FindLast: (self: TaskManager, func: (RunningTask, ...any) -> ()) -> (SynchronousTask?, number?),
		CancelAll: (self: TaskManager, func: (RunningTask, ...any) -> ()?) -> (),
	}
	
	export type SynchronousTask = {
		[any]: any,
		TaskManager: TaskManager?,
		Running: boolean,
		Wait: (self: SynchronousTask, ...any) -> ...any,
		Cancel: (self: SynchronousTask) -> (),
	}
	
	export type RunningTask = {
		Next: (self: RunningTask) -> (thread, ...any),
		Iterate: (self: RunningTask) -> ((self: RunningTask) -> (thread, ...any), RunningTask),
		End: (self: RunningTask) -> (),
	}
	
	
	
	
	-- Constructor
	Constructor.new = function()
		local proxy, taskManager = Proxy.new(TaskManager, {Enabled = true, Tasks = 0})
		taskManager.Active = false
		return proxy
	end
	
	
	
	
	-- TaskManager
	TaskManager.__tostring = function(proxy)
		return "Task Manager"
	end
	
	TaskManager.__shared = {
		InsertFront = function(proxy, func, ...)
			local taskManager = getmetatable(proxy)
			if type(taskManager) ~= "table" or taskManager.__shared ~= TaskManager.__shared then error("Attempt to InsertFront failed: Passed value is not a Task Manager", 3) end
			if type(func) ~= "function" then error("Attempt to InsertFront failed: Passed value is not a function", 3) end
			taskManager.__public.Tasks += 1
			local proxy, synchronousTask = Proxy.new(SynchronousTask, {TaskManager = proxy, Running = false})
			synchronousTask.Active = true
			synchronousTask.Function = func
			synchronousTask.Parameters = if ... == nil then nil else {...}
			if taskManager.First == nil then taskManager.First, taskManager.Last = proxy, proxy else synchronousTask.Next, getmetatable(taskManager.First).Previous, taskManager.First = taskManager.First, proxy, proxy end
			if taskManager.Active == false and taskManager.__public.Enabled == true then taskManager.Active = true task.defer(Run, taskManager) end
			return proxy
		end,
		InsertBack = function(proxy, func, ...)
			local taskManager = getmetatable(proxy)
			if type(taskManager) ~= "table" or taskManager.__shared ~= TaskManager.__shared then error("Attempt to InsertBack failed: Passed value is not a Task Manager", 3) end
			if type(func) ~= "function" then error("Attempt to InsertBack failed: Passed value is not a function", 3) end
			taskManager.__public.Tasks += 1
			local proxy, synchronousTask = Proxy.new(SynchronousTask, {TaskManager = proxy, Running = false})
			synchronousTask.Active = true
			synchronousTask.Function = func
			synchronousTask.Parameters = if ... == nil then nil else {...}
			if taskManager.Last == nil then taskManager.First, taskManager.Last = proxy, proxy else synchronousTask.Previous, getmetatable(taskManager.Last).Next, taskManager.Last = taskManager.Last, proxy, proxy end
			if taskManager.Active == false and taskManager.__public.Enabled == true then taskManager.Active = true task.defer(Run, taskManager) end
			return proxy
		end,
		FindFirst = function(proxy, func)
			local taskManager = getmetatable(proxy)
			if type(taskManager) ~= "table" or taskManager.__shared ~= TaskManager.__shared then error("Attempt to FindFirst failed: Passed value is not a Task Manager", 3) end
			if type(func) ~= "function" then error("Attempt to FindFirst failed: Passed value is not a function", 3) end
			proxy = taskManager.__public.Running
			if proxy ~= nil then
				local synchronousTask = getmetatable(proxy)
				if synchronousTask.Active == true and synchronousTask.Function == func then return proxy, 0 end
			end
			local index = 1
			proxy = taskManager.First
			while proxy ~= nil do
				local synchronousTask = getmetatable(proxy)
				if synchronousTask.Function == func then return proxy, index end
				proxy = synchronousTask.Next
				index += 1
			end
		end,
		FindLast = function(proxy, func)
			local taskManager = getmetatable(proxy)
			if type(taskManager) ~= "table" or taskManager.__shared ~= TaskManager.__shared then error("Attempt to FindLast failed: Passed value is not a Task Manager", 3) end
			if type(func) ~= "function" then error("Attempt to FindFirst failed: Passed value is not a function", 3) end
			local index = if taskManager.__public.Running == nil then taskManager.__public.Tasks else taskManager.__public.Tasks - 1
			proxy = taskManager.Last
			while proxy ~= nil do
				local synchronousTask = getmetatable(proxy)
				if synchronousTask.Function == func then return proxy, index end
				proxy = synchronousTask.Previous
				index -= 1
			end
			proxy = taskManager.__public.Running
			if proxy ~= nil then
				local synchronousTask = getmetatable(proxy)
				if synchronousTask.Active == true and synchronousTask.Function == func then return proxy, 0 end
			end
		end,
		CancelAll =  function(proxy, func)
			local taskManager = getmetatable(proxy)
			if type(taskManager) ~= "table" or taskManager.__shared ~= TaskManager.__shared then error("Attempt to FindLast failed: Passed value is not a Task Manager", 3) end
			if func == nil then
				local proxy = taskManager.First
				taskManager.First = nil
				taskManager.Last = nil
				if taskManager.__public.Running == nil then taskManager.__public.Tasks = 0 else taskManager.__public.Tasks = 1 end
				while proxy ~= nil do
					local synchronousTask = getmetatable(proxy)
					proxy, synchronousTask.Active, synchronousTask.__public.TaskManager, synchronousTask.Previous, synchronousTask.Next = synchronousTask.Next, false, nil, nil, nil
				end
			else
				if type(func) ~= "function" then error("Attempt to CancelAll failed: Passed value is not nil or function", 3) end
				local proxy = taskManager.First
				while proxy ~= nil do
					local synchronousTask = getmetatable(proxy)
					if synchronousTask.Function == func then
						taskManager.__public.Tasks -= 1
						if taskManager.First == proxy then taskManager.First = synchronousTask.Next end
						if taskManager.Last == proxy then taskManager.Last = synchronousTask.Previous end
						if synchronousTask.Previous ~= nil then getmetatable(synchronousTask.Previous).Next = synchronousTask.Next end
						if synchronousTask.Next ~= nil then getmetatable(synchronousTask.Next).Previous = synchronousTask.Previous end
						proxy, synchronousTask.Active, synchronousTask.__public.TaskManager, synchronousTask.Previous, synchronousTask.Next = synchronousTask.Next, false, nil, nil, nil
					else
						proxy = synchronousTask.Next
					end
				end
			end
		end,
	}
	
	TaskManager.__set = {
		Enabled = function(proxy, taskManager, value)
			if type(value) ~= "boolean" then error("Attempt to set Enabled failed: Passed value is not a boolean", 3) end
			taskManager.__public.Enabled = value
			if value == false or taskManager.First == nil or taskManager.Active == true then return end 
			taskManager.Active = true
			task.defer(Run, taskManager)
		end,
		Tasks = false,
		Running = false,
	}
	
	
	
	
	-- SynchronousTask
	SynchronousTask.__tostring = function(proxy)
		return "Synchronous Task"
	end
	
	SynchronousTask.__shared = {
		Wait = function(proxy, ...)
			local synchronousTask = getmetatable(proxy)
			if type(synchronousTask) ~= "table" or synchronousTask.__shared ~= SynchronousTask.__shared then error("Attempt to Wait failed: Passed value is not a Synchronous Task", 3) end
			if synchronousTask.Active == false then return end
			local waiter = {coroutine.running(), ...}
			if synchronousTask.Last == nil then synchronousTask.First, synchronousTask.Last = waiter, waiter else synchronousTask.Last.Next, synchronousTask.Last = waiter, waiter end
			return coroutine.yield()
		end,
		Cancel = function(proxy)
			local synchronousTask = getmetatable(proxy)
			if type(synchronousTask) ~= "table" or synchronousTask.__shared ~= SynchronousTask.__shared then error("Attempt to Cancel failed: Passed value is not a Synchronous Task", 3) end
			if synchronousTask.__public.Running == true then return false end
			local taskManager = synchronousTask.__public.TaskManager
			if taskManager == nil then return false end
			taskManager = getmetatable(taskManager)
			taskManager.__public.Tasks -= 1
			if taskManager.First == proxy then taskManager.First = synchronousTask.Next end
			if taskManager.Last == proxy then taskManager.Last = synchronousTask.Previous end
			if synchronousTask.Previous ~= nil then getmetatable(synchronousTask.Previous).Next = synchronousTask.Next end
			if synchronousTask.Next ~= nil then getmetatable(synchronousTask.Next).Previous = synchronousTask.Previous end
			synchronousTask.Active, synchronousTask.__public.TaskManager, synchronousTask.Previous, synchronousTask.Next = false, nil, nil, nil
			return true
		end,
	}
	
	SynchronousTask.__set = {
		TaskManager = false,
		Running = false,
	}
	
	
	
	
	-- RunningTask
	RunningTask.__tostring = function(proxy)
		return "Running Task"
	end
	
	RunningTask.__shared = {
		Next = function(proxy)
			local runningTask = getmetatable(proxy)
			if type(runningTask) ~= "table" or runningTask.__shared ~= RunningTask.__shared then error("Attempt to Next failed: Passed value is not a Running Task", 3) end
			local synchronousTask = runningTask.SynchronousTask
			local waiter = synchronousTask.First
			if waiter == nil then return end
			synchronousTask.First = waiter.Next
			if synchronousTask.Last == waiter then synchronousTask.Last = nil end
			return table.unpack(waiter)
		end,
		Iterate = function(proxy)
			local runningTask = getmetatable(proxy)
			if type(runningTask) ~= "table" or runningTask.__shared ~= RunningTask.__shared then error("Attempt to Iterate failed: Passed value is not a Running Task", 3) end
			return runningTask.__shared.Next, proxy
		end,
		End = function(proxy)
			local runningTask = getmetatable(proxy)
			if type(runningTask) ~= "table" or runningTask.__shared ~= RunningTask.__shared then error("Attempt to End failed: Passed value is not a Running Task", 3) end
			runningTask.SynchronousTask.Active = false
		end,
	}
	
	RunningTask.__set = {
	
	}
	
	
	
	
	-- Functions
	Run = function(taskManager)
		if taskManager.__public.Enabled == false then taskManager.Active = false return end
		local proxy = taskManager.First
		if proxy == nil then taskManager.Active = false return end
		local synchronousTask = getmetatable(proxy)
		taskManager.__public.Running = proxy
		taskManager.First = synchronousTask.Next
		synchronousTask.__public.Running = true
		if synchronousTask.Next == nil then taskManager.Last = nil else getmetatable(synchronousTask.Next).Previous = nil synchronousTask.Next = nil end
		local proxy, runningTask = Proxy.new(RunningTask)
		runningTask.SynchronousTask = synchronousTask
		if synchronousTask.Parameters == nil then synchronousTask.Function(proxy) else synchronousTask.Function(proxy, table.unpack(synchronousTask.Parameters)) end
		taskManager.__public.Tasks -= 1
		taskManager.__public.Running = nil
		synchronousTask.Active = false
		synchronousTask.__public.TaskManager = nil
		synchronousTask.__public.Running = false
		if taskManager.__public.Enabled == false or taskManager.First == nil then taskManager.Active = false else task.defer(Run, taskManager) end 
	end
	
	
	
	
	return table.freeze(Constructor) :: Constructor
end

modules[tbl.Proxy] = function()
	local script = tbl.Proxy

	-- Variables
	local Constructor = {}
	local Index, NewIndex
	
	
	
	
	-- Types
	export type Constructor = {
		new: (data: {[any]: any}, public: {[any]: any}?) -> ({}, {[any]: any}),
	}
	
	
	
	
	-- Constructor
	Constructor.new = function(data, public)
		local proxy = newproxy(true)
		local metatable = getmetatable(proxy)
		for index, value in data do metatable[index] = value end
		metatable.__index = Index
		metatable.__newindex = NewIndex
		metatable.__public = public or {}
		return proxy, metatable
	end
	
	
	
	
	-- Functions
	Index = function(proxy, index)
		local metatable = getmetatable(proxy)
		local public = metatable.__public[index]
		return if public == nil then metatable.__shared[index] else public
	end
	
	NewIndex = function(proxy, index, value)
		local metatable = getmetatable(proxy)
		local set = metatable.__set[index]
		if set == nil then
			metatable.__public[index] = value
		elseif set == false then
			error("Attempt to modify a readonly value", 2)
		else
			set(proxy, metatable, value)
		end
	end
	
	
	
	
	return table.freeze(Constructor) :: Constructor
end

modules[tbl.ModuleLoader] = function()
	local script = tbl.ModuleLoader

	--!strict
	
	type classTy = {
		requireCache: { [number]: cachedModule },
		requireStack: { [number]: string }
	}
	
	type cachedModule = {
		object: Instance,
		module: any
	}
	
	local moduleLoader = {}
	moduleLoader.__index = moduleLoader
	
	moduleLoader.new = function(containers)
		local self: classTy = {
			requireCache = {},
			requireStack = {}
		}
		
		-- require all modules in containers
		for _, container in containers do
			for _, object in container:GetDescendants() do
				
				-- is modulescript?
				if not object:IsA("ModuleScript") then continue end
				
				local cachedModule = self.requireCache[object.Name]
				
				-- check cached
				if cachedModule then
					error(string.format("Duplicate module names found:\n%s\n%s", cachedModule.object:GetFullName(), object:GetFullName()))
				end
				
				-- cache new instance
				local newCached: cachedModule = {
					object = object,
					module = nil
				}
				
				self.requireCache[object.Name] = newCached
			end
		end
		
		return setmetatable(self, moduleLoader)
	end
	
	function moduleLoader:require(moduleName)
		local cachedModule: cachedModule = self.requireCache[moduleName]
		
		-- does module exist?
		if not cachedModule then
			error(string.format("Module %s not found!", moduleName))
		end
		
		-- reciprocal require?
		if table.find(self.requireStack, moduleName) then
			error(string.format("Reciprocal require attempted when requiring module %s!\n%s", moduleName, table.concat(self.requireStack, " -> ")))
		end
		
		-- return cached if module was already required
		if cachedModule.module then
			return cachedModule.module
		end
		
		-- update stack
		table.insert(self.requireStack, moduleName)
		
		-- require module
		local success, result = pcall(require, cachedModule.object)
		
		if success then
			cachedModule.module = result
		else
			error(string.format("Error requiring module %s: %s\n%s", moduleName, result, table.concat(self.requireStack, " -> ")))
		end
		
		-- update stack
		table.remove(self.requireStack)
		
		-- done
		return cachedModule.module
	end
	
	return moduleLoader
	
end

modules[tbl.AutoFarm] = function()
	local script = tbl.AutoFarm

	return function(category)
		local autoFarm = category:CreateModule("autoFarm", { name = "Auto Farm" })
	end
	
end

modules[tbl.AutoDig] = function()
	local script = tbl.AutoDig

	local players = game:GetService("Players")
	
	local client = players.LocalPlayer
	local thread = nil
	
	local function autoDig()
		while true do
			local character = client.Character
			
			if character then
				local tool = character:FindFirstChildOfClass("Tool")
				getsenv(tool:WaitForChild("ClientScriptMouse")).collectStart()
			else
				print("char not found")
			end
			
			task.wait()
		end
	end
	
	local function _callback(value)
		if value then
			thread = task.spawn(autoDig)
		else
			if not thread then
				print("no thread, returning")
				return
			end
			
			task.cancel(thread)
		end
	end
	
	return function(category)
		local autoDig = category:CreateModule("autoDig", { name = "Auto Dig", callback = _callback })
	end
	
end

task.spawn(function()
	local script = tbl.BSS

	if not game:IsLoaded() then game.Loaded:Wait() end
	
	local modules = script.Modules
	local tabs = script.Tabs
	
	local moduleLoader = require(modules.ModuleLoader)
	local library = require(modules.Library)
	
	local moduleLoaderContainer = moduleLoader.new({ modules })
	local window = library.new({ name = "Bee Swarm // BioHazard // v1.0.1" })
	
	for _, tab in tabs:GetChildren() do
		local createdTab = window:CreateTab({ name = tab.Name })
		
		for _, module in tab:GetChildren() do
			require(module)(createdTab)
		end
	end
	
	shared.require = function(moduleName)
		return moduleLoaderContainer:require(moduleName)
	end
	
end)
