#!/usr/bin/env ruby

require_relative 'parse.rb'

require 'pp'

pp parse(open('test.html').read.gsub("\n",""))
