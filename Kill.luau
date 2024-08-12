local teddy = script.Parent
local humanoid = teddy.Monster

local jumpscaring = false

local animation = script.Parent.Animator:WaitForChild('Normal')

local function getHumPos()
	return (teddy.HumanoidRootPart.Position)
end

local function attack(target, teddyPart)
		local distance = (teddyPart.Position - getHumPos()).Magnitude
	if distance < 6 and game.Players:GetPlayerFromCharacter(target) then
			if jumpscaring == false then
				jumpscaring = true
				local plr = game.Players:GetPlayerFromCharacter(target)
				-- jumpscare
				if plr.GettingChasedBy.Value == script.Parent then
					plr.GettingChased.Value = false
					plr.GettingChasedBy.Value = nil
				end
			script.Parent.Monster.WalkSpeed = 0
			game.ReplicatedStorage.AIScripts.Figure.Jumpscare:FireClient(plr)
			plr.Character.HumanoidRootPart.CFrame = script.Parent.TeleportPosition.CFrame
			script.Parent.Reached:Fire()
				plr.Character.HumanoidRootPart.CFrame = script.Parent.TeleportPosition.CFrame
				wait(.2) -- giving it a break
			plr.Character.Humanoid.WalkSpeed = 0
			wait(.2)
			plr.Character.HumanoidRootPart.Anchored = true
			local Jumpscareanim = script.Parent.Jumpscare
			script.Parent.Monster:LoadAnimation(Jumpscareanim):Play()
			local Jumpscareanimplr = script.Parent.PlayerJumpscare
			plr.Character.Humanoid:LoadAnimation(Jumpscareanimplr):Play()
				script.Parent.Monster.WalkSpeed = 0
				script.Parent["JJ's AI V1 Figure"].Disabled = true
				wait(6)
			script.Parent.Monster.WalkSpeed = 8
			plr.Character.HumanoidRootPart.Anchored = false
			script.Parent["JJ's AI V1 Figure"].Disabled = false
				script.Parent.Chasing.Value = false
				wait(2)
				jumpscaring = false
			else
				print("e")
		end
	end
end

script.Parent.Reached.Event:Connect(function(target)
		if jumpscaring == false then
			if target.Character then
				if target.Character.Humanoid.Health > 0 then
					-- target.Character.Humanoid.Health = 0
					jumpscaring = true
					local plr = target
					-- jumpscare
					if plr.GettingChasedBy.Value == script.Parent then
						plr.GettingChased.Value = false
						plr.GettingChasedBy.Value = nil
				end
				game.ReplicatedStorage.AIScripts.Freddy.Jumpscare:FireClient(plr)
					plr.Character.HumanoidRootPart.CFrame = script.Parent.TeleportPosition.CFrame
					wait(.2) -- giving it a break
					plr.Character.Humanoid.WalkSpeed = 0
					wait(.2)
				script.Parent.Monster.WalkSpeed = 0
				wait(2)
				plr.Character.HumanoidRootPart.Anchored = true
				wait(.2)
				plr.Character.HumanoidRootPart.CFrame = script.Parent.TeleportPosition.CFrame
				script.Parent["JJ's AI V1 Figure"].Disabled = true
					wait(6)
				script.Parent.Monster.WalkSpeed = 8
				plr.Character.HumanoidRootPart.Anchored = false
				script.Parent["JJ's AI V1 Figure"].Disabled = false
					script.Parent.Chasing.Value = false
				jumpscaring = false
				end
			end
		else
			print("e")
		end
end)
local function detection(part, teddyPart)
	if part.Parent:FindFirstChild("Humanoid") then
		local character = part.Parent
		if game.Players:GetPlayerFromCharacter(character) then
			--Check the player is still alive (And it's not our own character)
			if character.Humanoid.Health > 0 and character ~= teddy then
				attack(character, teddyPart)
			end
		end
	end
end

for i,v in pairs(script.Parent:GetDescendants()) do
	if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
		if not string.find(v.Name, "cloth") then
			v.Touched:Connect(function(hit)
				detection(hit, v)
			end)
		end
	end
end
