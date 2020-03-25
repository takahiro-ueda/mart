class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  # belongs_to :phone_number, optional: true
  # belongs_to :building, optional: true
  validates :first_name, :last_name, :first_name_kana, :last_name_kana, :post_number, :prefecture_id, :city, :address, presence: true

end
