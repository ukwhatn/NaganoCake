class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      # テーブル定義書に従い、NOT NULL制約をつける
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
