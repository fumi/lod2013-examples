#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'json'
require 'open-uri'
require 'sinatra'
require 'sinatra/contrib'
require 'sparql/client'

helpers do
  ENDPOINT = "http://ja.dbpedia.org/sparql"

  def query_endpoint_by_open_uri(endpoint, query)
    uri = "#{ENDPOINT}?query=#{CGI.escape(query)}"
    $stderr.puts uri
    open(uri, "Accept" => "application/sparql-results+json").read    
  end
end

get '/' do 
  erb :index
end

##
# DBpedia Japaneseから単語を引っ張ってくる
#
get '/word' do
  @results = []

  if params['word']
    client = SPARQL::Client.new(ENDPOINT)
    query = <<-EOQ
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT *
WHERE {
  ?s rdfs:label "#{params['word']}"@ja ;
    ?p ?o .
}
LIMIT 100
EOQ
    $stderr.puts query
    @results = client.query(query)
  end
  erb :word
end

##
# 地図表示
#
get '/map' do
  erb :map
end

get '/map/:lat1/:long1/:lat2/:long2' do
  query = <<-EOQ
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX geo: <http://www.w3.org/2003/01/geo/wgs84_pos#>

SELECT *
WHERE {
  ?s rdfs:label ?label ;
    geo:lat ?lat ;
    geo:long ?long .
  FILTER (?lat > "#{params[:lat1]}"^^xsd:float &&
          ?lat < "#{params[:lat2]}"^^xsd:float &&
          ?long > "#{params[:long1]}"^^xsd:float &&
          ?long < "#{params[:long2]}"^^xsd:float)
}
LIMIT 100
EOQ

  query_endpoint_by_open_uri(ENDPOINT, query)
end