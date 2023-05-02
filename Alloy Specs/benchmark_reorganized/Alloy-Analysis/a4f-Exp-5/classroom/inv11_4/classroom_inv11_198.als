pred inv11_OK {
  all c : Class, s:Student | (some c.Groups) implies some t:Teacher & t->c in Teaches and c->s->(c.Groups).t
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
```