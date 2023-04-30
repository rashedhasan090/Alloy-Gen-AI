/* Fixed code for inv14 */
pred inv14_OK {
  all s:Person, c:Class, g:Group | g in c.Groups.s implies all t:Teacher | t->c in Teaches implies t in s.^~Tutors 
}