PublicActivity::Activity.class_eval do
  scope :course, -> (course_id) {where(recipient_id: course_id,
    recipient_type: Settings.activity.course)}
end
