module NYTimes
	module Congress
		class Legislator < Base
      include AttributeTransformation
			
			ATTRIBUTE_MAP = { :date_for    =>  [:date_of_birth],
                        :roles_for   =>  [:roles],
                			  :integer_for =>  [:govtrack_id, :district],
                			  :string_for  =>  [:id, :member_id, :url, :state, :gender, :name, :party] }
      
      attr_reader *ATTRIBUTE_MAP.values.flatten
			
			def initialize(args={})
  			transformed_values = self.transform(args, ATTRIBUTE_MAP)
				transformed_values.each_pair do |attribute, value|
					instance_variable_set("@#{attribute}", value)
				end
			end

      def self.find(legislator_id)
        response = invoke("members/#{legislator_id}.json")
				new(response['results'].first)
      end

    end
  end
end