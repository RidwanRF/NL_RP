
col = engineLoadCOL( "a.col" )
dff = engineLoadDFF( "a.dff" )

engineImportTXD( txd, 5131 )
engineReplaceCOL( col, 5131 )
engineReplaceModel( dff, 5131 )-- replace the model at least
