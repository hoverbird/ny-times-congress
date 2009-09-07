def member_response
  File.read(File.dirname(__FILE__) + '/member.json')
end

def members_response
  File.read(File.dirname(__FILE__) + '/members.json')
end

def roll_call_votes_response
  File.read(File.dirname(__FILE__) + '/roll_call_votes.json')
end

def member_vote_comparison_response
  File.read(File.dirname(__FILE__) + '/member_vote_comparison.json')
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

def member_positions_response
  <<-JSON
  {
     "status":"OK",
     "copyright":"Copyright (c) 2009 The New York Times Company.  All Rights Reserved.",
     "results":[
        {
           "member_id":"N000147",
           "total_votes":"100",
           "offset":"0",
           "votes":[
             {
                "member_id":"N000147",
                "chamber":"House",
                "congress":"111",
                "session":"1",
                "roll_call":"23",
                "date":"2009-01-21",
                "time":"15:37:00",
                "position":"Yes"
             },
             {
                "member_id":"N000147",
                "chamber":"House",
                "congress":"111",
                "session":"1",
                "roll_call":"19",
                "date":"2009-01-15",
                "time":"13:37:00",
                "position":"Yes"
             },
             {
                "member_id":"N000147",
                "chamber":"House",
                "congress":"110",
                "session":"1",
                "roll_call":"1031",
                "date":"2007-11-01",
                "time":"14:21:00",
                "position":"No"
             }
           ]
        }
     ]
  }
  JSON
end