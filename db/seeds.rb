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

5.times do |n|
  Course.create! content: "Training-#{n+1}", description: "Traning course"
end
3.times do |n|
  UserCourse.create! user_id: 1, course_id: n+1, status: false
end
5.times do |n|
  Subject.create! content: "Subject-#{n+1}"
end
5.times do |n|
  CourseSubject.create! course_id: 1, subject_id: n+1
end
