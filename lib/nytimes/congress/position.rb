module NYTimes
	module Congress
		class Position < Base
		  attr_reader :member_id, :vote_position, :vote
		  alias position vote_position
		  
		  VALUES = ['Yes', 'No', 'Not Voting', 'Present', 'Speaker']
		  
		  def initialize(member_id, vote_position, vote)
		    raise "Member ID required" unless member_id
		    @member_id = member_id
		    @vote_position = vote_position
		    @vote = RollCallVote.new(extra_attrs)
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

# {"votes"=>[{"vote"=>{"chamber"=>"Senate", "time"=>"11:57:00", "date"=>"2008-06-10", "roll_call"=>"147", "session"=>"2", "member_id"=>"B001210", "congress"=>"110", "position"=>"Not Voting"}}], "total_votes"=>"100", "member_id"=>"B001210", "offset"=>"0"}