# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include Faker
User.create!(
    email: 'free@free.com',
    password: 'password'
    )

User.create!(
    email: 'admin@admin.com',
    password: 'password',
    role: 'admin'
    )
    
User.create!(
    email: 'paid@paid.com',
    password: 'password',
    role: 'premium'
    )
    
10.times do 
    User.create(
        email: Faker::Internet.email,
        password: Faker::Internet.password
        )
    end
users = User.all
50.times do 
    Wiki.create!(
        title: Faker::Hipster.word,
        body: Faker::Hipster.paragraph(40, true, 4),
        user: users.sample
        )
end
wikis = Wiki.all
    

    
    
