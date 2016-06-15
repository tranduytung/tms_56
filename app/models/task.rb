class Task < ActiveRecord::Base
  belongs_to :subject

  has_many :trainee_tasks, dependent: :destroy
end
