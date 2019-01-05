class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :company, default: ""
      t.string :company2, default: ""
      t.string :street, default: ""
      t.string :plz, default: ""
      t.string :location, default: ""
      t.string :country, default: ""
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
