class Substitution < ApplicationRecord
    belongs_to :match
    belongs_to :player
    belongs_to :team

    validates :match_id, presence: true
    validates :player_id, presence: true
    validates :team_id, presence: true
    
end
