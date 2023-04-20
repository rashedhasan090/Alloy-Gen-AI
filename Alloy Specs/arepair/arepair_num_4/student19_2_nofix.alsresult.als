The bug in the specification is in the pred Count. The line "result = #x" should be changed to "result = #n". 

The fixed pred Count should be:

pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    all n: This.header.*link.elem | x = n
    result = #n
}