class CreateWorkTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :work_times do |t|
      t.belongs_to :user, index: true
      t.date :date
      t.decimal :time, precision: 16, scale: 2, default: 0
      t.string :area, default: ""
      t.string :project, default: ""
      t.boolean :voluntary, default: false

      t.timestamps
    end
  end
end
