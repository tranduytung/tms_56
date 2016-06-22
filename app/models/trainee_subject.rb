class TraineeSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :course_subject
  belongs_to :subject
  belongs_to :user_course

  has_many :trainee_tasks, dependent: :destroy
  has_many :tasks, through: :trainee_tasks

  enum status: {start: 0, training: 1, finish: 2}
end
