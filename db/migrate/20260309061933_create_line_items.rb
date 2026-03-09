class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.string :sku
      t.integer :quantity
      t.boolean :original
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
