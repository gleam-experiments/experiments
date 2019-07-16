trait Named {
  fn name(self) -> String
}

fn whats_the_name(n: Named) -> String {
  {"the name is:", name(n)}
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
