
```
pred inv4_OK {
  all p:Person | (p in Student) xor (p in Teacher)
}
assert inv4_Repaired {
  inv4[] iff inv4_OK[]
}
```