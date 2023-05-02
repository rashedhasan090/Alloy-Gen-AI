/* Fixed code */
pred inv11_OK {
  all c : Class | some g:Group | some t:Teacher | c->t in Teaches implies c->t->g in Groups 
}