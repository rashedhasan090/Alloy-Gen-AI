The bug in the specification is in the predicate 'Sorted'. It over-constrains the model by requiring that there should be no nodes with a link. This is not necessary for a sorted list and can prevent some valid models from being generated.

The corrected 'Sorted' predicate is:

pred Sorted(This: List) {
     no This.header || all n: This.header.*link |
          no n.link || n.elem < n.link.elem
}

With this correction, the assertions pass and the model is valid.