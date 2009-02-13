require File.dirname(__FILE__) + '/spec_helper.rb'

describe Legislator do
  attr_reader :legislator, :role, :parsed_data
  
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
      joe.roles.size.should == 11
      joe.roles.first.title.should == "Senator, 1st Class"
      joe.roles.first.state.should == "CT"
    end
	end
	
	describe "#initialize" do
	  before do
	    @parsed_data  = JSON.parse(example_data)
  	  @legislator   = Legislator.new(parsed_data)
  	end
    
	  context "with limited params hash" do
  	  def example_data
        limited_legislator_attributes
  		end
		
  		it "assigns attributes as expected" do
  		  legislator.id.should == "B000444"
        legislator.name.should == "Joseph Biden"
        legislator.party.should == "D"
        legislator.state.should == "DE"
  		end
  		
  		describe ":id and :member_id attributes" do
  		  attr_reader :identifier
  		  
  		  setup do
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
		
    describe "initializing with full bio and roles hash" do
      def example_data
        full_legislator_attributes
      end

      it "assigns attributes as expected" do  
        legislator.id.should == "B000444"
        legislator.name.should == "Joseph Biden"
        legislator.gender.should == "M"
        legislator.govtrack_id.should == 300008
        legislator.url.should == "http://biden.senate.gov"
        legislator.date_of_birth.should == Date.parse("1942-11-20")
        legislator.district.should be_nil
      end
    
      it "assigns a number of Roles to the Legislator" do
        legislator.roles.size.should == 2
        legislator.roles.each {|role| role.should be_kind_of(Role)}      
      end
  	end
  end
	
  describe "#positions" do
    it "needs specs"
  end
  
  describe "#roles" do
    
    before do
	    @parsed_data  = JSON.parse(example_data)
  	  @legislator   = Legislator.new(parsed_data)
  	  FakeWeb.clean_registry 
  	end
  	
    context "when  bio and roles haven't been populated"
      def example_data
        limited_legislator_attributes
  		end
  		
  		before do
  		  legislator.instance_variable_get("@roles").should be_nil
  		  legislator.instance_variable_get("@url").should be_nil
  		  legislator.instance_variable_get("@birthdate").should be_nil
  		  
  		  FakeWeb.register_uri(api_url_for('members/B000444.json'), :string => full_legislator_attributes)
  		end
  		
      it "makes an API request for bio and roles fields" do
        legislator.roles
        roles = legislator.instance_variable_get("@roles").should_not be_nil
  		  
  		  legislator.url.should == Date.parse("1942-11-20")
        legislator.date_of_birth.should == Date.parse("http://biden.senate.gov")
      end
      
    end
    
    context "when bio and roles have already been loaded" do
      def example_data
        full_legislator_attributes
  		end
  		
  		before do
  		  legislator.instance_variable_get("@roles").should_not be_nil
  		  legislator.birthdate.should_not be_nil
  		end
      
      it "does not make another API request" do
        legislator.roles
  		  legislator.instance_variable_get("@roles").should_not be_nil
  		  legislator.instance_variable_get("@url").should be_nil
  		  legislator.instance_variable_get("@birthdate").should be_nil  		  
      end
    end
    
  end
	
