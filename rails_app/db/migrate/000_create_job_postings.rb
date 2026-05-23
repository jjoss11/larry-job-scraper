class CreateJobPostings < ActiveRecord::Migration[7.0]
  def change
    # Example migration — implement the exact columns when you're ready.
    create_table :job_postings do |t|
      t.string :title
      t.string :school_district
      t.string :position_area
      t.string :url
      t.datetime :posted_at
      t.string :distance
      t.text :description
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

    end

    # Add indexes you need, e.g. on :url for uniqueness and :posted_at for queries
    # add_index :job_postings, :url, unique: true
  end
end
