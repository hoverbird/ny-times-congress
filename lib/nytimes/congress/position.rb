module NYTimes
	module Congress
		class Position < Base
		  attr_reader :member_id, :vote_position
		  alias position vote_position
		  
		  def initialize(member_id, vote_position)
		    @member_id = member_id
		    @vote_position = vote_position
		  end
		  
		  def legislator
		    Legislator.find(member_id)
		  end
		  
		  def to_s
		    position
		  end
		  
		  def for?
		    case position
  	      when "Yes" then true
  	      when "No" then false
	      end
		  end
		  
		end
	end
end