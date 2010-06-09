module NYTimes
	module Congress
		class Bill < Base
      include AttributeTransformation
      attr_reader :attributes, :id

			ATTRIBUTE_MAP = { 
			  :date_for => [:introduced_date, :latest_major_action_date],
			  :integer_for =>  [:cosponsors, :congress_id],
			  :string_for  =>  [:number, :bill_uri, :title, :sponsor_id, :committees, :latest_major_action] 
			}
						  
      ATTRIBUTES = ATTRIBUTE_MAP.values.flatten
      ATTRIBUTES.each {|attribute| define_lazy_reader_for_attribute_named(attribute) }
      
  		def initialize(args={})
  		  prepare_arguments(args)
  		  @attributes = {}
				@transformed_arguments.each_pair {|name, value| attributes[name.to_sym] = value }
			end
      
      def id
        number
      end
       
      def to_s
    	  number
    	end

			private
						  
			  def prepare_arguments(hash)
			    args = hash.dup
    			@transformed_arguments = transform(args, ATTRIBUTE_MAP)
    	  end
      
    end
  end
end