require 'csv'
require 'date'

namespace :hexlet do
  desc "Import users from csv file, by the path"
  task :import_users, [:path] => :environment do |t, args|
    if !args[:path]
      print 'There is no file path in arguments'
      return
    end

    CSV.foreach(args[:path], headers: true, converters: [->(v) { Date.strptime(v, "%m/%d/%Y") rescue v }]) do |row|
      User.create(row.to_h)
    end
  end
end
