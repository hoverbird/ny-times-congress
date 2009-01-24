module NYTimes
	module Congress
		class Vote < Base
		  attr_reader :congress, :session_number, :roll_call_number, :bill_number, :question,
		              :vote_type, :datetime, :result, :democratic, :republican, :independent, :total
		end
	end
end

# "congress": "111",
#  "session": "1",
#  "roll_call": "12",
#  "bill_number": "S.181",
#  "question": "On the Motion to Table ", 
#  "description": "Motion to Table Isakson Amdt. No. 37; To limit the application of the Act to claims resulting from discriminatory compensation decisions that are adopted on or after the date of enactment of the Act.",
#  "vote_type": "1/2",
#  "date": "2009-01-22",
#  "time": "17:20:00",
#  "result": "Agreed to",
#  "democratic": {
#    "yes": "54",
#    "no": "0",
#    "present": "0",
#    "not_voting": "1",
#    "majority_position": "Yes"
#   },
#  "republican": {
#    "yes": "3",
#    "no": "38",
#    "present": "0",
#    "not_voting": "0",
#    "majority_position": "No"
#   },
#  "independent": {
#    "yes": "2",
#    "no": "0",
#    "present": "0",
#    "not_voting": "0"
#   },
#  "total": {
#    "yes": "59",
#    "no": "38",
#    "present": "0",
#    "not_voting": "1"
#   },