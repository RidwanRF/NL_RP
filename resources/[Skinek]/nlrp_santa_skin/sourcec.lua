
txd = engineLoadTXD ( "other/195.txd" ) 
engineImportTXD ( txd, 195 )
dff = engineLoadDFF ( "other/195.dff", 195 ) 
engineReplaceModel ( dff, 195)

