
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher |
		some c : t.Teaches |
		some g : Group |
			some s : Student |
				c -> s -> g in Groups
}