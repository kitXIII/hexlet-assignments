5.times do |idx|
  Post.create(
    title: "Title #{idx}",
    body: "Body #{idx}",
    summary: "Short #{idx}",
    published: [true, false].sample
  )
end
