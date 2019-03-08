require 'json'
require 'redis'
require 'pry'

$redis = Redis.new

data = {}

loop do
  puts "SLOW CALCULATOR"
  puts "enter your name and two numbers for adding (ex, name,1,1)"
  msg = gets.chomp
  $redis.publish ARGV[0], data.merge('msg' => msg.strip).to_json
end
