class Player < ApplicationRecord
    belongs_to :user
    belongs_to :current_team, class_name: "Team", foreign_key: "current_team_id", optional: true
    has_many :lineup_substitute_options, foreign_key: "substitute_player_id", dependent: :destroy
    has_many :match_events, dependent: :nullify
    has_many :player_injuries, dependent: :destroy
    has_many  :player_stats, dependent: :destroy
    has_many :player_team_histories, dependent: :destroy
    has_many :teams, through: :player_team_histories
    has_many :player_transfers, dependent: :destroy
    has_many :trophy_players, dependent: :destroy
    has_many :trophies, through: :trophy_players

    # Example: A scope to find players by nationality
    scope :by_nationality, ->(nationality) { where(nationality: nationality) }

end
