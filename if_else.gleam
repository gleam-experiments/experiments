// # 1: C style
fn one() {
  if is_ok() {
    it_is_ok()
  } else if is_alright() {
    go()
  } else {
    whatever()
  }

  if is_ok() {
    go_one()
    go_two()
  } else if is_alright() {
    go()
  } else {
    whatever()
  }

  if is_ok() {
    it_is_ok()
  }

  if is_ok() { it_is_ok() }

  if is_ok() {
    go_one()
    go_two()
  }
}

// # 2: case similar style, braces required
fn two() {
  if {
    is_ok() -> it_is_ok()
    is_alright() -> go()
    else -> whatever()
  }

  if {
    is_ok() -> {
      go_one()
      go_two()
    }
    is_alright() -> go()
    else -> whatever()
  }

  if {
    is_ok() -> it_is_ok()
  }

  if {
    is_ok() -> {
      go_one()
      go_two()
    }
  }
}

// # 3: case similar style, braces optional
fn three() {
  if {
    is_ok() -> it_is_ok()
    is_alright() -> go()
    else -> whatever()
  }

  if {
    is_ok() -> {
      go_one()
      go_two()
    }
    is_alright() -> go()
    else -> whatever()
  }

  if is_ok() -> it_is_ok()

  if is_ok() -> {
    go_one()
    go_two()
  }
}
