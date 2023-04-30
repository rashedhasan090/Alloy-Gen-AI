```alloy
pred inv4_OK {
 let tr = { s1, s2 : State, e : Event | s1->e->s2 in trans } //fixed
 State in Init.^tr 
}
```