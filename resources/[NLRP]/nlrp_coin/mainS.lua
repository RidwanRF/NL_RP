addEvent("serverElementData",true)
addEventHandler("serverElementData",resourceRoot,
    function(player,data,value)
        setElementData(player,data,value)
    end
)