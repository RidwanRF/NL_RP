
txd = engineLoadTXD ( "other/90.txd" ) 
engineImportTXD ( txd, 90 )
dff = engineLoadDFF ( "other/90.dff", 90 ) 
engineReplaceModel ( dff, 90)

