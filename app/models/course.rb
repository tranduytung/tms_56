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
  tracked owner: Proc.new{|controller, model| controller.current_user}
  
  after_update :create_course_activity

  def build_course_subjects subjects = {}
    Subject.all.each do |subject|
      unless subjects.include? subject
        self.course_subjects.build subject_id: subject.id
      end
    end
  end

  private

  def create_activities type_action
    create_activity key: type_action, recipient: self
    users.each do |user|
      create_activity key: type_action, owner: user, recipient: self
    end
  end

  def create_course_activity
    started? ? (create_activities I18n.t("activity.started")) :
      (create_activities I18n.t("activity.finished"))
  end
end
