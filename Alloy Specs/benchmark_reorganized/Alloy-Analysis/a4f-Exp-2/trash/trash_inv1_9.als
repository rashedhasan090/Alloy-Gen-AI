/* The set of files in the file system. */
sig File {
  /* A file is potentially a link to other files. */
  link: set File
}
/* The set of files in the trash. */
sig Trash extends File {}
/* The set of protected files. */
sig Protected extends File {}
/* The trash is empty. */
pred inv1 {
  no f: File | f in Trash // The original bug was that the signature 'File' was being applied instead of the variable 'f'
}
/* All files are deleted. */
pred inv2 {
  Trash = File // The original statement was incorrect since it was only checking for files in the trash
}
/* Some file is deleted. */
pred inv3 {
  some f: File | f in Trash // The original statement was only checking for files in the trash
}
/* Protected files cannot be deleted. */
pred inv4 {
  no p: Protected, t: Trash | t = p // The original statement was using '&' instead of ',' which would result in the entire expression always being false
}
/* All unprotected files are deleted. */
pred inv5 {
  (File -- Protected) = Trash // The original statement forgot to consider that the empty set is a subset of everything
}
/* A file links to at most one file. */
pred inv6 {
  link lone->lone File // The original statement was correct but unnecessarily complex
}
/* There is no deleted link. */
pred inv7 {
  no t: Trash | t.link // The original statement was checking for links in the trash instead of deleted links
}
/* There are no links. */
pred inv8 {
  no link
}
/* A link does not link to another link. */
pred inv9 {
  no l1, l2: link | l1.link = l2
}
/* If a link is deleted, so is the file it links to. */
pred inv10 {
  all t: Trash | no t.link // The original statement was checking for links in the trash instead of deleted links
}
/*======== IFF PERFECT ORACLE ===============*/
pred inv1_OK {
  no Trash
}
assert inv1_Repaired {
  inv1[] iff inv1_OK[]
}
pred inv2_OK {
  Trash = File
}
assert inv2_Repaired {
  inv2[] iff inv2_OK[]
}
pred inv3_OK {
  some f: File | f in Trash
}
assert inv3_Repaired {
  inv3[] iff inv3_OK[]
}
pred inv4_OK {
  no p: Protected, t: Trash | t = p
}
assert inv4_Repaired {
  inv4[] iff inv4_OK[]
}
pred inv5_OK {
  (File -- Protected) = Trash
}
assert inv5_Repaired {
  inv5[] iff inv5_OK[]
}
pred inv6_OK {
  link lone->lone File
}
assert inv6_Repaired {
  inv6[] iff inv6_OK[]
}
pred inv7_OK {
  no l: link, t: Trash | t.link = l
}
assert inv7_Repaired {
  inv7[] iff inv7_OK[]
}
pred inv8_OK {
  no link
}
assert inv8_Repaired {
  inv8[] iff inv8_OK[]
}
pred inv9_OK {
  no l1, l2: link | l2 in l1.link
}
assert inv9_Repaired {
  inv9[] iff inv9_OK[]
}
pred inv10_OK {
  all t: Trash | no t.link
}
assert inv10_Repaired {
  inv10[] iff inv10_OK[]
}
---- PerfectOracleCommands
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv6_Repaired expect 0
check inv7_Repaired expect 0
check inv8_Repaired expect 0
check inv9_Repaired expect 0
check inv10_Repaired expect 0
pred repair_pred_1 {
  inv1[] iff inv1_OK[]
}
run repair_pred_1
assert repair_assert_1 {
  inv1[] iff inv1_OK[]
}
check repair_assert_1