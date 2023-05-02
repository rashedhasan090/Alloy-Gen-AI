The bug in the Sorted predicate is that it is comparing the elements of a node with the elements of its single link, instead of comparing the elements of a node with the elements of all of its links. This can be fixed by changing the predicate as follows:

// Fixed
pred Sorted ( This : List ) {
    all n: This.header.*link | all m: n.link | n.elem <= m.elem
}

The repaired assertion and predicate are as follows:

assert repair_assert_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | no n.link or all m: n.link | n.elem <= m.elem }
}
check repair_assert_1

pred repair_pred_1 {
    all l: List | Sorted[l] <=> { all n: l.header.*link | no n.link or all m: n.link | n.elem <= m.elem }
}
run repair_pred_1

With this fix, all the assertions should pass.