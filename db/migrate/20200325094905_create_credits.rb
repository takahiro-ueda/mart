class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.integer :number, null: false
      t.integer :expiration_date_month, null: false
      t.integer :expiration_date_year, null: false
      t.integer :security_code, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
