statuses = ['New' 'In prgress' 'Done']

statuses.each do |status|
  Status.create(name: status)
end

users = %w[Alice Bob Rabbit]

users.each do |user|
  User.create(name: user)
end
