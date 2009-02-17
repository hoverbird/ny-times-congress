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
   {
    "id": "L000304",
    "name": "Joseph I. Lieberman",
    "first_name": "Joseph I.",
    "middle_name": "I.",
    "last_name": "Lieberman",
    "party": "ID",
    "state": "CT",
                     "missed_votes_pct": "0.00",
    "votes_with_party_pct": "93.44" 
    }
  JSON
end

def full_legislator_attributes
  <<-JSON
  {
     "status":"OK",
     "copyright":"Copyright (c) 2009 The New York Times Company.  All Rights Reserved.",
     "results":[
        {
           "member_id": "L000304",
           "name": "Joseph I. Lieberman",
           "first_name": "Joseph I.",
           "middle_name": "I.",
           "last_name": "Lieberman",
           "date_of_birth": "1942-02-24",
           "gender": "M",
           "url": "http://lieberman.senate.gov/",
           "govtrack_id": "300067",
           "roles": [
           {
             "congress": "111",
             "chamber": "Senate",
             "title": "Senator, 1st Class",
             "state": "CT",
             "party": "ID",
             "district": "N/A",
             "start_date": "2009-01-06",
             "end_date": "2011-01-04",
             "missed_votes_pct": "0.00",
             "votes_with_party_pct": "93.44"
           },        {
             "congress": "110",
             "chamber": "Senate",
             "title": "Senator, 1st Class",
             "state": "CT",
             "party": "ID",
             "district": "N/A",
             "start_date": "2007-01-04",
             "end_date": "2009-01-03",
             "missed_votes_pct": "3.20",
             "votes_with_party_pct": "86.79"
           }
          ]
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