local betoltendoObjektek = {
	
}


function startLoading()
	for i,c in ipairs(betoltendoObjektek) do
		ChangeObjectModel(c[1],c[2])
	end
end
addEventHandler("onClientResourceStart",getRootElement(),startLoading)

function ChangeObjectModel (filename,id)
	if id and filename then
		if fileExists("objs/"..filename..".txd") then
			txd = engineLoadTXD( "objs/"..filename..".txd", true)
			engineImportTXD( txd, id )
		end
		if fileExists("objs/"..filename..".dff") then
			dff = engineLoadDFF( "objs/"..filename..".dff", 0)
			engineReplaceModel( dff, id )
		end
		if fileExists("objs/"..filename..".col") then
			col = engineLoadCOL( "objs/"..filename..".col" )
			engineReplaceCOL( col, id )
		end
	end
end


