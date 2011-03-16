$LOAD_PATH.push(File.join(File.dirname(__FILE__), "../lib/ny-times"))

require 'rubygems'
require 'open-uri'
require 'date'
require 'JSON'

require 'congress/base'
require 'congress/attribute_transformation'
require 'congress/bill'
require 'congress/congress'
require 'congress/current_member'
require 'congress/legislator'
require 'congress/legislator_vote_comparison'
require 'congress/member_vote_type'
require 'congress/role'
require 'congress/roll_call_vote'
require 'congress/position'
require 'congress/nomination'
require 'congress/floor'

