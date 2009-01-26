module NYTimes
	module Congress
		class Legislator < Base
		  
      include AttributeTransformation
			ATTRIBUTE_MAP = { :date_for    =>  [:date_of_birth],
                        :roles_for   =>  [:roles],
                			  :integer_for =>  [:govtrack_id, :district],
                			  :string_for  =>  [:id, :url, :state, :gender, :name, :party] }
      
      attr_reader *ATTRIBUTE_MAP.values.flatten
      alias member_id id
      
      def self.find(id)
        response = invoke("members/#{id}.json")['results'].first
				new(response)
      end
		
			def initialize(args={})
  			transformed_values = self.transform(args, ATTRIBUTE_MAP)
				transformed_values.each_pair do |attribute, value|
					instance_variable_set("@#{attribute}", value)
				end
				set_id(args['member_id'])
			end
      
      def positions
        response = Base.invoke("members/#{id}/votes.json")
        response['results'].first.collect do |hash|
          Position.new(hash)
        end
      end
			
			private
			
			# normalize identifier, which is referred to as member_id in some contexts
			def set_id(new_id)
        @id = new_id if empty?(id)  			  
			end
			
    end
  end
end