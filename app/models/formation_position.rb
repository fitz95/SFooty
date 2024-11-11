class FormationPosition < ApplicationRecord
  belongs_to :formation

  validates :position_name, presence: true
  validates :position_order, presence: true, numericality: { only_integer: true }
  validates :position_number, numericality: { only_integer: true }
end
