module NYTimes
	module Congress
		class Legislator < Base
      include AttributeTransformation
			ATTRIBUTE_MAP = { :date_for    =>  [:date_of_birth],
                        :roles_for   =>  [:roles],
                			  :integer_for =>  [:govtrack_id, :district],
                			  :string_for  =>  [:url, :state, :gender, :name, :party,
                			                    :missed_votes_pct, :votes_with_party_pct] }
                			  
      ATTRIBUTES = ATTRIBUTE_MAP.values.flatten
      ATTRIBUTES.each {|attribute| define_lazy_reader_for_attribute_named attribute }
      
      def self.find(id)
        response = invoke("members/#{id}.json")
				new(response['results'].first)
      end
		  attr_reader :attributes, :id
      
      def positions
        @positions ||= fetch_positions
      end
      alias votes positions
      
  		def initialize(args={})
  		  prepare_arguments(args)
  		  @attributes = {}
				@transformed_arguments.each_pair do |name, value|
				  attributes[name.to_sym] = value
				end
				@fully_loaded = false
			end
    			
			private
			  attr_reader :fully_loaded
			  
			  def prepare_arguments(hash)
			    args = hash.dup
    			@id = args.delete('member_id') || args.delete('id')
    			raise ArgumentError, "could not assign ID" unless @id.is_a?(String)
    			@transformed_arguments = transform(args, ATTRIBUTE_MAP)
    	  end
			  
			  def fully_loaded?
			    fully_loaded
			  end
			  
	  		def load_fully
	  		  full_legislator = Legislator.find(id)
	  		  attributes.merge!(full_legislator.attributes)
	  		  @fully_loaded = true
  			end
        
        def fetch_positions
          response = Base.invoke("members/#{id}/votes.json")
          response = response['results'].first['votes']
          positions_for(response)
        end
    end
  end
end