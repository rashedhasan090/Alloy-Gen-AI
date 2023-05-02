sig State {
        trans : Event -> State
}
sig Init in State {}
sig Event {}

pred inv1 {
	all s: State | some s.trans 
}

pred inv2 {
	one Init 
}

pred inv3 {
	all s : State, e : Event | lone e.(s.trans) 
}

pred inv4 {
	let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
	State in Init.^tr 
}

pred inv5 {
	all s:State, s1:State | s.trans.State = s1.trans.State 
}

pred inv6 {
	all e:Event | some s1,s2:State | s1->e->s2 in trans 
}

pred inv7 {
	let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
	all s : Init.^tr | some i : Init | i in s.^tr 
}

check inv1 expect 0
check inv2 expect 0
check inv3 expect 0 
check inv4 expect 0
check inv5 expect 0
check inv6 expect 0
check inv7 expect 0