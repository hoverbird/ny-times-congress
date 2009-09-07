require File.dirname(__FILE__) + '/spec_helper.rb'

describe LegislatorVoteComparison do
	describe "#initialize" do
	  attr_reader :comparison
	  
    def example_data
      member_vote_comparison_response
    end
	  
	  before do
      @comparison = LegislatorVoteComparison.new(JSON.parse(example_data)['results'].first)
    end
    
    it "should return the LegislatorVoteComparison for the two Legislators" do
      comparison.should be_kind_of(LegislatorVoteComparison)
    end
    
    it "should return counts of the votes where the two Legislators agreed and disagreed" do
      comparison.common_votes.should == 241
      comparison.disagree_votes.should == 187
    end
    
    it "should return percents of votes where the two Legislators agreed and disagreed" do
      comparison.disagree_percent.should == '77.59'
      comparison.agree_percent.should == '22.41'
    end
    
    it "should return percents of votes where the two Legislators agreed and disagreed" do
      comparison.first_member_id.should == 'F000062'
      comparison.second_member_id.should == 'S001141'
    end
    
	end
end