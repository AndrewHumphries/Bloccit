class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
        if user.role? :member #what can members do? 
            can :manage, Post, :user_id => user.id #manage their own posts
            can :manage, Comment, :user_id => user.id #comment
            can :create, Vote
            can :manage, Favorite, user_id: user.id
            can :read, Topic
        end

        if user.role? :moderator #what can mods do?
            can :destroy, Post #delete any post
            can :destroy, Comment #delete any comment
        end

        if user.role? :admin #what can admins do? 
            can :manage, :all #manage every object in the system
        end
        
        
        can :read, Topic, public: true
        can :read, Post 
    end
 end
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

