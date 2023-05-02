
pred inv2 { // A user profile can only have works added by himself or some external institution
	all u : User | u.profile.Work.source in u + Institution
} 

Note that we changed the order of quantification to first consider the works in the profile and then look at their source. Also, instead of using set comprehension, we used the dot notation to directly access the source of each work in the profile.