require File.dirname(__FILE__) + '/spec_helper.rb'

describe Congress do
  attr_reader :congress
  
  before do
    @congress = Congress.new(111, :senate)
  end
  
  describe "initializing with a congress number and chamber symbol", :shared => true do
    it "is numbered with an Integer" do
      congress.number.should == 111
    end
    
    it "has a symbol representing the chamber" do
      congress.chamber.should == :senate
    end
  end
  
  describe "initializing with a initializing with a session number as well" do
    before do
       @congress = Congress.new(111, :senate, 2)
     end
    
    it "holds a Integer representing the session of congress" do
      congress.session.should == 2
    end
    
    it_should_behave_like "initializing with a congress number and chamber symbol"
  end
  
  describe "alternately initializing with Strings for either argument" do
    before do
      @congress = Congress.new('111', 'senate')
    end
    
    it_should_behave_like "initializing with a congress number and chamber symbol"
  end
  
  describe "#members" do
    attr_accessor :members
  
    def example_data
      members_response
    end

    before do
    	FakeWeb.register_uri(api_url_for('111/senate/members.json'), :string => example_data)
      @members = congress.members
    end

    it "should return an hash of Legislators keyed by ID" do
      members.should be_kind_of(Hash)
      members.values.all? {|e| e.class.should == Legislator}
      members['M000303'].name.should == "John McCain"
    end

    it "should return all members" do
      members.size.should == 102
    end
  end  

  describe "#compare" do
		attr_reader :congress, :legislator, :comparison
    def example_data; member_vote_comparison_response; end

	  before do
    	FakeWeb.register_uri(api_url_for('members/L000304/compare/S001141/111/senate.json'), :string => example_data)  	    
      @congress = Congress.new(111, :senate)
      @legislator = Legislator.new(JSON.parse(member_response)['results'].first)
    end
    
    describe "with a legislator id and a legislator object" do
      it "returns a LegislatorVoteComparison for the two users" do
        @comparison = congress.compare(legislator, 'S001141')
        @comparison.should_not be_nil
        @comparison.should be_kind_of(LegislatorVoteComparison)
      end
    end
  end
  
end