The bug in the specification is in the inv4 predicate, where the "no" and "&" operators are used instead of the "not" and "&&" operators. Here is the fixed code:

sig File {
    link: set File
}

sig Trash extends File {}

sig Protected extends File {}

pred inv1 {
    no Trash
}

pred inv2 {
    File in Trash
}

pred inv3 {
    some Trash
}

pred inv4 {
    not (Protected & Trash)
}

pred inv5 {
    (File - Protected) in Trash
}

pred inv6 {
    not (link & ~link)
}

pred inv7 {
    no link.Trash
}

pred inv8 {
    no link
}

pred inv9 {
    no link.link
}

pred inv10 {
    Trash.link in Trash => all t: Trash | (t.link in Trash)
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