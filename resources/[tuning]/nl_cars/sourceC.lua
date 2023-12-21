local lastTick = getTickCount()
local s = {guiGetScreenSize()}
local core = exports.reach_core
local fonts = core:getFonts()

local mods = {
	["parts/jester"] = {
		["fbmp_a_j"] = 1160,
		["fbmp_c_j"] = 1173,
		["rbmp_a_j"] = 1159,
		["rbmp_c_j"] = 1161,
		["rf_a_j"] = 1067,
		["rf_c_j"] = 1068,
		["spl_a_j_b"] = 1162,
		["spl_c_j_b"] = 1158,
		["wg_l_a_j"] = 1069,
		["wg_l_c_j"] = 1070,
		["wg_r_a_j"] = 1071,
		["wg_r_c_j"] = 1072,
	},
	["parts/stratum"] = {
		["fbmp_a_st"] = 1155,
		["fbmp_c_st"] = 1157,
		["rbmp_a_st"] = 1154,
		["rbmp_c_st"] = 1156,
		["rf_a_st"] = 1055,
		["rf_c_st"] = 1061,
		["spl_a_st_r"] = 1058,
		["spl_c_st_r"] = 1060,
		["wg_l_a_st"] = 1056,
		["wg_l_c_st"] = 1057,
		["wg_r_a_st"] = 1062,
		["wg_r_c_st"] = 1063,
	},
	["parts/sultan"] = {
		["fbmp_a"] = 1166,
		["fbmp_c"] = 1165,
		["rbmp_a"] = 1168,
		["rbmp_c"] = 1167,
		["rf_a"] = 1088,
		["rf_c"] = 1091,
		["spl_a_l"] = 1164,
		["spl_c_l"] = 1163,
		["wg_l_a"] = 1090,
		["wg_l_c"] = 1093,
		["wg_r_a"] = 1094,
		["wg_r_c"] = 1095,
	},
	["parts/uranus"] = {
		["fbmp_a"] = 1169,
		["fbmp_c"] = 1170,
		["rbmp_a"] = 1141,
		["rbmp_c"] = 1140,
		["rf_a"] = 1032,
		["rf_c"] = 1033,
		["spl_a_l"] = 1138,
		["spl_c_l"] = 1139,
		["wg_l_a"] = 1026,
		["wg_l_c"] = 1031,
		["wg_r_a"] = 1027,
		["wg_r_c"] = 1030,
	},
	["parts/flash"] = {
		["fbmp_a_l"] = 1153,
		["fbmp_c_l"] = 1152,
		["rbmp_a_l"] = 1150,
		["rbmp_c_l"] = 1151,
		["rf_a_l"] = 1054,
		["rf_c_l"] = 1053,
		["wg_l_a_l"] = 1047,
		["wg_l_c_l"] = 1048,
		["wg_r_a_l"] = 1051,
		["wg_r_c_l"] = 1052,
	},
}

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		for category,models in pairs(mods) do
			for name,id in pairs(models) do
				if string.find(category,"parts") then
					engineImportTXD( engineLoadTXD("vehicles/" .. category:gsub("parts/","") .. ".txd"),id)
					engineReplaceModel( engineLoadDFF(category .. "/" .. name .. ".dff",0),id)
				else
					engineImportTXD( engineLoadTXD(category .. "/" .. name .. ".txd"),id)
					engineReplaceModel( engineLoadDFF(category .. "/" .. name .. ".dff",0),id)
				end
			end
		end
	end
)