class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :line1, default: ""
      t.string :line2, default: ""
      t.string :line3, default: ""
      t.string :line4, default: ""
      t.string :line5, default: ""
      t.string :street, default: ""
      t.string :plz, default: ""
      t.string :location, default: ""
      t.string :country, default: ""
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
