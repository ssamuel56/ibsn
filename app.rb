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
  bucket = ENV['S3_BUCKET']
  if isbn_file_name[-3..-1] == "csv"
    s3 = Aws::S3::Client.new(
     :access_key_id   => ENV['S3_KEY'],
     :secret_access_key => ENV['S3_SECRET']
    )
    s3::S3Object.store(
     isbn_file_name,
     open(isbn_file.path),
     bucket,
     :access => :public_read
    )
    url = "https://#{bucket}.s3.amazonaws.com/#{filename}"
    redirect url
  else
    isbn = "Please use CSV"
  end
  redirect '/?file=' + isbn
end
