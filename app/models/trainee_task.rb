class TraineeTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :trainee_subject
  belongs_to :task

  enum status: {start: 0, training: 1, finish: 2}
end
