pred noLoopsOK {
	adj & iden = none
}
assert noLoopsRepaired {
   noLoops[]  iff noLoopsOK[]
}