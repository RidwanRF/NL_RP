addEventHandler ( "onClientResourceStart", resourceRoot,
	function ()
		txd = engineLoadTXD ( "mk1.txd" );
		engineImportTXD ( txd, 260 );
		dff = engineLoadDFF ( "mk1.dff" );
		engineReplaceModel ( dff, 260 );
	end
);