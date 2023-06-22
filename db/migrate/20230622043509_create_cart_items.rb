class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      # テーブル定義書に従い、NOT NULL制約をつける
      t.integer :customer_id, null: false
      t.integer :item_id, null: false
      t.integer :amount, null: false
      t.timestamps
    end
  end
end
