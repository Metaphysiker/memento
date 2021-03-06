class CreateInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :institutions do |t|
      t.string :name, default: ""
      t.text :description, default: ""
      t.string :email, default: ""
      t.string :language, default: ""
      t.integer :philosophie_society_id

      t.timestamps
    end

    create_table :affiliations do |t|
      t.belongs_to :institution, index: true
      t.belongs_to :person, index: true
      t.string :function, default: ""
      t.timestamps
    end
  end
end
