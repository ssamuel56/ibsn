require 'sinatra'
require 'csv'
require_relative 'isbn_checker.rb'
require 'aws-sdk'
load 'local_env.rb' if File.exist?('local_env.rb')

Aws.config.update({
   credentials: Aws::Credentials.new(ENV['S3_KEY'], ENV['S3_SECRET'])
})


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
    isbn = s3_function(isbn_file)
  else
    isbn = "Please use CSV"
  end

  redirect '/?file=' + isbn
end
