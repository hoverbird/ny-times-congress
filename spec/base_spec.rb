require File.dirname(__FILE__) + '/spec_helper.rb'

describe Base do
	describe "#build_request_url" do
    attr_reader :url, :expected_url
	
		setup do
		  @url = NYTimes::Congress::Base.build_request_url("members/A000014.json", {"api-key" => "does-not-matter"} )
		  @expected_url = URI.parse "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/members/A000014.json?api-key=does-not-matter"
		end
		
		it "returns a string matching the expected URL" do
		  url.should eql expected_url
		end
		
	end
	
	describe "#invoke" do
	  attr_reader :response
	    def example_data
  	    <<-JSON
  	    {
           "status":"OK",
           "copyright":"Copyright (c) 2009 The New York Times Company.  All Rights Reserved.",
           "results":[
              {
                 "congress":"109",
                 "chamber":"House",
                 "num_results":"441",
                 "offset":"0",
                 "members":{
                    "member":{
                       "id":"A000014",
                       "name":"Neil Abercrombie",
                       "party":"D",
                       "state":"HI",
                       "district":"1"
                    },
                    "member":{
                       "id":"A000022",
                       "name":"Gary Ackerman",
                       "party":"D",
                       "state":"NY",
                       "district":"5"
                    },
                    "member":{
                       "id":"Y000033",
                       "name":"Donald Young",
                       "party":"R",
                       "state":"AK",
                       "district":"1"
                    }
                 }
              }
           ]
        }
        JSON
      end
    
	  it "makes a call to a given url and parses the returned JSON into a response hash" do
	    FakeWeb.register_uri(api_url_for('congress/111/senate/members.json'), :string => example_data)
      @response = NYTimes::Congress::Base.invoke("congress/111/senate/members.json")
      response.should == JSON.parse(example_data)
	  end
	  
	end
end
