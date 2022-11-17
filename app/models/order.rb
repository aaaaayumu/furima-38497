class Order < ApplicationRecord
  has_one :shipping_address
  belongs_to :user
  belongs_to :item
end
