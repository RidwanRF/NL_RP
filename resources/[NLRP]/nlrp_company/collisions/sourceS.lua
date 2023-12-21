
local created_cols = {}

addEventHandler("onResourceStart",resourceRoot,
	function()
		for line,row in ipairs(collisions) do
			local col = createColPolygon(0,0,unpack(row))
			setElementData(col,"company.Col",true)
			created_cols[col] = true
		end
	end
)

addEventHandler("onElementColShapeHit",root,
	function(col,dim)
		if col and dim then
			if created_cols[col] then
				for k,v in ipairs(getElementsByType("player")) do
					triggerClientEvent(v,"toggleVehicleCollisions",v,source,false)
				end
			end
		end
	end
)

addEventHandler("onElementColShapeLeave",root,
	function(col,dim)
		if col and dim then
			if created_cols[col] then
				if not created_cols[isElementWithinAColShape(source)] then
					for k,v in ipairs(getElementsByType("player")) do
						triggerClientEvent(v,"toggleVehicleCollisions",v,source,true)
					end
				end
			end
		end
	end
)

function isElementWithinAColShape(element)
   if element or isElement(element)then
      for _,colshape in ipairs(getElementsByType("colshape"))do
	 if isElementWithinColShape(element,colshape) then
	    return colshape
	 end
      end
   end
   return false
end