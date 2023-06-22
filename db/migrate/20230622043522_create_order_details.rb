class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      # テーブル定義書に従い、NOT NULL制約をつける
      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :price, null: false
      t.integer :amount, null: false
      t.timestamps
    end
  end
end
