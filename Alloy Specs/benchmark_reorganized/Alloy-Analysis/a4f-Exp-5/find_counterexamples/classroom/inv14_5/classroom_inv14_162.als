pred inv14_OK {
      all s : Person, c : Class | some g : c.Groups | 
          (s -> g in Groups) and some t : Teacher | t -> c in Teaches implies t -> s in Tutors 
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}