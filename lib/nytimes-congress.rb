$LOAD_PATH.push(File.join(File.dirname(__FILE__), "../lib/nytimes"))

require 'rubygems'
require 'open-uri'
require 'JSON'

require 'congress/base'
require 'congress/attribute_transformation'
require 'congress/congress'
require 'congress/legislator'
require 'congress/role'
require 'congress/roll_call_vote'
require 'congress/position'
