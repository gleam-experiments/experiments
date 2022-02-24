import gleam/result
import app/db

pub fn main() {
  db.connect(fn(db) {
    result.then(db.create_user(db, "Tim"), fn(user) {
      Ok(Nil)
    })
  })
}

pub fn main() {
  with db = db.connect()
  with user = result.then(db.create_user("Tim"))
  Ok(Nil)
}
