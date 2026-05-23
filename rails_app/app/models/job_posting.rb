class JobPosting < ApplicationRecord
  def to_s
    "Title: #{@title}\nPosition Area: #{@position_area}\nSchool District: #{@school_district}\nPosted At: #{@posted_at}\nDistance: #{@distance}\nDescription: #{@description}"
  end
end
