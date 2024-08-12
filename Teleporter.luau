local npcIsStuck = false
local stuckAmount = 0
local lastPosition

local root = script.Parent.HumanoidRootPart

function FindClose()
	local waypoints = script.Parent.Parent.LoopPoints:GetChildren()
	local closest = nil
	local distance = 50
	for _,Waypoint in pairs(waypoints) do
		if (Waypoint.Position-root.Parent.HumanoidRootPart.Position).Magnitude < distance then
			closest = Waypoint
			distance = (Waypoint.Position-root.Parent.HumanoidRootPart.Position).Magnitude
		end
	end
	if closest ~= nil then
		root.Parent.Monster:MoveTo(closest.Position)
	end
end

spawn(function()
	while root.Parent do
		lastPosition = root.Position
		wait(1) -- check interval
		if (lastPosition - root.Position).magnitude < 1 then 
			print("not moving")
			stuckAmount += 1
			if stuckAmount == 1 then
				if script.Parent.Jumpscaring.Value == true then
					print("Jumpscaring, Will not move.")
				else
					print("teleported")
					FindClose()
					script.Parent.Teleport:Fire()
				end
			end
		else
			stuckAmount = 0
			npcIsStuck = false
		end
	end
end)
