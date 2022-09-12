locals {
  common_tags = {
    project   = "zarrp"
    lifecycle = "testing"
    owner     = "kieran"
  }

  current_timestamp = timestamp()
  current_day       = formatdate("YYYY-MM-DD", local.current_timestamp)
  current_time      = formatdate("hh:mm:ss", local.current_timestamp)
  current_day_name  = formatdate("EEEE", local.current_timestamp)
  current_datetime  = formatdate("YYYYMMDD-hhmmss", local.current_timestamp)
}