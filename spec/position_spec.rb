require File.dirname(__FILE__) + '/spec_helper.rb'

describe Position do
  attr_reader :vote, :position
  
  before do		  
	  @position = Position.new("W000779", "Yes")
	end
  
  describe "initializing" do  	 
    it "assigns attributes as expected" do
      position.member_id.should == "W000779"
      position.vote_position.should == "Yes"
    end
  end
  
  describe "instance methods" do
    describe "#legislator" do
      it "returns the Legislator whose position this is" do
        mock(Legislator).find("W000779") do |legislator|
          stub(legislator).name {"Hank McPank"}
        end
        position.legislator.name.should == "Hank McPank"
      end
    end
    
    describe "#to_s" do
      it "returns the vote position" do
        position.to_s.should == "Yes"
      end
    end
  
    describe "#for?" do
      
      it "returns true when the vote_position is 'Yes'" do
        Position.new("W000779", 'Yes').should be_for
      end
      it "returns false when the vote_position is 'No'" do
        Position.new("W000779", 'No').should_not be_for
      end
    end

  end
  
end