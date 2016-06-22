class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :trainee_subjects, dependent: :destroy

  enum status: {start: 0, training: 1, finish: 2}

  after_save :create_trainee_subject

  private
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
