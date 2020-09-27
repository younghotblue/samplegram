# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             user_name: "user",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name = Faker::Games::Pokemon.name
  user_name = "example#{n+1}"
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               user_name: user_name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# ユーザーの一部を対象に投稿を生成する
users = User.order(:created_at).take(6)
50.times do
  caption = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.photos.create!(caption: caption) }
end
