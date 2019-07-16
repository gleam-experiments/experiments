import gleam/string

// Define

trait Named {
  fn name(self) -> String
}

// Use the trait, taking any arguments that implement the trait

fn whats_the_name(n: T) -> String
where T: Named {
  {"the name is:", name(n)}
}

fn two_names(x: X, y: Y) -> String
where X: Named, Y: Named {
  {"the name is:", name(n)}
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
