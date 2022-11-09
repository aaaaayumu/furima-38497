class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください', if: :password_errors_blank?

  validates_format_of :last_name, with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'には全角ひらがな、全角カタカナ、漢字を使用してください', if: :last_name_errors_blank?
  validates_format_of :first_name, with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'には全角ひらがな、全角カタカナ、漢字を使用してください', if: :frist_name_errors_blank?
  
  validates_format_of :last_name_kana, with: /\A[ァ-ヶー]+\z/, message: 'には全角カタカナを使用してください', if: :last_name_kana_errors_blank?
  validates_format_of :first_name_kana, with: /\A[ァ-ヶー]+\z/, message: 'には全角カタカナを使用してください', if: :first_name_kana_errors_blank?

  def password_errors_blank?
    errors[:password].blank?
  end

  def last_name_errors_blank?
    errors[:last_name].blank?
  end

  def frist_name_errors_blank?
    errors[:first_name].blank?
  end

  def last_name_kana_errors_blank?
    errors[:last_name_kana].blank?
  end

  def first_name_kana_errors_blank?
    errors[:first_name_kana].blank?
  end
  
end
