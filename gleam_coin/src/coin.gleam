pub enum Method {
  Get
  Head
  Post
  Put
  Delete
  Connect
  Options
  Trace
  Patch
}

pub struct Header {
  name: String
  value: String
}

pub struct Request(assigns) {
  method: Method
  path: List(String)
  headers: List(Header)
  body: Result(Nil, String)
  assigns: assigns
}

pub struct Response {
  status: Int
  headers: List(Header)
  body: String
}

// We have a concept of middleware which can be chained to preprocess a
// request.
//
// A middleware can return `Next` or `Send`. `Next` allows the request to
// continue through the middleware stack, while `Send` causes the server to
// immediately send a response, skipping any following middleware.
//
pub enum MiddlewareAction(assigns) {
  Next(Request(assigns))
  Send(Response)
}

pub type Middleware(assigns_in, assigns_out) =
  fn(Request(assigns_in)) -> MiddlewareAction(assigns_out);

// Wrap a Request so that it can be used by middleware.
//
pub fn into_middleware(request) {
  Next(request)
}

pub fn finally(action, handler) {
  case action {
    Next(request) -> handler(request)
    Send(response) -> response
  }
}

pub fn use(action, middleware) {
  case action {
    Next(request) -> middleware(request)
    Send(response) -> action
  }
}
