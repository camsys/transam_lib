module Abilities
  class ManagerLibAbility
    include CanCan::Ability

    def initialize(user)

      #-------------------------------------------------------------------------
      # Document Library
      #-------------------------------------------------------------------------
      can :manage,  [LibraryCategory, LibraryDocument]

      cannot :destroy, LibraryCategory do |c|
        ! c.deleteable?
      end


    end
  end
end