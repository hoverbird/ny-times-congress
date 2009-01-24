$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'open-uri'
require 'ostruct'
require 'JSON'

require 'congress/base'
require 'congress/attribute_transformation'
require 'congress/congress'
require 'congress/legislator'
require 'congress/role'
