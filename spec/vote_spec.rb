require File.dirname(__FILE__) + '/spec_helper.rb'

describe Vote do
  attr_reader :congress, :vote
  
  def example_data
    File.read('example_data/member.json')
  end
  
  before do
    @congress = 
    @vote = Vote.new(111, :senate)
  end
  
  describe "initializing with a congress number and chamber symbol", :shared => true do
    it "is numbered with an Integer" do
      congress.number.should be_kind_of Integer
    end
    
    it "has a symbol representing the chamber" do
      congress.chamber.should be_kind_of Symbol
    end
  end
  
  describe "alternately initializing with Strings for either argument" do
    before do
      @congress = Congress.new('111', 'senate')
    end
    
    it_should_behave_like "initializing with a congress number and chamber symbol"
  end
