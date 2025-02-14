# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user1 = User.create(
  email: "user1@test.com",
  password: "password"
)

user2 = User.create(
  email: "user2@test.com",
  password: "password"
)

User.create(
  email: "user3@test.com",
  password: "password"
)

User.create(
  email: "user4@test.com",
  password: "password"
)

projects_user1 = rand(1..10).times.map do
  Project.create!(name: Faker::Educator.unique.subject, user: user1)
end

projects_user1.each do |project|
  rand(1..20).times do
    Task.create!(name: Faker::ProgrammingLanguage.unique.name,
      project: project, priority: rand(-1..3), due_date: Faker::Date.forward(days: 60))
  end
end

projects_user2 = rand(1..10).times.map do
  Project.create!(name: Faker::Educator.unique.subject, user: user2)
end

projects_user2.each do |project|
  rand(1..20).times do
    Task.create!(name: Faker::ProgrammingLanguage.unique.name,
      project: project, priority: rand(-1..3), due_date: Faker::Date.forward(days: 60))
  end
end
