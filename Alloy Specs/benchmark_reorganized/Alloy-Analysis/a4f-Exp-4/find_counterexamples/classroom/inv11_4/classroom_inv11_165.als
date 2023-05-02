```
pred inv11_OK {
  all c : Class | (some c.Groups) implies some t : Teacher | c -> t -> Groups 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
```