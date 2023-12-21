mainCategories = {}
availableItems = {}
itemBasePrices = {}
itemCategories = {}

function addAnItem(itemId, basePrice)
	if type(itemId) == "string" then
		table.insert(mainCategories, itemId)
	else
		availableItems[itemId] = true
		itemBasePrices[itemId] = math.floor(basePrice)
		itemCategories[itemId] = #mainCategories
	end
end

addAnItem("Gyorsételek")
addAnItem(45, 1055) --hamburger
addAnItem(46, 1060) --Taco
addAnItem(47, 715) --Szendvics
addAnItem(48, 560) --Hot-Dog
addAnItem(49, 425) --Fank
addAnItem(50, 325) --Suti
addAnItem(51, 215) --Puding
addAnItem("Üdítők")
addAnItem(52, 425) --Fanta
addAnItem(53, 425)
addAnItem(54, 425)
addAnItem(55, 425)
addAnItem(56, 425)
addAnItem(57, 425)
addAnItem(58, 425)
addAnItem(59, 425)
addAnItem(60, 425)
addAnItem(61, 425)
addAnItem("Forró italok")
addAnItem(70, 250)
addAnItem("Alkohol/Cigaretta")
addAnItem(62, 600)
addAnItem(63, 650)
addAnItem(64, 5000)
addAnItem(65, 6000)
addAnItem(66, 6000)
addAnItem(67, 6000)
addAnItem(68, 5500)
addAnItem(69, 7000)
addAnItem(98, 6000) --Egy doboz cigi
addAnItem("Műszaki")
addAnItem(28, 110000) --Fenykepezo
addAnItem(44, 5300) --Sd kartya
addAnItem(71, 100000) --Telefon
addAnItem(79, 35000) --Radio
addAnItem(82, 1000) --Hifi
addAnItem("Szerszámok")
addAnItem(33, 5000)
addAnItem(37, 5000)
addAnItem(312, 5000) --Csavarhúzó
addAnItem(313, 500) -- Csavarok
addAnItem(137, 25000)--kulcsmásoló
addAnItem("Hobby")
addAnItem(32, 5000)
addAnItem(25, 5000)
addAnItem(42, 5000)
addAnItem(139, 3500)
addAnItem(85, 5000000)--széf
addAnItem("Egészség")
addAnItem(105, 1000)
addAnItem(106, 1000)
addAnItem(90, 3000)
addAnItem(122, 1000)
addAnItem("Egyéb")
addAnItem(84, 850)



function deepcopy(t)
	if type(t) ~= "table" then return t end
	local meta = getmetatable(t)
	local target = {}
	for k, v in pairs(t) do
		if type(v) == "table" then
			target[k] = deepcopy(v)
		else
			target[k] = v
		end
	end
	setmetatable(target, meta)
	return target
end

function table_eq(table1, table2)
	local avoid_loops = {}
	local function recurse(t1, t2)
		-- compare value types
		if type(t1) ~= type(t2) then return false end
		-- Base case: compare simple values
		if type(t1) ~= "table" then return t1 == t2 end
		-- Now, on to tables.
		-- First, let's avoid looping forever.
		if avoid_loops[t1] then return avoid_loops[t1] == t2 end
		avoid_loops[t1] = t2
		-- Copy keys from t2
		local t2keys = {}
		local t2tablekeys = {}
		for k, _ in pairs(t2) do
			if type(k) == "table" then table.insert(t2tablekeys, k) end
			t2keys[k] = true
		end
		-- Let's iterate keys from t1
		for k1, v1 in pairs(t1) do
			local v2 = t2[k1]
			if type(k1) == "table" then
				-- if key is a table, we need to find an equivalent one.
				local ok = false
				for i, tk in ipairs(t2tablekeys) do
					if table_eq(k1, tk) and recurse(v1, t2[tk]) then
						table.remove(t2tablekeys, i)
						t2keys[tk] = nil
						ok = true
						break
					end
				end
				if not ok then return false end
			else
				-- t1 has a key which t2 doesn't have, fail.
				if v2 == nil then return false end
				t2keys[k1] = nil
				if not recurse(v1, v2) then return false end
			end
		end
		-- if t2 has a key which t1 doesn't have, fail.
		if next(t2keys) then return false end
		return true
	end
	return recurse(table1, table2)
end