#!/usr/bin/env ruby
include NYTimes::Congress

if ENV['NYTIMES_CONGRESS_API_KEY']
  NYTimes::Congress::Base.api_key = ENV['NYTIMES_CONGRESS_API_KEY']
end
