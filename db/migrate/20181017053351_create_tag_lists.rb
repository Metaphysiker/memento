class CreateTagLists < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_lists do |t|
      t.string :name
      t.string :category
      t.string :model

      t.timestamps
    end
  end
end
