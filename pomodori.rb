require 'sinatra'

set :static, true

get '/' do
  haml :index
end

get '/stylesheets/styles.css' do
  scss :styles
end

get '/javascripts/pomodori.js' do
  coffee :pomodori
end
