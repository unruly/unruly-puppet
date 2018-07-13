LoadPlugin write_graphite
<Plugin write_graphite>
  <Carbon>
    Host "<%= @backend_host %>"
    Port "<%= @backend_port %>"
    Protocol "tcp"
    Prefix "collectd."
    StoreRates true
    AlwaysAppendDS true
    EscapeCharacter "_"
    LogSendErrors false
  </Carbon>
</Plugin>
