local DataModel = game;
repeat DataModel = game wait() until DataModel ~= nil

local RunService = DataModel:GetService("RunService")
local Workspace = DataModel:GetService("Workspace")
local Lighting = DataModel:GetService("Lighting")
local Terrain = Workspace:WaitForChild("Terrain")

local function Render()
  RunService.Heartbeat:Wait()
end

Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = false
Lighting.FogEnd = math.huge

function Simplify(part)
  if part:IsA("BasePart") then
    part.Material = "SmoothPlastic"
    part.Reflectance = 0
  elseif part:IsA("BlurEffect") or part:IsA("BloomEffect") or part:IsA("ColorCorrectionEffect") or part:IsA("DepthOfFieldEffect") or part:IsA("SunRaysEffect") then
    part.Enabled = false
  elseif part:IsA("Explosion") then
    part.Visible = false
  elseif part:IsA("Fire") or part:IsA("Smoke") or part:IsA("Sparkles") or part:IsA("ForceField") then
    Render()
    part:Destroy()
  end
end

for index, descendant in pairs(DataModel:GetDescendants()) do
  Simplify(descendant)
end
DataModel.DescendantAdded:Connect(Simplify)
