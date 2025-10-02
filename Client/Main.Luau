local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")

local orbitModule = require(replicatedStorage.OrbitModule)
local dataModule = require(script.CelestialData)

local warnEvent = replicatedStorage.WarnEvent

local values = workspace.Values
local adjustValue = replicatedStorage.AdjustValue
local solarSystem = replicatedStorage.SolarSystem

local main = script.Parent
local gui = script.Parent.Frame.ScrollingFrame

local frame = gui.PlanetLoader
local input = frame.NameInput
local generate = frame.GenerateButton

local timeScale = gui.TimeScale
local timeInput = timeScale.NumberInput
local timeButton = timeScale.ReassignButton

local cameraLock = gui.CameraLock
local nameInput = cameraLock.NameInput
local lockOnButton = cameraLock.LockOnButton

local scale = gui.Scale
local scaleInput = scale.NameInput
local scaleButton = scale.LockOnButton

local lookAt = gui.LookAt
local nameInput2 = lookAt.NumberInput
local lookAtButton = lookAt.ReassignButton

local menuOpen = true
local debounce = false

workspace.Camera.CameraSubject = workspace.Centre

workspace.Camera.Changed:Connect(function()
	main.Zoom.Text = tostring(math.round((workspace.Camera.CFrame.Position - workspace.Camera.Focus.Position).Magnitude / 10) / 100) .. "% Zoom"
end)

main.Hide.MouseButton1Click:Connect(function()
	if debounce == true then return end
	
	if menuOpen == true then
		menuOpen = false
		
		debounce = true
		
		tweenService:Create(main.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.fromScale(-0.5, 0.5)}):Play()
		tweenService:Create(main.Hide, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.fromScale(0.025, 0.1)}):Play()
		
		main.Hide.Text = ">"
		
		task.wait(0.5)
		
		debounce = false
	elseif menuOpen == false then
		menuOpen = true
		
		debounce = true
		
		tweenService:Create(main.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.125, 0.5)}):Play()
		tweenService:Create(main.Hide, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.fromScale(0.25, 0.1)}):Play()
		
		main.Hide.Text = "<"
		
		task.wait(0.5)

		debounce = false
	end
end)

function load(input)
	print("Generating")
	
	if input == "Sun" then
		game.Lighting.Brightness = 0
	else
		game.Lighting.Brightness = 3
	end

	workspace.Camera:ClearAllChildren()

	print(dataModule[input .. "System"])

	if dataModule[input .. "System"] and solarSystem:FindFirstChild(input .. "System") then
		local systemModel = Instance.new("Model")
		systemModel.Parent = workspace.Camera
		systemModel.Name = input

		local part = Instance.new("Part")
		part.Name = "Centre"
		part.Position = Vector3.new(0, 0, 0)
		part.Size = Vector3.new(1, 1, 1)
		part.Anchored = true
		part.Transparency = 1
		part.CanCollide = false
		part.CanTouch = false
		part.CanQuery = false
		part.Parent = systemModel

		systemModel.PrimaryPart = part

		for i, object in pairs(dataModule[input .. "System"]) do
			task.spawn(function()
				print(object.Name)

				local orbitPoint

				local createdObject = solarSystem:FindFirstChild(input .. "System"):FindFirstChild(object.Name):Clone()
				createdObject.Parent = workspace.Camera:FindFirstChild(input)

				if object.Orbit then
					orbitPoint = Instance.new("Part")

					orbitPoint.Parent = workspace.Camera:FindFirstChild(input)
					orbitPoint.Position = Vector3.new(0, 0, 0)
					orbitPoint.Size = Vector3.new(1, 1, 1)
					orbitPoint.Orientation = Vector3.new(90 - object.Orbit.OrbitalAngle, 180, 180)
					orbitPoint.Anchored = true
					orbitPoint.Transparency = 1

					createdObject.Position = Vector3.new(object.Orbit.OrbitalDistance, 0, 0)

					orbitModule:CircularOrbit(createdObject, orbitPoint, object.Orbit.OrbitalPeriod, object.Orbit.Retrograde)
				elseif object.EOrbit then
					orbitPoint = Instance.new("Part")

					orbitPoint.Parent = workspace.Camera:FindFirstChild(input)
					orbitPoint.Position = Vector3.new(0, 0, 0)
					orbitPoint.Size = Vector3.new(1, 1, 1)
					orbitPoint.Orientation = Vector3.new(90 - object.EOrbit.OrbitalAngle, 180, 180)
					orbitPoint.CFrame = orbitPoint.CFrame*CFrame.Angles(0, 0, math.rad(object.EOrbit.ArguementOfPerhelion))
					orbitPoint.Transparency = 1

					local rotation = CFrame.Angles(0, math.rad(object.EOrbit.ArguementOfLongitude), 0)*orbitPoint.CFrame

					orbitPoint.CFrame = rotation

					orbitPoint.Anchored = true

					createdObject.Position = Vector3.new(object.EOrbit.SemiMajorAxis * (1 - object.EOrbit.Eccentricity), 0, 0)

					orbitModule:ProperEccentricOrbit(createdObject, orbitPoint, object.EOrbit.Eccentricity, object.EOrbit.OrbitalAngle, object.EOrbit.OrbitalPeriod, object.EOrbit.Retrograde)
				end

				if object.Rotation then
					if object.Orbit then
						if object.Rotation.TidallyLocked == true then
							orbitModule:TidalLocking(createdObject, orbitPoint, object.Orbit.TextureAdjustmentX, object.Orbit.TextureAdjustmentZ)
						else
							orbitModule:Rotation(createdObject, object.Rotation.RotationalPeriod, object.Rotation.RotationalAngle)
						end
					else
						orbitModule:Rotation(createdObject, object.Rotation.RotationalPeriod, 0)
					end
				end
			end)
		end

		systemModel:PivotTo(CFrame.new() * CFrame.Angles(math.rad(dataModule[input .. "System"][input].Rotation.RotationalAngle), 0, 0))
		systemModel:ScaleTo(workspace.Values.SizeScale.Value)
	else
		warnEvent:Fire("Planet not found, removing current planet. If you're trying to generate something check your spelling and capitalization.", 5)
	end
