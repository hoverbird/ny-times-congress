module NYTimes
	module Congress
		class Base
		  API_NAME    = 'congress'
		  API_SERVER  = 'api.nytimes.com'
		  API_VERSION = 3
		  API_BASE    = "/svc/politics/v#{API_VERSION}/us/legislative/#{API_NAME}"
			
			@@api_key = nil
			@@copyright = nil
			
			class << self
				
				# The copyright footer to be placed at the bottom of any data from the New York Times. Note this is only set after an API call.
				def copyright
					@@copyright
				end
				
				# Set the API key used for operations. This needs to be called before any requests against the API. To obtain an API key, go to http://developer.nytimes.com/
				def api_key=(key)
					@@api_key = key
				end
				
				def api_key
					@@api_key
				end
				
				# Builds a request URI to call the API server
				def build_request_url(path, params)
					URI::HTTP.build :host => API_SERVER,
													:path => "#{API_BASE}/#{path}",
													:query => params.map {|k,v| "#{k}=#{v}"}.join('&')
				end
				
				def invoke(path, params={})
					begin
						if @@api_key.nil?
							raise "You must initialize the API key before you run any API queries"
						end
						
						full_params = params.merge 'api-key' => @@api_key
						uri = build_request_url(path, full_params)

						reply = uri.read
						reply = JSON.parse(reply)
												
						raise "Empty reply returned from API" if reply.nil?

						@@copyright = reply['copyright']
						
						reply
					rescue OpenURI::HTTPError => e
						return nil if e.message =~ /^404/						
						raise "Error connecting to URL #{uri} #{e}"
					end
				end
        
        def define_lazy_reader_for_attribute_named(attribute)
          class_eval(<<-EVAL, __FILE__, __LINE__)
            def #{attribute}
              load_fully if attributes[:#{attribute}].nil? && !fully_loaded
              attributes[:#{attribute}]
            end
          EVAL
        end
			end
			
		end
	end
end