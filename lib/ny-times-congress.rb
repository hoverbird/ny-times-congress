$LOAD_PATH.push(File.join(File.dirname(__FILE__), "../lib/ny-times"))

require 'rubygems'
require 'open-uri'
require 'JSON'

require 'congress/base'
require 'congress/attribute_transformation'
require 'congress/congress'
require 'congress/legislator'
require 'congress/legislator_vote_comparison'
require 'congress/role'
require 'congress/roll_call_vote'
require 'congress/position'
require 'congress/nomination'
require 'congress/floor'
