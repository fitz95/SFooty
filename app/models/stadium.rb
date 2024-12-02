class Stadium < ApplicationRecord
  self.table_name = "stadiums"
  belongs_to :team, optional: true
  has_many :matches, dependent: :nullify
  belongs_to :user
end
