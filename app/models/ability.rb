class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Post
    can :read, Comment
    can :delete, Post
    return unless user.present?

    can :manage, Post, user: user
    can :manage, Comment, user: user
    can :create, Comment
    can :create, Like
    return unless user.role == 'admin'

    can :manage, :all
  end
end
