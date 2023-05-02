
/* Every teacher has at least one class assigned. */
pred inv6 {
  all t:Teacher | some t.Teaches 
}