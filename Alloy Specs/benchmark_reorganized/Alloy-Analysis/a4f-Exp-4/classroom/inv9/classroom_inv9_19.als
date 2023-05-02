
/* No class has more than a teacher assigned. */
pred inv9 {
    all c:Class | lone c.Teacher.Teaches:>c 
} 

And the repaired assertion is:

assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}