module NYTimes
	module Congress
		class LegislatorVoteComparison < Base 
      attr_reader :common_votes, :disagree_votes, :agree_percent, :disagree_percent, 
                  :first_member_id, :second_member_id  
      include AttributeTransformation
  
      def initialize(result)
        @common_votes, @disagree_votes = integer_for(result['common_votes']), integer_for(result['disagree_votes'])
        @agree_percent, @disagree_percent = result['agree_percent'], result['disagree_percent']
        @first_member_id, @second_member_id = result['first_member_id'], result['second_member_id']
      end
      
    end
  end
end
