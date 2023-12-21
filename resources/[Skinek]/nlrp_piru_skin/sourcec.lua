
txd = engineLoadTXD ( "piru/p2.txd" ) 
engineImportTXD ( txd, 256 ) 
dff = engineLoadDFF ( "piru/p2.dff", 256 ) 
engineReplaceModel ( dff, 256)

txd = engineLoadTXD ( "piru/p3.txd" ) 
engineImportTXD ( txd, 254 ) 
dff = engineLoadDFF ( "piru/p3.dff", 254 ) 
engineReplaceModel ( dff, 254)

txd = engineLoadTXD ( "piru/pi4.txd" ) 
engineImportTXD ( txd, 245 ) 
dff = engineLoadDFF ( "piru/pi4.dff", 245 ) 
engineReplaceModel ( dff, 245)

txd = engineLoadTXD ( "piru/p5.txd" ) 
engineImportTXD ( txd, 232 ) 
dff = engineLoadDFF ( "piru/p5.dff", 232 ) 
engineReplaceModel ( dff, 232)

txd = engineLoadTXD ( "piru/p6.txd" ) 
engineImportTXD ( txd, 231 ) 
dff = engineLoadDFF ( "piru/p6.dff", 231 ) 
engineReplaceModel ( dff, 231)
