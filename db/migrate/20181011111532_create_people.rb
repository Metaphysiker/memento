class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :firstname, default: ""
      t.string :lastname, default: ""
      t.string :name, default: ""
      t.string :email, default: ""
      t.string :phone, default: ""
      t.integer :philosophie_id
      t.string :gender, default: ""
      t.text :description, default: ""
      t.string :language, default: ""

      t.timestamps
    end
  end
end
