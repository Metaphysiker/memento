class Payment < ApplicationRecord
  belongs_to :paymentable, :polymorphic => true
end
