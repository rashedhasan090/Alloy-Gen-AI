Fixed code:

pred inv5_OK {
	all e : Event | all s, s' : State | (s.trans & e) = (s'.trans & e)
}