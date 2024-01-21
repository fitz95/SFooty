class PlayerInjury < ApplicationRecord
  belongs_to :player
  belongs_to :user

  validates :player_id, presence: true
  validates :injury_type, presence: true
end
