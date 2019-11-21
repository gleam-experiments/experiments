// # EnumerateEnum
//
// Derive a function that lists all varients of an enum.
// Only works for enums where all of the variant constructors have the same
// type i.e. they all have the same number of arguments of the same type. Most
// likely none.
//
//    list()
//    => [North, East, South, West]
//

pub enum Cardinal {
  North
  East
  South
  West
}

pub fn list() -> List(Cardinal)
  = derive EnumerateEnum

// # Coerse
//
// Safely Coerse one type into another that has the same runtime
// representation.
//
//    into_result(Error(1))
//    => Error(1)
//
// OK, this one is hard to display here... Basically it's just a no-op.

pub enum MyError {
  Error(a)
}

pub fn into_result(Error(err)) -> Result(b, err)
  = derive Coerse

// # Compare
//
// Compare two values from an enum where the variant constructors take no
// arguments. The ordering is based upon the ordering the variants are
// described- smallest comes first.
//
//    compare(Small, Medium)
//    => order.Lt
//
//    compare(Medium, Medium)
//    => order.Eq
//
//    compare(Large, Medium)
//    => order.Gt
//

pub enum TshirtSize {
  Small
  Medium
  Large
}

// TODO: Update the external fn syntax to match this new derive one

pub fn compare(TshirtSize, TshirtSize) -> order.Order
  = derive Compare

pub fn compare(TshirtSize, TshirtSize) -> order.Order
  = external "my_mod" "compare"
