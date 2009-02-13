module NYTimes
	module Congress
		class Position < Base
		  attr_reader :member_id, :vote_position, :vote
		  alias position vote_position
		  
		  VALUES = ['Yes', 'No', 'Not Voting', 'Present', 'Speaker']
		  
		  def initialize(member_id, vote_position, vote = nil)
		    @member_id = member_id
		    @vote_position = vote_position
        @vote = vote
		  end
		  
		  def legislator
		    Legislator.find(member_id)
		  end
		  
		  def to_s
		    position
		  end
		  
		  def for?
        position == 'Yes'
		  end
		  
		  def against?
		    position == 'No'
		  end
		  
		  def not_voting?
		    position == 'Not Voting'
		  end
		  
		end
	end
end
