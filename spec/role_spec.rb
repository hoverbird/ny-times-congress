require File.dirname(__FILE__) + '/spec_helper.rb'

describe NYTimes::Congress::Role do
  attr_reader :role
  
  def example_data
    role_response_fragment
	end
	
	context "initializing with params hash", :shared => true do
		before do
		  @role = Role.new(JSON.parse(example_data))
		end
		
		it "should set String attributes" do 
      role.chamber.should == 'Senate'
      role.title.should == 'Senator, 2nd Class'
      role.state.should == 'DE'
      role.party.should == 'D'
		end
		
		it "should set the congress number as an Integer" do
		  role.congress.should == 111
    end
		
		it "should parse start and end dates into Date objects" do
		  role.start_date.should == Date.parse("2009-01-06")
      role.end_date.should   == Date.parse("2009-01-20")
    end
    
    it "should return nil for values that are 'N/A'" do
      role.district.should be_nil
    end
  end
  
  context "initializing through a Legislator" do
    attr_reader :legislator
    def example_data
       <<-JSON
        {
           "member_id":"B000444",
           "name":"Joseph Biden",
           "date_of_birth":"1942-11-20",
           "gender":"M",
           "url":"http://biden.senate.gov",
           "govtrack_id":"300008",
           "roles":[
              {
                 "congress":"111",
                 "chamber":"Senate",
                 "title":"Senator, 2nd Class",
                 "state":"DE",
                 "party":"D",
                 "district":"N/A",
                 "start_date":"2009-01-06",
                 "end_date":"2009-01-20"
              },
              {
                 "congress":"110",
                 "chamber":"Senate",
                 "title":"Senator, 2nd Class",
                 "state":"DE",
                 "party":"D",
                 "district":"N/A",
                 "start_date":"2007-01-04",
                 "end_date":"2009-01-03"
              }
           ]
         }
          JSON
     end
    
    before do     
      @legislator = Legislator.new(JSON.parse(example_data))
      legislator.roles.should_not be_nil
      @role = legislator.roles.sort_by{|r| r.congress}.first
    end
        
    it "should set String attributes" do 
      role.chamber.should == 'Senate'
      role.title.should == 'Senator, 2nd Class'
      role.state.should == 'DE'
      role.party.should == 'D'
		end
		
		it "should set the congress number as an Integer" do
		  role.congress.should == 110
    end
		
		it "should parse start and end dates into Date objects" do
		  role.start_date.should == Date.parse("2007-01-04")
      role.end_date.should == Date.parse("2009-01-03")
    end
    
    it "should return nil for values that are 'N/A'" do
      role.district.should be_nil
    end
    
    it "can be found through the Legislator" do
      legislator.roles.should include(role)
    end    
		
  end
end