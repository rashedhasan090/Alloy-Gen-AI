/* The set of files in the file system. */
sig File {
	link : set File
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
	File in Trash 
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
	File -- Protected in Trash 
}
/* A file links to at most one file. */
pred inv6 {
	~link . link in iden 
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
	no link.link 
}
/* If a link is deleted, so is the file it links to. */
pred inv10 {
	Trash.link in Trash 
}

/*======== REPAIRED ORACLE ===============*/

/* The trash is empty. */
pred inv1_Repaired {
	no Trash 
}
assert inv1_Repaired {
    inv1[] iff inv1_Repaired[]
}

/* All files are deleted. */
pred inv2_Repaired {
	File in Trash 
}
assert inv2_Repaired {
    inv2[] iff inv2_Repaired[]
}

/* Some file is deleted. */
pred inv3_Repaired {
	some Trash 
}
assert inv3_Repaired {
    inv3[] iff inv3_Repaired[]
}

/* Protected files cannot be deleted. */
pred inv4_Repaired {
	no Protected & Trash 
}
assert inv4_Repaired {
    inv4[] iff inv4_Repaired[]
}

/* All unprotected files are deleted.. */
pred inv5_Repaired {
	File -- Protected in Trash 
}
assert inv5_Repaired {
    inv5[] iff inv5_Repaired[]
}

/* A file links to at most one file. */
pred inv6_Repaired {
	~link . link in iden 
}
assert inv6_Repaired {
    inv6[] iff inv6_Repaired[]
}

/* There is no deleted link. */
pred inv7_Repaired {
	no link.Trash 
}
assert inv7_Repaired {
    inv7[] iff inv7_Repaired[]
}

/* There are no links. */
pred inv8_Repaired {
	no link 
}
assert inv8_Repaired {
    inv8[] iff inv8_Repaired[]
}

/* A link does not link to another link. */
pred inv9_Repaired {
	no link.link 
}
assert inv9_Repaired {
    inv9[] iff inv9_Repaired[]
}

/* If a link is deleted, so is the file it links to. */
pred inv10_Repaired {
	Trash.link in Trash 
}
assert inv10_Repaired {
    inv10[] iff inv10_Repaired[]
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

---- Repairing
pred repair_pred {
	inv10[] iff inv10_Repaired[]
}
run repair_pred
assert repair_assert {
	inv10[] iff inv10_Repaired[]
}
check repair_assert