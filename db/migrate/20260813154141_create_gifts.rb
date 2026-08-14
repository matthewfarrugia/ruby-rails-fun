class CreateGifts < ActiveRecord::Migration[8.1]
  def change
    create_table :gifts, id: false, primary_key: :slug do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.text :summary
      t.boolean :contribution, default: false
      t.integer :amount, null: false

      t.timestamps
      t.index :slug, unique: true
    end
  end
end
