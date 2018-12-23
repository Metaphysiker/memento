class AddWebsiteToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :website, :string, default: ""
    add_column :institutions, :website, :string, default: ""
  end
end
