-- Universal Aim Assist Script (Delta-Compatible)
-- Educational use only

local plrs = game:GetService("Players")
local cam = workspace.CurrentCamera
local lp = plrs.LocalPlayer
local rs = game:GetService("RunService")

local function getClosest()
    local closest, dist = nil, math.huge
    for _, p in ipairs(plrs:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head.Position
            local scr, onScr = cam:WorldToViewportPoint(head)
            if onScr then
                local d = (Vector2.new(scr.X, scr.Y) - Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)).Magnitude
                if d < dist then
                    dist = d
                    closest = p
                end
            end
        end
    end
    return closest
end

rs.RenderStepped:Connect(function()
    local t = getClosest()
    if t and t.Character and t.Character:FindFirstChild("Head") then
        cam.CFrame = CFrame.new(cam.CFrame.Position, t.Character.Head.Position)
    end
end)
