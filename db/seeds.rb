puts 'Creating admin users ..'

User.create do |user|
  user.email = 'phatograph@gmail.com'
  user.password = 'romeocat13'
  user.first_name = 'Site'
  user.last_name = 'Admin'
  user.admin = true
end

puts 'Done creating admin users ..'
