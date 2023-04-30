//Bug fixed in inv5_OK
pred inv5_OK {
	all e: Event | all s: State | some e.(s.trans) and e in State.evt
}