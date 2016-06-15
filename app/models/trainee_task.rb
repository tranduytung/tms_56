class TraineeTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :trainee_subject
  belongs_to :task
end
