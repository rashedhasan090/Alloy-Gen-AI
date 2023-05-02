
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
  all c:Class,g:Group,p:Person |some t:Teacher| c->p->g in Groups implies p in t.Teaches 
}