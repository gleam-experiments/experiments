import gleam/string

// Define

pub trait Named {
  fn name(self) -> String
}

// compiled to
// -record(namedTrait, {name=undefined}).
// namedTrait_name(Trait) -> element(1, Trait).

// Use the trait, taking any arguments that implement the trait

fn whats_the_name(n: Named) -> String {
  string.append("the name is: ", name(n))
}

// compiles to
// whats_the_name(N, N_Named) ->
//     gleam@string:append(<<"the name is: ">>, (namedTrait_name(N_Named))(N)).

fn two_names(x: Named, y: Named) -> struct(String, String) {
  struct(name(x), name(y))
}

// compiles to
// two_names(X, X_Named, Y, Y_Named) ->
//     {(namedTrait_name(X_Named))(X), (namedTrait_name(Y_Named))(Y)}.

// Define some types that implement the trait

pub struct Cat {
  name: String
}

let trait Cat: Named {
  fn name(self) -> String {
    let Cat(name) = self
    name
  }
}

// compiles to
// namedTrait_Cat() ->
//     {fun namedTrait_Cat_name/1}.
// namedTrait_Cat_name(Self) ->
//     {cat, Name} = Self,
//     Name.

pub enum Person {
  Friend(name: String)
  Stranger
}

let trait Person: Named {
  fn name(self) -> String {
    case self {
      Friend(name) -> name
      Stranger -> "Unknown"
    }
  }
}

// Use the trait, taking arguments of concrete types that implement the trait

pub fn hello_kitty(cat: Cat) -> String {
  string.append("Hello ", name(cat))
}

// There's no need to pass around a trait object here as it can be statically
// resolved. compiled to
// hello_kitty(Cat) ->
//     gleam@string:append(<<"the name is: ">>, namedTrait_name(N)).

// We may want to be able have implementations that depend on other
// implementations

pub struct Wrapper(x) {
  value: x
}

let trait Wrapper(x: Named): Named {
  fn name(self) -> String {
    let Wrapper(x) = self
    name(x)
  }
}

// compiles to
// namedTrait_Wrapper_name(X) ->
//     {namedTrait_trait_Wrapper_name(X)}.
// namedTrait_Wrapper_name(X_Name) ->
//     fun(Self) ->
//         {wrapper, Name} = X,
//         (namedTrait_name(X_Name))(Name).
//     end.

// Deriving trait implementations

pub enum Size {
  Small
  Medium
  Large
}

derive trait Size: Show
derive trait Size: Eq
derive trait Size: Order
derive trait Size: FromAny
derive trait Size: ToAny

pub struct Box(b) {
  boxed: b
}

derive trait Box(Eq): Eq
