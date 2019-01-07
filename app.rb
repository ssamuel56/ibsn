require 'sinatra'
require_relative 'isbn_checker.rb'
require 'aws-sdk'

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
  isbn_file = params[:isbn][:tempfile]
  isbn_file_name = params[:isbn][:filename]
  if isbn_file_name[-3..-1] == "csv"
    s3 = Aws::S3::Client.new
    File.open('isbn.csv', 'rb') do |file|
      s3.put_object({
        bucket: ENV['S3_BUCKET'],
        key: 'isbn.csv',
        body: file
      })
    end
  else
    isbn = "Please use CSV"
  end
  redirect '/?file=' + isbn
end
