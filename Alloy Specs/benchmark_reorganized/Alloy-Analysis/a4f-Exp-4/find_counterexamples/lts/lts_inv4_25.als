
pred inv4 {
	all s : State | some i : Init | i in s.*(trans)
} 

This version states that for all states, there exists at least one initial state from which that state is reachable through a sequence of transitions.