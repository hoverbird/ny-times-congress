module NYTimes
	module Congress
		class Floor < Base
		  include AttributeTransformation
      attr_reader :date, :title, :url, :start_time, :end_time
      
			def initialize(date, title, url, start_time, end_time)
			  @date = date
			  @title = title
			  @url = url
			  @start_time = start_time
			  @end_time = end_time
			end
			
    end
	end
end