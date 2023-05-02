
Fixed inv5 predicate:

pred inv5 {
	all s:State, s1:State | s.trans.Event = s1.trans.Event 
}