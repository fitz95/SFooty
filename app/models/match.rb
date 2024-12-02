class Match < ApplicationRecord
  belongs_to :user
  belongs_to :stadium
  belongs_to :referee
  belongs_to :league_group, optional: true
  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'
  belongs_to :league, optional: true
  belongs_to :game_week, optional: true 
  belongs_to :competition, optional: true
  has_many :player_stats, dependent: :destroy
  has_many :match_events, dependent: :destroy
  has_many :match_goals, dependent: :destroy
  has_many :match_lineups, dependent: :destroy
  has_many :lineup_players, through: :match_lineups
  has_many :lineup_positions, through: :match_lineups
  has_many :substitudes
  has_many :match_shots, dependent: :destroy
  has_many :match_passes, dependent: :destroy
  has_many :match_fouls, dependent: :destroy
  has_many :match_touches, dependent: :destroy
  has_many :match_dribbles, dependent: :destroy


  validates :stadium_id, :referee_id, :home_team_id, :away_team_id, presence: true
  validate :teams_must_be_different

  def teams_must_be_different
    errors.add(:away_team, "can't be the same as home team") if home_team_id == away_team_id 
  end

end
