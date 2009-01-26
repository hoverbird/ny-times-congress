module NYTimes
	module Congress
		class Congress < Base
		  attr_reader :number, :chamber
		  include AttributeTransformation
      
      def initialize(number, chamber)
        @number  = integer_for number
        @chamber = symbol_for chamber
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