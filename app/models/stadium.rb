class Stadium < ApplicationRecord
  belongs_to :team, optional: true
  has_many :matches, dependent: :nullify
  belongs_to :user
end
