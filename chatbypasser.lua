local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Chat = game:GetService("Chat")

local printingcons = printconsole or consoleprint or function(a)end -- or warn
printingcons("Chat Bypasser made by BitProxy.")
printingcons("Rip, BitProxy (Terminated)")

local create = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/BitProxy/Studio-Scripts/main/create.lua"))()
local ChatRemotes = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")

local MainBypassUi = create.createInstance("ScreenGui", {
	Name = "RolboxGui",
	DisplayOrder = 7,
	Parent = CoreGui:FindFirstChild("RobloxGui"),
})
local MainFrame = create.createInstance("Frame", {
	Name = "Main",
	Active = true,
	Draggable = true,
	BackgroundColor3 = Color3.fromRGB(46, 46, 46),
	BorderSizePixel = 0,
	Position = UDim2.new(0, 50, 0, 50),
	Size = UDim2.new(0, 400, 0, 350),
	Parent = MainBypassUi,
})
local CornerUi = create.createInstance("UICorner", {
	Parent = MainFrame,
})
local ScriptTitle = create.createInstance("TextLabel", {Name = "ScriptTitle", Parent = MainFrame, Text = "Chat Bypasser [0.1.5]", Font = Enum.Font.GothamBold, BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 0, 35), TextScaled = true})
local Line = create.createInstance("Frame", {Parent = ScriptTitle, Name = "Line", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 0, 2), Position = UDim2.new(0, 0, 1, 0)})
local BypassFrame = create.createInstance("Frame", {Name = "Bypass", Parent = MainFrame, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -37), Position = UDim2.new(0, 0, 0, 37)})
local Desc = create.createInstance("TextLabel", {Name = "Description", Parent = BypassFrame, BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 136), Size = UDim2.new(0, 400, 0, 15), Font = Enum.Font.Gotham, Text = "Adds more keys (not perfect)", TextColor3 = Color3.fromRGB(170, 50, 50), TextSize = 14})
local InputTextBox = create.createInstance("TextBox", {
	Name = "Input",
	Parent = BypassFrame,
	BackgroundColor3 = Color3.fromRGB(63, 63, 63),
	Position = UDim2.new(0, 25, 0, 200),
	Size = UDim2.new(0, 350, 0, 45),
	Font = Enum.Font.GothamBold,
	PlaceholderText = "Input",
	Text = "",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextScaled = true,
})
create.createInstance("UICorner", {CornerRadius = UDim.new(0, 2), Parent = InputTextBox})
function createStatus(data)
	local Colours = {
		[true] = Color3.fromRGB(125, 255, 100),
		[false] = Color3.fromRGB(200, 50, 25),
	}
	local TextLabel = create.createInstance("TextLabel", {
		Name = "TextToggle",
		Parent = BypassFrame,
		BackgroundTransparency = 1,
		Text = data.txt,
		TextSize = 28,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.new(0, 200, 0, 30),
		Position = data.pst,
		Font = Enum.Font.Gotham,
	})
	local TextButton = create.createInstance("TextButton", {
		Name = "Toggle",
		Parent = BypassFrame,
		BackgroundColor3 = Colours[data.iso] or Color3.fromRGB(200, 50, 25),
		Text = "",
		Size = UDim2.new(0, 35, 0, 25),
		Position = UDim2.new(0, 350, 0, data.pst.Y.Offset),
	})
	create.createInstance("UICorner", {CornerRadius = UDim.new(0, 2), Parent = TextButton})
	return TextButton
end
local status1 = createStatus({txt = "Auto Review", pst = UDim2.new(0, 0, 0, 4), iso = true})
local status2 = createStatus({txt = "Auto Send", pst = UDim2.new(0, 0, 0, 38), iso = true})
local status3 = createStatus({txt = "Toggle '⁥К'", pst = UDim2.new(0, 0, 0, 72), iso = true})
local status4 = createStatus({txt = "Alt Keys", pst = UDim2.new(0, 0, 0, 106), iso = false})

local CreditsOpened = false
local TweenProcessing = false
local CustomChatTo = "All"

local AutomaticallySend = true
local AutomaticallyReview = true
local ToggleKeyK = true
local AutomaticallyKick = false


if game.PlaceId == 142823291 then
	CustomChatTo = "normalchat"
end

function getchars()
	local str = string.rep("\226\129\165", 4)
	return str
end

function byted(char)
	local s = string.byte(char, 1, 1)
	return tostring(s)
end

-- KEYs: E, e, O, o, H, x, A, a, M, N, T, s, c, p

local BYTES = {
	-- Uppercase
	["65"] = "\208\144"; -- A
	["66"] = "\208\146"; -- B
	["67"] = "\208\161"; -- C
	["69"] = "\208\149"; -- E
	["72"] = "\208\157"; -- H
	["77"] = "\208\156"; -- M
	["73"] = "\208\134"; -- I
	["74"] = "\208\136"; -- J
	["79"] = "\208\158"; -- O
	["83"] = "\208\133"; -- S
	["80"] = "\208\160"; -- P
	["89"] = "\210\174"; -- Y
	["84"] = "\208\162"; -- T
	["88"] = "\208\165"; -- X
	-- Lowercase
	["101"] = "\208\181"; -- e
	["111"] = "\208\190"; -- o
	["120"] = "\209\133"; -- x
	["97"] = "\208\176"; -- a
	["115"] = "\209\149"; -- s
	["99"] = "\209\129"; -- c
	["112"] = "\209\128"; -- p
	["121"] = "\209\131"; -- y
}

