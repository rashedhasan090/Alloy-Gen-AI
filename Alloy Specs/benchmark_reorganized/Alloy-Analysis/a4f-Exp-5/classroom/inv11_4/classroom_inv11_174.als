pred inv11_OK {
  all c : Class, g:Group | some t:Teacher | t in c.Teaches and c.Groups[t]=g 
}