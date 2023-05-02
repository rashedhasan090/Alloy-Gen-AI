pred inv4_OK {
 all s:State | (some i:Init | i.trans.Event=s) implies s in Init.*trans 
}