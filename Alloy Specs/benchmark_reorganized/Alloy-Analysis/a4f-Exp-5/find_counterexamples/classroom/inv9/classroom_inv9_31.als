pred inv9_OK {
  all c:Class | lone Teachers.c 
}

assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

check inv9_Repaired expect 0