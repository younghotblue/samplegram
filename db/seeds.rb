# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             user_name: "user",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

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
               password_confirmation: password)
end
