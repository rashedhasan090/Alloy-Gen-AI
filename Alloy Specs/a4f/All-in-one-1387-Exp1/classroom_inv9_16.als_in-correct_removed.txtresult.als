pred inv9_OK {
  all c:Class | lone Teaches.c & Teacher 
}

assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

check inv9_Repaired expect 0

pred repair_pred_1{inv9[] iff inv9_OK[] }

run repair_pred_1

assert repair_assert_1{inv9[] iff inv9_OK[] }

check repair_assert_1