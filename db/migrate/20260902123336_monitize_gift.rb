class MonitizeGift < ActiveRecord::Migration[8.1]
  def change
    add_monetize :gifts, :amount
  end
end
