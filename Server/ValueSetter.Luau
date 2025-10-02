local adjustValueEvent = game.ReplicatedStorage.AdjustValue
local timeScale = script.Parent.TimeScale
local sizeScale = script.Parent.SizeScale

adjustValueEvent.OnServerEvent:Connect(function(plr, Type, newValue)
	if Type == "Time" then
		timeScale.Value = newValue
	elseif Type == "Scale" then
		sizeScale.Value = newValue
	end
end)
