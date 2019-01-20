class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.decimal :inventory_count

      t.timestamps
    end
  end
end
