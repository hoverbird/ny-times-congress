require File.dirname(__FILE__) + '/spec_helper.rb'

describe Legislator do  
  describe ".find" do
	  attr_reader :joe
	  
    def example_data
      member_response
    end
	  
	  before do
    	FakeWeb.register_uri(api_url_for('members/B000444.json'), :string => example_data)
      @joe = Legislator.find('B000444')
    end
    
    it "should return the Legislator with a given ID" do
      joe.name.should == "Joseph I. Lieberman"
    end
    
    it "should return the Legislator's roles" do
      joe.roles.size.should        == 11
      joe.roles.first.title.should == "Senator, 1st Class"
      joe.roles.first.state.should == "CT"
    end
	end
	
	describe "#initialize" do
	  context "with limited params hash" do
	    attr_reader :legislator, :role, :parsed_data
      
  	  def example_data
        limited_legislator_attributes
  		end
  		
		  before do
  	    @parsed_data = JSON.parse(example_data)
    	  @legislator  = Legislator.new(parsed_data)	    
    	end
    	
  		it "assigns attributes as expected" do
  		  legislator.id.should == "L000304"
        legislator.name.should == "Joseph I. Lieberman"
        legislator.party.should == "ID"
        legislator.state.should == "CT"
  		end
  		
  		describe ":id and :member_id attributes" do
  		  attr_reader :identifier
  		  
  		  before do
  		    @identifier = "H00HAA"
  		  end
  		  
    		it "assigns to the same value if :id is passed as a hash argument" do
    		  @legislator = Legislator.new('id' => identifier)
    		  legislator.id.should == identifier
    		end
  		
    		it "assigns to the same value if :member_id is passed as a hash argument" do
    		  @legislator = Legislator.new('member_id' => identifier)
    		  legislator.id.should == identifier
    		end
    	end
	  end
		
    context "with full bio and roles hash" do
      attr_reader :legislator, :role, :parsed_data
      
      def example_data
        full_legislator_attributes
      end
      
		  before do
  	    @parsed_data = JSON.parse(example_data)['results'].first
    	  @legislator  = Legislator.new(parsed_data)	    
    	end

      it "assigns attributes as expected" do
        legislator.id.should == "L000304"
        legislator.name.should == "Joseph I. Lieberman"
        legislator.gender.should == "M"
        legislator.govtrack_id.should == 300067
        legislator.url.should == "http://lieberman.senate.gov/"
        legislator.date_of_birth.should == Date.parse("1942-02-24")
      end
    
      it "assigns a number of Roles to the Legislator" do
        legislator.roles.size.should == 2
        legislator.roles.each {|role| role.should be_kind_of(Role)}      
      end
      
      it "raises an error if it's unable to assign an id" do
        data = @parsed_data.dup.delete('member_id')
        lambda {Legislator.new(dat)}.should raise_error
      end
      
  	end
  end
	
  describe "#positions" do
    attr_reader :legislator, :legislator_id, :role, :positions, :parsed_data
    
    def example_data
      full_legislator_attributes
    end
    
    before do
      @legislator_id = 'L000304'
      FakeWeb.clean_registry
	    FakeWeb.register_uri(api_url_for("members/#{legislator_id}/votes.json"), :string => member_positions_response)
    	FakeWeb.register_uri(api_url_for("members/#{legislator_id}.json"), :string => member_response)
  	  @legislator   = Legislator.find(legislator_id)
  	end
  	
    it "returns an Array of Positions for the given Legislator" do
      legislator.positions.should_not be_nil
      legislator.positions.size.should == 3
    end
    
  end
  
  describe "#roles" do

    context "when bio and roles haven't been populated" do
  		attr_reader :legislator, :role, :parsed_data
      def example_data
        limited_legislator_attributes
  		end
      
  		before do
  		  @parsed_data = JSON.parse(example_data)
  	    @parsed_data['id'].should_not be_nil
    	  @legislator  = Legislator.new(parsed_data)
    	  
  		  legislator.attributes[:roles].should be_nil
  		  legislator.attributes[:url].should be_nil
  		  legislator.attributes[:birthdate].should be_nil
  		  FakeWeb.clean_registry
  		  FakeWeb.register_uri(api_url_for('members/L000304.json'), :string => member_response)
  		end
  		
      it "makes second API request when one attempts to read those attributes" do        
        legislator.roles
        roles = legislator.attributes[:roles].should_not be_nil
  		  legislator.date_of_birth.should == Date.parse("1942-02-24")
        legislator.url.should =="http://lieberman.senate.gov/"
      end
      
    end
    
    context "when bio and roles have already been loaded" do
      attr_reader :legislator, :role, :parsed_data
  		
    	def example_data
        full_legislator_attributes
  		end
  		
    	before do
  	    @parsed_data = JSON.parse(example_data)['results'].first
    	  @legislator  = Legislator.new(parsed_data)
    	end
  		
      it "does not make another API request when accessing attributes" do
        legislator.roles.should_not be_nil
  		  legislator.url.should_not be_nil
  		  legislator.date_of_birth.should_not be_nil
      end
    end
  end
end
