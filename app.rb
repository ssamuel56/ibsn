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
    s3 = Aws::S3::Client.new(profile: ENV['PROFILE_NAME'], region: ENV['AWS_REGION'])
    hosted_file = s3.get_object(bucket: ENV['S3_BUCKET'], key: ENV['key'])
    partial_file = hosted_file.body.read
    full_file = isbn_file_maker(isbn_file, partial_file)
    s3 = Aws::S3::Resource.new
    s3.bucket(ENV['S3_BUCKET']).object(ENV['key']).upload_file(File.open(full_file))
    isbn = full_file.open.read.gsub("\n", ",")
    print isbn
  else
    isbn = "Please use CSV"
  end
  redirect '/?file=' + isbn
end
