--Code Made By Tomroblox54321 and IlyasTawawe
--Eccentricty Code made tweaked by Creeperman16487
--All gave permission to use code in the module
--Hope you Enjoy!




local OrbitModule = {}

--Getting RunService
local RunService = game:GetService("RunService")

--Getting Our Math Variables
local CosineMath = math.cos
local SineMath = math.sin
local Atan2Math = math.atan2
local Tan = math.tan

local PIMath = math.pi
local TAU = 2*PIMath

local eccentricityValues = require(script.EccentricityValues)

--Getting HeartbeatWait
local HeartbeatWait = RunService.Heartbeat:Wait()

function OrbitModule:TidalLocking(PlanetLocked : PVInstance, PlanetGettingLockedTo : PVInstance, TextureAdjustmentX, TextureAdjustmentZ)
	assert(PlanetLocked ~= PlanetGettingLockedTo, "Cannot lock itself, PlanetLocked and PlanetGettingLockedTo should be different")
	
	local HeartbeatConnection
	HeartbeatConnection = RunService.Heartbeat:Connect(function(DeltaTime)
		
		if not (PlanetLocked or PlanetGettingLockedTo) then
			HeartbeatConnection:Disconnect()
			HeartbeatConnection = nil
			assert("Orbit Disconnected")
		end
		
		PlanetLocked.CFrame = CFrame.lookAt(PlanetLocked.Position, PlanetGettingLockedTo.Position) * CFrame.Angles(math.rad(TextureAdjustmentX), 0, math.rad(TextureAdjustmentZ))
	end)
	
	return HeartbeatConnection
end

function OrbitModule:Rotation(PlanetRotating : PVInstance, RotationPeriod : number, Tilt : number, Reversed : boolean)
	
	if Tilt == nil then Tilt = 0 end
	
	if Reversed == true then RotationPeriod = -RotationPeriod end
	
	PlanetRotating.Orientation = Vector3.new(Tilt, 0, 0)

	local HeartbeatConnection
	HeartbeatConnection = RunService.Heartbeat:Connect(function(DeltaTime)
		
		if not PlanetRotating then
			HeartbeatConnection:Disconnect()
			HeartbeatConnection = nil
			assert("Orbit Disconnected")
		end
		
		local rotationAngle = (360 / RotationPeriod) * (0.016 * workspace.Values.TimeScale.Value)

		PlanetRotating.CFrame = PlanetRotating.CFrame * CFrame.Angles(0, math.rad(rotationAngle), 0)
	end)
	
	return HeartbeatConnection
end
--Creating the Circular Orbit Function
function OrbitModule:CircularOrbit(PlanetOrbiting : PVInstance, PlanetGettingOrbited : PVInstance, TimeToOrbit : number, Retrograde: boolean)
	assert(PlanetOrbiting ~= PlanetGettingOrbited, "Cannot orbit itself, PlanetOrbiting and PlanetGettingOrbited should be different")
	task.wait(HeartbeatWait)

	--Getting Our Difference, Radius and Angle
	local DifferenceVector = PlanetOrbiting:GetPivot().Position-PlanetGettingOrbited:GetPivot().Position --Differnce
	local Radius = DifferenceVector.Magnitude
	local Angle = Atan2Math(DifferenceVector.Y, DifferenceVector.X)--Angle
	
	--Creating the HeartbeatCobnection
	local HeartbeatConnection
	HeartbeatConnection = RunService.Heartbeat:Connect(function(DeltaTime)
		-- Disconnect the event if one of the planets got destroyed
		if not (PlanetOrbiting or PlanetGettingOrbited) then
			HeartbeatConnection:Disconnect()
			HeartbeatConnection = nil
			assert("Orbit Disconnected")
			return
		end
		
		local model = PlanetOrbiting:FindFirstAncestorOfClass("Model")
		
		task.wait(HeartbeatWait/10)
		
		if not model then
			HeartbeatConnection:Disconnect()
			HeartbeatConnection = nil
			assert("Orbit Disconnected")
			return
		end
		-- Polar coordinates 2D
		local x = Radius*CosineMath(Angle)*model:GetScale()
		local y = Radius*SineMath(Angle)*model:GetScale()
		local z = 0

		--Putting it all together
		PlanetOrbiting:PivotTo(PlanetGettingOrbited.CFrame*CFrame.new(x, y, z))
		
		if Retrograde then
			Angle += (DeltaTime * workspace.Values.TimeScale.Value)*TAU/TimeToOrbit
		else
			Angle -= (DeltaTime * workspace.Values.TimeScale.Value)*TAU/TimeToOrbit
		end
	end)
	-- Return the heartbeat connection, so we can disconnect it if we no longer wants the part to orbit
	return HeartbeatConnection
