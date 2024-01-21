class Ability
    include CanCan::Ability
  
    def initialize(user)
      # Define abilities for the user here. For example:
      #
      return unless user.present?
  
      can :read, :all
  
      return unless user.role == 'admin'
  
      can :manage, :all
  
    end
end
  
  