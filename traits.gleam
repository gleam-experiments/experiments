import gleam/string

// Define

pub trait Named {
  fn name(self) -> String
}

// Use the trait, taking any arguments that implement the trait

fn whats_the_name(n: T) -> String
where T: Named {
  string.append("the name is:", name(n))
}

fn two_names(x: X, y: Y) -> {String, String}
where X: Named, Y: Named {
  {name(x), name(y)}
}

// Define some types that implement the trait

pub enum Cat =
  | Cat(String)

implement Pet: Named {
  fn name(self) -> String {
    let Cat(name) = self
    name
  }
}

pub enum Person =
  | Friend(String)
  | Stranger

implement Person: Named {
  fn name(self) -> String {
    case self {
    | Friend(name) -> name
    | Stranger -> "Unknown"
    }
  }
}

// Use the trait, taking arguments of concrete types that implement the trait

pub fn hello_kitty(cat: Cat) -> String {
  string.append("Hello ", name(cat))
}

// Deriving trait implementations

pub enum Size =
  | Small
  | Medium
  | Large

derive Size: Show
derive Size: Eq
derive Size: Order
derive Size: FromAny
derive Size: ToAny

pub struct Box(b) {
  boxed: b
}

derive Box(Boxed): Eq
where Boxed: Eq
