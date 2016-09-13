$:.unshift File.expand_path("../", __FILE__)
require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra'
require './web'

$stdout.sync = true

run Sinatra::Application
