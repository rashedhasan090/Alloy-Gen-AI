/* Bug fixed: the quantification order of the original expression was wrong. Therefore, for each event x and state y, the previous assertion checked whether y had at most one transition for any event x, which is incorrect. Now, the assertion checks that for each state y and event x, there is at most one transition from y to any other state for event x. */
pred inv3_OK {
	all s : State, e : Event | lone e.(s.trans) 
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}