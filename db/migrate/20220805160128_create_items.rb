class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :quantity
      t.float :price
      t.boolean :favorite
      t.integer :category
      t.timestamps
    end
  end
end
