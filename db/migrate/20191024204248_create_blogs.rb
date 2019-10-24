class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.date :planned_date
      t.string :language, default: "de"
      t.string :working_title, default: ""
      t.string :submitted, default: "false"
      t.string :published, default: "false"
      t.string :author_informed, default: "false"
      t.belongs_to :person

      t.timestamps
    end
  end
end
