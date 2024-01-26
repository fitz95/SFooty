class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    # Anyone with an account can follow any account
    can :create, Follow if user.persisted?

    # Abilities for different roles
    if user.super_admin?
      can :manage, :all
    elsif user.admin?
      can :manage, [Formation, GameWeek, League, LineupPlayer, LineupPosition, LineupSubstituteOption, Match, Player, Referee, Trophy]
    elsif user.data_collector?
      can :manage, [Formation, GameWeek, LineupPlayer, LineupPosition, LineupSubstituteOption, MatchEvent, MatchGoal, MatchLineup]
    elsif user.client?
      can :read, [Follow, Formation, GameWeek, League, LineupPlayer, LineupPosition, LineupSubstituteOption, Match, Player, Referee, Trophy]
      can :create, Follow if user.persisted?
      # Define more abilities as needed for clients
    else
      can :read, [Follow, Formation, GameWeek, LineupPlayer, LineupPosition, LineupSubstituteOption, Match, Player, Referee, Trophy, ...]
      can :create, Follow if user.persisted?
      # Default abilities for guests
    end
  end
end


