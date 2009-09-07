require File.dirname(__FILE__) + '/spec_helper.rb'

describe Congress do
  attr_reader :congress
  
  before do
    @congress = Congress.new(111, :senate)
  end
  
  describe "initializing with a congress number and chamber symbol", :shared => true do
    it "is numbered with an Integer" do
      congress.number.should be_kind_of(Integer)
    end
    
    it "has a symbol representing the chamber" do
      congress.chamber.should be_kind_of(Symbol)
    end
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
end