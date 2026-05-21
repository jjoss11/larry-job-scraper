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
    @position_type = t.position_type
    @job_id = t.job_id
    @school = t.school
    @posted_at = t.posted_at
    @work_schedule = t.work_schedule
    @start_date = t.start_date
    @salary = t.salary
    @benefits = t.benefits
  end


end
