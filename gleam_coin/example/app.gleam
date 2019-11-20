import coin.{Response, Send, Next, Get, respond, body}
import string

pub fn handle(request) {
  request
    |> coin.into_middleware
    |> coin.use(_, reject_favicon_requests)
    |> coin.finally(_, router)
}

fn router(request) {
  case coin.method(request), coin.path(request) {
    Get, [] ->
      home_page()

    Get, ["profile", name] ->
      profile_page(name)

    _, _ ->
      not_found()
  }
}

fn reject_favicon_requests(request) {
  case request.path {
    ["favicon.ico"] -> Send(Response(404, [], ""))
    _ -> Next
  }
}

fn home_page() {
  Response(200, [], "Welcome!")
}

fn profile_page(name) {
  Response(200, [], string.concat([name, "'s profile"]))
}

fn not_found() {
  Response(404, [], "Page not found")
}
