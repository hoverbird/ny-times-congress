def member_response
  File.read(File.dirname(__FILE__) + '/member.json')
end

def members_response
  File.read(File.dirname(__FILE__) + '/members.json')
end

def roll_call_votes_response
  File.read(File.dirname(__FILE__) + '/roll_call_votes.json')
end

def limited_legislator_attributes
  <<-JSON
    {"id":"B000444",
    "name":"Joseph Biden",
    "party":"D",
    "state":"DE",
    "district":"N/A"}
  JSON
end

def full_legislator_attributes
  <<-JSON
  {
     "member_id":"B000444",
     "name":"Joseph Biden",
     "date_of_birth":"1942-11-20",
     "gender":"M",
     "url":"http://biden.senate.gov",
     "govtrack_id":"300008",
     "roles":[
        {
           "congress":"111",
           "chamber":"Senate",
           "title":"Senator, 2nd Class",
           "state":"DE",
           "party":"D",
           "district":"N/A",
           "start_date":"2009-01-06",
           "end_date":"2009-01-20"
        },
        {
           "congress":"110",
           "chamber":"Senate",
           "title":"Senator, 2nd Class",
           "state":"DE",
           "party":"D",
           "district":"N/A",
           "start_date":"2007-01-04",
           "end_date":"2009-01-03"
        }
     ]
   }
  JSON
end

def role_response_fragment
  <<-JSON
    {
       "congress":"111",
       "chamber":"Senate",
       "title":"Senator, 2nd Class",
       "state":"DE",
       "party":"D",
       "district":"N/A",
       "start_date":"2009-01-06",
       "end_date":"2009-01-20"
    }
  JSON
end