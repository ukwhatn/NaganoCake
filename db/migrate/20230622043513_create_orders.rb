class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      # テーブル定義書に従い、NOT NULL制約をつける
      t.integer :customer_id, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :shipping_cost, null: false
      t.integer :total_payment, null: false
      # enumで管理するので、テーブル側はinteger型で定義する
      t.integer :payment_method, null: false
      t.timestamps
    end
  end
end
