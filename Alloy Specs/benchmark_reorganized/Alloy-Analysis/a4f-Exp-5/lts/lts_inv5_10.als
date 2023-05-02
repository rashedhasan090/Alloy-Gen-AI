Fixed code:

pred inv5_OK {
	all s:State, e:Event | some s.trans.e 
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

Note: the bug was in the use of "->" instead of "." to refer to the relation between states and events in the helper predicate of inv5.