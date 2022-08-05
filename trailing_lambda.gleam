pub fn one_example() -> Promise(Int) {
  async_function()
  |> promise.then(fn(x) {
    let y = sync_function()
    async_function()
    |> promise.then(fn(z) {
      promise.resolve(x + y + z)
    })
  })
}

pub fn one_example_with() -> Promise(Int) {
  with x <- async_function() |> promise.then
  let y = sync_function()
  with z <- async_function() |> promise.then
  promise.resolve(x + y + z)
}

pub fn one_example_do() -> Promise(Int) {
  do x <- async_function() |> promise.then
  let y = sync_function()
  do z <- async_function() |> promise.then
  promise.resolve(x + y + z)
}


pub fn one_example_let() -> Promise(Int) {
  let x <- async_function() |> promise.then
  let y = sync_function()
  let z <- async_function() |> promise.then
  promise.resolve(x + y + z)
}
