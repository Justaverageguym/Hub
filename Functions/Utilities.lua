-- Utilities

local Uti = {}
local playerss = game:GetService("Players")
local client = playerss.LocalPlayer
local Runservice = game:GetService("RunService")

function Uti:fireproximityprompt(obj, amount, skip, range)
    if client.Character then
        if obj:IsA("ProximityPrompt") then
            if obj.Enabled then
                amount = amount or 1 
                range = range or obj.MaxActivationDistance
                local PromptTime = obj.HoldDuration
                if skip then 
                    obj.HoldDuration = 0
                end 
    
                for i = 1, amount do 
                    obj.MaxActivationDistance = range
                    obj.RequiresLineOfSight = false 
                    obj:InputHoldBegin()
                    if not skip then
                        obj.MaxActivationDistance = range
                        obj.RequiresLineOfSight = false 
                        wait(obj.HoldDuration)
                    end
                    obj:InputHoldEnd()
                end
                obj.HoldDuration = PromptTime
            end
        elseif obj:FindFirstChildOfClass("ProximityPrompt") then 
            if obj:FindFirstChildOfClass("ProximityPrompt").Enabled then 
                amount = amount or 1 
                range = range or obj:FindFirstChildOfClass("ProximityPrompt").MaxActivationDistance
                local PromptTime = obj:FindFirstChildOfClass("ProximityPrompt").HoldDuration
                if skip then 
                    obj:FindFirstChildOfClass("ProximityPrompt").HoldDuration = 0
                end 
    
                for i = 1, amount do 
                    obj:FindFirstChildOfClass("ProximityPrompt").MaxActivationDistance = range
                    obj:FindFirstChildOfClass("ProximityPrompt").RequiresLineOfSight = false
                    obj:FindFirstChildOfClass("ProximityPrompt"):InputHoldBegin()
                    if not skip then
                        obj:FindFirstChildOfClass("ProximityPrompt").MaxActivationDistance = range
                        obj:FindFirstChildOfClass("ProximityPrompt").RequiresLineOfSight = false
                        wait(obj:FindFirstChildOfClass("ProximityPrompt").HoldDuration)
                    end
                    obj:FindFirstChildOfClass("ProximityPrompt"):InputHoldEnd()
                end
                obj:FindFirstChildOfClass("ProximityPrompt").HoldDuration = PromptTime
            
            end
        else 
            if obj == nil then
            end
        end
    end
end

function Uti:fireclickdetectorbt(obj, amount, range)
    if client.Character then
        if obj then
            amount = amount or 1 
            if obj:IsA("ClickDetector") then 
                range = range or obj.MaxActivationDistance
                for i = 1, amount do
                    obj.MaxActivationDistance = range
                    obj.MouseClick()
                end
            elseif obj:FindFirstChildOfClass("ClickDetector") then
                range = range or obj:FindFirstChildOfClass("ClickDetector").MaxActivationDistance
                for i = 1, amount do
                    obj:FindFirstChildOfClass("ClickDetector").MaxActivationDistance = range
                    obj:FindFirstChildOfClass("ClickDetector").MouseClick()
                end
            else 
                warn("Invalid Clickdetector")
            end
        else 
            warn("No object found <Object = nil>")
        end 
    end
end

function Uti:Firetouchinterestbt(objtouched, objwillgetotouch)
    if client.Character then
        if objtouched:FindFirstChildOfClass("TouchTransmitter") then
            firetouchinterest(objtouched, objwillgetotouch, 1)
            firetouchinterest(objtouched, objwillgetotouch, 0)
        elseif objtouched:IsA("TouchTransmitter") then 
            firetouchinterest(objtouched.Parent, objwillgetotouch, 1)
            firetouchinterest(objtouched.Parent, objwillgetotouch, 0)
        else 
            warn("Invalid TouchTransmitter")
        end
        else 
          repeat 
            wait() 
            until client.Character
    end
end

function Uti:Firetouchinterestinallchildren(ObjParent, objwillgetotouch)
        for _, v in pairs(ObjParent:GetChildren()) do
          if client.Character then
            if v:FindFirstChildOfClass("TouchTransmitter") then
                firetouchinterest(v, objwillgetotouch, 1)
                firetouchinterest(v, objwillgetotouch, 0)
            elseif v:IsA("TouchTransmitter") then 
                firetouchinterest(v.Parent, objwillgetotouch, 1)
                firetouchinterest(v.Parent, objwillgetotouch, 0)
            else 
                warn("Invalid TouchTransmitter")
            end
            else 
             repeat 
               wait()
            until client.Character
        end
    end
end

function Uti:magnitudecheck(TargetedPart, VictimPart)
    if client.Character then
        return math.floor((TargetedPart.Position - VictimPart.Position).Magnitude)
    end
end 

function Uti:Getpartattribute(part)
    if client.Character and part and part:GetAttributes() then
        for name, value in pairs(part:GetAttributes()) do
            print(name .. " = " .. value)
        end
    end
end

function Uti:SetAttribute(part, attributename, property)
    if client.Character and part then
        part:SetAttribute(attributename, property)
    end
