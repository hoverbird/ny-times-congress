#!/usr/bin/env ruby
include NYTimes::Congress

if ENV['NY_TIMES_CONGRESS_API_KEY']
  NYTimes::Congress::Base.api_key = ENV['NY_TIMES_CONGRESS_API_KEY']
  
  Senate = Congress.new(111, :senate, 2)
  House  = Congress.new(111, :house, 2)
  
end
