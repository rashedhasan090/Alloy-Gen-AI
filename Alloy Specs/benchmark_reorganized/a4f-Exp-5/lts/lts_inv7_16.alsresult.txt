There is a bug in `inv7` that prevents it from being satisfied by the model. The corrected definition of `inv7` is:

```
pred inv7 {
  //Fixed
  all x : Event | some Init.(^(~(trans.x))) and some Init.(trans.x)
}
```