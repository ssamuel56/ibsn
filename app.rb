require 'sinatra'
require_relative 'isbn_checker.rb'

get '/' do
  number = params[:number]
  file = params[:file]
  erb :home, locals: {number: number, file: file}
end

post '/check' do
  isbn = params[:isbn]
  redirect '/?number=' + isbn
end

post '/file' do
  isbn = params[:isbn]
  isbn = isbn_file_maker(isbn)
  redirect '/?file=' + isbn
end
