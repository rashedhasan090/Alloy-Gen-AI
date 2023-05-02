The fixed code for inv5 is:

pred inv5_OK {
	all x, y : State | x.trans.Event = y.trans.Event 
}

Note that we need to compare the Event sets, not the State sets, to check that all states have the same events available.