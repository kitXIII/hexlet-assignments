10.times do
  Task.create(
    creator: Faker::Internet.username,
    performer: [Faker::Internet.username, nil].sample,
    description: [Faker::Quote.matz, nil].sample,
    name: Faker::Lorem.sentence(word_count: 3),
  )
end
