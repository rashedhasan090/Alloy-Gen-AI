pred inv10_OK {
  all c:Class, s:Student | some g:Group | s->g in c.Groups 
}