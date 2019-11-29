fn one() {
  if is_ok() {
    it_is_ok()
  } else if is_alright() {
    go()
  } else {
    whatever()
  }
}

fn two() {
  if {
    is_ok() -> it_is_ok()
    is_alright() -> go()
    else -> whatever()
  }
}
