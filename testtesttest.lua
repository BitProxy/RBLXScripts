error("Check at another time.", 7)

-- ChatBypasser Ui For now.
-- Version: 0.3.5
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatRemotes = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local cvers = "0.3.5"
local amountinvis = 4

local LibUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local WinUi = LibUi.CreateLib("Chat Bypasser " .. cvers, "DarkTheme")
local MainTab = WinUi:NewTab("Main")
local BypassSettings = MainTab:NewSection("Bypass Settings")
local MainMain = MainTab:NewSection("Chat")

local CreditsOpened = false
local TweenProcessing = false
local CustomChatTo = "All"

local AutomaticallySend = true
local AutomaticallyReview = true
local ToggleAltKeys = false
local IgnoreCharacters = false

BypassSettings:NewToggle("Review Message", "Changes the message to a bypassed way, toggle.", function(val)
  AutomaticallyReview = val
end)

BypassSettings:NewToggle("Use More Characters", "Uses more spanish keys, etc.", function(val)
  ToggleAltKeys = val
end)

BypassSettings:NewSlider("Invisible Characters", "Adjusts the amount of invisible characters should be between each character.", 5, 2, function(val)
  amountinvis = tonumber(val) or 2
end)

if game.PlaceId == 142823291 then
	CustomChatTo = "normalchat"
end

function getchars()
	local str = string.rep("\226\129\165", amountinvis)
	return str
end

function byted(char)
	local s = {}
	for index, value in pairs({string.byte(char, 1, string.len(char))}) do
		table.insert(s, tostring(value))
	end
	return s
end

local BYTES = {
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
	["85"] = "\195\154"; -- U
	["78"] = "\195\145"; -- N
	["70"] = "\210\146"; -- F
	["86"] = "\209\180"; -- U
	["81"] = "\212\154"; -- Q
	["71"] = "\212\140"; -- G
	["87"] = "\212\156"; -- W
	["75"] = "\208\154"; -- K
	["103"] = "\196\161"; -- g
	["119"] = "\212\157"; -- w
	["113"] = "\212\155"; -- q
	["105"] = "\195\173"; -- i
	["110"] = "\195\177"; -- n
	["117"] = "\195\185"; -- u
	["114"] = "\208\179"; -- r
	["51"] = "\208\151"; -- 3
}
local ignoreBytes = {"33", "64", "35", "36", "37", "94", "38", "42", "40", "41", "124", "123", "125", "91", "93", "58", "59", "47", "92", "62", "60", "63", "126", "96", "45", "95", "43", "61"}
function returnBypassMethod(str)
	local REAL = ""
	for i = 1, string.len(str) do
		local newChar = string.sub(str, i, i)
		local byte = byted(newChar)[1]
		if BYTES[byte] ~= nil then
			newChar = BYTES[byte]
		end
		if ToggleAltKeys then
			if ALTSBYTES[byte] ~= nil then
				newChar = ALTSBYTES[byte]
			end
		end
		if IgnoreCharacters == true then
			if ignoreBytes[byte] == nil then
				REAL = REAL .. getchars() .. newChar
			else
				REAL = REAL .. newChar
			end
		else
			REAL = REAL .. getchars() .. newChar
		end
	end
	return REAL
end

function RequestMessage(msg)
	ChatRemotes.SayMessageRequest:FireServer(msg, CustomChatTo)
end

MainMain:NewTextBox("Chat Here", "Makes you chat something (safely)", function(text)
  if text == "" then return end
  if AutomaticallyReview then
    local c = returnBypassedMethod(text)
    return RequestMessage(c)
  end
  RequestMessage(text)
end)
