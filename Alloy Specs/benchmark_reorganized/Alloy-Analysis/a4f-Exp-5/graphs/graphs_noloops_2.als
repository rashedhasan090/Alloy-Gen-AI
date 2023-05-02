pred noLoopsOK {
	no iden & adj //fix: remove the tilde operator (~) before iden
}
assert noLoopsRepaired {
   noLoops[]  iff noLoopsOK[]
}