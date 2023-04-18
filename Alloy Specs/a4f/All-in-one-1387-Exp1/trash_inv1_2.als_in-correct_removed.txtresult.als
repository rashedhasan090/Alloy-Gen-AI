The fixed code for the Alloy specification is as follows:

/**
 * Relational logic revision exercises based on a simple model of a 
 * file system trash can.
 * 
 * The model has 3 unary predicates (sets), File, Trash and
 * Protected, the latter two a sub-set of File. There is a binary 
 * predicate, link, a sub-set of File x File.
 *
 * Solve the following exercises using Alloy's relational logic, which
 * extends first-order logic with:
 *
 *      - expression comparisons 'e1 in e2' and 'e1 = e2'
 *      - expression multiplicity tests 'some e', 'lone e', 'no e' and 'one e'
 *      - binary relational operators '.', '->', '&', '+', '-', ':>' and '<:' 
 *      - unary relational operators '~', '^' and '*'
 *      - definition of relations by comprehension
 **/
 
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
    no (Protected & Trash)
}

/* All unprotected files are deleted.. */
pred inv5 {
    (File - Protected) in Trash
}

/* A file links to at most one file. */
pred inv6 {
    all f: File | #(f.link) <= 1
}

/* There is no deleted link. */
pred inv7 {
    no (link & Trash)
}

/* There are no links. */
pred inv8 {
    no link
}

/* A link does not link to another link. */
pred inv9 {
    no (link.link)
}

/* If a link is deleted, so is the file it links to. */
pred inv10 {
    all l: Trash.link | l in Trash
}

/* IFF PERFECT ORACLE */
pred inv1_OK {
    no Trash
}

pred inv2_OK {
    File in Trash
}

pred inv3_OK {
    some Trash
}

pred inv4_OK {
    no (Protected & Trash)
}

pred inv5_OK {
    (File - Protected) in Trash
}

pred inv6_OK {
    all f: File | #(f.link) <= 1
}

pred inv7_OK {
    no (link & Trash)
}

pred inv8_OK {
    no link
}

pred inv9_OK {
    no (link.link)
}

pred inv10_OK {
    all l: Trash.link | l in Trash
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}


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

run inv1_OK for 5

run inv2_OK for 5

run inv3_OK for 5

run inv4_OK for 5

run inv5_OK for 5

run inv6_OK for 5

run inv7_OK for 5

run inv8_OK for 5

run inv9_OK for 5

run inv10_OK for 5