require 'sinatra'
require_relative 'isbn_checker.rb'
require 'aws-sdk-s3'

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
    Aws.config.update({
     credentials: Aws::Credentials.new(ENV['S3_key'], ENV['S3_SECRET'])
    })
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    obj = s3.bucket(bucket).object('isbn.csv')
    obj.upload_file('isbn.csv')
  else
    isbn = "Please use CSV"
  end
  redirect '/?file=' + isbn
end
