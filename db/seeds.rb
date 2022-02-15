# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

I18n.reload!

99.times do |n|
  name = Faker::Name.name
  username = "#{name}_#{n}".delete(' ')
  password = 'password'
  User.create!(
    name: name,
    username: username,
    password: password,
    password_confirmation: password
  )
end

User.create!(
  name: 'App Admin',
  username: 'admin',
  password: 'foobar',
  password_confirmation: 'foobar',
  admin: true
)

User.all.each do |user|
  user.albums.create!(
    name: Faker::Music.album,
    artist: ['Justin Bieber',
      'Katy Perry',
      'Rihana',
      'Taylor Swift',
      'Lady Gaga',
      'Ariana Grande',
      'Justin Timberlake',
      'Selena Gomez',
      'Britney Spears',
      'Demi Lovato',
      'Shakira',
      'Jennifer Lopez',
      'Miley Cyrus',
      'Bruno Mars',
      'Niall Horan',
      'Drake',
      'Wiz Khalifa',
      'Harry Styles',
      'Lil Wayne'].sample,
    year: (1980..2021).to_a.sample.to_s
  )
end


