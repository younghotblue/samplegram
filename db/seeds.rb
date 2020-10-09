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
30.times do |n|
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

#投稿を生成する
user = users.first
user = User.order(:created_at).take(6)
caption = Faker::Lorem.sentence(word_count: 5)
@post = user.posts.create!(caption: caption, hashbody: "#雪")
      @post.image.attach(io: File.open('app/assets/images/yEMIStDLa2W9ZWf.png'), filename: "yEMIStDLa2W9ZWf.png")
      
users = User.order(:created_at).take(6)
caption = Faker::Lorem.sentence(word_count: 5)
users.each { |user| @posts = user.posts.create!(caption: caption, hashbody: "#雪")
      @posts.image.attach(io: File.open('app/assets/images/yEMIStDLa2W9ZWf.png'), filename: "yEMIStDLa2W9ZWf.png")}

users = User.order(:created_at).take(6)
caption = Faker::Lorem.sentence(word_count: 5)
users.each { |user| @posts = user.posts.create!(caption: caption)
      @posts.image.attach(io: File.open('app/assets/images/r67h4934.jpeg'), filename: "r67h4934.jpeg")}

users = User.order(:created_at).take(6)
caption = Faker::Lorem.sentence(word_count: 5)
users.each { |user| @posts = user.posts.create!(caption: caption)
      @posts.image.attach(io: File.open('app/assets/images/OeL5025.jpeg'), filename: "OeL5025.jpeg")}

users = User.order(:created_at).take(6)
caption = Faker::Lorem.sentence(word_count: 5)
users.each { |user| @posts = user.posts.create!(caption: caption)
      @posts.image.attach(io: File.open('app/assets/images/ocpIYPhI7I572WF.png'), filename: "ocpIYPhI7I572WF.png")}

users = User.order(:created_at).take(6)
caption = Faker::Lorem.sentence(word_count: 5)
users.each { |user| @posts = user.posts.create!(caption: caption)
      @posts.image.attach(io: File.open('app/assets/images/eEy5oxiZSysNQwZ.png'), filename: "eEy5oxiZSysNQwZ.png")}

users = User.order(:created_at).take(6)
caption = Faker::Lorem.sentence(word_count: 5)
users.each { |user| @posts = user.posts.create!(caption: caption)
      @posts.image.attach(io: File.open('app/assets/images/TuV2MA9.png'), filename: "TuV2MA9.png")}


#リレーションシップを作成する
users = User.all
user  = users.first
following = users[2..5]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }