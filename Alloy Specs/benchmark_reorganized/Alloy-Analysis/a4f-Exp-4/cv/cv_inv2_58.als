There is a bug in the original specification in inv2. The expression "w in u.profile" should be enclosed in parentheses to bind it before the "implies" operator. The corrected version of inv2 is:

pred inv2 { // A user profile can only have works added by himself or some external institution
	all u:User, w:Work | (w in u.profile) implies (u in w.source or some i:Institution | i in w.source) 
}

