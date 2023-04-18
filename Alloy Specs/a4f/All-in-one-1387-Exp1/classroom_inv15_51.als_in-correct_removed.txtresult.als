The bug in the specification is in pred inv14. The correct specification is: 


```
/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
  all s : Student, c : Class | (c -> s -> _) in Groups implies all t : Teacher | t -> c in Teaches implies t -> s in Tutors
}
```