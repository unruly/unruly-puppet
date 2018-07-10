LoadPlugin write_graphite
<Plugin write_graphite>
  <Carbon>
    Host "<%= @graphite_host %>"
    Port "<%= @graphite_port %>"
    Protocol "tcp"
    Prefix "collectd."
    StoreRates true
    AlwaysAppendDS true
    EscapeCharacter "_"
    LogSendErrors false
  </Carbon>
</Plugin>