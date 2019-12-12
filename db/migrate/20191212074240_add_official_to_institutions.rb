class AddOfficialToInstitutions < ActiveRecord::Migration[5.2]
  def change
    add_column :institutions, :firstname_of_official, :string, default: ""
    add_column :institutions, :lastname_of_official, :string, default: ""
    add_column :institutions, :anrede_of_official, :string, default: ""
  end
end
