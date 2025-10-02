local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")

local warnEvent = replicatedStorage:WaitForChild("WarnEvent")

local warningTemplate = script.Parent.Warning

local goal = {}
goal.Size = UDim2.new(0.537, 0, 0.001, 0)

local goalBackground = {}
goalBackground.BackgroundTransparency = 0.75

local goalStroke = {}
goalStroke.Transparency = 0.5

local goalText = {}
goalText.TextTransparency = 0

local goalTextStroke = {}
goalTextStroke.Transparency = 0

local tweenInf = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

warnEvent.Event:Connect(function(warning, duration)
	local warnFrame = warningTemplate:Clone()
	
	warnFrame.Parent = script.Parent
	
	warnFrame.Visible = true
	
	local fadeInBackground = tweenService:Create(warnFrame.TextLabel, tweenInf, goalBackground)
	local fadeInStroke = tweenService:Create(warnFrame.TextLabel.UIStroke, tweenInf, goalStroke)
	local fadeInText = tweenService:Create(warnFrame.TextLabel, tweenInf, goalText)
	local fadeInTextStroke = tweenService:Create(warnFrame.TextLabel.TextStroke, tweenInf, goalTextStroke)
	
	fadeInBackground:Play()
	fadeInStroke:Play()
	fadeInText:Play()
	fadeInTextStroke:Play()
	
	warnFrame.TextLabel.Text = warning
	
	if duration then
		wait(duration)

		local shrink = tweenService:Create(warnFrame, tweenInf, goal)

		shrink:Play()

		shrink.Completed:Connect(function()
			warnFrame:Destroy()
		end)
	else
		wait(2)

		local shrink = tweenService:Create(warnFrame, tweenInf, goal)

		shrink:Play()

		shrink.Completed:Connect(function()
			warnFrame:Destroy()
		end)
	end
end)
