class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.string :description
      t.string :imageurl
      t.string :size

      t.timestamps
    end
  end
end
