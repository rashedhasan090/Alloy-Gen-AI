
pred inv9_OK {
  all c:Class | lone p:Person | p in Teachers.c implies p.Teaches = c
}