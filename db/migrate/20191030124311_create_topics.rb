class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :name, default: ""

      t.timestamps
    end

    create_table :topic_relations do |t|
      t.belongs_to :topic
      t.belongs_to :person

      t.timestamps
    end
  end
end
