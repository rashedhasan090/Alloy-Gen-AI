
pred inv12_OK {
 all t : Teacher, c : Class | c -> t in Teaches implies some g : Group | c -> t -> g in Groups 
}