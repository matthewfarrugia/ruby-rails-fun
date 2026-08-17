class MakeContributorEmailNotNullable < ActiveRecord::Migration[8.1]
  def change
    change_column_null :contributors, :email, false
  end
end
