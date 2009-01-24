module NYTimes
	module Congress
		class Congress < Base
		  include AttributeTransformation
      attr_reader :number, :chamber
      
      def initialize(number, chamber)
        @number  = number.to_i
        @chamber = chamber.to_sym
      end
      
      def members(params = {})
        results = Base.invoke("#{number}/#{chamber}/members.json")['results'].first
  			results['members'].collect { |hash| Legislator.new(hash) }
      end
      
      # def votes(session_number, roll_call_number)
      #   results = Base.invoke("#{number}/#{chamber}/sessions/#{session_number}/votes/#{roll_call_number}.json")
      # end
      
    end
  end
end