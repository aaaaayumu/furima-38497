class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :address, :building, :phone_number

  validates :user_id, :item_id, :postcode, :city, :address, :phone_number, presence: true
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :postcode,
            format: { with: /\A\d{3}-\d{4}\z/, message: 'は3桁-4桁で入力してください' },
            if: :postcode_errors_blank?
  validates :phone_number,
            format: { with: /\A\d{10,11}\z/, message: 'は半角数字のみで入力してください'},
            if: :phone_number_errors_blank?

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(
                          postcode: postcode, prefecture_id: prefecture_id, city: city, address: address,
                          building: building, phone_number: phone_number, order_id: order.id
                          )
  end

  def postcode_errors_blank?
    errors[:postcode].blank?
  end

  def phone_number_errors_blank?
    errors[:phone_number].blank?
  end
end