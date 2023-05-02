pred inv11_OK {
  all c : Class, g : Group | (some c.Groups) implies some t : Teacher | c -> t -> g in Groups and t -> c in Teaches 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}