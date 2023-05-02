/* The set of files in the file system. */
sig File {
  	/* A file is potentially a link to other files. */
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
 all f,g:File | f->g in link implies g not in Trash 
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

/*======== IFF PERFECT ORACLE ===============*/

/* Repairing the bug in inv7 predicate -- fixing the implication */
pred inv7_OK {
 all f,g:File | f->g in link implies g not in Trash 
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

---- PerfectOracleCommands
check inv1 expect 0
check inv2 expect 0
check inv3 expect 0 
check inv4 expect 0
check inv5 expect 0
check inv6 expect 0
check inv7_Repaired expect 0
check inv8 expect 0
check inv9 expect 0
check inv10 expect 0