end

generate.MouseButton1Click:Connect(function()
	load(input.Text)
end)

timeButton.MouseButton1Click:Connect(function()
	if tonumber(timeInput.Text) then
		adjustValue:FireServer("Time", tonumber(timeInput.Text))
	else
		adjustValue:FireServer("Time", 1)
		warnEvent:Fire("Invalid time value.", 5)
	end
end)

lockOnButton.MouseButton1Click:Connect(function()
	if not workspace.Camera:FindFirstChildOfClass("Model") then
		warnEvent:Fire("Load something in before attempting to use camera functions", 5)
		return
	end
	
	if workspace.Camera:FindFirstChildOfClass("Model"):FindFirstChild(nameInput.Text, true) then
		workspace.Camera.CameraSubject = workspace.Camera:FindFirstChildOfClass("Model"):FindFirstChild(nameInput.Text, true)
	else
		workspace.Camera.CameraSubject = workspace.Centre
		warnEvent:Fire("Object not found, perhaps check spelling.", 5)
	end
end)

scaleButton.MouseButton1Click:Connect(function()
	if not tonumber(scaleInput.Text) then
		adjustValue:FireServer("Scale", 1)
		warnEvent:Fire("Invalid scale value.", 5)
		return
	end
	
	if not workspace.Camera:FindFirstChildOfClass("Model") then
		warnEvent:Fire("Scale has been stored, load in a planet to view it.", 5)
		return
	end
	
	local model = workspace.Camera:FindFirstChildOfClass("Model")
	
	model:ScaleTo(math.abs(tonumber(scaleInput.Text)))
	model:PivotTo(CFrame.new(Vector3.new(0, 0, 0)))
	adjustValue:FireServer("Scale", tonumber(scaleInput.Text))
end)

local connection:RBXScriptConnection

lookAtButton.MouseButton1Click:Connect(function()
	if connection then
		connection:Disconnect()
		connection = nil
	end
	
	if not workspace.Camera:FindFirstChildOfClass("Model") then
		workspace.Camera.CameraType = Enum.CameraType.Custom
		main.ImageLabel.Visible = false
		main.StudDistance.Visible = false
		main.KmDistance.Visible = false
		
		warnEvent:Fire("Load something in before attempting to use camera functions", 5)
		return
	end
	
	local model = workspace.Camera:FindFirstChildOfClass("Model")
	
	local objectToLookAt = model:FindFirstChild(nameInput2.Text)
	
	if not objectToLookAt then
		workspace.Camera.CameraType = Enum.CameraType.Custom
		main.ImageLabel.Visible = false
		main.StudDistance.Visible = false
		main.KmDistance.Visible = false
		
		warnEvent:Fire("Object not found, perhaps check spelling", 5)
		return
	end
	
	if workspace.Camera.CameraSubject == workspace.Centre then
		workspace.Camera.CameraSubject = workspace.Camera:FindFirstChildOfClass("Model"):FindFirstChild(model.Name)
	end
	
	main.ImageLabel.Visible = true
	main.StudDistance.Visible = true
	main.KmDistance.Visible = true
	
	connection = runService.Heartbeat:Connect(function()
		if not objectToLookAt then
			connection:Disconnect()
			connection = nil
			workspace.Camera.CameraType = Enum.CameraType.Custom
			main.ImageLabel.Visible = false
			main.StudDistance.Visible = false
			main.KmDistance.Visible = false
			return
		end
		
		if not workspace.Camera.CameraSubject then
			connection:Disconnect()
			connection = nil
			workspace.Camera.CameraType = Enum.CameraType.Custom
			main.ImageLabel.Visible = false
			main.StudDistance.Visible = false
			main.KmDistance.Visible = false
			
			workspace.Camera.CameraSubject = workspace.Centre
			return
		end
		
		local distance = (objectToLookAt.Position - workspace.Camera.CameraSubject.Position).Magnitude
		
		workspace.Camera.CameraType = Enum.CameraType.Scriptable
		
		workspace.Camera.CFrame = CFrame.new(workspace.Camera.CameraSubject.Position)
		
		workspace.Camera.CFrame = CFrame.lookAt(workspace.Camera.CameraSubject.Position, objectToLookAt.Position) * CFrame.new(0, workspace.Camera.CameraSubject:FindFirstChildOfClass("SpecialMesh").Scale.Y * 0, 0)
		--workspace.Camera.CFrame *= CFrame.new(10, 10, 10)
		
		main.StudDistance.Text = tostring(math.round(distance)) .. " :Studs Away"
		main.KmDistance.Text = "Km Away: " .. tostring(math.round((distance * 1000) / values.SizeScale.Value))
	end)
end)

load("Earth")
