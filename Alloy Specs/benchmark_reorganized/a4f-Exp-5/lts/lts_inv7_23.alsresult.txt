pred inv7_OK {
    all x : State, y : Init | some z : Event | (trans in y one -> one z one -> one x) 
}
```