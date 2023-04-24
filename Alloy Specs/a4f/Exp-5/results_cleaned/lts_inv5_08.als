sig State {
        trans : Event -> State
}
sig Init in State {}
sig Event {}
pred inv1 {
//Bug 
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
//Bug 
//Bug 
 all s : State | some Event.(s.trans) 
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
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
pred inv2_OK {
	one Init 
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
pred inv3_OK {
	all s : State, e : Event | lone e.(s.trans) 
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}
pred inv4_OK {
 let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
  State in Init.^tr 
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
pred inv5_OK {
	all s:State, s1:State | s.trans.State = s1.trans.State 
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}
pred inv7_OK {
let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
	all s : Init.^tr | some i : Init | i in s.^tr 
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}
 check inv1_Repaired expect 0
 check inv2_Repaired expect 0
 check inv3_Repaired expect 0 
 check inv4_Repaired expect 0
 check inv5_Repaired expect 0
 check inv7_Repaired expect 0
pred repair_pred_1{inv5[] iff inv5_OK[] }
run repair_pred_1
assert repair_assert_1{inv5[] iff inv5_OK[] }
check repair_assert_1
