class MoveContributionAmountToMonetizeField < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      UPDATE contributions
      SET amount_cents = amount, amount_currency = currency
    SQL
    remove_column :contributions, :amount
    remove_column :contributions, :currency
  end

  def down
    add_column :contributions, :amount, :integer, null: false
    add_column :contributions, :currency, :string, default: 'GBP', null: false
    execute <<~SQL
      UPDATE contributions
      SET amount = amount_cents, currency = amount_currency
    SQL
  end
end
