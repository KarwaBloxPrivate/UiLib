
--Services
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local uis = game:GetService("UserInputService")
local LP = players.LocalPlayer
local Mouse = LP:GetMouse()
---------------------------------------------------
--Vars
local viewport = workspace.CurrentCamera.ViewportSize
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local Library = {
	Config = {},
	SizeDiffrence = 2,
	ColorDiffrence = 10
}

function Library:Validate(deafults, options)
	options = options or {}
	for i, v in pairs(deafults) do
		if options[i] == nil then
			options[i] = v 
		end
	end
	return options
end

function Library:tween(object, goal, callback)
	local tween = tweenService:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

function Library:IsHoveringOnElemt(Element)
	local Hovering = false
	local tx = Element.AbsolutePosition.X
	local ty = Element.AbsolutePosition.Y
	local bx = tx + Element.AbsoluteSize.X
	local by = ty + Element.AbsoluteSize.Y
	if Mouse.X >= tx and Mouse.Y >= ty and Mouse.X <= bx and Mouse.Y <= by then
		Hovering = true
	else
		Hovering = false
	end
	return Hovering
end

function Library:CreateWindow(options)
	options = Library:Validate({
		Text = "Karwa's Library",
		GameText = "Game Name Here",
		MinX = 400,
		MinY = 400,
		GUICloseBind = "RightShift",
		GUIDragSpeed = 0.3
	}, options or {})
	
	local GUI = {
		CurrentTab = nil,
		CurrentSection = {},
		DragToggle = false,
		DragSpeed = options.GUIDragSpeed,
		DragStart = nil,
		StartPos = nil,
		Dragging = false,
		GUIVisible = true,
		VisibleAnimation = false,
		Minimized = false
	}
	
	
	--//Window
	do
		-- StarterGui.UIlib(3rd)
		GUI["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
		GUI["1"]["IgnoreGuiInset"] = true;
		GUI["1"]["Name"] = [[UIlib(3rd)]];

		-- StarterGui.UIlib(3rd).MainFrame
		GUI["2"] = Instance.new("Frame", GUI["1"]);
		GUI["2"]["BorderSizePixel"] = 0;
		GUI["2"]["BackgroundColor3"] = Color3.fromRGB(12, 16, 27);
		GUI["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["2"]["Size"] = UDim2.new(0, 650, 0, 450);
		GUI["2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
		GUI["2"]["Name"] = [[MainFrame]];

		-- StarterGui.UIlib(3rd).MainFrame.UICorner
		GUI["3"] = Instance.new("UICorner", GUI["2"]);
		GUI["3"]["CornerRadius"] = UDim.new(0, 5);

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo
		GUI["4"] = Instance.new("Frame", GUI["2"]);
		GUI["4"]["BorderSizePixel"] = 0;
		GUI["4"]["BackgroundColor3"] = Color3.fromRGB(15, 21, 35);
		GUI["4"]["Size"] = UDim2.new(1, 0, 0, 40);
		GUI["4"]["Name"] = [[TopInfo]];

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo.UICorner
		GUI["5"] = Instance.new("UICorner", GUI["4"]);
		GUI["5"]["CornerRadius"] = UDim.new(0, 6);

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo.Title
		GUI["6"] = Instance.new("TextLabel", GUI["4"]);
		GUI["6"]["ZIndex"] = 2;
		GUI["6"]["BorderSizePixel"] = 0;
		GUI["6"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		GUI["6"]["TextYAlignment"] = Enum.TextYAlignment.Top;
		GUI["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["6"]["TextSize"] = 15;
		GUI["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["6"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["6"]["Text"] = options.Text;
		GUI["6"]["Name"] = [[Title]];
		GUI["6"]["Font"] = Enum.Font.GothamMedium;
		GUI["6"]["BackgroundTransparency"] = 1;

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo.Title.UIPadding
		GUI["7"] = Instance.new("UIPadding", GUI["6"]);
		GUI["7"]["PaddingTop"] = UDim.new(0, 6);
		GUI["7"]["PaddingLeft"] = UDim.new(0, 12);

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo.Title.UIStroke
		GUI["8"] = Instance.new("UIStroke", GUI["6"]);
		GUI["8"]["Thickness"] = 0.800000011920929;
		GUI["8"]["LineJoinMode"] = Enum.LineJoinMode.Bevel;

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo.Close
		GUI["9"] = Instance.new("ImageLabel", GUI["4"]);
		GUI["9"]["ZIndex"] = 2;
		GUI["9"]["BorderSizePixel"] = 0;
		GUI["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["9"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["9"]["Image"] = [[rbxassetid://12699013947]];
		GUI["9"]["Size"] = UDim2.new(0, 16, 0, 16);
		GUI["9"]["Name"] = [[Close]];
		GUI["9"]["BackgroundTransparency"] = 1;
		GUI["9"]["Position"] = UDim2.new(1, -15, 0.5, 0);

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo.Minimize
		GUI["a"] = Instance.new("ImageLabel", GUI["4"]);
		GUI["a"]["ZIndex"] = 2;
		GUI["a"]["BorderSizePixel"] = 0;
		GUI["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["a"]["Image"] = [[rbxassetid://12195614424]];
		GUI["a"]["Size"] = UDim2.new(0, 20, 0, 20);
		GUI["a"]["Name"] = [[Minimize]];
		GUI["a"]["BackgroundTransparency"] = 1;
		GUI["a"]["Position"] = UDim2.new(1, -38, 0.5, 0);

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo.game
		GUI["b"] = Instance.new("TextLabel", GUI["4"]);
		GUI["b"]["ZIndex"] = 2;
		GUI["b"]["BorderSizePixel"] = 0;
		GUI["b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		GUI["b"]["TextYAlignment"] = Enum.TextYAlignment.Bottom;
		GUI["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["b"]["TextSize"] = 10;
		GUI["b"]["TextColor3"] = Color3.fromRGB(176, 176, 176);
		GUI["b"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["b"]["Text"] = options.GameText;
		GUI["b"]["Name"] = [[game]];
		GUI["b"]["Font"] = Enum.Font.GothamMedium;
		GUI["b"]["BackgroundTransparency"] = 1;

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo.game.UIPadding
		GUI["c"] = Instance.new("UIPadding", GUI["b"]);
		GUI["c"]["PaddingTop"] = UDim.new(0, 4);
		GUI["c"]["PaddingBottom"] = UDim.new(0, 6);
		GUI["c"]["PaddingLeft"] = UDim.new(0, 20);

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo.game.UIStroke
		GUI["d"] = Instance.new("UIStroke", GUI["b"]);
		GUI["d"]["Thickness"] = 0.800000011920929;
		GUI["d"]["LineJoinMode"] = Enum.LineJoinMode.Bevel;
		GUI["d"]["Transparency"] = 1;

		-- StarterGui.UIlib(3rd).MainFrame.TopInfo.FrameBottom
		GUI["e"] = Instance.new("Frame", GUI["4"]);
		GUI["e"]["BorderSizePixel"] = 0;
		GUI["e"]["BackgroundColor3"] = Color3.fromRGB(15, 21, 35);
		GUI["e"]["Size"] = UDim2.new(1, 0, 0, 10);
		GUI["e"]["Position"] = UDim2.new(0, 0, 1, -10);
		GUI["e"]["Name"] = [[FrameBottom]];

		-- StarterGui.UIlib(3rd).MainFrame.UIPadding
		GUI["f"] = Instance.new("UIPadding", GUI["2"]);


		-- StarterGui.UIlib(3rd).MainFrame.DropShadowHolder
		GUI["10"] = Instance.new("Frame", GUI["2"]);
		GUI["10"]["ZIndex"] = 0;
		GUI["10"]["BorderSizePixel"] = 0;
		GUI["10"]["BackgroundTransparency"] = 1;
		GUI["10"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["10"]["Name"] = [[DropShadowHolder]];

		-- StarterGui.UIlib(3rd).MainFrame.DropShadowHolder.DropShadow
		GUI["11"] = Instance.new("ImageLabel", GUI["10"]);
		GUI["11"]["ZIndex"] = 0;
		GUI["11"]["BorderSizePixel"] = 0;
		GUI["11"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
		GUI["11"]["ScaleType"] = Enum.ScaleType.Slice;
		GUI["11"]["ImageColor3"] = Color3.fromRGB(41, 50, 66);
		GUI["11"]["ImageTransparency"] = 0.5;
		GUI["11"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["11"]["Image"] = [[rbxassetid://6014261993]];
		GUI["11"]["Size"] = UDim2.new(1, 53, 1, 53);
		GUI["11"]["Name"] = [[DropShadow]];
		GUI["11"]["BackgroundTransparency"] = 1;
		GUI["11"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
		
		-- StarterGui.UIlib(3rd).MainFrame.ContentContainer
		GUI["a4"] = Instance.new("Frame", GUI["2"]);
		GUI["a4"]["BorderSizePixel"] = 0;
		GUI["a4"]["BackgroundColor3"] = Color3.fromRGB(12, 16, 27);
		GUI["a4"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["a4"]["Size"] = UDim2.new(1, -240, 1, -180);
		GUI["a4"]["Position"] = UDim2.new(0.5, 95, 0.5, -35);
		GUI["a4"]["Name"] = [[ContentContainer]];

		-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.UIStroke
		GUI["a5"] = Instance.new("UIStroke", GUI["a4"]);
		GUI["a5"]["Color"] = Color3.fromRGB(18, 23, 39);
		GUI["a5"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
	end
	
	--//TabNavigation
	do
		-- StarterGui.UIlib(3rd).MainFrame.TabName
		GUI["12"] = Instance.new("Frame", GUI["2"]);
		GUI["12"]["BorderSizePixel"] = 0;
		GUI["12"]["BackgroundColor3"] = Color3.fromRGB(15, 21, 35);
		GUI["12"]["Size"] = UDim2.new(0, 40, 1, -40);
		GUI["12"]["Position"] = UDim2.new(0, 0, 0, 40);
		GUI["12"]["Name"] = [[TabName]];

		-- StarterGui.UIlib(3rd).MainFrame.TabName.Holder
		GUI["99"] = Instance.new("Frame", GUI["12"]);
		GUI["99"]["BorderSizePixel"] = 0;
		GUI["99"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["99"]["BackgroundTransparency"] = 1;
		GUI["99"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["99"]["Name"] = [[Holder]];

		-- StarterGui.UIlib(3rd).MainFrame.TabName.Holder.UIListLayout
		GUI["9a"] = Instance.new("UIListLayout", GUI["99"]);
		GUI["9a"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

	end
	
	--//Console
	do
		-- StarterGui.UIlib(3rd).MainFrame.Console
		GUI["117"] = Instance.new("Frame", GUI["2"]);
		GUI["117"]["BorderSizePixel"] = 0;
		GUI["117"]["BackgroundColor3"] = Color3.fromRGB(17, 21, 29);
		GUI["117"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["117"]["Size"] = UDim2.new(1, -240, 0, 100);
		GUI["117"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["117"]["Position"] = UDim2.new(0.5, 95, 1, -65);
		GUI["117"]["Name"] = [[Console]];
		GUI["117"]["BackgroundTransparency"] = 0.5

		-- StarterGui.UIlib(3rd).MainFrame.Console.UIPadding
		GUI["118"] = Instance.new("UIPadding", GUI["117"]);
		GUI["118"]["PaddingTop"] = UDim.new(0, 1);
		GUI["118"]["PaddingRight"] = UDim.new(0, 1);
		GUI["118"]["PaddingBottom"] = UDim.new(0, 1);
		GUI["118"]["PaddingLeft"] = UDim.new(0, 1);

		-- StarterGui.UIlib(3rd).MainFrame.Console.ConsoleMessages
		GUI["119"] = Instance.new("ScrollingFrame", GUI["117"]);
		GUI["119"]["Active"] = true;
		GUI["119"]["BorderSizePixel"] = 0;
		GUI["119"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
		GUI["119"]["ScrollBarImageTransparency"] = 0;
		GUI["119"]["BackgroundColor3"] = Color3.fromRGB(12, 16, 27);
		GUI["119"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
		GUI["119"]["BackgroundTransparency"] = 1;
		GUI["119"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["119"]["ScrollBarImageColor3"] = Color3.fromRGB(168, 171, 188);
		GUI["119"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
		GUI["119"]["ScrollBarThickness"] = 3;
		GUI["119"]["Name"] = [[ConsoleMessages]];

		-- StarterGui.UIlib(3rd).MainFrame.Console.ConsoleMessages.UIListLayout
		GUI["11a"] = Instance.new("UIListLayout", GUI["119"]);
		GUI["11a"]["Padding"] = UDim.new(0, 4);
		GUI["11a"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		-- StarterGui.UIlib(3rd).MainFrame.Console.ConsoleMessages.UIPadding
		GUI["11b"] = Instance.new("UIPadding", GUI["119"]);
		GUI["11b"]["PaddingTop"] = UDim.new(0, 8);
		GUI["11b"]["PaddingRight"] = UDim.new(0, 8);
		GUI["11b"]["PaddingBottom"] = UDim.new(0, 8);
		GUI["11b"]["PaddingLeft"] = UDim.new(0, 8);
		
		-- StarterGui.UIlib(3rd).MainFrame.Console.UIStroke
		GUI["138"] = Instance.new("UIStroke", GUI["117"]);
		GUI["138"]["Color"] = Color3.fromRGB(18, 23, 39);
		GUI["138"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

	end
	
	--//Methods
	do
		local AbsoluteSizeX = GUI["2"].AbsoluteSize.X
		local AbsoluteSizeY = GUI["2"].AbsoluteSize.Y
		local Pos = GUI["2"].Position
		local PosX = GUI["2"].AbsolutePosition.X
		local PosY = GUI["2"].AbsolutePosition.Y
		function GUI:CloseUI()
			GUI.VisibleAnimation = true
			Library:tween(GUI["2"], {Position = UDim2.new(0.5, 0, 0, 0 - AbsoluteSizeY)})
			task.wait(0.2)
			GUI.VisibleAnimation = false
			GUI["1"].Enabled = false
			GUI["2"].Visible = false
			GUI.GUIVisible = false
		end
		
		function GUI:OpenUI()
			GUI["1"].Enabled = true
			GUI["2"].Visible = true
			GUI.GUIVisible = true
			GUI.VisibleAnimation = true
			Library:tween(GUI["2"], {Position = Pos})
			task.wait(0.2)
			GUI.VisibleAnimation = false
		end
		
		local SizeX
		local SizeY
		
		function GUI:Minimize()
			SizeX = GUI["2"].AbsoluteSize.X
			SizeY = GUI["2"].AbsoluteSize.Y
			Library:tween(GUI["2"], {Size = UDim2.new(GUI["2"].Size.X,0,31)})
			for i, v in pairs(GUI["2"]:GetChildren()) do
				if (v.ClassName == "Frame" or v.ClassName == "ScrollingFrame") and v.Name == "TopInfo" then
					for ii, vv in pairs(v:GetChildren()) do
						if vv.ClassName == "Frame" then
							vv.Visible = false
						end
					end
				end
				if v.ClassName == "Frame" and v.Name ~= "TopInfo" then
					v.Visible = false
				end
				if v.Name == "ContentContainer" then
					Library:tween(v, {Size = UDim2.new(0, 0, 0, 0)})
				end
			end
			GUI.Minimized = true
		end
		
		function GUI:UnMinimize()
			GUI.Minimized = false
			Library:tween(GUI["2"], {Size = UDim2.new(0, SizeX, 0, SizeY)})
			for i, v in pairs(GUI["2"]:GetChildren()) do
				if (v.ClassName == "Frame" or v.ClassName == "ScrollingFrame") and v.Name == "TopInfo" then
					for ii, vv in pairs(v:GetChildren()) do
						if vv.ClassName == "Frame" then
							vv.Visible = false
						end
					end
				end
				if v.ClassName == "Frame" or v.ClassName == "ScrollingFrame" and v.Name ~= "TopInfo" then
					v.Visible = true
				end
				if v.Name == "ContentContainer" then
					task.wait(0.059)
					Library:tween(v, {Size = UDim2.new(1, -240, 1, -180)})
				end
			end
		end
		
		function GUI:SendConsoleMessage(Type, Message)
			local OutputText = "[Karwa's Scripts]: " 
			local TextColor = Color3.fromRGB(255,255,255)
			if Type == "Print" then
				TextColor = Color3.fromRGB(255,255,255)
			elseif Type == "Error" then
				TextColor = Color3.fromRGB(255, 0, 0)
			elseif Type == "Warn" then
				TextColor = Color3.fromRGB(235, 211, 28)
			end
			-- StarterGui.UIlib(3rd).MainFrame.Console.ConsoleMessages.Message
			GUI["11c"] = Instance.new("Frame", GUI["119"]);
			GUI["11c"]["BorderSizePixel"] = 0;
			GUI["11c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			GUI["11c"]["BackgroundTransparency"] = 1;
			GUI["11c"]["Size"] = UDim2.new(1, 0, 0, 15);
			GUI["11c"]["Name"] = [[Message]];

			-- StarterGui.UIlib(3rd).MainFrame.Console.ConsoleMessages.Message.Message
			GUI["11d"] = Instance.new("TextLabel", GUI["11c"]);
			GUI["11d"]["BorderSizePixel"] = 0;
			GUI["11d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			GUI["11d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			GUI["11d"]["TextSize"] = 11;
			GUI["11d"]["TextColor3"] = TextColor;
			GUI["11d"]["Size"] = UDim2.new(1, 0, 1, 0);
			GUI["11d"]["Text"] = OutputText..Message
			GUI["11d"]["Name"] = [[Message]];
			GUI["11d"]["Font"] = Enum.Font.Gotham;
			GUI["11d"]["BackgroundTransparency"] = 1;

			-- StarterGui.UIlib(3rd).MainFrame.Console.ConsoleMessages.Message.Message.UIStroke
			GUI["11e"] = Instance.new("UIStroke", GUI["11d"]);
			GUI["11e"]["Thickness"] = 0.699999988079071;

			-- StarterGui.UIlib(3rd).MainFrame.Console.ConsoleMessages.Message.UIPadding
			GUI["11f"] = Instance.new("UIPadding", GUI["11c"]);
			GUI["11f"]["PaddingRight"] = UDim.new(0, 4);
			GUI["11f"]["PaddingLeft"] = UDim.new(0, 4);
		end
		
		GUI:SendConsoleMessage("Print", "Hello, World!")
		GUI:SendConsoleMessage("Print", "UI Design Inspired By Scriptware V3")
		function GUI:SaveConfig()
			local Settings = {}
			for i, v in pairs(Library.Config) do
				Settings[i] = v
			end
			return Settings
		end
		
	end	
	
	--//Logic
	do
		local function updateInput(input)
			local delta = input.Position - GUI.DragStart
			local position = UDim2.new(GUI.StartPos.X.Scale, GUI.StartPos.X.Offset + delta.X, GUI.StartPos.Y.Scale, GUI.StartPos.Y.Offset + delta.Y)
			game:GetService('TweenService'):Create(GUI["2"], TweenInfo.new(GUI.DragSpeed), {Position = position}):Play()
		end
		

		GUI["4"].InputBegan:Connect(function(input, gp)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not gp then
				GUI.Dragging = true
			end
		end)

		GUI["4"].InputEnded:Connect(function(input, gp)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not gp then
				GUI.Dragging = false
			end
		end)
		
		GUI["12"].InputBegan:Connect(function(input, gp)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not gp then
				GUI.Dragging = true
			end
		end)
		
		GUI["12"].InputEnded:Connect(function(input, gp)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not gp then
				GUI.Dragging = false
			end
		end)

		uis.InputBegan:Connect(function(input)
			if GUI.Dragging then
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not Library:IsHoveringOnElemt(GUI["a"]) and not Library:IsHoveringOnElemt(GUI["9"]) then 
					GUI.DragToggle = true
					GUI.DragStart = input.Position
					GUI.StartPos = GUI["2"].Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							GUI.DragToggle = false
						end
					end)
				end
			end
		end)

		uis.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if GUI.DragToggle then
					updateInput(input)
				end
			end
		end)
		
		uis.InputBegan:Connect(function(input, gp)
			if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode[options.GUICloseBind] and not gp and not GUI.VisibleAnimation then
				if GUI.GUIVisible then
					GUI.CloseUI()
				else
					GUI.OpenUI()
				end 
			end
		end)
		
		GUI["a"].InputBegan:Connect(function(input, gp)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not gp then
				if Library:IsHoveringOnElemt(GUI["a"]) then
					Library:tween(GUI["a"], {ImageColor3 = Color3.fromRGB(200, 200, 200)})
				end
			end
		end)
		
		GUI["a"].InputEnded:Connect(function(input, gp)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not gp then
				Library:tween(GUI["a"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
				if GUI.Minimized then
					GUI:UnMinimize()
				else
					GUI:Minimize()
				end
			end
		end)
		
		GUI["9"].InputBegan:Connect(function(input, gp)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not gp then
				if Library:IsHoveringOnElemt(GUI["9"]) then
					Library:tween(GUI["9"], {ImageColor3 = Color3.fromRGB(200, 200, 200)})
				end
			end
		end)

		GUI["9"].InputEnded:Connect(function(input, gp)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not gp then
				Library:tween(GUI["9"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
				if GUI.GUIVisible then
					GUI:CloseUI()
				else
					GUI:OpenUI()
				end
			end
		end)

		
	end
	
	function GUI:CreateTab(options)
		options = Library:Validate({
			name = "Deafult",
			icon = "rbxassetid://12705375624"
		}, options or {})
		local Tab = {
			Hover = false,
			Active = false,
			Name = options.name
		}
		
		--//RenderTab
		do
			-- StarterGui.UIlib(3rd).MainFrame.TabName.Holder.TabHolderUnActive
			Tab["a1"] = Instance.new("Frame", GUI["99"]);
			Tab["a1"]["BorderSizePixel"] = 0;
			Tab["a1"]["BackgroundColor3"] = Color3.fromRGB(19, 26, 43);
			Tab["a1"]["BackgroundTransparency"] = 1;
			Tab["a1"]["Size"] = UDim2.new(1, 0, 0, 40);
			Tab["a1"]["Name"] = options.name;

			-- StarterGui.UIlib(3rd).MainFrame.TabName.Holder.TabHolderUnActive.Line
			Tab["a2"] = Instance.new("Frame", Tab["a1"]);
			Tab["a2"]["BorderSizePixel"] = 0;
			Tab["a2"]["BackgroundColor3"] = Color3.fromRGB(67, 156, 252);
			Tab["a2"]["BackgroundTransparency"] = 1;
			Tab["a2"]["Size"] = UDim2.new(0, 3, 1, 0);
			Tab["a2"]["Name"] = [[Line]];

			-- StarterGui.UIlib(3rd).MainFrame.TabName.Holder.TabHolderUnActive.Icon
			Tab["a3"] = Instance.new("ImageLabel", Tab["a1"]);
			Tab["a3"]["BorderSizePixel"] = 0;
			Tab["a3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["a3"]["ImageColor3"] = Color3.fromRGB(226, 226, 226);
			Tab["a3"]["ImageTransparency"] = 0.10000000149011612;
			Tab["a3"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			Tab["a3"]["Image"] = options.icon
			Tab["a3"]["Size"] = UDim2.new(1, -15, 1, -15);
			Tab["a3"]["Name"] = [[Icon]];
			Tab["a3"]["BackgroundTransparency"] = 1;
			Tab["a3"]["Position"] = UDim2.new(0.5, 2, 0.5, 0);
			
			-- StarterGui.UIlib(3rd).MainFrame.TabName.Sections
			Tab["13"] = Instance.new("ScrollingFrame", GUI["12"]);
			Tab["13"]["Active"] = true;
			Tab["13"]["BorderSizePixel"] = 0;
			Tab["13"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
			Tab["13"]["ScrollBarImageTransparency"] = 1;
			Tab["13"]["BackgroundColor3"] = Color3.fromRGB(12, 16, 27);
			Tab["13"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			Tab["13"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
			Tab["13"]["Size"] = UDim2.new(0, 140, 1, -12);
			Tab["13"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["13"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
			Tab["13"]["ScrollBarThickness"] = 0;
			Tab["13"]["Position"] = UDim2.new(3, 0, 0.5, 0);
			Tab["13"]["Name"] = options.name;
			Tab["13"]["Visible"] = false

			-- StarterGui.UIlib(3rd).MainFrame.TabName.Sections.UIListLayout
			Tab["14"] = Instance.new("UIListLayout", Tab["13"]);
			Tab["14"]["Padding"] = UDim.new(0, 8);
			Tab["14"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			-- StarterGui.UIlib(3rd).MainFrame.TabName.Sections.UIPadding
			Tab["15"] = Instance.new("UIPadding", Tab["13"]);
			Tab["15"]["PaddingTop"] = UDim.new(0, 8);
			Tab["15"]["PaddingRight"] = UDim.new(0, 8);
			Tab["15"]["PaddingBottom"] = UDim.new(0, 8);
			Tab["15"]["PaddingLeft"] = UDim.new(0, 8);

			-- StarterGui.UIlib(3rd).MainFrame.TabName.Sections.UIStroke
			Tab["16"] = Instance.new("UIStroke", Tab["13"]);
			Tab["16"]["Color"] = Color3.fromRGB(18, 23, 39);
			Tab["16"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

		end
		
		--//Methods
		do
			function Tab:Activate()
				if not Tab.Active then
					if GUI.CurrentTab ~= nil then
						GUI.CurrentTab:Deactivate()
					end
					Tab.Active = true 
					Library:tween(Tab["a1"], {BackgroundTransparency = 0})
					Library:tween(Tab["a2"], {BackgroundTransparency = 0})
					GUI.CurrentTab = Tab
					for i, v in pairs(GUI.CurrentSection) do
						if i == GUI.CurrentTab.Name then
							v["a6"].Visible = true
							v["a9"].Visible = true
						else
							v["a6"].Visible = false
							v["a9"].Visible = false
						end
					end
					Tab["13"]["Visible"] = true
				end
			end

			function Tab:Deactivate()
				if Tab.Active then
					Tab.Active = false 
					Tab.Hover = false
					Library:tween(Tab["a1"], {BackgroundTransparency = 1})
					Library:tween(Tab["a2"], {BackgroundTransparency = 1})
					Tab["13"]["Visible"] = false
				end
			end
		end
		
		--//Logic
		do 
			Tab["a1"].MouseEnter:Connect(function()
				if Library:IsHoveringOnElemt(Tab["a1"]) then
					Tab.Hover = true
					if not Tab.Active then
						Library:tween(Tab["a1"], {BackgroundTransparency = 0})
					end
				end
			end)

			Tab["a1"].MouseLeave:Connect(function()
				Tab.Hover = false
				if not Tab.Active then
					Library:tween(Tab["a1"], {BackgroundTransparency = 1})
				end
			end)

			Tab["a1"].InputBegan:Connect(function(Input, gp)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
					if Tab.Hover then
						Tab:Activate()
					end
				end
			end)

			if GUI.CurrentTab == nil then
				Tab:Activate()
			end		
		end
		
		function Tab:Section(options)
			options = Library:Validate({
				name = "Deafult",
			}, options or {})
			
			local Section = {
				Hover = false,
				Active = false,
				Name = options.name
			}
			
			--//RenderSection
			do
				-- StarterGui.UIlib(3rd).MainFrame.TabName.Sections.Section
				Section["21"] = Instance.new("Frame", Tab["13"]);
				Section["21"]["BorderSizePixel"] = 0;
				Section["21"]["BackgroundColor3"] = Color3.fromRGB(15, 21, 35);
				Section["21"]["Size"] = UDim2.new(1, 0, 0, 20);
				Section["21"]["Name"] = [[Section]];

				-- StarterGui.UIlib(3rd).MainFrame.TabName.Sections.Section.UICorner
				Section["22"] = Instance.new("UICorner", Section["21"]);
				Section["22"]["CornerRadius"] = UDim.new(0, 2);

				-- StarterGui.UIlib(3rd).MainFrame.TabName.Sections.Section.UIStroke
				Section["23"] = Instance.new("UIStroke", Section["21"]);
				Section["23"]["Color"] = Color3.fromRGB(19, 43, 69);
				Section["23"]["Thickness"] = 0.699999988079071;

				-- StarterGui.UIlib(3rd).MainFrame.TabName.Sections.Section.TextLabel
				Section["24"] = Instance.new("TextLabel", Section["21"]);
				Section["24"]["BorderSizePixel"] = 0;
				Section["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["24"]["TextSize"] = 10;
				Section["24"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["24"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["24"]["Text"] = options.name;
				Section["24"]["Font"] = Enum.Font.Gotham;
				Section["24"]["BackgroundTransparency"] = 1;

				-- StarterGui.UIlib(3rd).MainFrame.TabName.Sections.Section.TextLabel.UIStroke
				Section["25"] = Instance.new("UIStroke", Section["24"]);
				Section["25"]["Thickness"] = 0.699999988079071;
				
				-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.SectionName
				Section["a6"] = Instance.new("TextLabel", GUI["a4"]);
				Section["a6"]["BorderSizePixel"] = 0;
				Section["a6"]["BackgroundColor3"] = Color3.fromRGB(12, 16, 27);
				Section["a6"]["TextSize"] = 10;
				Section["a6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["a6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["a6"]["Text"] = options.name;
				Section["a6"]["Size"] = UDim2.new(0, Section["a6"].TextBounds.X + 5, 0, 11);
				Section["a6"]["Name"] = options.name;
				Section["a6"]["Font"] = Enum.Font.Gotham;
				Section["a6"]["Position"] = UDim2.new(0.5, 0, 0, 0);
				Section["a6"]["Visible"] = false

				-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.SectionName.UIStroke
				Section["a7"] = Instance.new("UIStroke", Section["a6"]);
				Section["a7"]["Thickness"] = 0.699999988079071;
				
				-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming
				Section["a9"] = Instance.new("ScrollingFrame", GUI["a4"]);
				Section["a9"]["Active"] = true;
				Section["a9"]["BorderSizePixel"] = 0;
				Section["a9"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
				Section["a9"]["ScrollBarImageTransparency"] = 1;
				Section["a9"]["BackgroundColor3"] = Color3.fromRGB(12, 16, 27);
				Section["a9"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
				Section["a9"]["BackgroundTransparency"] = 1;
				Section["a9"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["a9"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
				Section["a9"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
				Section["a9"]["ScrollBarThickness"] = 0;
				Section["a9"]["Name"] = options.name;
				Section["a9"]["Visible"] = false

				-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.UIListLayout
				Section["aa"] = Instance.new("UIListLayout", Section["a9"]);
				Section["aa"]["Padding"] = UDim.new(0, 8);
				Section["aa"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.UIPadding
				Section["ab"] = Instance.new("UIPadding", Section["a9"]);
				Section["ab"]["PaddingTop"] = UDim.new(0, 16);
				Section["ab"]["PaddingRight"] = UDim.new(0, 10);
				Section["ab"]["PaddingBottom"] = UDim.new(0, 16);
				Section["ab"]["PaddingLeft"] = UDim.new(0, 10);
			end
			
			--//Methods
			do
				function Section:Deactivate()
					if Section.Active then
						Section.Active = false 
						Section.Hover = false
						Section["a9"]["Visible"] = false
						Section["a6"]["Visible"] = false
						Library.Config["Sections"] = GUI.CurrentSection
						Library:tween(Section["21"], {BackgroundColor3 = Color3.fromRGB(15, 21, 35)})
						Library:tween(Section["23"], {Color = Color3.fromRGB(22, 51, 81)})
					end
				end
				
				function Section:Activate()
					if not Section.Active then
						Section.Active = true 
						if GUI.CurrentSection[GUI.CurrentTab.Name] ~= nil then
							GUI.CurrentSection[GUI.CurrentTab.Name]:Deactivate()
						end
						GUI.CurrentSection[GUI.CurrentTab.Name] = Section
						Section["a9"]["Visible"] = true
						Section["a6"]["Visible"] = true
						Library.Config["Sections"] = GUI.CurrentSection
					end
				end

			end
			
			--//Logic
			do 
				Section["21"].MouseEnter:Connect(function()
					if Library:IsHoveringOnElemt(Section["21"]) then
						Section.Hover = true
						Library:tween(Section["23"], {Color = Color3.fromRGB(25, 57, 90)})
					end
				end)

				Section["21"].MouseLeave:Connect(function()
					Section.Hover = false
					Library:tween(Section["23"], {Color = Color3.fromRGB(19, 43, 69)})
				end)

				Section["21"].InputBegan:Connect(function(Input, gp)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
						if Section.Hover then
							Library:tween(Section["21"], {BackgroundColor3 = Color3.fromRGB(18+10, 27+10, 45+10)})
							Library:tween(Section["23"], {Color = Color3.fromRGB(25+10, 57+10, 90+10)})
						else
							Library:tween(Section["21"], {BackgroundColor3 = Color3.fromRGB(18+10, 27+10, 45+10)})
							Library:tween(Section["23"], {Color = Color3.fromRGB(22+10, 51+10, 81+10)})
						end
					end
				end)
				
				Section["21"].InputEnded:Connect(function(Input, gp)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
						if Section.Hover then
							Library:tween(Section["21"], {BackgroundColor3 = Color3.fromRGB(18, 27, 45)})
							Library:tween(Section["23"], {Color = Color3.fromRGB(25, 57, 90)})
						else
							Library:tween(Section["21"], {BackgroundColor3 = Color3.fromRGB(18, 27, 45)})
							Library:tween(Section["23"], {Color = Color3.fromRGB(22, 51, 81)})
						end
						Section:Activate()
					end
				end)

				if Tab.CurrentSection == nil then
					Section:Activate()
				end		
				spawn(function()
					local LastPos = Section["a9"].CanvasPosition
					local CanAnim = true
					while task.wait(0.1) do
						if Section["a9"].CanvasPosition ~= LastPos then
							LastPos = Section["a9"].CanvasPosition
							if Section["a9"].CanvasPosition.Y > 14 and CanAnim then
								CanAnim = false
								Library:tween(Section["a6"], {TextTransparency = 1})
								Library:tween(Section["a6"].UIStroke, {Thickness = 0})
								Section["a6"].Visible = false
								CanAnim = true
							elseif Section["a9"].CanvasPosition.Y < 14 and CanAnim then
								CanAnim = false
								Library:tween(Section["a6"], {TextTransparency = 0})
								Library:tween(Section["a6"].UIStroke, {Thickness = 0.7})
								Section["a6"].Visible = true
								CanAnim = true
							end
						end
					end
				end)
			end
			
			function Section:Button(options)
				options = Library:Validate({
					name = "Deafult",
					callback = function() print(options.name.." Clicked") end
				}, options or {})

				local Button = {
					Hover = false
				}
				
				--//RenderButton
				do
					print("RenderingButton")
					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Button
					Button["ac"] = Instance.new("Frame", Section["a9"]);
					Button["ac"]["BackgroundColor3"] = Color3.fromRGB(13, 18, 30);
					Button["ac"]["Size"] = UDim2.new(1, 0, 0, 30);
					Button["ac"]["ClipsDescendants"] = true;
					Button["ac"]["Name"] = options.name;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Button.UICorner
					Button["ad"] = Instance.new("UICorner", Button["ac"]);
					Button["ad"]["CornerRadius"] = UDim.new(0, 3);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Button.UIStroke
					Button["ae"] = Instance.new("UIStroke", Button["ac"]);
					Button["ae"]["Color"] = Color3.fromRGB(16, 36, 57);
					Button["ae"]["Thickness"] = 0.699999988079071;
					Button["ae"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Button.Text
					Button["af"] = Instance.new("TextLabel", Button["ac"]);
					Button["af"]["BorderSizePixel"] = 0;
					Button["af"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Button["af"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Button["af"]["TextSize"] = 11;
					Button["af"]["TextColor3"] = Color3.fromRGB(231, 231, 231);
					Button["af"]["Size"] = UDim2.new(1, 0, 1, 0);
					Button["af"]["ClipsDescendants"] = true;
					Button["af"]["Text"] = options.name;
					Button["af"]["Name"] = options.name;
					Button["af"]["Font"] = Enum.Font.GothamMedium;
					Button["af"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Button.Text.UIStroke
					Button["b0"] = Instance.new("UIStroke", Button["af"]);
					Button["b0"]["Thickness"] = 0.699999988079071;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Button.UIPadding
					Button["b1"] = Instance.new("UIPadding", Button["ac"]);
					Button["b1"]["PaddingRight"] = UDim.new(0, 16);
					Button["b1"]["PaddingLeft"] = UDim.new(0, 12);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Button.ImageContainer
					Button["b2"] = Instance.new("Frame", Button["ac"]);
					Button["b2"]["BorderSizePixel"] = 0;
					Button["b2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Button["b2"]["AnchorPoint"] = Vector2.new(0, 0.5);
					Button["b2"]["BackgroundTransparency"] = 1;
					Button["b2"]["Size"] = UDim2.new(0, 20, 0, 20);
					Button["b2"]["Position"] = UDim2.new(1, -10, 0.5, 0);
					Button["b2"]["Name"] = [[ImageContainer]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Button.ImageContainer.ClickIcon
					Button["b3"] = Instance.new("ImageLabel", Button["b2"]);
					Button["b3"]["BorderSizePixel"] = 0;
					Button["b3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Button["b3"]["ImageColor3"] = Color3.fromRGB(19, 42, 67);
					Button["b3"]["Image"] = [[rbxassetid://12795653061]];
					Button["b3"]["Size"] = UDim2.new(1, 0, 1, 0);
					Button["b3"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
					Button["b3"]["Name"] = [[ClickIcon]];
					Button["b3"]["BackgroundTransparency"] = 1;
				end
				
				--//Methods
				do
					function Button:SetText(text)
						Button["af"].Text = text
					end
					
					function Button:SetCallback(fn)
						Button.callback = fn
					end
				end
				
				--//Logic
				do
					Button["ac"].MouseEnter:Connect(function()
						if Library:IsHoveringOnElemt(Button["ac"]) then
							Button.Hover = true
							Library:tween(Button["b3"], {ImageColor3 = Color3.fromRGB(19+20, 42+20, 67+20)})
							Library:tween(Button["ae"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
						end
					end)

					Button["ac"].MouseLeave:Connect(function()
						Button.Hover = false
						Library:tween(Button["ae"], {Color = Color3.fromRGB(16, 36, 57)})
						Library:tween(Button["b3"], {ImageColor3 = Color3.fromRGB(19, 42, 67)})
					end)

					Button["ac"].InputBegan:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if Button.Hover then
								Library:tween(Button["ac"], {BackgroundColor3 = Color3.fromRGB(13+10, 18+10, 30+10)})
								Library:tween(Button["ae"], {Color = Color3.fromRGB(16+30, 36+30, 57+30)})
								Library:tween(Button["b3"], {ImageColor3 = Color3.fromRGB(19+30, 42+30, 67+30)})
							else
								Library:tween(Button["ac"], {BackgroundColor3 = Color3.fromRGB(13+10, 18+10, 30+10)})
								Library:tween(Button["ae"], {Color = Color3.fromRGB(16, 36, 57)})
								Library:tween(Button["b3"], {ImageColor3 = Color3.fromRGB(19, 42, 67)})
							end
						end
					end)

					Button["ac"].InputEnded:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if Button.Hover then
								Library:tween(Button["ac"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
								Library:tween(Button["ae"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
								Library:tween(Button["b3"], {ImageColor3 = Color3.fromRGB(19+20, 42+20, 67+20)})
							else
								Library:tween(Button["ac"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
								Library:tween(Button["ae"], {Color = Color3.fromRGB(16, 36, 57)})
								Library:tween(Button["b3"], {ImageColor3 = Color3.fromRGB(19, 42, 67)})
							end
							options.callback()
						end
					end)
				end
				
				return Button
			end
			
			function Section:Toggle(options)
				options = Library:Validate({
					name = "Deafult",
					deafult = false,
					callback = function(v) print(options.name.." Toggled To "..v) end
				}, options or {})

				local Toggle = {
					Hover = false,
					State = false
				}

				--//RenderToggle
				do
					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse
					Toggle["b4"] = Instance.new("Frame", Section["a9"]);
					Toggle["b4"]["BackgroundColor3"] = Color3.fromRGB(13, 18, 30);
					Toggle["b4"]["Size"] = UDim2.new(1, 0, 0, 30);
					Toggle["b4"]["ClipsDescendants"] = true;
					Toggle["b4"]["Name"] = [[ToggleFalse]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.UICorner
					Toggle["b5"] = Instance.new("UICorner", Toggle["b4"]);
					Toggle["b5"]["CornerRadius"] = UDim.new(0, 3);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.UIStroke
					Toggle["b6"] = Instance.new("UIStroke", Toggle["b4"]);
					Toggle["b6"]["Color"] = Color3.fromRGB(16, 36, 57);
					Toggle["b6"]["Thickness"] = 0.699999988079071;
					Toggle["b6"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.Text
					Toggle["b7"] = Instance.new("TextLabel", Toggle["b4"]);
					Toggle["b7"]["BorderSizePixel"] = 0;
					Toggle["b7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Toggle["b7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Toggle["b7"]["TextSize"] = 11;
					Toggle["b7"]["TextColor3"] = Color3.fromRGB(231, 231, 231);
					Toggle["b7"]["Size"] = UDim2.new(1, 0, 1, 0);
					Toggle["b7"]["ClipsDescendants"] = true;
					Toggle["b7"]["Text"] = options.name;
					Toggle["b7"]["Name"] = [[Text]];
					Toggle["b7"]["Font"] = Enum.Font.GothamMedium;
					Toggle["b7"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.Text.UIStroke
					Toggle["b8"] = Instance.new("UIStroke", Toggle["b7"]);
					Toggle["b8"]["Thickness"] = 0.699999988079071;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.UIPadding
					Toggle["b9"] = Instance.new("UIPadding", Toggle["b4"]);
					Toggle["b9"]["PaddingRight"] = UDim.new(0, 16);
					Toggle["b9"]["PaddingLeft"] = UDim.new(0, 12);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.CheckmarkContainer
					Toggle["ba"] = Instance.new("Frame", Toggle["b4"]);
					Toggle["ba"]["BorderSizePixel"] = 0;
					Toggle["ba"]["BackgroundColor3"] = Color3.fromRGB(12, 16, 27);
					Toggle["ba"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
					Toggle["ba"]["Size"] = UDim2.new(0, 45, 0, 18);
					Toggle["ba"]["ClipsDescendants"] = true;
					Toggle["ba"]["Position"] = UDim2.new(1, -16, 0.5, 0);
					Toggle["ba"]["Name"] = [[CheckmarkContainer]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.CheckmarkContainer.UICorner
					Toggle["bb"] = Instance.new("UICorner", Toggle["ba"]);


					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.CheckmarkContainer.UIStroke
					Toggle["bc"] = Instance.new("UIStroke", Toggle["ba"]);
					Toggle["bc"]["Color"] = Color3.fromRGB(16, 36, 57);
					Toggle["bc"]["Thickness"] = 0.699999988079071;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.CheckmarkContainer.Switch
					Toggle["bd"] = Instance.new("Frame", Toggle["ba"]);
					Toggle["bd"]["BackgroundColor3"] = Color3.fromRGB(17, 32, 52);
					Toggle["bd"]["AnchorPoint"] = Vector2.new(0.5, 0);
					Toggle["bd"]["Size"] = UDim2.new(0.5, 0, 1, 0);
					Toggle["bd"]["Position"] = UDim2.new(0.25, 0, 0, 0);
					Toggle["bd"]["Name"] = [[Switch]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.CheckmarkContainer.Switch.UICorner
					Toggle["be"] = Instance.new("UICorner", Toggle["bd"]);


					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.ToggleFalse.CheckmarkContainer.UIPadding
					Toggle["bf"] = Instance.new("UIPadding", Toggle["ba"]);
				end

				--//Methods
				do
					function Toggle:Toggle(b)
						if b == nil then
							Toggle.State = not Toggle.State
						else 
							Toggle.State = b 
						end

						if Toggle.State then
							Library:tween(Toggle["bd"], {BackgroundColor3 = Color3.fromRGB(25, 47, 77)})
							Library:tween(Toggle["bd"], {Position = UDim2.new(0.75, 0, 0, 0)})
						else
							Library:tween(Toggle["bd"], {Position = UDim2.new(0.25, 0, 0, 0)})
							Library:tween(Toggle["bd"], {BackgroundColor3 = Color3.fromRGB(17, 32, 52)})
						end
						options.callback(Toggle.State)
						Library.Config[options.name] = Toggle.State
					end
					
					function Toggle:SetText(text)
						Toggle["b7"]["Text"] = text
					end

					function Toggle:SetCallback(fn)
						Toggle.callback = fn
					end
					
					if options.deafult then
						Toggle:Toggle(options.deafult)
						Library.Config[options.name] = Toggle.State
					end
				end

				--//Logic
				do
					Toggle["b4"].MouseEnter:Connect(function()
						if Library:IsHoveringOnElemt(Toggle["b4"]) then
							Toggle.Hover = true
							Library:tween(Toggle["b6"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
							Library:tween(Toggle["bc"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
						end
					end)
					
					Toggle["b4"].MouseLeave:Connect(function()
						Toggle.Hover = false
						Library:tween(Toggle["b6"], {Color = Color3.fromRGB(16, 36, 57)})
						Library:tween(Toggle["bc"], {Color = Color3.fromRGB(16, 36, 57)})
					end)

					Toggle["b4"].InputBegan:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if Toggle.Hover then
								Library:tween(Toggle["b4"], {BackgroundColor3 = Color3.fromRGB(13+10, 18+10, 30+10)})
								Library:tween(Toggle["b6"], {Color = Color3.fromRGB(16+30, 36+30, 57+30)})
								Library:tween(Toggle["bc"], {Color = Color3.fromRGB(16+30, 36+30, 57+30)})
							else
								Library:tween(Toggle["b4"], {BackgroundColor3 = Color3.fromRGB(13+10, 18+10, 30+10)})
								Library:tween(Toggle["b6"], {Color = Color3.fromRGB(16, 36, 57)})
								Library:tween(Toggle["bc"], {Color = Color3.fromRGB(16, 36, 57)})
							end
						end
					end)

					Toggle["b4"].InputEnded:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if Toggle.Hover then
								Library:tween(Toggle["b4"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
								Library:tween(Toggle["b6"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
								Library:tween(Toggle["bc"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
							else
								Library:tween(Toggle["b4"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
								Library:tween(Toggle["b6"], {Color = Color3.fromRGB(16, 36, 57)})
								Library:tween(Toggle["bc"], {Color = Color3.fromRGB(16, 36, 57)})
							end
							Toggle:Toggle()	
						end
					end)
				end

				return Toggle
			end
			
			function Section:Executor(options)
				options = Library:Validate({
					name = "Deafult",
				}, options or {})

				local Executor = {
					Hover = false,
					State = false
				}
				--//RenderExecutor
				
				do
					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor
					Executor["117"] = Instance.new("Frame", Section["a9"]);
					Executor["117"]["BackgroundColor3"] = Color3.fromRGB(13, 18, 30);
					Executor["117"]["Size"] = UDim2.new(1, 0, 0, 150);
					Executor["117"]["ClipsDescendants"] = true;
					Executor["117"]["Name"] = [[Executor]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.UICorner
					Executor["118"] = Instance.new("UICorner", Executor["117"]);
					Executor["118"]["CornerRadius"] = UDim.new(0, 3);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.UIStroke
					Executor["119"] = Instance.new("UIStroke", Executor["117"]);
					Executor["119"]["Color"] = Color3.fromRGB(16, 36, 57);
					Executor["119"]["Thickness"] = 0.699999988079071;
					Executor["119"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.Text
					Executor["11a"] = Instance.new("TextLabel", Executor["117"]);
					Executor["11a"]["BorderSizePixel"] = 0;
					Executor["11a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Executor["11a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Executor["11a"]["TextSize"] = 11;
					Executor["11a"]["TextColor3"] = Color3.fromRGB(231, 231, 231);
					Executor["11a"]["Size"] = UDim2.new(1, 0, 0, 30);
					Executor["11a"]["ClipsDescendants"] = true;
					Executor["11a"]["Text"] = [[Executor 3000]];
					Executor["11a"]["Name"] = [[Text]];
					Executor["11a"]["Font"] = Enum.Font.GothamMedium;
					Executor["11a"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.Text.UIStroke
					Executor["11b"] = Instance.new("UIStroke", Executor["11a"]);
					Executor["11b"]["Thickness"] = 0.699999988079071;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.UIPadding
					Executor["11c"] = Instance.new("UIPadding", Executor["117"]);
					Executor["11c"]["PaddingRight"] = UDim.new(0, 12);
					Executor["11c"]["PaddingLeft"] = UDim.new(0, 12);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox
					Executor["11d"] = Instance.new("Frame", Executor["117"]);
					Executor["11d"]["BorderSizePixel"] = 0;
					Executor["11d"]["BackgroundColor3"] = Color3.fromRGB(11, 16, 26);
					Executor["11d"]["Size"] = UDim2.new(1, -15, 1, -60);
					Executor["11d"]["Position"] = UDim2.new(0, 5, 0, 30);
					Executor["11d"]["Name"] = [[ExecuteBox]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.ConsoleMessages
					Executor["11e"] = Instance.new("ScrollingFrame", Executor["11d"]);
					Executor["11e"]["Active"] = true;
					Executor["11e"]["BorderSizePixel"] = 0;
					Executor["11e"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
					Executor["11e"]["CanvasPosition"] = Vector2.new(0, 16);
					Executor["11e"]["BackgroundColor3"] = Color3.fromRGB(12, 16, 27);
					Executor["11e"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
					Executor["11e"]["BackgroundTransparency"] = 1;
					Executor["11e"]["Size"] = UDim2.new(1, 0, 1, 0);
					Executor["11e"]["ScrollBarImageColor3"] = Color3.fromRGB(169, 172, 189);
					Executor["11e"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
					Executor["11e"]["ScrollBarThickness"] = 2;
					Executor["11e"]["Name"] = [[ConsoleMessages]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.ConsoleMessages.TextBox
					Executor["11f"] = Instance.new("TextBox", Executor["11e"]);
					Executor["11f"]["CursorPosition"] = -1;
					Executor["11f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Executor["11f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Executor["11f"]["TextSize"] = 14;
					Executor["11f"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					Executor["11f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Executor["11f"]["MultiLine"] = true;
					Executor["11f"]["BackgroundTransparency"] = 1;
					Executor["11f"]["Size"] = UDim2.new(1, 0, 1, 0);
					Executor["11f"]["AutomaticSize"] = Enum.AutomaticSize.Y
					Executor["11f"]["Text"] = [[-- Example
					function Nigger()
											print("Nigger")
	end
	Nigger()
	]];
					Executor["11f"]["Font"] = Enum.Font.SourceSans;
					Executor["11f"]["ClearTextOnFocus"] = false;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.ConsoleMessages.TextBox.UIPadding
					Executor["120"] = Instance.new("UIPadding", Executor["11f"]);
					Executor["120"]["PaddingTop"] = UDim.new(0, 8);
					Executor["120"]["PaddingRight"] = UDim.new(0, 4);
					Executor["120"]["PaddingBottom"] = UDim.new(0, 8);
					Executor["120"]["PaddingLeft"] = UDim.new(0, 4);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.Execute
					Executor["121"] = Instance.new("Frame", Executor["11d"]);
					Executor["121"]["BorderSizePixel"] = 0;
					Executor["121"]["BackgroundColor3"] = Color3.fromRGB(12, 24, 37);
					Executor["121"]["Size"] = UDim2.new(0, 60, 0, 20);
					Executor["121"]["Position"] = UDim2.new(0, 0, 1, 1);
					Executor["121"]["Name"] = [[Execute]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.Execute.TextLabel
					Executor["122"] = Instance.new("TextLabel", Executor["121"]);
					Executor["122"]["BorderSizePixel"] = 0;
					Executor["122"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Executor["122"]["TextSize"] = 10;
					Executor["122"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Executor["122"]["Size"] = UDim2.new(1, 0, 1, 0);
					Executor["122"]["Text"] = [[Execute]];
					Executor["122"]["Font"] = Enum.Font.Gotham;
					Executor["122"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.Execute.TextLabel.UIStroke
					Executor["123"] = Instance.new("UIStroke", Executor["122"]);
					Executor["123"]["Thickness"] = 0.699999988079071;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.UIStroke
					Executor["124"] = Instance.new("UIStroke", Executor["11d"]);
					Executor["124"]["Color"] = Color3.fromRGB(15, 30, 48);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.UIPadding
					Executor["125"] = Instance.new("UIPadding", Executor["11d"]);
					Executor["125"]["PaddingRight"] = UDim.new(0, 4);
					Executor["125"]["PaddingLeft"] = UDim.new(0, 4);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.Clear
					Executor["126"] = Instance.new("Frame", Executor["11d"]);
					Executor["126"]["BorderSizePixel"] = 0;
					Executor["126"]["BackgroundColor3"] = Color3.fromRGB(12, 24, 37);
					Executor["126"]["Size"] = UDim2.new(0, 60, 0, 20);
					Executor["126"]["Position"] = UDim2.new(0, 64, 1, 1);
					Executor["126"]["Name"] = [[Clear]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.Clear.TextLabel
					Executor["127"] = Instance.new("TextLabel", Executor["126"]);
					Executor["127"]["BorderSizePixel"] = 0;
					Executor["127"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Executor["127"]["TextSize"] = 10;
					Executor["127"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Executor["127"]["Size"] = UDim2.new(1, 0, 1, 0);
					Executor["127"]["Text"] = [[Clear]];
					Executor["127"]["Font"] = Enum.Font.Gotham;
					Executor["127"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Executor.ExecuteBox.Clear.TextLabel.UIStroke
					Executor["128"] = Instance.new("UIStroke", Executor["127"]);
					Executor["128"]["Thickness"] = 0.699999988079071;
				end
				
				--//Methods
				do
					function Executor:Clear()
						Executor["11f"]["Text"] = [[]]
					end
					
					function Executor:Execute()
						local Succes, Error = pcall(function()
							local a = loadstring(Executor["11f"]["Text"])()
						end)
						if not Succes then
							GUI:SendConsoleMessage("Error", Error)
						end
					end
				end
				
				--//Logic
				do
					Executor["121"].MouseEnter:Connect(function()
						if Library:IsHoveringOnElemt(Executor["121"]) then
							Executor.Hover = true
						end
					end)

					Executor["121"].MouseLeave:Connect(function()
						Executor.Hover = false
					end)

					Executor["121"].InputBegan:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if Executor.Hover then
								Library:tween(Executor["121"], {BackgroundColor3 = Color3.fromRGB(12+10, 24+10, 37+10)})
							else
								Library:tween(Executor["121"], {BackgroundColor3 = Color3.fromRGB(12+10, 24+10, 37+10)})
							end
						end
					end)

					Executor["121"].InputEnded:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if Executor.Hover then
								Library:tween(Executor["121"], {BackgroundColor3 = Color3.fromRGB(12, 24, 37)})
							else
								Library:tween(Executor["121"], {BackgroundColor3 = Color3.fromRGB(12, 24, 37)})
							end
							Executor:Execute()
						end
					end)
					
					Executor["126"].InputBegan:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if Executor.Hover then
								Library:tween(Executor["126"], {BackgroundColor3 = Color3.fromRGB(12+10, 24+10, 37+10)})
							else
								Library:tween(Executor["126"], {BackgroundColor3 = Color3.fromRGB(12+10, 24+10, 37+10)})
							end
						end
					end)

					Executor["126"].InputEnded:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if Executor.Hover then
								Library:tween(Executor["126"], {BackgroundColor3 = Color3.fromRGB(12, 24, 37)})
							else
								Library:tween(Executor["126"], {BackgroundColor3 = Color3.fromRGB(12, 24, 37)})
							end
							Executor:Clear()
						end
					end)
				end
				
				return Executor
			end
			
			function Section:Label(options)
				options = Library:Validate({
					name = "This is Label",
					RainbowText = false,
					RainbowSpeed = 60
				}, options or {})
				
				local Label = {}
				
				---//render label
				do
					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Label
					Label["cc"] = Instance.new("Frame", Section["a9"]);
					Label["cc"]["BackgroundColor3"] = Color3.fromRGB(13, 18, 30);
					Label["cc"]["Size"] = UDim2.new(1, 0, 0, 30);
					Label["cc"]["ClipsDescendants"] = true;
					Label["cc"]["Name"] = [[Label]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Label.UICorner
					Label["cd"] = Instance.new("UICorner", Label["cc"]);
					Label["cd"]["CornerRadius"] = UDim.new(0, 3);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Label.UIStroke
					Label["ce"] = Instance.new("UIStroke", Label["cc"]);
					Label["ce"]["Color"] = Color3.fromRGB(16, 36, 57);
					Label["ce"]["Thickness"] = 0.699999988079071;
					Label["ce"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Label.Text
					Label["cf"] = Instance.new("TextLabel", Label["cc"]);
					Label["cf"]["BorderSizePixel"] = 0;
					Label["cf"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Label["cf"]["TextSize"] = 11;
					Label["cf"]["TextColor3"] = Color3.fromRGB(231, 231, 231);
					Label["cf"]["Size"] = UDim2.new(1, 0, 1, 0);
					Label["cf"]["ClipsDescendants"] = true;
					Label["cf"]["Text"] = options.name;
					Label["cf"]["Name"] = [[Text]];
					Label["cf"]["Font"] = Enum.Font.GothamMedium;
					Label["cf"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Label.Text.UIStroke
					Label["d0"] = Instance.new("UIStroke", Label["cf"]);
					Label["d0"]["Thickness"] = 0.699999988079071;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Label.UIPadding
					Label["d1"] = Instance.new("UIPadding", Label["cc"]);
					Label["d1"]["PaddingRight"] = UDim.new(0, 12);
					Label["d1"]["PaddingLeft"] = UDim.new(0, 12);

				end
				
				--//Methods
				
				do
					function Label:SetText(text)
						Label["cf"]["Text"] = text
					end
					
					function Label:SetColor(a, b, c)
						Label["cf"]["TextColor3"] = Color3.fromRGB(a, b, c)
					end
					
				end
				
				--//Logic
				do
					if options.PulseText then
						spawn(function()
							while task.wait(0.1) do
								local r = Label["cf"]["TextColor3"].R * 255
								local g = Label["cf"]["TextColor3"].G * 255
								local b = Label["cf"]["TextColor3"].B * 255
								for i = 1, 70 do
									Label:SetColor(r-i, g-i, b-i)
									task.wait(0)
								end
								r = Label["cf"]["TextColor3"].R * 255
								g = Label["cf"]["TextColor3"].G * 255
								b = Label["cf"]["TextColor3"].B * 255
								for i = 1, 70 do
									Label:SetColor(r+i, g+i, b+i)
									task.wait(0)
								end
							end
						end)
					end
				end
				
				return Label
			end
			
			function Section:Slider(options)
				options = Library:Validate({
					name = "Slider",
					min = 0,
					max = 100,
					numberAfterInt = 2,
					deafult = 50,
					callback = function(v) print(v) end
				}, options or {})

				local Slider = {
					MouseDown = false,
					Hover = false,
					Connection = nil,
					Options = options
				}
				
				--//Render Slider
				do
					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider
					Slider["d2"] = Instance.new("Frame", Section["a9"]);
					Slider["d2"]["BackgroundColor3"] = Color3.fromRGB(13, 18, 30);
					Slider["d2"]["Size"] = UDim2.new(1, 0, 0, 45);
					Slider["d2"]["ClipsDescendants"] = true;
					Slider["d2"]["Name"] = [[Slider]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.UICorner
					Slider["d3"] = Instance.new("UICorner", Slider["d2"]);
					Slider["d3"]["CornerRadius"] = UDim.new(0, 3);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.UIStroke
					Slider["d4"] = Instance.new("UIStroke", Slider["d2"]);
					Slider["d4"]["Color"] = Color3.fromRGB(16, 36, 57);
					Slider["d4"]["Thickness"] = 0.699999988079071;
					Slider["d4"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.UIPadding
					Slider["d5"] = Instance.new("UIPadding", Slider["d2"]);
					Slider["d5"]["PaddingTop"] = UDim.new(0, 4);
					Slider["d5"]["PaddingRight"] = UDim.new(0, 12);
					Slider["d5"]["PaddingLeft"] = UDim.new(0, 12);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.SliderBack
					Slider["d6"] = Instance.new("Frame", Slider["d2"]);
					Slider["d6"]["BorderSizePixel"] = 0;
					Slider["d6"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
					Slider["d6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
					Slider["d6"]["Size"] = UDim2.new(1, 0, 0, 5);
					Slider["d6"]["Position"] = UDim2.new(0.5, 0, 1, -13);
					Slider["d6"]["Name"] = [[SliderBack]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.SliderBack.UICorner
					Slider["d7"] = Instance.new("UICorner", Slider["d6"]);
					Slider["d7"]["CornerRadius"] = UDim.new(0, 2);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.SliderBack.UIStroke
					Slider["d8"] = Instance.new("UIStroke", Slider["d6"]);
					Slider["d8"]["Color"] = Color3.fromRGB(15, 30, 48);
					Slider["d8"]["Thickness"] = 0.7;
					Slider["d8"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.SliderBack.Draggable
					Slider["d9"] = Instance.new("Frame", Slider["d6"]);
					Slider["d9"]["BorderSizePixel"] = 0;
					Slider["d9"]["BackgroundColor3"] = Color3.fromRGB(25, 47, 77);
					Slider["d9"]["Size"] = UDim2.new(0.5, 0, 0, 5);
					Slider["d9"]["Name"] = [[Draggable]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.Text
					Slider["da"] = Instance.new("TextLabel", Slider["d2"]);
					Slider["da"]["BorderSizePixel"] = 0;
					Slider["da"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Slider["da"]["BackgroundColor3"] = Color3.fromRGB(50, 50, 50);
					Slider["da"]["TextSize"] = 16;
					Slider["da"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Slider["da"]["Size"] = UDim2.new(1, 0, 0, 20);
					Slider["da"]["Text"] = [[Slider]];
					Slider["da"]["Name"] = [[Text]];
					Slider["da"]["Font"] = Enum.Font.Nunito;
					Slider["da"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.Text.UIStroke
					Slider["db"] = Instance.new("UIStroke", Slider["da"]);
					Slider["db"]["Thickness"] = 0.7;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.Value
					Slider["dc"] = Instance.new("TextLabel", Slider["d2"]);
					Slider["dc"]["BorderSizePixel"] = 0;
					Slider["dc"]["TextXAlignment"] = Enum.TextXAlignment.Right;
					Slider["dc"]["BackgroundColor3"] = Color3.fromRGB(50, 50, 50);
					Slider["dc"]["TextSize"] = 16;
					Slider["dc"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Slider["dc"]["Size"] = UDim2.new(0, 25, 0, 20);
					Slider["dc"]["Text"] = [[100]];
					Slider["dc"]["Name"] = [[Value]];
					Slider["dc"]["Font"] = Enum.Font.Nunito;
					Slider["dc"]["BackgroundTransparency"] = 1;
					Slider["dc"]["Position"] = UDim2.new(1, -20, 0, 0);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.Value.UIStroke
					Slider["dd"] = Instance.new("UIStroke", Slider["dc"]);
					Slider["dd"]["Thickness"] = 0.7;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Slider.Value.UIPadding
					Slider["de"] = Instance.new("UIPadding", Slider["dc"]);
					Slider["de"]["PaddingRight"] = UDim.new(0, 6);
					Slider["de"]["PaddingLeft"] = UDim.new(0, 8);
				end
				
				--//Methods
				do
					function Slider:RoundNumber(num, decimalPlaces)
						local multiplier = 10 ^ (decimalPlaces or 0)
						return math.floor(num * multiplier + 0.5) / multiplier
					end
					
					function Slider:SetValue(v)
						if v == nil then
							local percentage = math.clamp((Mouse.X - Slider["d6"].AbsolutePosition.X) / (Slider["d6"].AbsoluteSize.X), 0, 1)
							local value = ((options.max - options.min) * percentage) + options.min
							local value2 = Slider:RoundNumber(value, options.numberAfterInt)
							Slider["dc"].Text = tostring(value2)

							Slider["d9"].Size = UDim2.fromScale(percentage, 1)
						else
							Slider["dc"].Text = tostring(v)
							Slider["d9"].Size = UDim2.fromScale(((v - options.min) / (options.max - options.min)), 1)

						end
						options.callback(Slider:GetValue())
						Library.Config[options.name] = Slider:GetValue()
					end

					function Slider:GetValue(v)
						return tonumber(Slider["dc"].Text)
					end

					if options.deafult then
						Slider:SetValue(options.deafult)
						Library.Config[options.name] = options.deafult
					end
				end

				--//Logic
				do
					Slider["d2"].MouseEnter:Connect(function()
						if Library:IsHoveringOnElemt(Slider["d2"]) then
							Slider.Hover = true
							Library:tween(Slider["d4"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
						end
					end)
					
					Slider["d2"].MouseLeave:Connect(function()
						if not Library:IsHoveringOnElemt(Slider["d2"]) then
							Slider.Hover = false
							Library:tween(Slider["d4"], {Color = Color3.fromRGB(16, 36, 57)})
						end
					end)

					Slider["d2"].InputBegan:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if Slider.Hover then
								Slider.MouseDown = false
								Library:tween(Slider["d2"], {BackgroundColor3 = Color3.fromRGB(13+10, 18+10, 30+10)})
								Library:tween(Slider["d4"], {Color = Color3.fromRGB(16+30, 36+30, 57+30)})
								Library:tween(Slider["d8"], {Color = Color3.fromRGB(16+30, 36+30, 57+30)})
								if not Slider.Connection then
									Slider.Connection = runService.RenderStepped:Connect(function()
										if not GUI["1"].Enabled then
											Slider.Connection:Disconnect()
											Slider.Connection = nil	
											if Slider.Hover then
												Library:tween(Slider["d9"], {BackgroundColor3 = Color3.fromRGB(25+10, 47+10, 77+10)})
												Library:tween(Slider["d8"], {Color = Color3.fromRGB(15+30, 30+30, 48+30)})
											else 
												Library:tween(Slider["d9"], {BackgroundColor3 = Color3.fromRGB(25, 47, 77)})
												Library:tween(Slider["d8"], {Color = Color3.fromRGB(15, 30, 48)})
											end
										end
										Slider:SetValue()
									end)
								end
							else
								Library:tween(Slider["d2"], {BackgroundColor3 = Color3.fromRGB(13+10, 18+10, 30+10)})
								Library:tween(Slider["d4"], {Color = Color3.fromRGB(16, 36, 57)})
								Library:tween(Slider["d8"], {Color = Color3.fromRGB(16, 36, 57)})
							end
						end
					end)

					Slider["d2"].InputEnded:Connect(function(Input, gp)
						if not GUI["1"].Enabled then return end
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
								Slider.MouseDown = false

								if Slider.Connection then Slider.Connection:Disconnect()
									Slider.Connection = nil
								end	
								if Slider.Hover then
									Library:tween(Slider["d2"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
									Library:tween(Slider["d9"], {BackgroundColor3 = Color3.fromRGB(25, 47, 77)})
									Library:tween(Slider["d8"], {Color = Color3.fromRGB(15, 30, 48)})
									Library:tween(Slider["d4"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
								else 
									--reset
									Library:tween(Slider["d2"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
									Library:tween(Slider["d2"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
									Library:tween(Slider["d4"], {Color = Color3.fromRGB(16, 36, 57)})
									Library:tween(Slider["d8"], {Color = Color3.fromRGB(16, 36, 57)})
								end
						end
					end)


				end

				return Slider
			end
			
			function Section:Dropdown(options)
				options = Library:Validate({
					name = "Dropdown",
					values = {"value1", "value2", "value3"},
					deafult = nil,
					callback = function(v) print(v) end
				}, options or {})

				local Dropdown = {
					Items = {
						["id"] = {
							{},
							"Value"
						}
					},
					ActiveId = nil,
					Open = false,
					MouseDown = false,
					Hover = false,
					HoveringItem = false
				}
				
				--//Render Dropdown
				do
					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown
					Dropdown["f4"] = Instance.new("Frame", Section["a9"]);
					Dropdown["f4"]["BackgroundColor3"] = Color3.fromRGB(13, 18, 30);
					Dropdown["f4"]["Size"] = UDim2.new(1, 0, 0, 30);
					Dropdown["f4"]["ClipsDescendants"] = true;
					Dropdown["f4"]["Name"] = [[Dropdown]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.UICorner
					Dropdown["f5"] = Instance.new("UICorner", Dropdown["f4"]);
					Dropdown["f5"]["CornerRadius"] = UDim.new(0, 3);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.UIStroke
					Dropdown["f6"] = Instance.new("UIStroke", Dropdown["f4"]);
					Dropdown["f6"]["Color"] = Color3.fromRGB(16, 36, 57);
					Dropdown["f6"]["Thickness"] = 0.7;
					Dropdown["f6"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.Text
					Dropdown["f7"] = Instance.new("TextLabel", Dropdown["f4"]);
					Dropdown["f7"]["BorderSizePixel"] = 0;
					Dropdown["f7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Dropdown["f7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["f7"]["TextSize"] = 11;
					Dropdown["f7"]["TextColor3"] = Color3.fromRGB(231, 231, 231);
					Dropdown["f7"]["Size"] = UDim2.new(1, 0, 0, 30);
					Dropdown["f7"]["ClipsDescendants"] = true;
					Dropdown["f7"]["Text"] = options.name;
					Dropdown["f7"]["Name"] = [[Text]];
					Dropdown["f7"]["Font"] = Enum.Font.GothamMedium;
					Dropdown["f7"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.Text.UIStroke
					Dropdown["f8"] = Instance.new("UIStroke", Dropdown["f7"]);
					Dropdown["f8"]["Thickness"] = 0.7;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.UIPadding
					Dropdown["f9"] = Instance.new("UIPadding", Dropdown["f4"]);
					Dropdown["f9"]["PaddingRight"] = UDim.new(0, 12);
					Dropdown["f9"]["PaddingLeft"] = UDim.new(0, 12);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.ImageContainer
					Dropdown["fa"] = Instance.new("Frame", Dropdown["f4"]);
					Dropdown["fa"]["BorderSizePixel"] = 0;
					Dropdown["fa"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["fa"]["BackgroundTransparency"] = 1;
					Dropdown["fa"]["Size"] = UDim2.new(0, 20, 0, 20);
					Dropdown["fa"]["Position"] = UDim2.new(1, -14, 0, 5);
					Dropdown["fa"]["Name"] = [[ImageContainer]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.ImageContainer.DropIcon
					Dropdown["fb"] = Instance.new("ImageLabel", Dropdown["fa"]);
					Dropdown["fb"]["BorderSizePixel"] = 0;
					Dropdown["fb"]["BackgroundColor3"] = Color3.fromRGB(127, 161, 255);
					Dropdown["fb"]["ImageColor3"] = Color3.fromRGB(25, 47, 77);
					Dropdown["fb"]["Image"] = [[rbxassetid://12822246825]];
					Dropdown["fb"]["Size"] = UDim2.new(1, 0, 1, 0);
					Dropdown["fb"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
					Dropdown["fb"]["Name"] = [[DropIcon]];
					Dropdown["fb"]["BackgroundTransparency"] = 1;
					
					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder
					Dropdown["fc"] = Instance.new("Frame", Dropdown["f4"]);
					Dropdown["fc"]["BorderSizePixel"] = 0;
					Dropdown["fc"]["BackgroundColor3"] = Color3.fromRGB(73, 73, 73);
					Dropdown["fc"]["BackgroundTransparency"] = 1;
					Dropdown["fc"]["Size"] = UDim2.new(1, -15, 1, -30);
					Dropdown["fc"]["ClipsDescendants"] = true;
					Dropdown["fc"]["Position"] = UDim2.new(0, 5, 0, 30);
					Dropdown["fc"]["Visible"] = false;
					Dropdown["fc"]["Name"] = [[OptionHolder]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.UIListLayout
					Dropdown["fd"] = Instance.new("UIListLayout", Dropdown["fc"]);
					Dropdown["fd"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
					Dropdown["fd"]["Padding"] = UDim.new(0, 5);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.UIPadding
					Dropdown["fe"] = Instance.new("UIPadding", Dropdown["fc"]);
					Dropdown["fe"]["PaddingTop"] = UDim.new(0, 4);
					Dropdown["fe"]["PaddingRight"] = UDim.new(0, 4);
					Dropdown["fe"]["PaddingLeft"] = UDim.new(0, 4);
				end
				
				--//Methods 
				do
					function Dropdown:Add(id, value)
						local Item = {
							Hover = false,
							MouseDown = false,
						}

						if Dropdown.Items[id] ~= nil then
							return
						end

						-- StarterGui.ScreenGui.MainFrame.ContentCointainer.HomeTab.Dropdown.OptionHolder.Option3InActive
						Dropdown.Items[id] = {
							instance = {},
							value = value
						}
						
						-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.Option3InActive
						Dropdown.Items[id].instance["ff"] = Instance.new("TextLabel", Dropdown["fc"]);
						Dropdown.Items[id].instance["ff"]["BorderSizePixel"] = 0;
						Dropdown.Items[id].instance["ff"]["BackgroundColor3"] = Color3.fromRGB(15, 21, 35);
						Dropdown.Items[id].instance["ff"]["TextSize"] = 11;
						Dropdown.Items[id].instance["ff"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						Dropdown.Items[id].instance["ff"]["Size"] = UDim2.new(1, 0, 0, 20);
						Dropdown.Items[id].instance["ff"]["ClipsDescendants"] = true;
						Dropdown.Items[id].instance["ff"]["Text"] = id;
						Dropdown.Items[id].instance["ff"]["Name"] = id;
						Dropdown.Items[id].instance["ff"]["Font"] = Enum.Font.Gotham;
						Dropdown.Items[id].instance["ff"]["BackgroundTransparency"] = 0.6;
						Dropdown.Items[id].instance["ff"]["Position"] = UDim2.new(0, 8, 0, 0);

						-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.Option3InActive.UIStroke
						Dropdown.Items[id].instance["100"] = Instance.new("UIStroke", Dropdown.Items[id].instance["ff"]);
						Dropdown.Items[id].instance["100"]["Thickness"] = 0.7;

						-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.Option3InActive.UICorner
						Dropdown.Items[id].instance["101"] = Instance.new("UICorner", Dropdown.Items[id].instance["ff"]);
						Dropdown.Items[id].instance["101"]["CornerRadius"] = UDim.new(0, 3);

						-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.Option3InActive.UIStroke
						Dropdown.Items[id].instance["102"] = Instance.new("UIStroke", Dropdown.Items[id].instance["ff"]);
						Dropdown.Items[id].instance["102"]["Color"] = Color3.fromRGB(17, 35, 56);
						Dropdown.Items[id].instance["102"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
						
						if options.deafult ~= nil then 
							if Dropdown.Items[options.deafult] then
								Library.Config[options.name] = options.deafult
								options.callback(options.deafult)
								Library:tween(Dropdown.Items[options.deafult].instance["102"], {Color = Color3.fromRGB(17+30, 35+30, 56+30)})
								Dropdown["f7"]["Text"] = options.name .. " | " .. options.deafult 
								Dropdown.ActiveId = options.deafult
							end
						end
						
						Dropdown.Items[id].instance["ff"].MouseEnter:Connect(function()
							if Library:IsHoveringOnElemt(Dropdown.Items[id].instance["ff"]) then
								Item.Hover = true
								Dropdown.HoveringItem = true
								if id ~= Dropdown.ActiveId then
									Library:tween(Dropdown.Items[id].instance["102"], {Color = Color3.fromRGB(17+20, 35+20, 56+20)})
								end
							end
						end)

						Dropdown.Items[id].instance["ff"].MouseLeave:Connect(function()
							if not Library:IsHoveringOnElemt(Dropdown.Items[id].instance["ff"])  then
								Item.Hover = false
								Dropdown.HoveringItem = false
								if id ~= Dropdown.ActiveId then
									Library:tween(Dropdown.Items[id].instance["102"], {Color = Color3.fromRGB(17, 35, 56)})
								end
							end
						end) 
						
						Dropdown.Items[id].instance["ff"].InputBegan:Connect(function(Input, gp)
							if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
								Library:tween(Dropdown.Items[id].instance["ff"], {BackgroundColor3 = Color3.fromRGB(15+10, 21+10, 35+10)})
								Library:tween(Dropdown.Items[id].instance["102"], {Color = Color3.fromRGB(17+30, 35+30, 56+30)})
							end
						end)

						Dropdown.Items[id].instance["ff"].InputEnded:Connect(function(Input, gp)
							if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
								Dropdown.ActiveId = id
								Library:tween(Dropdown.Items[id].instance["ff"], {BackgroundColor3 = Color3.fromRGB(15, 21, 35)})
								if Dropdown.ActiveId ~= id then
									Library:tween(Dropdown.Items[Dropdown.ActiveId].instance["ff"], {BackgroundColor3 = Color3.fromRGB(15, 21, 35)})
									Library:tween(Dropdown.Items[Dropdown.ActiveId].instance["102"], {Color = Color3.fromRGB(17, 35, 56)})
								end
								Library.Config[options.name] = id
								options.callback(id)
								Dropdown["f7"]["Text"] = options.name .. " | " .. id

							end
						end)
						
					end
					
					function Dropdown:Remove(id)
						if Dropdown.ActiveId == id then
							GUI:SendConsoleMessage("Warn", "You can't delete option that is currently valid: "..id)
						else
							if Dropdown.Items[id] ~= nil then
								if Dropdown.Items[id].instance ~= nil then
									if id ~= nil then
										for i, v in pairs(Dropdown.Items[id].instance)  do
											v:Destroy()
										end
									end
								end
								Dropdown.Items[id] = nil
								if Dropdown.Open then
									local Size = 0
									for i, v in pairs(Dropdown.Items) do
										Size = Size + 25
									end
									Library:tween(Dropdown["f4"], {Size = UDim2.new(1, 0, 0, 30 + Size)})
								end
							end
						end
					end
					
					for i, v in pairs(options.values) do
						Dropdown:Add(v, i)
					end
					
					function Dropdown:Toggle()
						if not Dropdown.Open then
							Dropdown.Open = true
							Dropdown["fc"].Visible = true
							local Size = 0
							for i, v in pairs(Dropdown.Items) do
								Size = Size + 25
							end
							Library:tween(Dropdown["f4"], {Size = UDim2.new(1, 0, 0, 30 + Size)})
						else
							Dropdown.Open = false
							Library:tween(Dropdown["f4"], {Size = UDim2.new(1, 0, 0, 30)})
							task.wait(0.24)
							Dropdown["fc"].Visible = false
						end
					end
				end
				
				--//Logic
				do
					Dropdown["f4"].MouseEnter:Connect(function()
						if Library:IsHoveringOnElemt(Dropdown["f4"]) then
							Dropdown.Hover = true
							Library:tween(Dropdown["f6"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
						end
					end)

					Dropdown["f4"].MouseLeave:Connect(function()
						if not Library:IsHoveringOnElemt(Dropdown["f4"]) then
							Dropdown.Hover = false
							Library:tween(Dropdown["f6"], {Color = Color3.fromRGB(16, 36, 57)})
						end
					end)

					Dropdown["f4"].InputBegan:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if not Dropdown.HoveringItem then
								if Dropdown.Hover then
									Library:tween(Dropdown["f4"], {BackgroundColor3 = Color3.fromRGB(13+10, 18+10, 30+10)})
									Library:tween(Dropdown["f6"], {Color = Color3.fromRGB(16+30, 36+30, 57+30)})
								else
									Library:tween(Dropdown["f4"], {BackgroundColor3 = Color3.fromRGB(13+10, 18+10, 30+10)})
									Library:tween(Dropdown["f6"], {Color = Color3.fromRGB(16, 36, 57)})
								end
							end
						end
					end)

					Dropdown["f4"].InputEnded:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp and not Dropdown.HoveringItem then
							if not Dropdown.HoveringItem then
								if Dropdown.Hover then
									Library:tween(Dropdown["f4"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
									Library:tween(Dropdown["f6"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
								else
									Library:tween(Dropdown["f4"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
									Library:tween(Dropdown["f6"], {Color = Color3.fromRGB(16, 36, 57)})
								end
								Dropdown:Toggle()
							end
						end
					end)
				end
				return Dropdown
			end
			
			function Section:MultiDropdown(options)
				options = Library:Validate({
					name = "MultiDropdown",
					values = {"value1", "value2", "value3"},
					deafult = nil,
					callback = function(v) print(v) end
				}, options or {})

				local MultiDropdown = {
					Items = {
						["id"] = {
							{},
							"Value"
						}
					},
					ActiveIds = {},
					Open = false,
					MouseDown = false,
					Hover = false,
					HoveringItem = false
				}
				--//Render Dropdown
				do
					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown
					MultiDropdown["f4"] = Instance.new("Frame", Section["a9"]);
					MultiDropdown["f4"]["BackgroundColor3"] = Color3.fromRGB(13, 18, 30);
					MultiDropdown["f4"]["Size"] = UDim2.new(1, 0, 0, 30);
					MultiDropdown["f4"]["ClipsDescendants"] = true;
					MultiDropdown["f4"]["Name"] = [[Dropdown]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.UICorner
					MultiDropdown["f5"] = Instance.new("UICorner", MultiDropdown["f4"]);
					MultiDropdown["f5"]["CornerRadius"] = UDim.new(0, 3);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.UIStroke
					MultiDropdown["f6"] = Instance.new("UIStroke", MultiDropdown["f4"]);
					MultiDropdown["f6"]["Color"] = Color3.fromRGB(16, 36, 57);
					MultiDropdown["f6"]["Thickness"] = 0.7;
					MultiDropdown["f6"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.Text
					MultiDropdown["f7"] = Instance.new("TextLabel", MultiDropdown["f4"]);
					MultiDropdown["f7"]["BorderSizePixel"] = 0;
					MultiDropdown["f7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					MultiDropdown["f7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					MultiDropdown["f7"]["TextSize"] = 11;
					MultiDropdown["f7"]["TextColor3"] = Color3.fromRGB(231, 231, 231);
					MultiDropdown["f7"]["Size"] = UDim2.new(1, 0, 0, 30);
					MultiDropdown["f7"]["ClipsDescendants"] = true;
					MultiDropdown["f7"]["Text"] = options.name;
					MultiDropdown["f7"]["Name"] = [[Text]];
					MultiDropdown["f7"]["Font"] = Enum.Font.GothamMedium;
					MultiDropdown["f7"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.Text.UIStroke
					MultiDropdown["f8"] = Instance.new("UIStroke", MultiDropdown["f7"]);
					MultiDropdown["f8"]["Thickness"] = 0.7;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.UIPadding
					MultiDropdown["f9"] = Instance.new("UIPadding", MultiDropdown["f4"]);
					MultiDropdown["f9"]["PaddingRight"] = UDim.new(0, 12);
					MultiDropdown["f9"]["PaddingLeft"] = UDim.new(0, 12);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.ImageContainer
					MultiDropdown["fa"] = Instance.new("Frame", MultiDropdown["f4"]);
					MultiDropdown["fa"]["BorderSizePixel"] = 0;
					MultiDropdown["fa"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					MultiDropdown["fa"]["BackgroundTransparency"] = 1;
					MultiDropdown["fa"]["Size"] = UDim2.new(0, 20, 0, 20);
					MultiDropdown["fa"]["Position"] = UDim2.new(1, -14, 0, 5);
					MultiDropdown["fa"]["Name"] = [[ImageContainer]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.ImageContainer.DropIcon
					MultiDropdown["fb"] = Instance.new("ImageLabel", MultiDropdown["fa"]);
					MultiDropdown["fb"]["BorderSizePixel"] = 0;
					MultiDropdown["fb"]["BackgroundColor3"] = Color3.fromRGB(127, 161, 255);
					MultiDropdown["fb"]["ImageColor3"] = Color3.fromRGB(25, 47, 77);
					MultiDropdown["fb"]["Image"] = [[rbxassetid://12822246825]];
					MultiDropdown["fb"]["Size"] = UDim2.new(1, 0, 1, 0);
					MultiDropdown["fb"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
					MultiDropdown["fb"]["Name"] = [[DropIcon]];
					MultiDropdown["fb"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder
					MultiDropdown["fc"] = Instance.new("Frame", MultiDropdown["f4"]);
					MultiDropdown["fc"]["BorderSizePixel"] = 0;
					MultiDropdown["fc"]["BackgroundColor3"] = Color3.fromRGB(73, 73, 73);
					MultiDropdown["fc"]["BackgroundTransparency"] = 1;
					MultiDropdown["fc"]["Size"] = UDim2.new(1, -15, 1, -30);
					MultiDropdown["fc"]["ClipsDescendants"] = true;
					MultiDropdown["fc"]["Position"] = UDim2.new(0, 5, 0, 30);
					MultiDropdown["fc"]["Visible"] = false;
					MultiDropdown["fc"]["Name"] = [[OptionHolder]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.UIListLayout
					MultiDropdown["fd"] = Instance.new("UIListLayout", MultiDropdown["fc"]);
					MultiDropdown["fd"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
					MultiDropdown["fd"]["Padding"] = UDim.new(0, 5);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.UIPadding
					MultiDropdown["fe"] = Instance.new("UIPadding", MultiDropdown["fc"]);
					MultiDropdown["fe"]["PaddingTop"] = UDim.new(0, 4);
					MultiDropdown["fe"]["PaddingRight"] = UDim.new(0, 4);
					MultiDropdown["fe"]["PaddingLeft"] = UDim.new(0, 4);
				end

				--//Methods 
				do
					function MultiDropdown:GetText()
						local Text = options.name.." | "
						for i, v in pairs(MultiDropdown.ActiveIds) do
							Text = Text..v..", "
						end
						Text = string.sub(Text, 1, -3)
						return Text
					end
					
					function MultiDropdown:Add(id, value)
						local Item = {
							Hover = false,
							MouseDown = false,
						}

						if MultiDropdown.Items[id] ~= nil then
							return
						end

						-- StarterGui.ScreenGui.MainFrame.ContentCointainer.HomeTab.Dropdown.OptionHolder.Option3InActive
						MultiDropdown.Items[id] = {
							instance = {},
							value = value
						}

						-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.Option3InActive
						MultiDropdown.Items[id].instance["ff"] = Instance.new("TextLabel", MultiDropdown["fc"]);
						MultiDropdown.Items[id].instance["ff"]["BorderSizePixel"] = 0;
						MultiDropdown.Items[id].instance["ff"]["BackgroundColor3"] = Color3.fromRGB(15, 21, 35);
						MultiDropdown.Items[id].instance["ff"]["TextSize"] = 11;
						MultiDropdown.Items[id].instance["ff"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						MultiDropdown.Items[id].instance["ff"]["Size"] = UDim2.new(1, 0, 0, 20);
						MultiDropdown.Items[id].instance["ff"]["ClipsDescendants"] = true;
						MultiDropdown.Items[id].instance["ff"]["Text"] = id;
						MultiDropdown.Items[id].instance["ff"]["Name"] = id;
						MultiDropdown.Items[id].instance["ff"]["Font"] = Enum.Font.Gotham;
						MultiDropdown.Items[id].instance["ff"]["BackgroundTransparency"] = 0.6;
						MultiDropdown.Items[id].instance["ff"]["Position"] = UDim2.new(0, 8, 0, 0);

						-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.Option3InActive.UIStroke
						MultiDropdown.Items[id].instance["100"] = Instance.new("UIStroke", MultiDropdown.Items[id].instance["ff"]);
						MultiDropdown.Items[id].instance["100"]["Thickness"] = 0.7;

						-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.Option3InActive.UICorner
						MultiDropdown.Items[id].instance["101"] = Instance.new("UICorner", MultiDropdown.Items[id].instance["ff"]);
						MultiDropdown.Items[id].instance["101"]["CornerRadius"] = UDim.new(0, 3);

						-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.Dropdown.OptionHolder.Option3InActive.UIStroke
						MultiDropdown.Items[id].instance["102"] = Instance.new("UIStroke", MultiDropdown.Items[id].instance["ff"]);
						MultiDropdown.Items[id].instance["102"]["Color"] = Color3.fromRGB(17, 35, 56);
						MultiDropdown.Items[id].instance["102"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

						if options.deafult ~= nil then 
							if MultiDropdown.Items[options.deafult] then
								table.insert(MultiDropdown.ActiveIds, options.deafult)
								Library.Config[options.name] = MultiDropdown.ActiveIds
								options.callback(MultiDropdown.ActiveIds)
								Library:tween(MultiDropdown.Items[options.deafult].instance["102"], {Color = Color3.fromRGB(17+30, 35+30, 56+30)})
								MultiDropdown["f7"]["Text"] = MultiDropdown:GetText()
							end
						end

						MultiDropdown.Items[id].instance["ff"].MouseEnter:Connect(function()
							if Library:IsHoveringOnElemt(MultiDropdown.Items[id].instance["ff"]) then
								Item.Hover = true
								MultiDropdown.HoveringItem = true
								if not table.find(MultiDropdown.ActiveIds, id) then
									Library:tween(MultiDropdown.Items[id].instance["102"], {Color = Color3.fromRGB(17+20, 35+20, 56+20)})
								end
							end
						end)

						MultiDropdown.Items[id].instance["ff"].MouseLeave:Connect(function()
							if not Library:IsHoveringOnElemt(MultiDropdown.Items[id].instance["ff"])  then
								Item.Hover = false
								MultiDropdown.HoveringItem = false
								if not table.find(MultiDropdown.ActiveIds, id) then
									Library:tween(MultiDropdown.Items[id].instance["102"], {Color = Color3.fromRGB(17, 35, 56)})
								end
							end
						end) 

						MultiDropdown.Items[id].instance["ff"].InputBegan:Connect(function(Input, gp)
							if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
								Library:tween(MultiDropdown.Items[id].instance["ff"], {BackgroundColor3 = Color3.fromRGB(15+10, 21+10, 35+10)})
								Library:tween(MultiDropdown.Items[id].instance["102"], {Color = Color3.fromRGB(17+30, 35+30, 56+30)})
							end
						end)

						MultiDropdown.Items[id].instance["ff"].InputEnded:Connect(function(Input, gp)
							if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
								Library:tween(MultiDropdown.Items[id].instance["ff"], {BackgroundColor3 = Color3.fromRGB(15, 21, 35)})
								if table.find(MultiDropdown.ActiveIds, id) then
									Library:tween(MultiDropdown.Items[id].instance["ff"], {BackgroundColor3 = Color3.fromRGB(15, 21, 35)})
									Library:tween(MultiDropdown.Items[id].instance["102"], {Color = Color3.fromRGB(17, 35, 56)})
								end
								if table.find(MultiDropdown.ActiveIds, id) then
									local index
									for i, v in pairs(MultiDropdown.ActiveIds) do
										if v == id then
											index = i
										end
									end
									table.remove(MultiDropdown.ActiveIds, index)
								else
									table.insert(MultiDropdown.ActiveIds, id)
								end
								Library.Config[options.name] = MultiDropdown.ActiveIds
								options.callback(MultiDropdown.ActiveIds)
								MultiDropdown["f7"]["Text"] = MultiDropdown:GetText()
							end
						end)

					end


					function MultiDropdown:Remove(id)
						local x = table.find(MultiDropdown.ActiveIds, id)
						if x then
							table.remove(MultiDropdown.ActiveIds, x)
						else
							if MultiDropdown.Items[id] ~= nil then
								if MultiDropdown.Items[id].instance ~= nil then
									if id ~= nil then
										for i, v in pairs(MultiDropdown.Items[id].instance)  do
											v:Destroy()
										end
									end
								end
								MultiDropdown.Items[id] = nil
								if MultiDropdown.Open then
									local Size = 0
									for i, v in pairs(MultiDropdown.Items) do
										Size = Size + 25
									end
									Library:tween(MultiDropdown["f4"], {Size = UDim2.new(1, 0, 0, 30 + Size)})
								end
							end
						end
					end
					for i, v in pairs(options.values) do
						MultiDropdown:Add(v, i)
					end

					function MultiDropdown:Toggle()
						if not MultiDropdown.Open then
							MultiDropdown.Open = true
							MultiDropdown["fc"].Visible = true
							local Size = 0
							for i, v in pairs(MultiDropdown.Items) do
								Size = Size + 25
							end
							Library:tween(MultiDropdown["f4"], {Size = UDim2.new(1, 0, 0, 30 + Size)})
						else
							MultiDropdown.Open = false
							Library:tween(MultiDropdown["f4"], {Size = UDim2.new(1, 0, 0, 30)})
							task.wait(0.24)
							MultiDropdown["fc"].Visible = false
						end
					end
				end

				--//Logic
				do
					MultiDropdown["f4"].MouseEnter:Connect(function()
						if Library:IsHoveringOnElemt(MultiDropdown["f4"]) then
							MultiDropdown.Hover = true
							Library:tween(MultiDropdown["f6"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
						end
					end)

					MultiDropdown["f4"].MouseLeave:Connect(function()
						if not Library:IsHoveringOnElemt(MultiDropdown["f4"]) then
							MultiDropdown.Hover = false
							Library:tween(MultiDropdown["f6"], {Color = Color3.fromRGB(16, 36, 57)})
						end
					end)

					MultiDropdown["f4"].InputBegan:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp then
							if not MultiDropdown.HoveringItem then
								if MultiDropdown.Hover then
									Library:tween(MultiDropdown["f4"], {BackgroundColor3 = Color3.fromRGB(13+10, 18+10, 30+10)})
									Library:tween(MultiDropdown["f6"], {Color = Color3.fromRGB(16+30, 36+30, 57+30)})
								else
									Library:tween(MultiDropdown["f4"], {BackgroundColor3 = Color3.fromRGB(13+10, 18+10, 30+10)})
									Library:tween(MultiDropdown["f6"], {Color = Color3.fromRGB(16, 36, 57)})
								end
							end
						end
					end)

					MultiDropdown["f4"].InputEnded:Connect(function(Input, gp)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not gp and not MultiDropdown.HoveringItem then
							if not MultiDropdown.HoveringItem then
								if MultiDropdown.Hover then
									Library:tween(MultiDropdown["f4"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
									Library:tween(MultiDropdown["f6"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
								else
									Library:tween(MultiDropdown["f4"], {BackgroundColor3 = Color3.fromRGB(13, 18, 30)})
									Library:tween(MultiDropdown["f6"], {Color = Color3.fromRGB(16, 36, 57)})
								end
								MultiDropdown:Toggle()
							end
						end
					end)
				end
				return MultiDropdown
			end
			
			function Section:TextBox(options)
				options = Library:Validate({
					name = "Deafult",
					deafult = "aha",
					holdingText = "text...",
					callback = function(v) print(v) end
				}, options or {})

				local TextBox = {
					Hover = false
				}

				--//Render Textbox
				do
					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.TextBox
					TextBox["df"] = Instance.new("Frame", Section["a9"]);
					TextBox["df"]["BackgroundColor3"] = Color3.fromRGB(13, 18, 30);
					TextBox["df"]["Size"] = UDim2.new(1, 0, 0, 30);
					TextBox["df"]["ClipsDescendants"] = true;
					TextBox["df"]["Name"] = [[TextBox]];

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.TextBox.UICorner
					TextBox["e0"] = Instance.new("UICorner", TextBox["df"]);
					TextBox["e0"]["CornerRadius"] = UDim.new(0, 3);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.TextBox.UIStroke
					TextBox["e1"] = Instance.new("UIStroke", TextBox["df"]);
					TextBox["e1"]["Color"] = Color3.fromRGB(16, 36, 57);
					TextBox["e1"]["Thickness"] = 0.7;
					TextBox["e1"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.TextBox.Text
					TextBox["e2"] = Instance.new("TextLabel", TextBox["df"]);
					TextBox["e2"]["BorderSizePixel"] = 0;
					TextBox["e2"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					TextBox["e2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					TextBox["e2"]["TextSize"] = 11;
					TextBox["e2"]["TextColor3"] = Color3.fromRGB(231, 231, 231);
					TextBox["e2"]["Size"] = UDim2.new(1, 0, 1, 0);
					TextBox["e2"]["ClipsDescendants"] = true;
					TextBox["e2"]["Text"] = options.name;
					TextBox["e2"]["Name"] = [[Text]];
					TextBox["e2"]["Font"] = Enum.Font.GothamMedium;
					TextBox["e2"]["BackgroundTransparency"] = 1;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.TextBox.Text.UIStroke
					TextBox["e3"] = Instance.new("UIStroke", TextBox["e2"]);
					TextBox["e3"]["Thickness"] = 0.7;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.TextBox.UIPadding
					TextBox["e4"] = Instance.new("UIPadding", TextBox["df"]);
					TextBox["e4"]["PaddingRight"] = UDim.new(0, 16);
					TextBox["e4"]["PaddingLeft"] = UDim.new(0, 12);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.TextBox.TextBox
					TextBox["e5"] = Instance.new("TextBox", TextBox["df"]);
					TextBox["e5"]["PlaceholderColor3"] = Color3.fromRGB(179, 179, 179);
					TextBox["e5"]["TextColor3"] = Color3.fromRGB(192, 200, 240);
					TextBox["e5"]["TextSize"] = 11;
					TextBox["e5"]["BackgroundColor3"] = Color3.fromRGB(12, 16, 27);
					TextBox["e5"]["AnchorPoint"] = Vector2.new(0, 0.5);
					TextBox["e5"]["PlaceholderText"] = options.holdingText;
					TextBox["e5"]["Size"] = UDim2.new(0, 41, 1, -10);
					TextBox["e5"]["ClipsDescendants"] = true;
					TextBox["e5"]["Text"] = [[]];
					TextBox["e5"]["Position"] = UDim2.new(1, -36, 0.5, 0);
					TextBox["e5"]["Font"] = Enum.Font.Gotham;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.TextBox.TextBox.UICorner
					TextBox["e6"] = Instance.new("UICorner", TextBox["e5"]);
					TextBox["e6"]["CornerRadius"] = UDim.new(0, 3);

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.TextBox.TextBox.UIStroke
					TextBox["e7"] = Instance.new("UIStroke", TextBox["e5"]);
					TextBox["e7"]["Color"] = Color3.fromRGB(16, 36, 57);
					TextBox["e7"]["Thickness"] = 0.7;
					TextBox["e7"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.UIlib(3rd).MainFrame.ContentContainer.Section Farming.TextBox.TextBox.UIStroke
					TextBox["e8"] = Instance.new("UIStroke", TextBox["e5"]);
					TextBox["e8"]["Thickness"] = 0.7;
				end

				--//Methods
				do
					function TextBox:SetText(text)
						TextBox["e2"].Text = text
					end
				end

				--//Logic
				do
					TextBox["df"].MouseEnter:Connect(function()
						if Library:IsHoveringOnElemt(TextBox["df"]) then
							TextBox.Hover = true
							Library:tween(TextBox["e1"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
							Library:tween(TextBox["e7"], {Color = Color3.fromRGB(16+20, 36+20, 57+20)})
						end
					end)

					TextBox["df"].MouseLeave:Connect(function()
						TextBox.Hover = false
						Library:tween(TextBox["e1"], {Color = Color3.fromRGB(16, 36, 57)})
						Library:tween(TextBox["e7"], {Color = Color3.fromRGB(16, 36, 57)})
					end)
					
					TextBox["e5"].FocusLost:Connect(function(enterPressed)
						if enterPressed then
							options.callback(TextBox["e5"].Text)
						end
					end)
					
				end
				return TextBox
			end
			
			return Section
		end
		
		return Tab
	end
	
	return GUI
end

return Library
