require 'redis'
require 'json'
require 'pry'

$redis = Redis.new(:timeout => 0)

$redis.subscribe('rubyonrails', 'ruby-lang') do |on|
    on.message do |channel, msg|
    data = JSON.parse(msg)
    array = data['msg'].split(',')
    user = array[0]
    sum = array[1] + array[2]
    puts "##{channel} - [#{data['user']}]: #{array[1]} + #{array[2]} = #{sum}"
  end
end
