class CourseSubject < ActiveRecord::Base
  belongs_to :subject
  belongs_to :course

  has_many :trainee_subjects, dependent: :destroy
  
  delegate :content, :description, to: :subject, prefix: true
  delegate :content, :description, to: :course, prefix: true
  
  enum status: {ready: 0, started: 1, finished: 2}

  include PublicActivity::Model
  tracked

  after_update :activity
  def activity
    if started?
      course.users.each do |user|
        create_activity key: I18n.t("activity.subject.started"), owner: user
      end
    elsif finished?
      course.users.each do |user|
        create_activity key: I18n.t("activity.subject.finished"), owner: user
      end
    end
  end
end
