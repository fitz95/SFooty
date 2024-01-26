class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    can :create, Follow if user.persisted?

    if user.super_admin?
      can :manage, :all
    elsif user.admin?
      can :manage, [
        Formation, GameWeek, League, LineupPlayer, LineupPosition,
        LineupSubstituteOption, Match, MatchOfficial, Player, Referee,
        Trophy, Stadium, Team, User, Transfer, TrophyPlayer, MatchEvent,
        MatchGoal, MatchLineup, MatchOfficialForMatch, MatchShot,
        MatchSubstitute, PlayerPosition, PlayerInjury, PlayerStat, TeamStat
      ]
    elsif user.data_collector?
      can :manage, [
        Formation, GameWeek, LineupPlayer, LineupPosition,
        LineupSubstituteOption, MatchEvent, MatchGoal, MatchLineup,
        MatchPlayer, MatchOfficial, MatchOfficialForMatch, MatchShot,
        MatchSubstitute, Player, Stadium, TrophyPlayer, PlayerPosition,
        PlayerInjury, PlayerStat, TeamStat
      ]
    elsif user.client?
      can :read, [
        Follow, Formation, GameWeek, League, LineupPlayer, LineupPosition,
        LineupSubstituteOption, Match, Player, Referee, Trophy
      ]
      can :create, Follow if user.persisted?
      # Define more abilities as needed for clients
    else
      can :read, [
        Follow, Formation, GameWeek, LineupPlayer, LineupPosition,
        LineupSubstituteOption, Match, Player, Referee, Trophy, Stadium, Team,
        User, Transfer, TrophyPlayer, MatchEvent, MatchGoal, MatchLineup,
        MatchOfficialForMatch, MatchShot, MatchSubstitute, PlayerPosition,
        PlayerInjury, PlayerStat, TeamStat, League, GameWeek, MatchOfficial
      ]
      can :create, Follow if user.persisted?
      # Default abilities for guests
    end
  end
end



