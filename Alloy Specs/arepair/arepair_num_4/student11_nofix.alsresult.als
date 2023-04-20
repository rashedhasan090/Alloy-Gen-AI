The bug is in the "Sorted" predicate. The constraint "no This.header || all n: This.header.*link | n.elem < n.link.elem" is too restrictive, as it requires all nodes in the list to be sorted in ascending order. To fix it, we need to change the quantifier from "all" to "some", which will allow for the possibility of unsorted nodes in the list:

// Fixed
pred Sorted(This: List) {
     no This.header || some n: This.header.*link | n.elem < n.link.elem
}