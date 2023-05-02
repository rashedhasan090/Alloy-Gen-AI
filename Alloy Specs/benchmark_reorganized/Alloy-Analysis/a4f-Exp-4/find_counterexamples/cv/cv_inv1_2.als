
pred inv1 {
  all w : Work | some (User<:visible) in w.source implies some w.(User<:profile)  
}