end

function Uti:Gotopart(part,offsetx,offsety,offsetz)
  if client.Character and part then
  offsetx = offsetx or 0 
  offsety = offsety or 0 
  offsetz = offsetz or 0 
  client.Character:FindFirstChild("HumanoidRootPart").CFrame = part.CFrame * CFrame.new(offsetx,offdety,offsetz)
  end
end

function Uti:Bringpart(part,offsetx,offsety,offsetz)
  if client.Character and part then
  offsetx = offsetx or 0 
  offsety = offsety or 0 
  offsetz = offsetz or 0 
  part.CFrame = client.Character:FindFirstChild("HumanoidRootPart").CFrame  * CFrame.new(offsetx,offdety,offsetz)
  end
end

function Uti:Gotomodel(model,offsetx,offsety,offsetz)
  if client.Character and model then
  offsetx = offsetx or 0 
  offsety = offsety or 0 
  offsetz = offsetz or 0 
  client.Character:FindFirstChild("HumanoidRootPart").CFrame = model:GetPivot() * CFrame.new(offsetx,offdety,offsetz)
  end
end

function Uti:Bringmodel(model,offsetx,offsety,offsetz)
  if client.Character and model then
  offsetx = offsetx or 0 
  offsety = offsety or 0 
  offsetz = offsetz or 0 
  model:PivotTo(client.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(offsetx,offdety,offsetz))
  end
end

function Uti:Serverhop()
    if client.Character then
        local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()
        while true do
            module:Teleport(game.PlaceId)
            wait(.1)
        end
    end
end

function Uti:Joingame(gameid)
    if client.Character then
        while true do
            game:GetService("TeleportService"):Teleport(tonumber(gameid), client)
            wait(.1)
        end
    end
end

function Uti:Rejoin()
    if client.Character then
        while true do
            game:GetService("TeleportService"):Teleport(game.PlaceId, client)
            wait(.1)
        end
    end
end 

function Uti:FpsUnlocker(num)
   setfpscap(num)
end

function Uti:CpuGpusaver(toggle)
        Uti:FpsUnlocker(360)
        Runservice:Set3dRenderingEnabled(toggle == true and false or toggle == false and true)
end

function Uti:GetClosestPlayerToPart(with)
    if client.Character then
        local closestPlayer = nil
        local closestMagnitude = math.huge

        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= client and v.Character then
                local magnitude = Uti:magnitudecheck(v.Character:FindFirstChild("HumanoidRootPart"), with)
                if magnitude < closestMagnitude then
                    closestMagnitude = magnitude
                    closestPlayer = v
                end
            end
        end

        return closestPlayer
    end
end


function Uti:ClientWalkspeed(num)
    if client.Character then
     local gmt = getrawmetatable(game)
        setreadonly(gmt, false)
        local oldindex = gmt.__index
        gmt.__index = newcclosure(function(self, b)
            if b == "WalkSpeed" then
                return 16
            end
            return oldindex(self, b)
        end)
        client.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = num
    end
end

function Uti:ClientJumpPower(num)
    if client.Character then
    local gmt = getrawmetatable(game)
        setreadonly(gmt, false)
        local oldindex = gmt.__index
        gmt.__index = newcclosure(function(self, b)
            if b == "JumpPower" then
                return 50
            end
            return oldindex(self, b)
        end)
        client.Character:FindFirstChildOfClass("Humanoid").JumpPower = num
    end
end

 
local fbh,oldbn, oldfog, oldExposureCompensation, oldglobalshadow
function Uti:FullBright(toggle)
    if toggle then
        oldbn = game:GetService("Lighting").Brightness
        oldfog = game:GetService("Lighting").FogEnd
        oldExposureCompensation = game:GetService("Lighting").ExposureCompensation
        oldglobalshadow = game:GetService("Lighting").GlobalShadows

        game:GetService("Lighting").ExposureCompensation = 2
        game:GetService("Lighting").FogEnd = 9999999
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").GlobalShadows = 0

        fbh = game:GetService("Lighting").Changed:Connect(function(property)
            if property == "Brightness" and game:GetService("Lighting").Brightness ~= 1 then
                game:GetService("Lighting").Brightness = 1
            elseif property == "FogEnd" and game:GetService("Lighting").FogEnd ~= 9999999 then
                game:GetService("Lighting").FogEnd = 9999999
            elseif property == "GlobalShadows" and game:GetService("Lighting").GlobalShadows ~= 0 then
                game:GetService("Lighting").GlobalShadows = 0
            elseif property == "ExposureCompensation" and game:GetService("Lighting").ExposureCompensation ~= 2 then
                game:GetService("Lighting").ExposureCompensation = 2
            end
        end)
    else
        if fbh then 
          fbh:Disconnect()
          fbh = nil 
         end
        game:GetService("Lighting").ExposureCompensation = oldExposureCompensation
        game:GetService("Lighting").FogEnd = oldfog
        game:GetService("Lighting").Brightness = oldbn
        game:GetService("Lighting").GlobalShadows = oldglobalshadow
    end