end


function OrbitModule:EccentricOrbit(PlanetOrbiting : PVInstance, PlanetGettingOrbited : PVInstance, TimeToOrbit : number, Eccentricity : number)
	assert(PlanetOrbiting ~= PlanetGettingOrbited, "Cannot orbit itself, PlanetOrbiting and PlanetGettingOrbited should be different")
	
	--Getting Our Difference, Radius and Angle
	local DifferenceVector = PlanetOrbiting:GetPivot().Position-PlanetGettingOrbited:GetPivot().Position --Differnce
	local Radius = DifferenceVector.Magnitude
	local Angle = Atan2Math(DifferenceVector.Y, DifferenceVector.X)--Angle
	
	
	--Creating HeartbeatConnection
	local HeartbeatConnection
	HeartbeatConnection = RunService.Heartbeat:Connect(function(DeltaTime)
		-- Disconnect the event if one of the planets got destroyed
		if not (PlanetOrbiting or PlanetGettingOrbited) then
			HeartbeatConnection:Disconnect()
			HeartbeatConnection = nil
			assert("Orbit Disconnected")
		end

		-- Polar coordinates 2D
		local x = (Radius+Eccentricity/2)*CosineMath(Angle)
		local y = Radius*SineMath(Angle)
		local z = 0
		local Offset = CFrame.new(Eccentricity,0,0)
		PlanetOrbiting:PivotTo((PlanetGettingOrbited.CFrame*Offset)*CFrame.new(x, y, z))
		Angle += (0.016 * workspace.Values.TimeScale.Value)*TAU/TimeToOrbit
	end)

	-- Return the heartbeat connection, so we can disconnect it if we no longer wants the part to orbit
	return HeartbeatConnection

end

function OrbitModule:EllipticalOrbit(PlanetOrbiting : PVInstance, PlanetGettingOrbited : PVInstance, TimeToOrbit : number, Ellipse : number)
	assert(PlanetOrbiting ~= PlanetGettingOrbited, "Cannot orbit itself, PlanetOrbiting and PlanetGettingOrbited should be different")

	local DifferenceVector = PlanetOrbiting:GetPivot().Position-PlanetGettingOrbited:GetPivot().Position --Differnce
	local Radius = DifferenceVector.Magnitude

	local Angle = Atan2Math(DifferenceVector.Y, DifferenceVector.X)--Angle

	local HeartbeatConnection
	HeartbeatConnection = RunService.Heartbeat:Connect(function(DeltaTime)
		-- Disconnect the event if one of the planets got destroyed
		if not (PlanetOrbiting or PlanetGettingOrbited) then
			HeartbeatConnection:Disconnect()
			HeartbeatConnection = nil
		end
		
		local EllipseNumber = (Ellipse/10)

		-- Polar coordinates 2D
		local x = (Radius*EllipseNumber)*CosineMath(Angle)
		local y = (Radius/EllipseNumber)*SineMath(Angle)
		local z = 0
		--Putting it all together
		PlanetOrbiting:PivotTo(PlanetGettingOrbited.CFrame*CFrame.new(x, y, z))
		Angle += (0.016 * workspace.Values.TimeScale.Value)*TAU/TimeToOrbit
	end)

	-- Return the heartbeat connection, so we can disconnect it if we no longer wants the part to orbit
	return HeartbeatConnection
end


