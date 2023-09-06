class MatchEvent < ApplicationRecord
  belongs_to :match
  belongs_to :player, optional: true
  belongs_to :team, optional: true
  belongs_to :user

  # Define event types as constants or enums for better readability
  EVENT_TYPES = ['Goal', 'Yellow Card', 'Red Card', 'Substitution','Var', 'Foul', 'Corner', 'Fan', 'Other']

  # Validation example (you can customize this)
  validates :event_type, presence: true, inclusion: { in: EVENT_TYPES }

end
