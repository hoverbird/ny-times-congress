module NYTimes
	module Congress
		class Vote < Base
      include AttributeTransformation

			ATTRIBUTE_MAP = { 
			  :date_for     =>  [:date],
        :integer_for  =>  [:session_number, :congress, :roll_call_number],
        :string_for   =>  [:bill_number, :question, :vote_type, :time, :result, :description],
        :symbol_for   =>  [:chamber]
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
