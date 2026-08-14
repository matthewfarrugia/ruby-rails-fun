class CreateContributions < ActiveRecord::Migration[8.1]
  def change
    create_table :contributions do |t|
      t.integer :amount, null: false
      t.string :currency, null: false

      t.timestamps
      t.belongs_to :gift, foreign_key: { to_table: :gifts, primary_key: :slug }, type: :string
      t.belongs_to :contributor, foreign_key: true
    end
  end
end
