class UpdateMatchPassesForGoalkeeperPassesAndTrackingagain < ActiveRecord::Migration[7.0]
  def change
    # Add a new column for is_throw_in
    add_column :match_passes, :is_throw_in, :boolean, default: false, null: false

    # Rename the existing column is_throwout to is_throw_out
    rename_column :match_passes, :is_throwout, :is_throw_out
  end
end

