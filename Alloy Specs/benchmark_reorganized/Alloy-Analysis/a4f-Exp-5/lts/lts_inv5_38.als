//Fixed inv5 predicate
pred inv5_OK {
	all s1,s2: State | s1.trans.State = s2.trans.State 
}