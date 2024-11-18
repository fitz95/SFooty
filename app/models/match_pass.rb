class MatchPass < ApplicationRecord
    belongs_to :match
    belongs_to :player
    belongs_to :team
    belongs_to :user
    belongs_to :receiver, class_name: 'Player', optional: true
    belongs_to :assister, class_name: 'Player', optional: true

    validates :match_id, presence: true
    validates :player_id, presence: true
    validates :team_id, presence: true
    validates :user_id, presence: true
    
end
