The bug in the specification is in the predicate Sorted. The condition "n.elem <= n.link.elem" should be "n.elem <= (n.link).elem", as link is a set and needs to be specified which element in the set is being compared. 

Here is the fixed predicate:

pred Sorted(This: List) {
    all n: This.header.*link | n.elem <= (n.link).elem
}