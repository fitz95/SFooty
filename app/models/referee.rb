class Referee < ApplicationRecord
    belongs_to :user
    belongs_to :league
    has_many :matches, dependent: :nullify
end
