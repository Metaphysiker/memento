class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, default: ""
      t.text :description, default: ""
      t.date :start, default: nil
      t.date :end, default: nil

      t.timestamps
    end

    create_table :project_people do |t|
      t.belongs_to :project, index: true
      t.belongs_to :person, index: true
      t.timestamps
    end
  end
end
