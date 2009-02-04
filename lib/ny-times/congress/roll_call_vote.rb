module NYTimes
	module Congress
		class RollCallVote < Base
      include AttributeTransformation

			ATTRIBUTE_MAP = { 
			  :date_for       =>  [:date],
        :integer_for    =>  [:session_number, :congress, :roll_call],
        :string_for     =>  [:chamber, :bill_number, :question, :vote_type, :time, :result, :description],
        :positions_for  =>  [:positions]
      }    			  
      attr_reader *ATTRIBUTE_MAP.values.flatten

			def initialize(args={})
  			transformed_values = self.transform(args, ATTRIBUTE_MAP)
				transformed_values.each_pair do |attribute, value|
					instance_variable_set("@#{attribute}", value)
				end
			end
		
		  def get_congress
		    Congress.new(congress, chamber)
		  end
		  
		end
	end
end
