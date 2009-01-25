module NYTimes
	module Congress
		class Congress < Base
		  attr_reader :number, :chamber
		  include AttributeTransformation
      
      def initialize(number, chamber)
        @number  = number.to_i
        @chamber = chamber.to_sym
      end
      
      def members(params = {})
        results = Base.invoke("#{path}/members.json")['results'].first
  			results['members'].collect { |hash| Legislator.new(hash) }
      end
      
      def vote(session_number, roll_call_number, params = {})
        results = Base.invoke("#{path}/sessions/#{session_number}/votes/#{roll_call_number}.json")['results']['votes']['vote']
        results.merge!({:chamber => chamber}) # TODO 'chamber' is missing from Vote JSON results for some reason
        Vote.new results
      end
      
      protected
      
      def path
        "#{number}/#{chamber}"
      end      
    end
    
  end
end