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
        @members ||= fetch_members(Base.invoke("#{api_path}/members.json")['results'].first)
      end
      
      def self.new_members(params = {})
        Congress.fetch_new_members
      end
      
      def current_member_for_state_district(state, district=nil)
        if district
          api_path = "members/house/#{state}/#{district}/current.json"
        else
          api_path = "members/senate/#{state}/current.json"
        end
        response = Base.invoke(api_path)['results']
        fetch_current_members(response)
      end
      
      def roll_call_vote(session_number, roll_call_number, params = {})
        results = Base.invoke("#{api_path}/sessions/#{session_number}/votes/#{roll_call_number}.json")['results']['votes']
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
      
      def fetch_members(results)
  			results.inject({}) do |hash, member| 
  			  hash[member['id']] = Legislator.new(member)
  			  hash.delete_if {|k,v| k.nil? }
  			  hash
  			end
      end

      def fetch_current_members(results)
        if results.length > 1
    			results.collect do |member| 
    			  CurrentMember.new(member)
    			end
    		else
    		  CurrentMember.new(results.first)
    		end
      end

      def self.fetch_new_members
        results = Base.invoke("/members/new.json")['results'].first
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