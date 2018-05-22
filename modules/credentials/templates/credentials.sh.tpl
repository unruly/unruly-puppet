<% @config.each do |k, v| -%>
<%= @system + "_" + @title + "_" + k %>=<%= v %>
<% end -%>