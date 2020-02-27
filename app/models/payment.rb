class Payment < ApplicationRecord
  audited
  belongs_to :paymentable, :polymorphic => true, optional: true
end
