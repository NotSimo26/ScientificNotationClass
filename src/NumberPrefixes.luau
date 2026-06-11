-- Put inside ScientificNotationClass.luau
local NumberPrefixes = {}

NumberPrefixes.basePrefixes = {
	"m",
	"b",
	"tr",
	"quadr",
	"quint",
	"sext",
	"sept",
	"oct",
	"non"
}
NumberPrefixes.latinUnits = {
	"un",
	"duo",
	"tre",
	"quattuor",
	"quin",
	"se",
	"septe",
	"octo",
	"nove"
}
NumberPrefixes.latinTens = {
	"deci",
	"viginti",
	"triginta",
	"quadraginta",
	"quinquaginta",
	"sexaginta",
	"septuaginta",
	"octoginta",
	"nonaginta"
}
NumberPrefixes.latinHundreds = {
	"centi",
	"ducenti",
	"trecenti",
	"quadringenti",
	"quingenti",
	"sescenti",
	"septingenti",
	"octingenti",
	"nongenti"
}


-- Short

NumberPrefixes.basePrefixesShort = {
	"M",
	"B",
	"T",
	"Qd",
	"Qn",
	"Sx",
	"Sp",
	"Oc",
	"No"
}
NumberPrefixes.latinUnitsShort = {
	"U",
	"D",
	"T",
	"Qa",
	"Qi",
	"Sx",
	"Sp",
	"Oc",
	"No"
}
NumberPrefixes.latinTensShort = {
	"Dc",
	"Vg",
	"Tg",
	"Qg",
	"Qq",
	"Sg",
	"St",
	"Og",
	"Ng"
}
NumberPrefixes.latinHundredsShort = {
	"C",
	"DuC",
	"TrC",
	"QdC",
	"QnC",
	"SxC",
	"SpC",
	"OcC",
	"NoC"
}

-- lookup tables useful to check if i should add the addons
-- like "s" at the end of "tre" or "se"

NumberPrefixes.hasS = {
	-- Tens
	viginti = true, 
	triginta = true, 
	quadraginta = true, 
	quinquaginta = true,

	-- Hundreds
	trecenti = true, 
	quadringenti = true, 
	quingenti = true
}

NumberPrefixes.hasX = {
	-- Tens
	octoginta = true,

	-- Hundreds
	centi = true, 
	octingenti = true
}

NumberPrefixes.hasM = {
	-- Tens
	octoginta = true,

	-- Hundreds
	octingenti = true
}

NumberPrefixes.hasN = {
	-- Tens
	deci = true, 
	triginta = true, 
	quadraginta = true, 
	quinquaginta = true, 
	sexaginta = true, 
	septuaginta = true,

	-- Hundreds
	centi = true, 
	ducenti = true, 
	trecenti = true, 
	quadringenti = true, 
	quingenti = true, 
	sescenti = true, 
	septingenti = true
}


NumberPrefixes.addons = {
	s = NumberPrefixes.hasS,
	x = NumberPrefixes.hasX,
	m = NumberPrefixes.hasM,
	n = NumberPrefixes.hasN
}


return NumberPrefixes