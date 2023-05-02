pred inv14_OK {
  all s:Student, c:Class, g:Group | (c->g) in Groups.s implies some t:Teacher | t->c in Teaches and t->g in c.Groups and t in s.^~Tutors
}