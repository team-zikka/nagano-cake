class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: true
      t.string :name
      t.text :introduction
      t.string :price
      t.string :image_id
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
