class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      # テーブル定義書に従い、NOT NULL制約をつける
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.timestamps
    end
  end
end
