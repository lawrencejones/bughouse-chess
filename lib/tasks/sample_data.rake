namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Arnas Kaminskas",
                         email: "arnaskam@gmail.com",
                         password: "kaminskas9",
                         password_confirmation: "kaminskas9",
                         admin: true)
    admin = User.create!(name: "Yury Belevskiy",
                         email: "yb1012@ic.ac.uk",
                         password: "150295Fe",
                         password_confirmation: "150295Fe",
                         admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end