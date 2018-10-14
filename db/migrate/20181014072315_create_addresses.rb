class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :form_of_address
      t.string :firstname
      t.string :lastname
      t.string :company
      t.string :street
      t.string :plz
      t.string :location
      t.string :country
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
