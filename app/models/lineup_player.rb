class LineupPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :match_lineup
  belongs_to :formation_position
  belongs_to :user

  validates :position, presence: true
  
end
