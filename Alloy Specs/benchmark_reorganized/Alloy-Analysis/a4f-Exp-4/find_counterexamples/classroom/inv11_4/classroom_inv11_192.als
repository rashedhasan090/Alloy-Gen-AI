
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class,g:Group| some t:Teacher | (c -> t -> g) in Groups and t in c.Teaches
}