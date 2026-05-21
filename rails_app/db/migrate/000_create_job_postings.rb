class CreateJobPostings < ActiveRecord::Migration[7.0]
  def change
    # Example migration — implement the exact columns when you're ready.
    create_table :job_postings do |t|
      t.string :title
      t.string :company
      t.string :location
      t.string :url
      t.datetime :posted_at
      t.string :salary
      t.text :snippet
      t.string :source
      # t.text :raw_html

      t.timestamps
    end

    # Add indexes you need, e.g. on :url for uniqueness and :posted_at for queries
    # add_index :job_postings, :url, unique: true
  end
end
