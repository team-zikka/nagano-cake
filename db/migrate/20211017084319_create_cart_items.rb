class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.references :customer, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
