The bug in this Alloy specification is in the predicate inv10. The correct predicate is:

pred inv10 {
	all c : Class, s : Student | some g : Group | (c -> s -> g in Groups) 
}