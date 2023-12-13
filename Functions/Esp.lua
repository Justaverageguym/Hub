local cam = workspace.CurrentCamera
local runservice = game:GetService("RunService")
local playersService = game:GetService("Players")

local cl = playersService.LocalPlayer

local EspObject = {}
EspObject.__index = EspObject

function EspObject.new(object, customName,customColor)
    local self = setmetatable({}, EspObject)
    self.Object = object
    self.CustomName = customName or object.Name or object.Parent.Name or "nil"
    self.CustomColor = customColor or Color3.fromRGB(0,255,0)
    self.Nametag = Drawing.new("Text")
    self.Nametag.Visible = false
    self.Nametag.Center = true
    self.Nametag.Outline = true
    self.Nametag.Font = 3
    self.Nametag.Color = self.CustomColor
    self.Nametag.OutlineColor = Color3.fromRGB(255,255,255)
    self.Nametag.Size = 19
    self.Nametag.Text = self.CustomName
    
    self.HowFarAway = Drawing.new("Text")
    self.HowFarAway.Visible = false
    self.HowFarAway.Center = true
    self.HowFarAway.Outline = true
    self.HowFarAway.Font = 3
    self.HowFarAway.Color = self.CustomColor
    self.HowFarAway.OutlineColor = Color3.fromRGB(255,255,255)
    self.HowFarAway.Size = 17
    self.HowFarAway.Text = "...M Away"
    return self
end

function EspObject:GetDistance()
    if self.Object and self.Object.Position and cl.Character and cl.Character:FindFirstChild("HumanoidRootPart") then
        return math.floor((self.Object.Position - cl.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude)
    else
        return -1
    end
end


function EspObject:Update()
    if not self.Object or not self.Object.Parent then
        self:NametagVisible(false)
        return
    end

    local onscreenPos, onscreen = cam:WorldToViewportPoint(self.Object.Position)

    if onscreen then
        self.HowFarAway.Position = Vector2.new(onscreenPos.X, onscreenPos.Y + 2)
        self.Nametag.Position = Vector2.new(onscreenPos.X, onscreenPos.Y - 10)
        self:NametagVisible(true)
        self.HowFarAway.Text = self:GetDistance() .. "M Away"
    else
        self:NametagVisible(false)
    end
end

function EspObject:NametagVisible(isVisible)
    if self.Object then
        self.Nametag.Visible = isVisible
        self.HowFarAway.Visible = isVisible

        if not isVisible and not self.Object then
            self:DisconnectRenderConnection()
        end
    else
        self.Nametag.Visible = false
        self.HowFarAway.Visible = false
        self:DisconnectRenderConnection()
    end
end

function EspObject:DisconnectRenderConnection()
    if self.RenderConnection then
        self.RenderConnection:Disconnect()
        self.RenderConnection = nil
    end

    if self.Nametag then
        self.Nametag:Remove()
    end

    if self.HowFarAway then
        self.HowFarAway:Remove()
    end
end

local Esp = {
    Components = {}
}

function Esp:CreateEspHandler(object, customName,Customcolor)
    local espObject = EspObject.new(object,customName,Customcolor)

    local objectRender = runservice.RenderStepped:Connect(function()
        espObject:Update()
    end)

    espObject.RenderConnection = objectRender
    self.Components[object] = espObject
end

function Esp:RemoveAllComponents()
    for _, espObject in pairs(self.Components) do
        espObject:DisconnectRenderConnection()
    end

    self.Components = {}
end

function Esp:CreateEsp(ObjectName, ObjectParent, Custom_name, Custom_Color)
    local function createEspForObject(obj)
        if obj:IsA("BasePart") then
            Esp:CreateEspHandler(obj, Custom_name, Custom_Color)
        end
    end

    for _, v in ipairs(ObjectParent:GetChildren()) do
        if not ObjectName or v.Name == ObjectName then
            createEspForObject(v)
        end
    end
end

return Esp
