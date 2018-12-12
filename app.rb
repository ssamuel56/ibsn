require 'sinatra'
require_relative 'isbn_checker.rb'

get '/' do
  number = params[:number]
  erb :home, locals: {number: number}
end

post '/check' do
  isbn = params[:isbn]
  redirect '/?number=' + isbn
end
