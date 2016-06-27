User.create!(
  name: "Admin",
  email: "admin@railstutorial.org",
  password: "12345678",
  password_confirmation: "12345678",
  role: 1)

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "12345678"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role: 0)
end

# 5.times do |n|
#   Course.create! content: "Training-#{n+1}", description: "Traning course"
# end

# 5.times do |n|
#   Subject.create! content: "Subject-#{n+1}"
# end
# 5.times do |n|
#   CourseSubject.create! course_id: 1, subject_id: n+1
# end

# users = User.all
# user  = users.first
# following = users[2..10]
# followers = users[3..5]
# following.each{|followed| user.follow(followed)}
# followers.each{|follower| follower.follow(user)}

# users = User.order(:created_at).take(5)
# courses = Course.order(:created_at)
# users.each do |user|
#   courses.take(rand(Course.count) + 1).each do |course|
#     user.user_courses.create! course_id: course.id
#   end
# end
