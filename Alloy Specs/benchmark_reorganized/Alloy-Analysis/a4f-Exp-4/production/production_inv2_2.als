
pred inv2 { // A component cannot be a part of itself
    no c: Component | c in c.^parts
}