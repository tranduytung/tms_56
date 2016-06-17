class Course < ActiveRecord::Base
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  
  accepts_nested_attributes_for :course_subjects,
    reject_if: proc {|attributes| attributes[:subject_id].blank?},
    allow_destroy: true

  validates :content, presence: true
end
