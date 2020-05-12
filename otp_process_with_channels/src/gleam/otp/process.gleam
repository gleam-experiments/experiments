// TODO: async send
// TODO: sync send
// TODO: README
// TODO: monitor
// TODO: processes that trap exit
// TODO: processes that monitor
import gleam/atom
import gleam/dynamic.{Dynamic}

/// A Pid (or Process identifier) is a reference to an OTP process, which is a
/// lightweight thread that communicates by sending and receiving messages.
///
/// It can be thought of as the address of a process, similar to the IP address
/// of a website. If we have a Pid we can make requests to the process, and if
/// the process is alive it can react to those messages.
///
pub external type Pid(accepted_message)

/// UnknownMessage is a type that has no values, it can never be constructed!
///
/// This is useful because we can safely cast a Pid of dynamic message type to a Pid
/// of with message type of UnknownMessage as there's no risk of a
/// UnknownMessage value being sent to the process.
///
pub external type UnknownMessage

/// Cast a Pid with a known message type to one with an unknown message type,
/// erasing type information and making it impossible to send messages to.
///
/// This may be useful for when you wish to have a list or other data structure
/// of Pids but don't care about what messages they can receieve.
///
pub external fn make_opaque(Pid(msg)) -> Pid(UnknownMessage) =
  "gleam_otp_process_external" "cast"

/// Check to see whether the process for a given Pid is alive.
///
/// See the [Erlang documentation][erl] for more information.
/// [erl]: http://erlang.org/doc/man/erlang.html#is_process_alive-1
///
pub external fn is_alive(Pid(msg)) -> Bool =
  "erlang" "is_process_alive"

/// Sends an exit signal to a process, indicating that that process is to shut
/// down.
///
/// See the [Erlang documentation][erl] for more information.
/// [erl]: http://erlang.org/doc/man/erlang.html#exit-2
///
pub external fn send_exit(to: Pid(msg), because: reason) -> Nil =
  "gleam_otp_process_external" "send_exit"

pub external type Timeout

pub external type DebugOptions

pub type Msg(msg) {
  Async(msg)
  None
}

pub type Self(msg) {
  Self(parent: Pid(UnknownMessage), pid: Pid(msg), debug: DebugOptions)
}

pub type StartResult(msg) =
  Result(Pid(msg), String)

// TODO: document
// TODO: test
// Start a linked process
//
pub external fn start(routine: fn(Self(msg)) -> anything) -> StartResult(msg) =
  "gleam_otp_process_external" "start"

// TODO: document
// TODO: test
//
pub external fn receive(self: Self(msg), Timeout) -> Msg(msg) =
  "gleam_otp_process_external" "start"
