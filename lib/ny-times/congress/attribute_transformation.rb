module NYTimes
	module Congress
    module AttributeTransformation
      
      def transform(args, attributes_map)
        raise "Can only transform a hash" unless args.kind_of?(Hash)
        new_values = {}
        attributes_map.each_pair do |transformation, attributes|
   		    attributes.each do |attribute_name|
   		      value = args[attribute_name.to_s]
			      new_values[attribute_name] = do_transformation(transformation, value)
          end
  			end
  			new_values
    	end
      
      def do_transformation(transformation, value)
        send(transformation, value) unless empty?(value)
      end
      
      def date_for(string)
        Date.parse(string)
      end
  
      def string_for(value)
        value.to_s
      end
      
      def float_for(value)
        value.to_f
      end
  
      def integer_for(string)
        if string.respond_to? :to_i
          string.to_i
        else
          string
        end
      end
      
      def symbol_for(string)
        string.to_sym
      end
      
      def roles_for(roles_array)
        roles_array.collect {|e| Role.new(e)}
      end
      
      def appearances_for(floor_array)
        floor_array.collect do |floor_hash|
          Floor.new(floor_hash['date'], floor_hash['title'], floor_hash['url'], floor_hash['start_time'], floor_hash['end_time'])
        end
      end
      
      def votes_for(votes_array)        
        votes_array.collect {|vote_hash| RollCallVote.new(vote_hash['vote'])}
      end
      
      def positions_for(votes_array)        
        votes_array.collect do |vote_hash|
          Position.new(vote_hash['member_id'], vote_hash['vote_position'])
        end
      end
      
      def empty?(value)
        value.nil? || value == "N/A" || value == ""
      end
            
    end
  end
end
