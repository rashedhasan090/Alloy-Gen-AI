There is a bug in the inv2 predicate. The fixed code for inv2 predicate is provided below:

pred inv2 {
	all u:User, w:Work | w in u.profile implies (u in w.source or Institution in w.source) 
}

The Institution needs to be used instead of Institution <: Source.