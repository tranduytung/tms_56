class Course < ActiveRecord::Base
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  
  accepts_nested_attributes_for :course_subjects,
    reject_if: proc {|attributes| attributes[:subject_id].blank?},
    allow_destroy: true
  accepts_nested_attributes_for :user_courses, allow_destroy: true

  validates :content, presence: true

  enum status: {ready: 0, started: 1, finished: 2}

  include PublicActivity::Model
  tracked
  
  after_update :activity

  def activity
    if started?
      users.each do |user|
        create_activity key: I18n.t("activity.course.started"), owner: user
      end
    elsif self.finished?
      users.each do |user|
        create_activity key: I18n.t("activity.course.finished"), owner: user
      end
    end
  end
end
