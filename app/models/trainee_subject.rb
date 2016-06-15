class TraineeSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :course_subject
  belongs_to :subject

  has_many :trainee_tasks, dependent: :destroy
  has_many :tasks, through: :trainee_tasks
end
