class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :language, default: ""

      t.timestamps
    end

    create_table :language_blogs do |t|
      t.belongs_to :blog
      t.belongs_to :language

      t.timestamps
    end
  end
end
