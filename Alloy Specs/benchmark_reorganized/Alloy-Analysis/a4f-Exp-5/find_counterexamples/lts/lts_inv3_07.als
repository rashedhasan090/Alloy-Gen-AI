sig State {
        trans : Event -> State
}
sig Init in State {}
sig Event {}

pred inv1 {
	all s: State | some s.trans 
}

pred inv2 {
	one i: Init | i in State
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

pred inv1_OK {
	all s: State | some s.trans 
}

pred inv2_OK {
	one i: Init | i in State
}

pred inv3_OK {
	all s : State, e : Event | lone e.(s.trans) 
}

pred inv4_OK {
 let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
  State in Init.^tr 
}

pred inv5_OK {
	all s:State, s1:State | s.trans.State = s1.trans.State 
}

pred inv7_OK {
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

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

pred repair_pred_1 {
    inv3[] iff inv3_OK[]
}

run repair_pred_1

assert repair_assert_1 {
    inv3[] iff inv3_OK[]
}

check repair_assert_1