pub struct MyStruct(x) {
  call: fn(x) -> x
}

fn use_it(s: MyStruct(x)) -> x {
  let call = m.call
  call()
}

pub fn make(call) -> MyStruct(x) {
  MyStruct(
    call: call
  )
}
