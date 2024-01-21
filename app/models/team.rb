class Team < ApplicationRecord
  belongs_to :league
  belongs_to :user
  has_many :players
  belongs_to :league
  has_many :home_matches, class_name: 'Match', foreign_key: 'home_team_id'
  has_many :away_matches, class_name: 'Match', foreign_key: 'away_team_id'
  has_many :team_shots, dependent: :destroy
  has_many :stadiums
  has_many :match_events, dependent: :nullify
  has_many :player_team_histories, dependent: :destroy
  has_many :outgoing_player_transfers, class_name: 'PlayerTransfer', foreign_key: 'selling_team_id', dependent: :destroy
  has_many :players, through: :player_team_histories
  has_many :incoming_player_transfers, class_name: 'PlayerTransfer', foreign_key: 'buying_team_id', dependent: :destroy

  scope :by_country, ->(country) { where(country:) }
end
