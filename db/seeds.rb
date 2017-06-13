User.create! name: "Example User",
  email: "example@railstutorial.org",
  password: "manhcuong",
  password_confirmation: "manhcuong",
  is_admin: true,
  activated: true,
  activated_at: Time.zone.now

29.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "manhcuong"
  User.create! name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
end
