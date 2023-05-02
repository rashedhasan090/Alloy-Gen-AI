/* The set of files in the file system. */
sig File {
  	link : set File /* A file can link to other files. */
}
/* The set of files in the trash. */
sig Trash extends File {}
/* The set of protected files. */
sig Protected extends File {}
/* The trash is empty. */
pred inv1 {
	no Trash
}
/* All files are deleted. */
pred inv2 {
	File -- Trash = Protected
}
/* Some file is deleted. */
pred inv3 {
	some Trash
}
/* Protected files cannot be deleted. */
pred inv4 {
	no Protected & Trash
}
/* All unprotected files are deleted.. */
pred inv5 {
	File -- Protected = Trash
}
/* A file links to at most one file. */
pred inv6 {
	acyclic ~link
}
/* There is no deleted link. */
pred inv7 {
	no link.Trash
}
/* There are no links. */
pred inv8 {
	no link
}
/* A link does not link to another link. */
pred inv9 {
	all l: link | lone l.link
}
/* If a link is deleted, so is the file it links to. */
pred inv10 {
	all f,g:File | f->g in link && f in Trash implies g in Trash
}

/*======== IFF PERFECT ORACLE ===============*/

pred inv1_OK {
	no Trash
}
assert inv1_Repaired {
    inv1[] <=> inv1_OK[]
}

pred inv2_OK {
	File -- Trash = Protected
}
assert inv2_Repaired {
    inv2[] <=> inv2_OK[]
}

pred inv3_OK {
	some Trash
}
assert inv3_Repaired {
    inv3[] <=> inv3_OK[]
}

pred inv4_OK {
	no Protected & Trash
}
assert inv4_Repaired {
    inv4[] <=> inv4_OK[]
}

pred inv5_OK {
	File -- Protected = Trash
}
assert inv5_Repaired {
    inv5[] <=> inv5_OK[]
}

pred inv6_OK {
	acyclic ~link
}
assert inv6_Repaired {
    inv6[] <=> inv6_OK[]
}

pred inv7_OK {
	no link.Trash
}
assert inv7_Repaired {
    inv7[] <=> inv7_OK[]
}

pred inv8_OK {
	no link
}
assert inv8_Repaired {
    inv8[] <=> inv8_OK[]
}

pred inv9_OK {
	all l: link | lone l.link
}
assert inv9_Repaired {
    inv9[] <=> inv9_OK[]
}

pred inv10_OK {
	all f,g:File | f->g in link && f in Trash implies g in Trash
}
assert inv10_Repaired {
    inv10[] <=> inv10_OK[]
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
 
 ---- RepairedCommands
 pred repair_pred_1{
 	all f,g:File | f->g in link && f in Trash implies g in Trash
}
run repair_pred_1
assert repair_assert_1{
	all f,g:File | f->g in link && f in Trash implies g in Trash
}
check repair_assert_1