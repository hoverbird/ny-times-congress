module NYTimes
	module Congress
		class Role < Base
		  include AttributeTransformation
      
  		ATTRIBUTE_MAP = { :date_for    =>  [:start_date, :end_date],
                			  :integer_for =>  [:district, :congress],
                			  :string_for  =>  [:party, :chamber, :title, :state] }
    
      attr_reader *ATTRIBUTE_MAP.values.flatten
      
			def initialize(args={})
  			transformed_values = transform(args, ATTRIBUTE_MAP)
				transformed_values.each_pair do |attribute, value|
					instance_variable_set("@#{attribute}", value)
				end
			end
			
	  end
	end
end