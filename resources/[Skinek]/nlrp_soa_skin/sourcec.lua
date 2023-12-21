
--===============================[player skinek]===============================



txd = engineLoadTXD ( "other/soa1.txd" ) 
engineImportTXD ( txd, 101 )
dff = engineLoadDFF ( "other/soa1.dff", 101 ) 
engineReplaceModel ( dff, 101)

txd = engineLoadTXD ( "other/soa2.txd" ) 
engineImportTXD ( txd, 102 )
dff = engineLoadDFF ( "other/soa2.dff", 102 ) 
engineReplaceModel ( dff, 102)

txd = engineLoadTXD ( "other/soa3.txd" ) 
engineImportTXD ( txd, 104 )
dff = engineLoadDFF ( "other/soa3.dff", 104 ) 
engineReplaceModel ( dff, 104)

txd = engineLoadTXD ( "other/soa4.txd" ) 
engineImportTXD ( txd, 105 )
dff = engineLoadDFF ( "other/soa4.dff", 105 ) 
engineReplaceModel ( dff, 105)