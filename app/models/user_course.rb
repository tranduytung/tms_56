class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  enum status: {not_learn: 0, learning: 1, finish: 2}
end
