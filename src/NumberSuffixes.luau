-- Put inside ScientificNotationClass.luau
local NumberSuffixes = {}

NumberSuffixes.baseSuffixes = {
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
NumberSuffixes.latinUnits = {
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
NumberSuffixes.latinTens = {
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
NumberSuffixes.latinHundreds = {
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

NumberSuffixes.baseSuffixesShort = {
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
NumberSuffixes.latinUnitsShort = {
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
NumberSuffixes.latinTensShort = {
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
NumberSuffixes.latinHundredsShort = {
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

NumberSuffixes.hasS = {
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

NumberSuffixes.hasX = {
	-- Tens
	octoginta = true,
	
	-- Hundreds
	centi = true, 
	octingenti = true
}

NumberSuffixes.hasM = {
	-- Tens
	octoginta = true,
	
	-- Hundreds
	octingenti = true
}

NumberSuffixes.hasN = {
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


NumberSuffixes.addons = {
	s = NumberSuffixes.hasS,
	x = NumberSuffixes.hasX,
	m = NumberSuffixes.hasM,
	n = NumberSuffixes.hasN
}


return NumberSuffixes