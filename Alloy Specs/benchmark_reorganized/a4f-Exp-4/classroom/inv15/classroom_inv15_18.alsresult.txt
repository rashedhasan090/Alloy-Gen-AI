The fixed code is already provided in the comments. There was a missing negation of the second condition in the implication in `inv9`. The corrected `inv9_OK` predicate is:

```
pred inv9_OK {
  all c:Class | lone (Teaches.c & Teacher) 
}
```