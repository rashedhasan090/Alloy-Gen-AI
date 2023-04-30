pred inv14_OK {
  all s : Student, c : Class, t : Teacher | t -> c in Teaches and (some g : Group | c -> s -> g in Groups) iff t -> s in Tutors 
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}