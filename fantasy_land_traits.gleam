pub trait Setoid {
  fn equals(Self, Self) -> Bool
}

pub trait Ord {
  fn less_than_equal(Self, Self) -> Bool
}

pub trait Semigroup {
  fn concat(Self, Self) -> Self
}

pub trait Monoid: Semigroup {
  fn empty() -> Self
}

pub trait Group: Monoid {
  fn invert(Self) -> Self
}

pub trait Semigroupoid {
  fn compose(Self(i, j), Self(j, k)) -> Self(i, k)
}

pub trait Category: Semigroupoid {
  fn id() -> Self(i, k)
}

pub trait Filterable {
  fn filter(Self(a), fn(a) -> Bool) -> Self(a)
}

pub trait Functor {
  fn map(Self(a), fn(a) -> b) -> Self(b)
}

pub trait Contravariant {
  fn contramap(Self(b), fn(a) -> b) -> Self(a)
}

pub trait Apply: Functor {
  fn ap(Self(fn(a) -> b), Self(a)) -> Self(b)
}

pub trait Apply {
  fn ap(Self(fn(a) -> b), Self(a)) -> Self(b)
}

pub trait Applicative: Apply {
  fn of(a) -> Self(a)
}

pub trait Alt: Functor {
  fn alt(Self(a), Self(a)) -> Self(a)
}

pub trait Plus: Alt {
  fn zero() -> Self(a)
}

pub trait Alternative: Applicative + Plus

pub trait Chain: Apply {
  fn chain(Self(a), fn(a) -> Self(b)) -> Self(b)
}

pub trait Monad: Applicative + Self + Chain

pub trait Foldable {
  fn reduce(Self(b), a, fn(a) -> b) -> b
}

pub trait Extend: Functor {
  fn extend(Self(a), fn(Self(a)) -> a) -> Self(b)
}

pub trait Comonad: Extend {
  fn extract(Self(a)) -> a
}

pub trait Traversable {
  fn traverse(Self(a), Applicative(u), u(b)) -> u(Self(b))
}
