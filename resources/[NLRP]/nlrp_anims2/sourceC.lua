local sprintSpeed = 0.7 -- analog control state
local lastSpaceClick = 0
--local sprintTime = 20000 -- 20s
local sprintClicks = 0
local sprintClicksLimit = 20000 -- przerabiamy to na czas w MS

addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), 
	function ()
		local stat = getPedStat (getLocalPlayer(),22) -- sprint
		--outputChatBox ("sprint stat: " .. stat)
		--sprintTime = 20000 + 100000*(stat/999)
		--outputChatBox ("sprint: " .. sprintTime/1000)
		sprintClicksLimit = 20000 + 100000*(stat/999)--40 + 120*stat/999
		--outputChatBox ("limit: " .. sprintClicksLimit/1000)
	end
)


function onKey (button,press)
	if isCursorShowing () == false and isControlEnabled (button) == true then
		if press == "down" then
			local sprintKey = false
			for i,v in pairs(getBoundKeys ("sprint")) do
				if getKeyState (i) then
					sprintKey = true
					break
				end
			end
			if sprintKey == false then
				setControlState ("walk",true)
			end
		else
			local f = false
			local keys = {"forwards","backwards","left","right"}
			for k,v in ipairs(keys) do
				local bound = getBoundKeys (v)
				for i,key in pairs(bound) do
					if getKeyState (i) then
						f = true
						break
					end
				end
			end
			if f == false then
				--if isControlEnabled ("sprint") then
					setControlState ("walk",false)
				--end
			end
		end
	end
end

addEventHandler ("onClientResourceStart",getResourceRootElement(),
	function ()
		local keys = {"forwards","backwards","left","right"}
		for k,v in ipairs(keys) do
			bindKey (v,"both",onKey)
		end
		bindKey ("walk","both",
			function ()
				setControlState ("walk",true)
			end
		)
		bindKey ("sprint","both",
			function (button,press)
				if press == "down" then
					setControlState ("sprint",false)
					--setAnalogControlState ("sprint",0)
					if isControlEnabled ("sprint") then
						setControlState ("walk",false)
					end
					local cTick = getTickCount ()
					local delay = cTick - lastSpaceClick
					if delay <= 500 then
						--sprintClicks = sprintClicks+1
						sprintClicks = sprintClicks+delay
						if sprintClicks < sprintClicksLimit then
							if isControlEnabled ("sprint") then
								setControlState ("sprint",true)
								--setAnalogControlState ("sprint",sprintSpeed)
							end
						else
							sprintClicks = sprintClicksLimit
							setControlState ("sprint",false)
							--setAnalogControlState ("sprint",0)
						end
						
					end
					lastSpaceClick = getTickCount ()
				else
					if getTickCount()-lastSpaceClick > 500 then
						setControlState ("walk",true)
					else
						lastSpaceClick = getTickCount ()
					end
				end
			end
		)
		setTimer (
			function ()
				local st = false
				local keys = {"forwards","backwards","left","right"}
				for k,v in ipairs(keys) do
					if getControlState (v) then
						st = true
						break
					end
				end
				if st then
					local sprintKey = false
					for i,v in pairs(getBoundKeys ("sprint")) do
						if getKeyState (i) then
							sprintKey = true
							break
						end
					end
					local cTick = getTickCount ()
					local delay = cTick-lastSpaceClick
					if delay > 500 then
						if sprintKey == false then
							setControlState ("walk",true)
							setControlState ("sprint",false)
							--setAnalogControlState ("sprint",0)
						else
							setControlState ("sprint",false)
							if isControlEnabled ("sprint") == false then
								setControlState ("walk",true)
							end
							--setAnalogControlState ("sprint",0)
						end
					end
					
				end
			end
		,500,0)
		setTimer (
			function ()
				if sprintClicks > 0 then
					--sprintClicks = sprintClicks-1
					sprintClicks = sprintClicks-100
					if sprintClicks < 0 then
						sprintClicks = 0
					end
				end
			end
		,1000,0)
	end
)



local anim = false
local localPlayer = getLocalPlayer()
local walkanims = { WALK_armed = true, WALK_civi = true, WALK_csaw = true, Walk_DoorPartial = true, WALK_drunk = true, WALK_fat = true, WALK_fatold = true, WALK_gang1 = true, WALK_gang2 = true, WALK_old = true, WALK_player = true, WALK_rocket = true, WALK_shuffle = true, Walk_Wuzi = true, woman_run = true, WOMAN_runbusy = true, WOMAN_runfatold = true, woman_runpanic = true, WOMAN_runsexy = true, WOMAN_walkbusy = true, WOMAN_walkfatold = true, WOMAN_walknorm = true, WOMAN_walkold = true, WOMAN_walkpro = true, WOMAN_walksexy = true, WOMAN_walkshop = true, run_1armed = true, run_armed = true, run_civi = true, run_csaw = true, run_fat = true, run_fatold = true, run_gang1 = true, run_old = true, run_player = true, run_rocket = true, Run_Wuzi = true }
local attachedRotation = false

function onRender()
	local forcedanimation = getElementData(localPlayer, "forcedanimation")

	if (getPedAnimation(localPlayer)) and not (forcedanimation==1) then
		local screenWidth, screenHeight = guiGetScreenSize()
		anim = true

		local block, style = getPedAnimation(localPlayer)
		if block == "ped" and walkanims[ style ] then
			local px, py, pz, lx, ly, lz = getCameraMatrix()
			setPedRotation( localPlayer, math.deg( math.atan2( ly - py, lx - px ) ) - 90 )
		end
	elseif not (getPedAnimation(localPlayer)) and (anim) then
		anim = false
		toggleAllControls(true, true, false)
	end
	
	local element = getElementAttachedTo(localPlayer)
	if element and getElementType( element ) == "vehicle" then
		if attachedRotation then
			local rx, ry, rz = getElementRotation( element )
			setPedRotation( localPlayer, rz + attachedRotation )
		else
			local rx, ry, rz = getElementRotation( element )
			attachedRotation = getPedRotation( localPlayer ) - rz
		end
	elseif attachedRotation then
		attachedRotation = false
	end
end
addEventHandler("onClientRender", getRootElement(), onRender)

function onRender()
	if not getPedAnimation(getLocalPlayer()) and getControlState ( "jump" ) and getControlState ( "sprint" ) and getControlState ( "forwards" ) then -- W + SPACE + SHIFT
		setPedAnimation( getLocalPlayer(), "ped", "EV_dive", 2000, false, true, false)
	end
end
--addEventHandler("onClientRender", getRootElement(), onRender)