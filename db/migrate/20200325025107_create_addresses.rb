class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :family_name, null: false
      t.string :first＿name, null: false
      t.string :family_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :tel
      t.integer :prefecture_id, null: false
      t.integer :zip_code, null: false
      t.string :municipality, null: false
      t.string :address, null: false
      t.string :building_name
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end


