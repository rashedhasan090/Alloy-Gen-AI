
pred inv1 {
  all u : User | u.visible in u.profile
}

The "some" quantifier is unnecessary and causes a syntax error.