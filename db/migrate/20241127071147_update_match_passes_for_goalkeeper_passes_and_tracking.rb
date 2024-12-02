class UpdateMatchPassesForGoalkeeperPassesAndTracking < ActiveRecord::Migration[7.0]
  def change
    # Add new columns for goalkeeper-specific actions
    add_column :match_passes, :is_goalkick, :boolean, default: false
    add_column :match_passes, :is_throwout, :boolean, default: false
    add_column :match_passes, :is_punt, :boolean, default: false

    # Add new columns for tracking open play and free kicks
    add_column :match_passes, :is_open_play, :boolean, default: true
    add_column :match_passes, :is_freekick, :boolean, default: false
  end
end
