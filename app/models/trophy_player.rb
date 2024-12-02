class TrophyPlayer < ApplicationRecord
  belongs_to :trophy
  belongs_to :player
end
