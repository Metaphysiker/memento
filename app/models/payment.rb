class Payment < ApplicationRecord
  audited
  belongs_to :paymentable, :polymorphic => true, optional: true

  def self.paid_options
    ['yes', 'no']
  end

end
