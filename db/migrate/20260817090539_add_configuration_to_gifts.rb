class AddConfigurationToGifts < ActiveRecord::Migration[8.1]
  def up
    add_column :gifts, :config, :json, default: {}, null: false
    execute <<~SQL
      UPDATE gifts
      SET config = json_set(
        COALESCE(config, '{}'),
        '$.accepts_contributions',
        json(CASE WHEN contribution = 1 THEN 'true' ELSE 'false' END)
      )
    SQL
    remove_column :gifts, :contribution
  end

  def down
    add_column :gifts, :contribution, :boolean, default: false
    execute <<~SQL
      UPDATE gifts
      SET contribution = CASE WHEN json_extract(config, '$.accepts_contributions') IN (1, 'true') THEN 1 ELSE 0 END
    SQL
    remove_column :gifts, :config
  end
end
