class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, default: ""
      t.text :description, default: ""
      t.date :start, default: nil
      t.date :end, default: nil

      t.timestamps
    end
  end
end
