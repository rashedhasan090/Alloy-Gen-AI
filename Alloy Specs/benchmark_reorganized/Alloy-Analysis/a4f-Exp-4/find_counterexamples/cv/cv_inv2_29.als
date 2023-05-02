
pred inv2 {
	all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i = w.source) 
}