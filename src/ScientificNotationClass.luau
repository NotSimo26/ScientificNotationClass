-- @title: ScientificNotationClass
-- @author: SimoDevv
-- @date: 06/09/26
-- @type: Class

-- <<< Modules >>> -- 
local NumberPrefixes			= require(script.NumberPrefixes)

-- <<< Local Functions >>> --
local function round3(value: number): number
	return math.floor(value * 1000) / 1000
end
local function validateMantissa(value: number): number
	assert(typeof(value) == "number", "Mantissa must be a number")
	assert(
		value >= 1 and value < 10,
		"Mantissa must be in [1, 10), got " .. value
	)
	return value
end
local function validateExponent(value: number): number
	assert(typeof(value) == "number", "Exponent must be a number")
	assert(value >= 0, "Exponent must be >= 0")
	assert(math.floor(value) == value, "Exponent must be an integer")
	return value
end
local function getModifiedUnit(unit:string, nextComponent:string)
	if not nextComponent or nextComponent == "" then return unit end
	if unit == "tre" then
		if NumberPrefixes.addons.s[nextComponent] then return "tres" end
	elseif unit == "se" then
		if NumberPrefixes.addons.x[nextComponent] then return "sex" end
		if NumberPrefixes.addons.s[nextComponent] then return "ses" end
	elseif unit == "septe" or unit == "nove" then
		if NumberPrefixes.addons.m[nextComponent] then return unit .. "m" end
		if NumberPrefixes.addons.n[nextComponent] then return unit .. "n" end
	end
	return unit
end
local function elaborateGroup(conwayIndex:number, suffix:string): (string, string)
	local res = ""
	local shortRes = ""
	if conwayIndex < 0 then
	elseif conwayIndex == 0 then
		res = "n" .. suffix
	elseif conwayIndex < 10 then
		-- standard nomenclature
		res = NumberPrefixes.basePrefixes[conwayIndex] .. suffix
		shortRes = NumberPrefixes.basePrefixesShort[conwayIndex]
	elseif conwayIndex < 1000 then
		-- 10 <= N < 1000
		local hundredIndex = math.floor(conwayIndex / 100)
		local tenIndex = math.floor((conwayIndex % 100) / 10)
		local unitIndex = conwayIndex % 10
		--
		local hundred = NumberPrefixes.latinHundreds[hundredIndex] or ""
		local ten = NumberPrefixes.latinTens[tenIndex] or ""
		local unit = NumberPrefixes.latinUnits[unitIndex] or ""
		--
		local hundredShort = NumberPrefixes.latinHundredsShort[hundredIndex] or ""
		local tenShort = NumberPrefixes.latinTensShort[tenIndex] or ""
		local unitShort = NumberPrefixes.latinUnitsShort[unitIndex] or ""
		--
		-- If there's ten i'll use that as next, otherwise i'll use hundred
		unit = getModifiedUnit(unit, (ten~="") and ten or hundred)
		--
		res = string.gsub(unit .. ten .. hundred, ".$", suffix)
		shortRes = shortRes .. unitShort .. tenShort .. hundredShort
	end
	if suffix == "illi" then
		shortRes = shortRes .. "i"
	elseif conwayIndex == 0 then
		shortRes = "N"
	end
	return res, shortRes
end

-- <<< Init >>> --
local ScientificNotationClass 	= {}
ScientificNotationClass.__index = ScientificNotationClass

-- <<< Methods >>> --

-- Constructor
function ScientificNotationClass.new(mantissa: number,exponent: number)
	local self = setmetatable({}, ScientificNotationClass)
	self.mantissa = validateMantissa(mantissa)
	self.exponent = validateExponent(exponent)
	return self
end


-- Set the given mantissa on the current Scientific Number Object.
-- NB: if the mantissa isn't a number or ∉ [1, 10) it will raise an error
-- so maybe consider using pcall() if you're not sure about the given value
-- @param value -> the mantissa to set 
function ScientificNotationClass:SetMantissa(value: number)
	self.mantissa = validateMantissa(value)
end

-- Set the given exponent on the current Scientific Number Object.
-- NB: if the exponent isn't a positive integer it will raise an error
-- so maybe consider using pcall() if you're not sure about the given value
-- @param value -> the exponent to set 
function ScientificNotationClass:SetExponent(value: number)
	self.exponent = validateExponent(value)
end
--

-- Convert the current Scientific Notation Object into a normal luau number (so basically a double)
-- NB: if the current number is > 1.7 * (10^308) it will return inf
-- @return number -> the converted number
function ScientificNotationClass:ToNumber(): number
	return self.mantissa * (10 ^ self.exponent)
end

-- Format the current Scientific Notation Object in a number (the coefficient),
-- a string that will be the result of the Conway's algorithm applied to it, and another string
-- that will be the short rapresentation of the Conway-string. (like Million will be M)
-- @return number -> the coefficient of the number, float with .3f and 1<=n<=999.999.
-- @return string -> the string rappresentation of the number by using Conway's algorithm.
-- @return string -> short rapresentation of the Conway-string.
function ScientificNotationClass:FormatNumberConway(): (number, string, string)
	local expo = self.exponent
	local coefficient = round3(self.mantissa * (10 ^ (expo%3)))
	local conwayIndex = math.floor(expo / 3 - 1) -- The N for conway algorithm
	--
	local res = ""
	local shortRes = ""
	if conwayIndex < 0 then
	elseif conwayIndex == 0 then
		res = "thousand"
		shortRes = "K"
	else
		-- N >= 1, so starting from million
		-- since i wanna make it to work also with N>=1000
		-- i'll divide it in group of 3 digits, starting from right
		local j = 0
		while conwayIndex > 0 do
			local group = conwayIndex % 1000
			local groupRes, groupShortRes = 
				elaborateGroup(group, (j==0) and "illion" or "illi")
			-- i'll concatenate backwards bc this while loop is cycling from right to left
			-- but i wanna build the string the other way around
			res = groupRes .. res 
			shortRes = groupShortRes .. shortRes
			conwayIndex = math.floor(conwayIndex / 1000)
			j+=1
		end
	end
	--
	return coefficient, res, shortRes
end

-- Format the current Scientific Notation Object in a number (the coefficient),
-- a string that will rapresent the exponent.
-- @return number -> the coefficient of the number, float with .3f and 1<=n<=999.999.
-- @return string -> the string rappresentation of the number by using Conway's algorithm.
function ScientificNotationClass:FormatNumberScientific(): (number, string)
	local expo = self.exponent
	local coefficient = round3(self.mantissa * (10 ^ (expo%3)))
	local res = "x 10^" .. expo
	--
	return coefficient, res
end


return ScientificNotationClass