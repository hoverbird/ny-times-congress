require File.dirname(__FILE__) + '/spec_helper.rb'

describe Vote do
  attr_reader :congress, :vote
  
  def example_data
    File.read('example_data/votes.json')
  end
  
  before do
    FakeWeb.clean_registry
    @congress = Congress.new(111, :senate)
  end
  
  describe "finding through a Congress by session and roll call number"do
    before do
      FakeWeb.clean_registry
      FakeWeb.register_uri(api_url_for('111/senate/sessions/1/votes/12.json'), :string => example_data)
      @vote = congress.vote(1, 12)    	
    end
    
    it "returns its outcome" do
      vote.result.should == "Agreed to"
    end
    it "returns its Congress number and chamber" do
      vote.congress.should == congress.number
      vote.chamber.should == congress.chamber      
    end
    
    it "can return its Congress object" do
      vote.get_congress.should == congress
    end

    it "returns a Date object for the day of the vote" do
      vote.date.should == Date.parse("2009-01-22")
    end
  end
  
  describe ""
end