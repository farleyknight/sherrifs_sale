require_relative 'database'
require 'sinatra'

get '/' do
  public_file 'index.html'
end

get '/properties.js' do
  public_file 'properties.js'
end

get '/bootstrap-spinedit.js' do
  public_file 'bootstrap-spinedit.js'
end

get '/heatmap.js' do
  public_file 'heatmap.js'
end

get '/heatmap-leaflet.js' do
  public_file 'heatmap-leaflet.js'
end

get '/properties.json' do
  puts params.inspect
  properties(params).to_json
end

after { ActiveRecord::Base.connection.close }

def public_file(name)
  File.read(File.join('public', name))
end

def properties(opts = {})
  min_price = (opts['min_price'] || 0).to_i
  max_price = (opts['max_price'] || 20).to_i
  lat       = opts['lat']        || 39.97
  lng       = opts['lng']        || -75.15

  Property.near([lat, lng], 2)
    .where('price_in_dollars > ?', min_price * 1000)
    .where('price_in_dollars < ?', max_price * 1000)
    .order('price_in_dollars desc')
    .limit(100)
end
