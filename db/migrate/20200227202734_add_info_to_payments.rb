class AddInfoToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :info, :string, default: ""
  end
end
