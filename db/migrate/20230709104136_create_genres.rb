class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.string :name
      t.timestamps
    end

    add_column :items, :genre_id, :integer
  end
end
