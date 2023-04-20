The bug in this specification is in the "pred Contains" predicate. The logic of the predicate is incorrect. The fixed predicate is:

pred Contains(This: List, x: Int, result: Boolean) {
    RepOk[This]
    result = False
    some n: This.header.*link | n.elem = x implies result = True
} 

The predicate first sets the result to False and then checks if there is any node with the element "x". If there is, then it sets the result to True. If there isn't, then the result remains False.