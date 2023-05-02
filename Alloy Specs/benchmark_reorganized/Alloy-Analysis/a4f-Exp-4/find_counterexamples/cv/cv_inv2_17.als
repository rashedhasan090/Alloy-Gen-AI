
pred inv2 { 
	all u : User | (u.profile <: Work[source = u]) + (u.profile <: Work[source = Institution]) = u.profile
}

The corrected predicate checks that the works in a user's profile are either added by the user or by an external institution.

