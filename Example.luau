local ScientificNotationClass	= require(script.Parent.ScientificNotationClass)
local myN 						= ScientificNotationClass.new(1,6)

-- Error handling example
local succ, err = pcall(function()
	-- I expect this to raise an error
	myN:SetExponent(-2)
end)
if not succ then
	warn(err, debug.traceback())
end


local coefficient, conwayString, shortConwayString = myN:FormatNumberConway()
print(coefficient, conwayString, shortConwayString)