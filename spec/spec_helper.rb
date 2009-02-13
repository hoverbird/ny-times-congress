require File.dirname(__FILE__) + '/../lib/ny-times-congress'
require File.dirname(__FILE__) + '/example_data/example_data'

require "rubygems"
require "spec"
require 'fake_web'

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
