
Fixed code:

/* A class has groups only if it has a teacher assigned. */
pred inv11 {
    all c : Class | some Groups.c implies some Teaches.c 
}