pred inv7_OK {
	all s1,s2:State, e1,e2:Event  | s1->e1->s2 in trans implies (s2->e2->s1 in trans or (s1=e2 and s1 in Init))
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}