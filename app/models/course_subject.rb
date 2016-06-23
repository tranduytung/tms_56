class CourseSubject < ActiveRecord::Base
  belongs_to :subject
  belongs_to :course

  has_many :trainee_subjects, dependent: :destroy
  
  delegate :content, :description, to: :subject, prefix: true
  delegate :content, :description, to: :course, prefix: true
  
  enum status: {ready: 0, training: 1, finish: 2}

  include PublicActivity::Model
  tracked

  after_update :activity
  after_create :create_trainee_subject_by_subject

  def activity
    if started?
      create_activity key: I18n.t("activity.subject.started"), recipient: course
      course.users.each do |user|
        create_activity key: I18n.t("activity.subject.started"), owner: user
      end
    elsif finished?
      create_activity key: I18n.t("activity.subject.finished"), recipient: course
      course.users.each do |user|
        create_activity key: I18n.t("activity.subject.finished"), owner: user
      end
    end
  end

  private
  def create_trainee_subject_by_subject
    TraineeSubject.transaction do
      begin
        course.user_courses.each do |user_course|
          @trainee_subjects = user_course.trainee_subjects.
            create! user: user_course.user, subject: subject,
            course_subject: self
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end
end
