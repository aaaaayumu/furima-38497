# テーブル設計

## usersテーブル

|Column            |Type  |Options                  |
|------------------|------|-------------------------|
|nickname          |string|null: false              |
|email             |string|null: false, unique: true|
|encrypted_password|string|null: false              |
|last_name         |string|null: false              |
|first_name        |string|null: false              |
|last_name_kana    |string|null: false              |
|first_name_kana   |string|null: false              |
|birth_date        |date  |null: false              |

### Association

- has_many :items
- has_many :orders

## itemsテーブル

|Column                |Type      |Options                      |
|----------------------|----------|-----------------------------|
|name                  |string    |null: false                  |
|description           |text      |null: false                  |
|category_id           |integer   |null: false                  |
|condition_id          |integer   |null: false                  |
|shipping_fee_status_id|integer   |null: false                  |
|prefecture_id         |integer   |null: false                  |
|scheduled_delivery_id |integer   |null: false                  |
|price                 |integer   |null: false                  |
|user                  |references|null:false, foreign_key: true|

### Association

has_one :order
belongs_to :user

## ordersテーブル

|Column|Type      |Options                       |
|------|----------|------------------------------|
|user  |references|null: false, foreign_key: true|
|item  |references|null: false, foreign_key: true|

### Association

has_one :shipping_address
belongs_to :user
belongs_to :item


## shipping_addressesテーブル

|Column       |Type      |Options                       |
|-------------|----------|------------------------------|
|postcode     |string    |null: false                   |
|prefecture_id|integer   |null: false                   |
|city         |string    |null: false                   |
|address      |string    |null: false                   |
|building     |string    |                              |
|phone_number |integer   |null: false                   |
|order        |references|null: false, foreign_key: true|

### Association

belongs_to :order