class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.string :name
      t.string :email
      t.string :phone
      t.integer :philosophie_id
      t.string :gender
      t.text :description

      t.timestamps
    end
  end
end