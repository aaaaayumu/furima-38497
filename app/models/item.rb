class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  validates :name, :description, :price, presence: true
  validates :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
    numericality: { other_than: 1, message: "can't be blank" }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は(￥300~9,999,999)で入力してください" }, if: :price_errors_blank?
  validates :image, presence: true, blob: { content_type: :image }

  def price_errors_blank?
    errors[:price].blank?
  end

  
end
