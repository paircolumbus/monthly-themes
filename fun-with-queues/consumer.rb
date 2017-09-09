#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'
require 'pry'
require 'json'

require_relative 'dog'
require_relative 'services'
require_relative 'tasks'

consumer = RescueDog::TaskConsumer.new

begin
  consumer.receive
rescue Interrupt => _
  consumer.connection.close
end
