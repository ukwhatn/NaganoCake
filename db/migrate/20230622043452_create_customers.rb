class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      # テーブル定義書に従い、NOT NULL制約をつける
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :telephone_number, null: false
      # テーブル定義書に従い、デフォルト値を設定する
      t.boolean :is_deleted, null: false, default: false
      t.timestamps
    end
  end
end
