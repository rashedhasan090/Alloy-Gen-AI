
/* There is no deleted link. */
pred inv7 {
 all x,y:File | (x->y in link) implies (x in Trash or y in Trash) 
}