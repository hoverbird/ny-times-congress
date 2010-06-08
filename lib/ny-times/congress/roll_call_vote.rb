module NYTimes
	module Congress
		class RollCallVote < Base
      include AttributeTransformation

			ATTRIBUTE_MAP = { 
			  :date_for       =>  [:date],
        :integer_for    =>  [:session_number, :congress, :roll_call],
        :string_for     =>  [:bill_number, :question, :vote_type, :time, :result, :description, :chamber],
        :positions_for  =>  [:positions],
      }    			  
      attr_reader :democratic_majority_position, :republican_majority_position, *ATTRIBUTE_MAP.values.flatten

			def initialize(args={})
  			transformed_values = self.transform(args, ATTRIBUTE_MAP)
				transformed_values.each_pair do |attribute, value|
					instance_variable_set("@#{attribute}", value)
				end
				@democratic_majority_position, @republican_majority_position = string_for(args['democratic']['majority_position']), string_for(args['republican']['majority_position'])
			end
		
		  def get_congress
		    Congress.new(congress, chamber)
		  end

		end
	end
end
