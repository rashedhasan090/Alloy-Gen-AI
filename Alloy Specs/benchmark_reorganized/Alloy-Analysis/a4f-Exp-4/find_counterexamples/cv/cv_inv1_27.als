
pred inv1 {
  all w : Work | some (User.visible).w implies some w.(User<:profile)
}