end


function Uti:FpsBooster()
  Uti:FpsUnlocker(200)
   for _,v in next,game:GetService("Workspace"):GetDescendants() do
    if v and v:IsA("Model") then
      v.LevelOfDetail = "Disabled"
      v.ModelStreamingMode = "Nonatomic"
    elseif v and (v:IsA("BasePart") and not v:IsA("MeshPart")) then
      v.CastShadow = false
      v.Material = "Plastic"
      v.Reflectance = 0 
      v.MaterialVariant = ""
    elseif v and (v:IsA("Decal") or v:IsA("Texture")) then 
      v.Transparency = 1
    elseif v and v:IsA("MeshPart") then 
      v.CastShadow = false
      v.DoubleSided = false
      v.RenderFidelity = "Performance"
      v.TextureID = 10385902758728957
    elseif v and v:IsA("SpecialMesh") then 
      v.TextureId = 0
    elseif v and v:IsA("ShirtGraphic") then 
      v.Graphic = 0
    elseif v and (v:IsA("Shirt") or v:IsA("Pants")) then 
     v[v.ClassName.."Template"] = 0
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
     v.Enabled = false   
    elseif v:IsA("Explosion") then
     v.BlastPressure = 1
     v.BlastRadius = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
     v.Enabled = false
    elseif v and v:IsA("Beam") then 
     v.Enabled = false
    elseif v and v:IsA("SurfaceAppearance") then
      v:Destroy()
    elseif v and v:IsA("Debris") then 
      v:Destroy()
    elseif v and v:IsA("Attachment") then 
      v.Visible = false
   elseif v and v:IsA("MaterialVariant") then 
    v:Destroy()
      end
    end
   for _,v in next,game:GetService("Lighting"):GetDescendants() do 
     if v and (v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("Clouds") or v:isA("PostEffect") or v:IsA("ColorCorrectionEffect")) then 
       v:Destroy()
    end
   end
   sethiddenproperty(game:GetService("Lighting"),"Technology",2)
   game:GetService("Lighting").GlobalShadows = 0
   game:GetService("Lighting").FogEnd = 9e9
   game:GetService("Lighting").Brightness = 0
   sethiddenproperty(game:GetService("Workspace"):FindFirstChildOfClass("Terrain"),"Decoration",false)
   game:GetService("Workspace"):FindFirstChildOfClass("Terrain").WaterReflectance = 0 
   game:GetService("Workspace"):FindFirstChildOfClass("Terrain").WaterTransparency = 0.7
   game:GetService("Workspace"):FindFirstChildOfClass("Terrain").WaterWaveSize = 0
   game:GetService("Workspace"):FindFirstChildOfClass("Terrain").WaterWaveSpeed = 0
   game:GetService("Lighting").ChildAdded:Connect(function(addedshit)
     spawn(function()
     v:Destroy()
     end)
   end)
   game:GetService("Workspace").DescendantAdded:Connect(function(addedshit)
     spawn(function()
       if addedshit:IsA("Model") then
      addedshit.LevelOfDetail = "Disabled"
      addedshit.ModelStreamingMode = "Nonatomic"
    elseif (addedshit:IsA("BasePart") and not addedshit:IsA("MeshPart")) then
      addedshit.CastShadow = false
      addedshit.Material = "Plastic"
      addedshit.Reflectance = 0 
      addedshit.MaterialVariant = ""
    elseif (addedshit:IsA("Decal") or addedshit:IsA("Texture")) then 
      addedshit.Transparency = 1
    elseif addedshit:IsA("MeshPart") then 
      addedshit.CastShadow = false
      addedshit.DoubleSided = false
      addedshit.RenderFidelity = "Performance"
      addedshit.TextureID = 10385902758728957
    elseif addedshit:IsA("SpecialMesh") then 
      addedshit.TextureId = 0
    elseif addedshit:IsA("ShirtGraphic") then 
      addedshit.Graphic = 0
    elseif (addedshit:IsA("Shirt") or addedshit:IsA("Pants")) then 
     addedshit[addedshit.ClassName.."Template"] = 0
    elseif addedshit:IsA("Fire") or addedshit:IsA("SpotLight") or addedshit:IsA("Smoke") or addedshit:IsA("Sparkles") then
     addedshit.Enabled = false   
    elseif addedshit:IsA("Explosion") then
     addedshit.BlastPressure = 1
     addedshit.BlastRadius = 1
    elseif addedshit:IsA("ParticleEmitter") or addedshit:IsA("Trail") then
     addedshit.Enabled = false
    elseif addedshit:IsA("Beam") then 
     addedshit.Enabled = false
    elseif addedshit:IsA("SurfaceAppearance") then
      addedshit:Destroy()
    elseif addedshit:IsA("Debris") then 
      addedshit:Destroy()
    elseif addedshit:IsA("Attachment") then 
      addedshit.Visible = false
    elseif addedshit:IsA("MaterialVariant") then 
    addedshit:Destroy()
         end
       end)
     end)
  end
return Uti
