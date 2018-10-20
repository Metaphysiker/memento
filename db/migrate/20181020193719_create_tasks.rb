class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :description, default: ""
      t.datetime :deadline
      t.integer :priority, default: 1
      t.integer :assigned_to_user_id
      t.string :status, default: "noch nicht angefangen"
      t.decimal :time_needed
      t.references :taskable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
