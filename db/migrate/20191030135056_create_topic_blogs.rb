class CreateTopicBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_blogs do |t|
      t.belongs_to :topic
      t.belongs_to :blog

      t.timestamps
    end
  end
end
