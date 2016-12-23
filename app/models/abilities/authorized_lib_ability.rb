module Abilities
  class AuthorizedLibAbility
    include CanCan::Ability

    def initialize(user)

      #-------------------------------------------------------------------------
      # Document Library
      #-------------------------------------------------------------------------
      can :manage,  LibraryCategory do |c|
        user.organization_ids.include?(c.organization_id)
      end
      can :manage,  LibraryDocument do |c|
        user.organization_ids.include?(c.organization_id)
      end

      cannot :destroy, LibraryCategory do |c|
        ! c.deleteable?
      end


    end
  end
end