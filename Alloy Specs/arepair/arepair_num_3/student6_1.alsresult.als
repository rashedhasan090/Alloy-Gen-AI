The bug in this specification is in the predicate Sorted. The comparison should be less than or equal to (<=), but in the current specification it is only less than (<). Change the line:

'all n : This.header.*link | n.elem < n.link.elem'

to

'all n : This.header.*link | n.elem <= n.link.elem'

This will fix the bug and satisfy the assertions.