class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :trainee_subjects, dependent: :destroy

  enum status: {ready: 0, started: 1, finished: 2}

  after_save :create_trainee_subject

  private
  def create_trainee_subject
    if self.course.course_subjects.any?
      TraineeSubject.transaction do
        begin
          self.course.course_subjects.each do |course_subject|
            course_subject.trainee_subjects.create user: self.user,
              subject: course_subject.subject,
              user_course: self
          end
        rescue
          raise ActiveRecord::Rollback
        end
      end
    end
  end
end
