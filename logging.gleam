fn main() {
  log.metadata(
    [
      log.string("id", "10ba038e"),
      log.string("in", "some_component"),
      log.string("what", "config_change"),
      log.string("result", "error"),
      log.string("reason", "unauthorized"),
      log.object(
        "user",
        [
          log.string("name", "ferd"),
          log.string("role", "member"),
          log.float("score", 12478.54),
          log.int("id", 1337),
        ],
      ),
    ],
  )

  log.emergency([log.string("what", "config_change")])
  log.alert([log.string("what", "config_change")])
  log.critical([log.string("what", "config_change")])
  log.error([log.string("what", "config_change")])
  log.warning([log.string("what", "config_change")])
  log.notice([log.string("what", "config_change")])
  log.info([log.string("what", "config_change")])
  log.debug([log.string("what", "config_change")])

  log.emergency_text("Human readable text")
  log.alert_text("Human readable text")
  log.critical_text("Human readable text")
  log.error_text("Human readable text")
  log.warning_text("Human readable text")
  log.notice_text("Human readable text")
  log.info_text("Human readable text")
  log.debug_text("Human readable text")

  log.emergency_lazy(fn() { [log.string("what", "config_change")] })
  log.alert_lazy(fn() { [log.string("what", "config_change")] })
  log.critical_lazy(fn() { [log.string("what", "config_change")] })
  log.error_lazy(fn() { [log.string("what", "config_change")] })
  log.warning_lazy(fn() { [log.string("what", "config_change")] })
  log.notice_lazy(fn() { [log.string("what", "config_change")] })
  log.info_lazy(fn() { [log.string("what", "config_change")] })
  log.debug_lazy(fn() { [log.string("what", "config_change")] })
}
