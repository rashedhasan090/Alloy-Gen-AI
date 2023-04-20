The bug is in the "Sorted" predicate. 

The correct predicate should be:

pred Sorted(This: List) {
    all l: This.header.*link | l = last[l].header.*link implies last[l].link = none
    all n: This.header.*link | n.link in n.*(~link).elem
} 

The bug is in the "all" quantification. Instead of "all n: This.header.*link", it should be "all l: This.header.*link", since we need to consider all links in the list. The predicate should then specify that the last link in the list should not link to any node, and that for any node, its link should have a smaller or equal element value.