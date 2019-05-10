namespace :db do
  desc 'Seed with Faker'
  task faker: :environment do
    sh "bin/rails runner './db/seeds_with_faker.rb'"
  end
end
