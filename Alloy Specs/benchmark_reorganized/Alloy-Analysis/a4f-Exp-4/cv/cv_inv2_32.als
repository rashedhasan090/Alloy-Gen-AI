
pred inv2 { // A user profile can only have works added by himself or some external institution
	all u:User, w:Work | w in u.profile implies (w.source = u or some i:Institution | i in w.source) 
}