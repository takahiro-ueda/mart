class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  
  validates :family_name,:first＿name,:family_name_kana,:first_name_kana,:tel,:prefecture_id,:zip_code,:municipality,:address,:building_name,presence: true

end
