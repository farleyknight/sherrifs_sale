
require_relative 'database'
require 'sinatra'

get '/' do
  public_file 'index.html'
end

get '/properties.js' do
  public_file 'properties.js'
end

get '/properties.json' do
  # Property.where('price_in_dollars > 0').limit(50).to_json
  Property.where('price_in_dollars > 0').to_json
end

def public_file(name)
  File.read(File.join('public', name))
end
