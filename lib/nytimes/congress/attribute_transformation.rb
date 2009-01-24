module NYTimes
	module Congress
    module AttributeTransformation
      
      def transform(args, attributes_map)
        raise "Can only transform a hash" unless args.kind_of?(Hash)
        new_values = {}
        attributes_map.each_pair do |transformation, attributes|
   		    attributes.each do |attribute_name|
   		      value = args[attribute_name.to_s]
  		      if value
			        new_values[attribute_name] = do_transformation(transformation, value)
  			    end
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
  
      def string_for(string)
        string
      end
  
      def integer_for(string)
        if string.respond_to? :to_i
          string.to_i
        else
          string
        end
      end
      
      def roles_for(roles_array)
        roles_array.collect {|role_hash| Role.new(role_hash)}
      end
      
      def empty?(value)
        return true if value.nil? || value == "" || value == 'N/A'
      end
      
    end
  end
end
