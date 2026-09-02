class MonetizeContributions < ActiveRecord::Migration[8.1]
  def change
    add_monetize :contributions, :amount
  end
end
