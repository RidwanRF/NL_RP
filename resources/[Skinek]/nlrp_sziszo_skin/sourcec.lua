
txd = engineLoadTXD ( "other/a.txd" ) 
engineImportTXD ( txd, 129 )
dff = engineLoadDFF ( "other/a.dff", 129 ) 
engineReplaceModel ( dff, 129)

txd = engineLoadTXD ( "other/sziszo2.txd" ) 
engineImportTXD ( txd, 247 )
dff = engineLoadDFF ( "other/sziszo2.dff", 247 ) 
engineReplaceModel ( dff, 247)
