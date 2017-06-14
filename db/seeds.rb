User.create! name: "Example User",
  email: "example@railstutorial.org",
  password: "manhcuong",
  password_confirmation: "manhcuong",
  is_admin: true,
  activated: true,
  activated_at: Time.zone.now

15.times do |n|
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
users = User.order(:created_at).take 2
1.times do
  content = Faker::Lorem.sentence 5
  users.each{|user| user.microposts.create! content: content}
end
