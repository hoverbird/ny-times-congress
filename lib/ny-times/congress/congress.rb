module NYTimes
	module Congress
		class Congress < Base
		  attr_reader :number, :session, :chamber
		  
		  include AttributeTransformation
      
      def initialize(number, chamber, session = nil)
        @number, @session = integer_for(number), integer_for(session)
        @chamber = symbol_for(chamber)
        raise AttributeError unless number && chamber
      end
      
      def members(params = {})        
        @members ||= fetch_members
      end
      
      def roll_call_vote(session_number, roll_call_number, params = {})
        results = Base.invoke("#{api_path}/sessions/#{session_number}/votes/#{roll_call_number}.json")['results']['votes']['vote']
        results.merge!({'chamber' => chamber}) # TODO 'chamber' is missing from RollCallVote JSON results for some reason
        RollCallVote.new(results)
      end
      
      def to_s
        "#{number} #{chamber.upcase}"
      end
      
      def compare(legislator_1, legislator_2)
        response = Base.invoke("members/#{legislator_1}/compare/#{legislator_2}/#{number}/#{chamber}.json")
        if response 
          LegislatorVoteComparison.new(response['results'].first)
        end
      end
      
      protected
      
      def fetch_members
        results = Base.invoke("#{api_path}/members.json")['results'].first
  			results['members'].inject({}) do |hash, member| 
  			  hash[member['id']] = Legislator.new(member)
  			  hash
  			end
      end
      
      def api_path
        "#{number}/#{chamber}"
      end        
    end
    
  end
end