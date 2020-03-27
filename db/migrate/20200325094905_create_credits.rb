class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.integer :number, null: false
      t.string :customer_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
