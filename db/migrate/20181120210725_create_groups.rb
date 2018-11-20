class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, default: ""
      t.text :description, default: ""

      t.timestamps
    end

    create_table :group_people do |t|
      t.belongs_to :group, index: true
      t.belongs_to :person, index: true
      t.timestamps
    end
  end
end
