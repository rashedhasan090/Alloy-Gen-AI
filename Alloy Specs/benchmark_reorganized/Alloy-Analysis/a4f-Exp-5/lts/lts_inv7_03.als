pred inv7_OK {
	all e:Event,s1,s2:State |some e1:Event| s1->e->s2 in trans implies s2->e1->s1 in trans 
}
assert inv7_Repaired {
let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
all s : Init.^tr | some i : Init | i in s.^tr 
inv7_OK[]
}