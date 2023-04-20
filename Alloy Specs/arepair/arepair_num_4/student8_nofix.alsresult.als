The bug in this specification is in the pred Sorted. Specifically, the expression "n.elem <= n.link.elem" should be changed to "n.link.elem <= n.elem" to correctly check that the List is sorted in ascending order based on the elem attribute of the Nodes. The corrected pred Sorted is as follows:

pred Sorted(This: List) {
  all n:Node | n.link = none or n.link.elem <= n.elem
}