class AddTeamsToSeasons < ActiveRecord::Migration[7.0]
  def change
    add_column :seasons, :teams, :integer, array: true, default: []
  end
end

