class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :trainee_subjects, dependent: :destroy

  enum status: {start: 0, training: 1, finish: 2}
end
