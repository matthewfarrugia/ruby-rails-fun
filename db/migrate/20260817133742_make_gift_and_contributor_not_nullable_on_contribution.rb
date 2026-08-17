class MakeGiftAndContributorNotNullableOnContribution < ActiveRecord::Migration[8.1]
  def change
    change_column_null :contributions, :gift_id, false
    change_column_null :contributions, :contributor_id, false
  end
end
