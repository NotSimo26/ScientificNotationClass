local ScientificNotationClass	= require(script.Parent.ScientificNotationClass)
local myN 						= ScientificNotationClass.new(1,6)

-- Error handling example
local succ, err = pcall(function()
	-- i expect this to raise an error (since the expo should be >=0)
	myN:SetExponent(-2)
end)
if not succ then
	warn(err, debug.traceback())
end


local coefficient, conwayString, shortConwayString = myN:FormatNumberConway()
print(coefficient, conwayString, shortConwayString) -- 1 | "million" | "M"

local coefficient, expoString = myN:FormatNumberScientific()
print(coefficient, expoString) -- 1 | "x 10^6"

local rawNumber = myN:ToNumber()
print(rawNumber) -- 1000000