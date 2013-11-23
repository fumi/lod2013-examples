#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'bundler/setup'
require 'json'
require 'open-uri'
require 'sinatra'
require 'sinatra/contrib'
require 'sparql/client'

helpers do
  ENDPOINT_DBPEDIA_JAPANESE = "http://ja.dbpedia.org/sparql"

  ##
  # SPARQL Endpoint URIを指定してクエリを投げて，JSONを受け取る
  #
  # @param [String] SPARQL Endpoint URI
  # @param [String] SPARQLクエリ
  # @return [String] JSON文字列
  #
  def query_endpoint_by_open_uri(endpoint, query)
    uri = "#{endpoint}?query=#{CGI.escape(query)}"
    $stderr.puts uri
    open(uri, "Accept" => "application/sparql-results+json").read    
  end
end

##
# トップページの表示
#
get '/' do 
  erb :index
end

##
# 単語からデータ表示
# wordで単語が渡されたときは，それに関係するデータをSPARQLで問い合わせて結果を表示
#
get '/word' do
  @results = []

  if params['word']
    client = SPARQL::Client.new(ENDPOINT_DBPEDIA_JAPANESE)
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

##
# 指定した左上座標(lat1,long1)と右下座標(lat2,long2)の範囲に含まれる
# ポイントデータを100件取得
#
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

  query_endpoint_by_open_uri(ENDPOINT_DBPEDIA_JAPANESE, query)
end

##
# 円グラフ表示
#
get '/piechart' do
  erb :piechart
end
