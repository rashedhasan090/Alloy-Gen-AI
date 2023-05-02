pred inv11_OK {
  all c : Class | (some g:Group | c->g in Groups) implies some t:Teacher | c in t.Teaches 
}