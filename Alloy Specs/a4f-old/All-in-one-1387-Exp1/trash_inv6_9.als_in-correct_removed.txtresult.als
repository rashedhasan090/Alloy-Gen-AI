The bug is in the comment for inv6. The correct Alloy code is:

/* A file links to at most one file. */
pred inv6 {
  all f: File | lone f.link
}

/*======== IFF PERFECT ORACLE ===============*/
pred inv6_OK {
  all f: File | lone f.link
}
assert inv6_Repaired {
  inv6[] iff inv6_OK[]
}

check inv6_Repaired expect 0

pred repair_pred_1 {
  inv6[] iff inv6_OK[]
}
run repair_pred_1
assert repair_assert_1 {
  inv6[] iff inv6_OK[]
}
check repair_assert_1