local ALTSBYTES = {
	-- Uppercase
	["85"] = "\195\154"; -- U
	["78"] = "\195\145"; -- N
	["70"] = "\210\146"; -- F
	["86"] = "\209\180"; -- U
	["81"] = "\212\154"; -- Q
	["71"] = "\212\140"; -- G
	["87"] = "\212\156"; -- W
	-- Lowercase
	["119"] = "\212\157"; -- w
	["113"] = "\212\155"; -- q
	["105"] = "\195\173"; -- i
	["110"] = "\195\177"; -- n
	["117"] = "\195\185"; -- u
	["114"] = "\208\179"; -- r
	-- Numbers
	["51"] = "\208\151"; -- 3
}

function returnBypassMethod(str)
	local REAL = ""
	for i = 1, string.len(str) do
		local newChar = string.sub(str, i, i)
		local byte = byted(newChar)
		if BYTES[byte] ~= nil then
			newChar = BYTES[byte]
		end
		if ToggleKeyK then
			if byte == "75" then -- K
				newChar = "\208\154"
			end
		end
		if AutomaticallyKick then
			if ALTSBYTES[byte] ~= nil then
				newChar = ALTSBYTES[byte]
			end
		end
		REAL = REAL .. getchars() .. newChar
	end
	return REAL
end

function RequestMessage(msg)
	if string.len(msg) > 200 then
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "{Script}: Your message may not be sent due to the amount of characters. Max Limit Characters: <200\nUnder 201 characters.",
			Color = Color3.fromRGB(200, 50, 25),
			Font = Enum.Font.Arial,
			FontSize = Enum.FontSize.Size24
		})
	end
	ChatRemotes.SayMessageRequest:FireServer(msg, CustomChatTo)
	if string.sub(Chat:FilterStringForBroadcast(msg, Players.LocalPlayer), 1, 6) == "######" then
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "{Script}: Your message has been moderated. Don't worry, you cannot be banned from the report system.",
			Color = Color3.fromRGB(200, 50, 25),
			Font = Enum.Font.Arial,
			FontSize = Enum.FontSize.Size24
		})
	end
end

-- Roles

local t = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

function tween(z,s,f)
	local renderingFunc = coroutine.wrap(function()
		local Creation = TweenService:Create(z,s,f)
		pcall(Creation.Play, Creation)
		wait(s.Time)
		for index, value in pairs(f)do
			z[index] = value
		end
	end)
	renderingFunc()
end

status1.AutoButtonColor = false
status2.AutoButtonColor = false
status3.AutoButtonColor = false
status4.AutoButtonColor = false

local TweenProcessing3 = false
local TweenProcessing2 = false
local TweenProcessing1 = false
local TweenProcessing0 = false

status1.MouseButton1Click:Connect(function()
	if TweenProcessing0 == true then return end
	TweenProcessing0 = true
	if AutomaticallyReview == true then
		tween(status1, t, {
			BackgroundColor3 = Color3.fromRGB(200, 50, 25)
		})
		AutomaticallyReview = false
		wait(0.4)
	else
		tween(status1, t, {
			BackgroundColor3 = Color3.fromRGB(125, 255, 100)
		})
		AutomaticallyReview = true
		wait(0.4)
	end
	TweenProcessing0 = false
end)

status2.MouseButton1Click:Connect(function()
	if TweenProcessing1 == true then return end
	TweenProcessing1 = true
	if AutomaticallySend == true then
		tween(status2, t, {
			BackgroundColor3 = Color3.fromRGB(200, 50, 25)
		})
		AutomaticallySend = false
		wait(0.4)
	else
		tween(status2, t, {
			BackgroundColor3 = Color3.fromRGB(125, 255, 100)
		})
		AutomaticallySend = true
		wait(0.4)
	end
	TweenProcessing1 = false
end)

status3.MouseButton1Click:Connect(function()
	if TweenProcessing2 == true then return end
	TweenProcessing2 = true
	if ToggleKeyK == true then
		tween(status3, t, {
			BackgroundColor3 = Color3.fromRGB(200, 50, 25)
		})
		ToggleKeyK = false
		wait(0.4)
	else
		tween(status3, t, {
			BackgroundColor3 = Color3.fromRGB(125, 255, 100)
		})
		ToggleKeyK = true
		wait(0.4)
	end
	TweenProcessing2 = false
end)

status4.MouseButton1Click:Connect(function()
	if TweenProcessing3 == true then return end
	TweenProcessing3 = true
	if AutomaticallyKick == true then
		tween(status4, t, {
			BackgroundColor3 = Color3.fromRGB(200, 50, 25)
		})
		AutomaticallyKick = false
		wait(0.4)
	else
		tween(status4, t, {
			BackgroundColor3 = Color3.fromRGB(125, 255, 100)
		})
		AutomaticallyKick = true
		wait(0.4)
	end
	TweenProcessing3 = false
end)

InputTextBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		if InputTextBox.Text == '' then return end
		if not AutomaticallySend then return end
		if not AutomaticallyReview then
			return RequestMessage(InputTextBox.Text)
		end
		local msg = returnBypassMethod(InputTextBox.Text)
		return RequestMessage(msg)
	end
end)

ret = function(str)
	local tab = ""
	for i,v in pairs({string.byte(str, 1, string.len(str))}) do
		tab = tab.."\\"..v
	end
	return tab
end

function imp()
	getgenv().deleteui = function()
		create.RemoveInstance(MainBypassUi)
	end
end

pcall(imp)
