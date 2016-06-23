class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :trainee_subjects, dependent: :destroy

  enum status: {start: 0, training: 1, finish: 2}

  after_save :create_trainee_subject
  after_create :send_mail_assign
  before_destroy :send_mail_delete

  private
  def send_mail_assign
    UserMailer.assign_to_course(user, course).deliver_later
  end

  def send_mail_delete
    UserMailer.delete_from_course(user, course).deliver_later
  end

  def create_trainee_subject
    if self.course.course_subjects.any?
      TraineeSubject.transaction do
        self.course.course_subjects.each do |course_subject|
          course_subject.trainee_subjects.create user: self.user,
            subject: course_subject.subject,
            user_course: self
        end
      end
    end
  end
end
