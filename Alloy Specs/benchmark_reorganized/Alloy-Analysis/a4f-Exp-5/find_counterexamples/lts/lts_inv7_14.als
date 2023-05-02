sig State {
        trans : Event -> State
}
sig Init in State {}
sig Event {}

pred inv1 {
	all s: State | some s.trans 
}

pred inv2 {
	one s: Init 
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
 all x : Event | some (*(~(trans.x))).Init 
}

pred inv7_OK {
let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
	all s : Init.^tr | some i : Init | i in s.^tr 
}

run {
    assert inv1[] and inv2[] and inv3[] and inv4[] and inv5[] and inv6[] and inv7[]
    assert inv1_Repaired[] and inv2_Repaired[] and inv3_Repaired[] and inv4_Repaired[] and inv5_Repaired[] and inv7_Repaired[]
    assert repair_assert_1[]
} for 3 State, 3 Init, 3 Event, 8 trans, 2 disj, 2 trans.Init, 2 trans.Event0, 2 trans.Event1, 2 trans.Event2, 2 trans.Init0, 2 trans.Init1, 2 trans.Init2  , 8 trans.trans