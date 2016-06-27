class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  after_create :create_following_activity
  after_destroy :create_unfollow_activity

  private
  def create_following_activity
    followed.create_activity key: I18n.t("activity.following"), owner: follower
    follower.create_activity key: I18n.t("activity.followed"), owner: followed
  end

  def create_unfollow_activity
    followed.create_activity key: I18n.t("activity.unfollow"), owner: follower
  end
end
