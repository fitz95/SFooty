class AddSweeperClearanceToMatchClearances < ActiveRecord::Migration[7.0]
  def change
    add_column :match_clearances, :sweeper_clearance, :boolean, default: false
  end
end
