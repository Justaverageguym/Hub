repeat 
  wait() 
  until game:IsLoaded()
task.spawn(function()
setfpscap(999)
-- Library
_G.RayfieldTheme = "Red"
local rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Justaverageguym/Hub/main/Ea.lua"))()
-- Variables
local ws = game:GetService("Workspace")
local pls = game:GetService("Players")
local cl = pls.LocalPlayer
local rs = game:GetService("RunService")

task.spawn(function()
local Window = rayfield:CreateWindow({
   Name = "Undertale simulator",
   LoadingTitle = "......",
   LoadingSubtitle = "by Sirius",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "Nozz method of obtaining the key is provided",
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
local Tab = Window:CreateTab("Main", 4483362458) 
local Section = Tab:CreateSection("Main")
local autoclicker,autoclick,autoopen,autopenselected,autopopen,egglist,hatchshitidk = nil,nil,nil,nil,nil,"None",nil,{"None"},"Single"
local Toggle = Tab:CreateToggle({
   Name = "Auto-click",
   CurrentValue = false,
   Flag = "Autoclick", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
    autoclicker = Value 
  if autoclicker then 
   autoclick = rs.Heartbeat:Connect(function()
    task.spawn(function()
      game:GetService("ReplicatedStorage").Remotes.Clicker:FireServer()
      end)
   end)
  else 
    if autoclick then
      autoclick:Disconnect() 
      autoclick = nil 
     end
    end
   end,
})

task.spawn(function()
for _,v in pairs(ws.Map.Eggs:GetChildren()) do 
 if v:IsA("Model") then
  table.insert(egglist,v.Name)
 end
end
end)
local Dropdown = Tab:CreateDropdown({
   Name = "Eggs list",
   Options = egglist,
   CurrentOption = egglist[1],
   Flag = "es", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Option)
     autopenselected = Option
   end,
})
local Dropdown = Tab:CreateDropdown({
   Name = "(Idk what to name it)",
   Options = {"Single","Triple"},
   CurrentOption = "Single",
   Flag = "eKey", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Option)
     hatchshitidk = Option
   end,
})
local Toggle = Tab:CreateToggle({
   Name = "AutoOpen selected egg",
   CurrentValue = false,
   Flag = "Autopen", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
    autoopen = Value 
  if autoopen then 
   autopopen = rs.Stepped:Connect(function()
    task.spawn(function()
  if autopenselected ~= "None" then
    local args = {
        [1] = tostring(autopenselected),
        [2] = hatchshitidk == "Single" and 1 or hatchshitidk == "Triple" and 3
      }

game:GetService("ReplicatedStorage").Remotes.Egg:InvokeServer(unpack(args))
        end
      end)
   end)
  else 
    if autopopen then
      autopopen:Disconnect() 
      autopopen = nil 
     end
    end
   end,
})
local Button = Tab:CreateButton({
   Name = "Free badges",
   Callback = function()
    task.spawn(function()
     for _,v in next,ws:GetDescendants() do 
       if v.Name == "Badge Giver (open me)" and v:IsA("BasePart") and v:FindFirstChildOfClass("TouchTransmitter") then 
        firetouchinterest(v,cl.Character:WaitForChild("HumanoidRootPart"),0)
        firetouchinterest(v,cl.Character:WaitForChild("HumanoidRootPart"),1)
      end
     end
    end)
   end,
})
 end)
end)
