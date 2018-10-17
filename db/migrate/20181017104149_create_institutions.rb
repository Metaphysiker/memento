class CreateInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :institutions do |t|
      t.string :name, default: ""
      t.string :description, default: ""
      t.integer :philosophie_society_id

      t.timestamps
    end

    create_table :affiliations do |t|
      t.belongs_to :institution, index: true
      t.belongs_to :person, index: true
      t.timestamps
    end
  end
end
