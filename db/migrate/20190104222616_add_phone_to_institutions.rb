class AddPhoneToInstitutions < ActiveRecord::Migration[5.2]
  def change
    add_column :institutions, :phone, :string
    add_column :people, :phone2, :string
  end
end
