#!/usr/bin/env ruby
include NYTimes::Congress

if ENV['NYTIMES_CONGRESS_API_KEY']
  NYTimes::Congress::Base.api_key = ENV['NYTIMES_CONGRESS_API_KEY']
  
  Senate = Congress.new(111, :senate)
  House  = Congress.new(111, :house)
  
end
