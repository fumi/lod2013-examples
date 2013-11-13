# -*- coding: utf-8 -*-
<% content_for :header do %>
  <title>DBpedia Japanese データ表示</title>
<% end %>

<h1>DBpedia Japanese データ表示</h1>

<form role="form" class="form-inline" action="/word" method="GET">
  <div class="form-group">
    <label class="sr-only" for="word">Word</label>
    <input type="text" class="form-control" name="word" id="word" placeholder="東京都">
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>

<table class="table">
  <thead>
    <tr><th>p</th><th>o</th></tr>
  </thead>
  <thead>
<% @results.each do |solution| %>
    <tr><td><%= solution[:p] %></td><td><%= solution[:o] %></td></tr>
<% end %>
  </tbody>
</table>