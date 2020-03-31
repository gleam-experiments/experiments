// An idea for effects in Gleam

import gleam/io
import gleam/result

// A function annotated with the IO effect. If the effect annotation was
// neglected it would be inferred by the fact that io.read_line has the IO
// effect
pub fn read_string() effect(IO) -> String
{
  io.read_line()
}

// This function uses the Assert effect
pub fn unsafe_unwrap(x: Result(a, e)) effect(Assert) -> a
{
  assert Ok(a) = x
  a
}

// This function calls a function that has the IO effect and another that has
// the Assert effect, so it has both the IO and Assert effects. If the
// annotation was not given this would be inferred.
pub fn get_content() -> effect(IO, Assert) String
{
  read_line() |> unsafe_unwrap
}

// This function's effect annotation says that it may have any effects `a`, but
// that `a` effects do not include the effects IO or Assert.
pub fn render_view(view: fn() -> String) effect(a | -IO, -Assert) -> String
{
  view()
}

pub fn main() effect(IO, Assert) -> String
{
  // This won't compile as in this case the effects of IO and Assert are
  // happening inside the call to render_view, which is annotated as not having
  // the IO or Assert effects
  render_view(get_content)

  // This will compile as the effects happen outside of render_view
  let s = get_content()
  render_view(fn() { s })
}

// The syntax is something we can bikeshed over too.
