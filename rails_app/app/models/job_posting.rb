class JobPosting < ApplicationRecord
  # Fields to store (example):
  # - title :string
  # - company :string
  # - location :string
  # - url :string
  # - posted_at :datetime
  # - salary :string (optional)
  # - snippet :text (short description)
  # - source :string (which URL/domain)
  # - raw_html :text (OPTIONAL: avoid unless needed)

  # Add validations and indexes in your migration and model
  # e.g. validates :url, presence: true, uniqueness: true

  def initialize(t)
    @title = t.title
    @position_area = t.position_area
    @school_district = t.school_district
    @posted_at = t.posted_at
    @distance = t.distance
    @description = t.description
  end
end
