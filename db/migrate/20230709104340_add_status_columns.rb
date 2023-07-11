class AddStatusColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :is_active, :boolean, default: true, null: false
    add_column :orders, :status, :integer, default: 0, null: false
    add_column :order_details, :making_status, :integer, default: 0, null: false
  end
end
