module NYTimes
	module Congress
		class CurrentMember < Base
      include AttributeTransformation
      attr_reader :attributes, :id

			ATTRIBUTE_MAP = { 
			  :integer_for =>  [:district, :seniority, :next_election],
			  :string_for  =>  [:gender, :name, :party, :twitter_id, :youtube_id, :role, :api_url, :times_topics_url] 
			}           			  
      ATTRIBUTES = ATTRIBUTE_MAP.values.flatten
      ATTRIBUTES.each {|attribute| define_lazy_reader_for_attribute_named(attribute) }
      
  		def initialize(args={})
  		  prepare_arguments(args)
  		  @attributes = {}
				@transformed_arguments.each_pair {|name, value| attributes[name.to_sym] = value }
			end
      
      def to_s
    	  id
    	end

			private
						  
			  def prepare_arguments(hash)
			    args = hash.dup
    			@id = args.delete('member_id') || args.delete('id')
    			raise ArgumentError, "could not assign ID" unless @id.is_a?(String)
    			@transformed_arguments = transform(args, ATTRIBUTE_MAP)
    	  end
      
    end
  end
end