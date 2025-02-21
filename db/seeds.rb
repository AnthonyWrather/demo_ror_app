# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

FirstOrgUser = User.create(
  email: "firstorg@test.com",
  password: "password",
  full_name: "First Org User Full Name",
  invitations_count: 0
)

FirstOrg = Organisation.create(
  subdomain: "FirstOrgSubDomain",
  name: "FirstOrgName",
  owner_id: FirstOrgUser.id
)

SecondOrgUser = User.create(
  email: "secondorg@test.com",
  password: "password",
  full_name: "Second Org User Full Name",
  invitations_count: 0
)

SecondOrg = Organisation.create(
  subdomain: "SecondOrgSubDomain",
  name: "SecondOrgName",
  owner_id: SecondOrgUser.id
)

  # ActsAsTenant.with_tenant(FirstOrgUser) do
  projects_FirstOrgUser = rand(1..10).times.map do
    Project.create!(name: Faker::Educator.unique.subject, user: FirstOrgUser)
  end

  current_user = projects_FirstOrgUser
  projects_FirstOrgUser.each do |project|
    rand(1..20).times do
      Task.create!(name: Faker::ProgrammingLanguage.unique.name,
        project: project, priority: rand(-1..3), due_date: Faker::Date.forward(days: rand(1..60)))
    end
  end
  # end

  # ActsAsTenant.with_tenant(SecondOrgUser) do
  projects_SecondOrgUser = rand(1..10).times.map do
    Project.create!(name: Faker::Educator.unique.subject, user: SecondOrgUser)
  end

  current_user = projects_SecondOrgUser
  projects_SecondOrgUser.each do |project|
    rand(1..20).times do
      Task.create!(name: Faker::ProgrammingLanguage.unique.name,
        project: project, priority: rand(-1..3), due_date: Faker::Date.forward(days: rand(1..60)))
    end
  end
# end
