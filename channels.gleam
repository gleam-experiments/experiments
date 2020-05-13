import gleam/channel
import gleam/timeout

fn main() {
  let c1 = channel.new
  let c2 = channel.new
  let c3 = channel.new

  receive {
    OneMsgA = c1 -> 1

    OneMsgB = c1 -> 2

    Nil = c2 -> Nil

    timeout.ms(100) -> "No messages"
  }
}
