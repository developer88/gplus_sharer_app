$:.unshift File.expand_path("../", __FILE__)
require 'rubygems'
require 'bundler'

Bundler.require

$stdout.sync = true

require 'sinatra'
require './web'
run Sinatra::Application
