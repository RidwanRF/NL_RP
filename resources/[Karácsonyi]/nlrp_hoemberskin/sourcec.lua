
txd = engineLoadTXD ( "other/a.txd" ) 
engineImportTXD ( txd, 56 )
dff = engineLoadDFF ( "other/a.dff", 56 ) 
engineReplaceModel ( dff, 56)
