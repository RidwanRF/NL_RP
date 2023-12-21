local lastTick = getTickCount()
local s = {guiGetScreenSize()}

local particleDistance = 100

local textures = {
	["smokes"] = {}
}
local particles = {}
local id

addEventHandler("onClientRender",root,
	function()
		--if getElementData(localPlayer,"settings_effects") == 1 then
			for k,row in ipairs(particles) do
				local p = Vector3(getElementPosition(localPlayer))
				local distance = getDistanceBetweenPoints3D(p.x,p.y,p.z,row.x,row.y,row.z)
				if distance <= particleDistance then
					local mx,my,mz,_,_,_ = getCameraMatrix()

					local alpha = interpolateBetween(1,0,0,0,0,0,getProgress(row.lifetime,row.tick),"Linear")
					local nx,ny,nz = interpolateBetween(row.x,row.y,row.z,row.nx,row.ny,row.nz,getProgress(row.lifetime,row.tick),"OutQuad")
					row.size = row.size + 0.02
					dxDrawMaterialLine3D(nx,ny,nz+row.size,nx,ny,nz-row.size/2,textures[row.category][row.image_id],row.size,tocolor(row.color[1],row.color[2],row.color[3],row.alpha*alpha),mx,my,mz)
					if alpha == 0 then
						table.remove(particles,k)
					end
				end
			end
		--end
	end
)

function createParticle(x,y,z,nx,ny,nz,category,size,lifetime,color,alpha)
	if not color then color = {255,255,255} end
	table.insert(particles, {
		id = id,
		x = x,
		y = y,
		z = z,
		nx = nx,
		ny = ny,
		nz = nz,
		tick = getTickCount(),
		category = category,
		image_id = math.random(1,#textures["smokes"]),
		color = color,
		alpha = alpha,
		lifetime = lifetime,
		forceZ = math.random(2.6,3.4),
		size = size,
	})
	id = id + 1
end

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		id = 1
		textures["smokes"][1] = dxCreateTexture("assets/smokes/1.dds")
		textures["smokes"][2] = dxCreateTexture("assets/smokes/2.dds")
		textures["smokes"][3] = dxCreateTexture("assets/smokes/3.dds")
	end
)

function getProgress(addtick, lastTick) 
    local now = getTickCount() 
    local elapsedTime = now - lastTick 
    local duration = lastTick+addtick - lastTick 
    local progress = elapsedTime / duration 
    return progress 
end 



local raw_shader = [[
	texture gTexture;

	technique hello
	{
	    pass P0
	    {
	        Texture[0] = gTexture;
	    }
	}
]]

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		local shader = dxCreateShader(raw_shader)
		if shader then
			dxSetShaderValue(shader,"gTexture",dxCreateTexture("assets/empty.dds"))
			engineApplyShaderToWorldTexture(shader,"collisionsmoke")
		end
	end
)
