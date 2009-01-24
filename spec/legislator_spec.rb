require File.dirname(__FILE__) + '/spec_helper.rb'

describe NYTimes::Congress::Legislator do
  attr_reader :legislator, :role
  

	describe "initializing" do
	  before do		  
  	  @legislator = Legislator.new(JSON.parse example_data)
  	end
    
	  context "with basic params hash" do
  	  def example_data
  	    <<-JSON
          {"id":"A000022",
          "name":"Gary Ackerman",
          "party":"D",
          "state":"NY",
          "district":"5"}
  		  JSON
  		end
		
  		it "assigns attributes as expected" do
        legislator.name.should eql "Gary Ackerman"
        legislator.party.should eql "D"
        legislator.state.should eql "NY"
        legislator.district.should eql 5
        legislator.id.should eql "A000022"
  		end
	  end
		
    describe "initializing with bio and roles hash" do
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

      it "assigns attributes as expected" do  
        # legislator.id.should eql "B000444"    
        legislator.member_id.should eql "B000444"
        legislator.name.should eql "Joseph Biden"
        legislator.gender.should eql "M"
        legislator.govtrack_id.should eql 300008
        legislator.url.should eql "http://biden.senate.gov"
        legislator.date_of_birth.should eql Date.parse("1942-11-20")
        legislator.district.should be_nil
      end
    
      it "assigns a number of Roles to the Legislator" do
        legislator.roles.size.should == 2
        legislator.roles.each {|role| role.should be_kind_of Role}      
      end
  	end
  end
	
	describe "#find" do
	  attr_reader :joe
	  
    def example_data
      File.read('example_data/member.json')
    end
	  
	  before do
    	FakeWeb.clean_registry
    	FakeWeb.register_uri(api_url_for('members/B000444.json'), :string => example_data)
      @joe = Legislator.find('B000444')
    end
    
    it "should return the Legislator with a given ID" do
      joe.name.should == "Joseph I. Lieberman"
    end
    
    it "should return the Legislator's roles" do
      joe.roles.size.should be 11
      joe.roles.first.title.should == "Senator, 1st Class"
      joe.roles.first.state.should == "CT"
    end
	end
	
end
