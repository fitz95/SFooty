class UpdateMatchesTable < ActiveRecord::Migration[7.0]
  def change
    change_table :matches do |t|
      # Add competition_id as a foreign key
      t.integer :competition_id, index: true, foreign_key: true

      # Remove home_team_score and away_team_score columns
      t.remove :home_team_score, :away_team_score
    end
  end
end

