
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
 all c:Class , t:Teacher, g:Group, s:Student | (t->c in Teaches and c.Groups[s] = g) implies t->s in Tutors 
}