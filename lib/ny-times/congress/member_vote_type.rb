module NYTimes
	module Congress
		class MemberVoteType < Base
      include AttributeTransformation
      attr_reader :attributes, :id

			ATTRIBUTE_MAP = { 
			  :integer_for =>  [:total_votes, :missed_votes, :rank, :district, :votes_with_party, :loneno],
			  :float_for => [:missed_votes_pct, :party_votes_pct],
			  :string_for  =>  [:id, :name, :party, :state, :notes] 
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