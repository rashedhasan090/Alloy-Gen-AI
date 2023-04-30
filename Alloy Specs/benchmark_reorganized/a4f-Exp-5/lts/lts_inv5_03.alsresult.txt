Fixed code:

pred inv5_OK {
	all s:State, s1:State | Event in s.(trans.s1)
}