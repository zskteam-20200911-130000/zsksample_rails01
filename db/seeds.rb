# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do |n|
  name  = "test#{n}"
  email = "test#{n}"
  u = User.create!(name: name, email: email)
  content = "test#{n} content"
  micropost = u.microposts.create!(content: content)
  if (n % 3).zero?
    params = { io: File.open(Rails.root.join('app/assets/images/image.png').to_s),
               filename: 'image.png',
               content_type: 'image/png' }
  elsif (n % 7).zero?
    params = { io: File.open(Rails.root.join('app/assets/images/slack.png').to_s),
               filename: 'slack.png',
               content_type: 'image/png' }
  end
  micropost.images.attach(params)
end
