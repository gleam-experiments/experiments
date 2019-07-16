// Possible implicit syntax

pub fn sum(collection :: List(t), item :: implicit Monoid(t, _)) {
  list:fold(collection, item:empty(), item:concat)
}
