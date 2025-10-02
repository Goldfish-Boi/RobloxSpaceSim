game:GetService("Players").PlayerAdded:connect(function(player) --Connects specified function when player joins.
	player.CharacterAdded:connect(function() --Connects specified function when player's character is loaded.
		local character = workspace:WaitForChild(player.Name) --We can now refer to the player's character as "character".
		for i,v in pairs(character:children()) do --Gets all of character's children.
			if v:IsA("Part") or v:IsA("MeshPart") then --If a found child is a part or mesh, then
				v.Transparency = 1 --Set transparency to said child to 1
			elseif v:IsA("Accessory") then --If a found child is an accessory, then
				v:WaitForChild("Handle").Transparency = 1 --Set transparency of first child of accessory named "Handle" to 1
			end
		end
		character:WaitForChild("Head"):FindFirstChildOfClass("Decal"):Destroy() --Destroys decal in character's head
	end)
end)
