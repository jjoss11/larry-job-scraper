class AddFieldsToJobPostings < ActiveRecord::Migration[7.2]
  def change
    add_column :job_postings, :position_area, :string
    add_column :job_postings, :school_district, :string
    add_column :job_postings, :distance, :string
    add_column :job_postings, :description, :text
    remove_column :job_postings, :company, :string
    remove_column :job_postings, :location, :string
    remove_column :job_postings, :salary, :string
    remove_column :job_postings, :snippet, :text
    remove_column :job_postings, :source, :string
  end
end
