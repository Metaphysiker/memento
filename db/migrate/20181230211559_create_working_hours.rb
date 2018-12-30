class CreateWorkingHours < ActiveRecord::Migration[5.2]
  def change
    create_table :working_hours do |t|
      t.date :date
      t.string :name
      t.string :task
      t.decimal :hours
      t.string :area
      t.string :project

      t.timestamps
    end
  end
end
