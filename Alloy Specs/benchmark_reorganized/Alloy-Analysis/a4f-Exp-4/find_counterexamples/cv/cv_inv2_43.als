
pred inv2 {
	all u : User | (u.profile.Work & Institution.source.Work) = none
} 

Here, we are checking that the intersection between the User's profile and Institution's source Work is empty. This ensures that only works added by the User or some external Institution are part of the User's profile. 

The rest of the code remains the same.