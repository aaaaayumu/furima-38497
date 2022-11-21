require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入機能' do
    context '商品購入できるとき' do
      it 'すべての値が正し入力されていれば購入できる' do
        expect(@order_shipping_address).to be_valid
      end
      it 'buildingは空でも購入できる' do
        @order_shipping_address.building = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '商品購入できないとき' do
      it 'tokenが空では保存できない' do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Token can't be blank"
      end
      it 'postcodeが空では購入できない' do
        @order_shipping_address.postcode = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Postcode can't be blank"
      end
      it 'postcodeが半角のハイフンを含んだ正しい形式でないと購入できない' do
        @order_shipping_address.postcode = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include 'Postcode は3桁-4桁で入力してください'
      end
      it 'prefectureを選択していないと購入できない' do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'cityが空では購入できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "City can't be blank"
      end
      it 'addressが空では購入できない' do
        @order_shipping_address.address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Address can't be blank"
      end
      it 'phone_numberが空では購入できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Phone number can't be blank"
      end
      it 'phone_numberが全角数字では購入できない' do
        @order_shipping_address.phone_number = '１２３４５６７８９０'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include 'Phone number は10桁もしくは11桁の半角数字で入力してください'
      end
      it 'phone_numberが10桁未満では購入できない' do
        @order_shipping_address.phone_number = '123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include 'Phone number は10桁もしくは11桁の半角数字で入力してください'
      end
      it 'phone_numberが11桁を超えると購入できない' do
        @order_shipping_address.phone_number = '123456789012'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include 'Phone number は10桁もしくは11桁の半角数字で入力してください'
      end
      it 'userが紐づいていなければ購入できない' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "User can't be blank"
      end
      it 'itemが紐づいていなければ購入できない' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
end
