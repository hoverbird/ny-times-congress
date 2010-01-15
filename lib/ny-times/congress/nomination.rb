module NYTimes
	module Congress
		class Nomination < Base
		  include AttributeTransformation
		  
      ATTRIBUTE_MAP = { 
			  :date_for       =>  [:latest_action_date, :date_received],
        :integer_for    =>  [:congress],
        :string_for     =>  [:nominee_state, :status, :uri, :id, :description],
      }
		  
		  attr_reader :nominee_state, :description, :latest_action_date, :status, :committee, :id, :uri, :date_received
		  alias state nominee_state
		  
		  def initialize(nominee_state, description, latest_action_date, status, id, date_received, committee = nil)
		    @nominee_state = nominee_state
		    @description = description
		    @latest_action_date = latest_action_date
		    @status = status
		    @id = id
		    @date_received = date_received
		    @committee = committee
		  end
		  
      def self.find(congress, id)
        response = invoke("#{congress}/nominees/detail/#{id}.json")
				new(response['results'].first)
      end
		  
		  def to_s
		    id +': ' + description
		  end
		  
		  
		  
		end
	end
end