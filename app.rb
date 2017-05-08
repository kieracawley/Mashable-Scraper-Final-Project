require 'sinatra'

get '/' do
  File.open("index.html", "rb").read
end
