class MoveAmountToMonitize < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      UPDATE gifts
      SET amount_cents = amount
    SQL
    remove_column :gifts, :amount
  end

  def down
    add_column :gifts, :amount, :integer, null: false
    execute <<~SQL
      UPDATE gifts
      SET amount = amount_cents
    SQL
  end
end
