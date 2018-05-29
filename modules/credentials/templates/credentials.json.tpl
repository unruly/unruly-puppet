<%- require 'json' -%>
<%- json_hash = Hash[@config.map{ |key, value| %W(#{@system}_#{@title}_#{key} #{value})} ]; -%>
<%= JSON.generate(json_hash) %>