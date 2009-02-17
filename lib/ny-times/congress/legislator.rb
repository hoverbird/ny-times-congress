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
        require 'ruby-debug'
        debugger if response.inspect unless response.has_key?('results')
				new(response['results'].first)
      end
		  attr_reader :attributes, :id
		  
			def initialize(args={})
        @attributes = {}
  			@id = args.delete('id') || args.delete('member_id')
  			transformed = transform(args, ATTRIBUTE_MAP)
				transformed.each_pair do |attribute_name, attribute_value|
				  attributes[attribute_name.to_sym] = attribute_value
				end
				@fully_loaded = false
			end
      
      def positions
        response = Base.invoke("members/#{id}/votes.json")
        response = response['results'].first['votes']
        positions_for(response)
      end
      
      def votes
        response = Base.invoke("members/#{id}/votes.json")
        response = response['results'].first['votes']
        votes_for(response)
      end
  		
			private
			  attr_reader :fully_loaded
			  
			  def fully_loaded?
			    fully_loaded
			  end
			  
	  		def load_fully
	  		  full_legislator = Legislator.find(id)
	  		  attributes.merge!(full_legislator.attributes)
	  		  @fully_loaded = true
  			end

    end
  end
end