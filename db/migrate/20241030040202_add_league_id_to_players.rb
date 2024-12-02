class AddLeagueIdToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_reference :players, :league, foreign_key: true, index: true
  end
end
