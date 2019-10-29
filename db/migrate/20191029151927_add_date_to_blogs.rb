class AddDateToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :submission_deadline, :date
    add_column :blogs, :assigned_to_user_id, :integer
  end
end
