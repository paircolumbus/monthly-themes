#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'
require 'json'
require 'pry'

require_relative 'dog'
require_relative 'tasks'

def prompt
  puts "Enter dog name, age, breed separated by commas"
  puts "rover,3,terrier"
  print "> "
  gets.chomp
end

def transform(array)
  Hash[[:name, :age, :breed].zip(array)]
end

loop do
  input = prompt
  hash = transform input.split(",")
  dog = RescueDog::Dog.new(hash).to_json
  RescueDog::TaskProducer.new(dog).submit
end
