require File.dirname(__FILE__) + '/../lib/nytimes-congress'
require "rubygems"
require "spec"
require 'fake_web'
require 'example_data/example_data'

gem 'rr'

include NYTimes::Congress

API_KEY = 'blahblah'
Base.api_key = API_KEY

Spec::Runner.configure do |config|
  config.mock_with :rr
end

def api_url_for(path, params = {})
	full_params = params.merge 'api-key' => API_KEY
	Base.build_request_url(path, full_params).to_s
end
