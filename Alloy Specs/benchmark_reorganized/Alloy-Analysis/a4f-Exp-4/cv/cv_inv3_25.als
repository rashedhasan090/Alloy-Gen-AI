
pred inv3_OK {
		all w1, w2 : Work, u : User | w1 != w2 and (w1 + w2) in u.profile and (w1.source = w2.source) implies no w1.ids & w2.ids 
}

with "&" between w1.ids and w2.ids.