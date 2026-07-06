--!strict
--!optimize 2

game:GetService("Players").PlayerAdded:Connect(function(player) --Connects specified function when player joins.
	player.CharacterAdded:Connect(function() --Connects specified function when player's character is loaded.
		local character = workspace:WaitForChild(player.Name) --We can now refer to the player's character as "character".
		for i, v:Instance in pairs(character:GetChildren()) do --Gets all of character's children.
			if v:IsA("Part") or v:IsA("MeshPart") then --If a found child is a part or mesh, then
				v.Transparency = 1 --Set transparency to said child to 1
			elseif v:IsA("Accessory") then --If a found child is an accessory, then
				local handle:BasePart = v:FindFirstChild("Handle")::BasePart
				
				if handle then
					handle.Transparency = 1 --Set transparency of first child of accessory named "Handle" to 1
				end
			end
		end
		
		local head = character:WaitForChild("Head")
		
		if head then
			local decal = head:FindFirstChildOfClass("Decal")
			
			if decal then
				decal:Destroy()
			end
		end
	end)
end)
