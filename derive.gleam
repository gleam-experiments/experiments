pub derive lens("name")
pub derive lens("email")
pub derive lens("password_hash")

enum Cardinals =
  | North
  | East
  | South
  | West

pub derive enumerate(Cardinals)
pub derive compare(Cardinals)
pub derive to_int(Cardinals)
pub derive from_int(Cardinals)
pub derive to_string(Cardinals)
pub derive from_string(Cardinals)
