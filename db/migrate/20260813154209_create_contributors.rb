class CreateContributors < ActiveRecord::Migration[8.1]
  def change
    create_table :contributors do |t|
      t.string :name, null: false
      t.string :email

      t.timestamps
      t.index :email
    end
  end
end
