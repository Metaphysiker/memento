class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.decimal :amount, :decimal, :precision => 8, :scale => 2
      t.date :date
      t.belongs_to :person

      t.references :paymentable, polymorphic: true

      t.timestamps
    end

  end
end
