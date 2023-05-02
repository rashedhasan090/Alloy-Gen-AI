
/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone (Teaches.c & Teacher) 
}

Here, we use the lone keyword instead of the & operator to ensure that each class has at most one teacher assigned to it. Using & would allow a class to have multiple teachers as long as it also has at least one person who is neither a student nor a teacher in its Groups.