function OrbitModule:ProperEccentricOrbit(PlanetOrbiting : PVInstance, PlanetGettingOrbited : PVInstance, Eccentricity : number, OrbitalPlane : number,TimeToOrbit: number, Retrograde: boolean, ArgOfLong: number, ArgOfPeri: number)
	assert(PlanetOrbiting ~= PlanetGettingOrbited, "Cannot orbit itself, PlanetOrbiting and PlanetGettingOrbited should be different")
	
	 --Differnce
	local DifferenceVectorStart = PlanetOrbiting:GetPivot().Position-PlanetGettingOrbited:GetPivot().Position
	local Radius = DifferenceVectorStart.Magnitude
	local Angle = math.rad(0)
	local tableValues = {}
	local sum = 0
	
	local EccentricityMultiplier = eccentricityValues[Eccentricity]
	
	local HeartbeatConnection
	
	task.spawn(function()
		HeartbeatConnection = RunService.Heartbeat:Connect(function(DeltaTime)
			local DifferenceVector = PlanetOrbiting:GetPivot().Position-PlanetGettingOrbited:GetPivot().Position
			local Dist = DifferenceVector.Magnitude
			-- Disconnect the event if one of the planets got destroyed
			if not (PlanetOrbiting or PlanetGettingOrbited) then
				HeartbeatConnection:Disconnect()
				HeartbeatConnection = nil
			end
			
			local model = PlanetOrbiting:FindFirstAncestorOfClass("Model")
			
			-- Polar coordinates 2D
			local x
			local y
			local z = 0
			local offset
			
			x = ((Radius + (-Radius * (1 + Eccentricity)) / (Eccentricity - 1)) / 2)*CosineMath(Angle)*model:GetScale()
			y = (((Radius + (-Radius * (1 + Eccentricity)) / (Eccentricity - 1)) / 2) * math.sqrt(1-Eccentricity^2))*SineMath(Angle)*model:GetScale()
			offset = CFrame.new((-Radius * (1 + Eccentricity)) / (Eccentricity - 1) / 2 - (Radius / 2), 0, 0)
			
			local cf = (PlanetGettingOrbited.CFrame*offset)*CFrame.new(x, y, z)
			PlanetOrbiting.Position = cf.Position
			
			local semiMajorAxis = (Radius + (-Radius * (1 + Eccentricity)) / (Eccentricity - 1)) -- or your actual value for a

			-- Base angular step to complete full orbit in TimeToOrbit
			
			
			local baseAngularStep = (0.016 * workspace.Values.TimeScale.Value) * TAU / TimeToOrbit

			-- Compute orbital speed factor using vis-viva approximation
			if Dist >= math.huge then
				Dist = Radius
			end
			
			local speedFactor = math.sqrt((2 / Dist) - (1 / semiMajorAxis))
			-- Final angle adjustment
			
			
			if EccentricityMultiplier then
				if Retrograde then
					Angle -= (baseAngularStep * speedFactor) * EccentricityMultiplier
				else
					Angle += (baseAngularStep * speedFactor) * EccentricityMultiplier
				end
			else
				if Retrograde then
					Angle -= (baseAngularStep * speedFactor)
				else
					Angle += (baseAngularStep * speedFactor)
				end
			end
			
			if not EccentricityMultiplier then
				if math.round(math.deg(math.abs(Angle))) == 90 then
					startTime = os.clock()
				elseif math.round(math.deg(math.abs(Angle))) == 450 then
					table.insert(tableValues, (os.clock() - startTime) / TimeToOrbit * workspace.Values.TimeScale.Value)
					--print((os.clock() - startTime) / TimeToOrbit * workspace.Values.TimeScale.Value)
				elseif math.round(math.deg(math.abs(Angle))) > 720 then
					HeartbeatConnection:Disconnect()
					HeartbeatConnection = nil
				end
			end
		end)
	end)
	--HeartbeatConnection:Disconnect()
	-- Return the heartbeat connection, so we can disconnect it if we no longer wants the part to orbit
	--return HeartbeatConnection
	
	--[[
	repeat
		task.wait()
	until HeartbeatConnection == nil

	for i, value in ipairs(tableValues) do
		sum += value
	end

	sum /= #tableValues

	return sum]]--
end

--Returning the whole module
return OrbitModule
