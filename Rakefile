require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

task 'db:create_migration' do
  unless ENV["NAME"]
    puts "No NAME specified. Example usage: `rake db:create_migration NAME=create_users`"
    exit
  end

  name    = ENV["NAME"]
  version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S")

  ActiveRecord::Migrator.migrations_paths.each do |directory|
    next unless File.exist?(directory)
    migration_files = Pathname(directory).children
    if duplicate = migration_files.find { |path| path.basename.to_s.include?(name) }
      puts "Another migration is already named \"#{name}\": #{duplicate}."
      exit
    end
  end

  filename = "#{version}_#{name}.rb"
  dirname  = ActiveRecord::Migrator.migrations_path
  path     = File.join(dirname, filename)

  FileUtils.mkdir_p(dirname)
  File.write path, <<-MIGRATION.strip_heredoc
    class #{name.camelize} < ActiveRecord::Migration
      def change
      end
    end
  MIGRATION

  puts path
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

# Populate database

desc 'populate the test database with data'
task 'db:populate' do

  # Users
  User.create(
    user_name: "angela.f",
    password: "angela",
    name: "Angela Fowles",
    email: "angela.f@google.com",
    company: "Google",
    avatar: "http://icons.iconarchive.com/icons/hopstarter/face-avatars/128/Female-Face-FC-4-icon.png"
    )
  User.create(
    user_name: "robert.d",
    password: "robert",
    name: "Robert Dante",
    email: "robert.d@facebook.com",
    company: "Facebook",
    avatar: "http://icons.iconarchive.com/icons/hopstarter/face-avatars/128/Male-Face-A2-icon.png"
    )
  User.create(
    user_name: "jane.w",
    password: "jane",
    name: "Jane Willow",
    email: "jane.w@twitter.com",
    company: "Twitter",
    avatar: "http://icons.iconarchive.com/icons/hopstarter/face-avatars/128/Female-Face-FE-1-blonde-icon.png"
    )

  # Tags
  Tag.create(name: "Social Media")
  Tag.create(name: "Content Marketing")
  Tag.create(name: "Search Engine Marketing")
  Tag.create(name: "Web Analytics")
  Tag.create(name: "Conversion Optimization")
  Tag.create(name: "Tag Management")

  # Questions & Answers
  Question.create( # Question 1, User 1
    user_id: 1,
    content: "After how long a period of inactivity does a visitor drop out of the active visitors count in Google Analytics' Real-Time reports?",
    image: "http://i.stack.imgur.com/xI3JD.png"
    )
  Answer.create(question_id: 1, content: "30 seconds", correct: false)
  Answer.create(question_id: 1, content: "1 minute", correct: false)
  Answer.create(question_id: 1, content: "5 minutes", correct: true)
  Answer.create(question_id: 1, content: "30 minutes", correct: false)

  QuestionTag.create(
    question_id: 1,
    tag_id: 4
    )

  QuestionTag.create(
    question_id: 1,
    tag_id: 5
    )

  Question.create( # Question 2, User 1
    user_id: 1,
    content: "When writing blog posts, what or who should you first prioritize focusing on addressing with your content?",
    image: "http://www.mdgadvertising.com/blog/wp-content/uploads/2012/10/MDG_Blog_Integrating_Email_Social_CRM.jpg"
    )
  Answer.create(question_id: 2, content: "Search Engine Optimization (SEO)", correct: false)
  Answer.create(question_id: 2, content: "Topics that you can write about", correct: false)
  Answer.create(question_id: 2, content: "Your buyer persona", correct: true)

  QuestionTag.create(
    question_id: 2,
    tag_id: 1
    )

  QuestionTag.create(
    question_id: 2,
    tag_id: 2
    )

  QuestionTag.create(
    question_id: 2,
    tag_id: 3
    )

  Question.create( # Question 3, User 2
    user_id: 2,
    content: "If you wanted to dynamically capture the values of conversions associated with your AdWords tag, what would you put in the Conversion Value field in GTM?",
    image: ""
    )
  Answer.create(question_id: 3, content: "A built-in Referrer variable that records conversion URLs", correct: false)
  Answer.create(question_id: 3, content: "A user-defined variable that records conversion amount", correct: true)
  Answer.create(question_id: 3, content: "The median amount users spend according to Analytics", correct: false)
  Answer.create(question_id: 3, content: "The projected amount users will spend according to Analytics", correct: false)

  QuestionTag.create(
    question_id: 3,
    tag_id: 3
    )

  QuestionTag.create(
    question_id: 3,
    tag_id: 6
    )

  Question.create( # Question 4, User 2
    user_id: 2,
    content: "What does CTA mean?"
    )
  Answer.create(question_id: 4, content: "Conversion Tracking Activity", correct: false)
  Answer.create(question_id: 4, content: "Call to Action", correct: true)
  Answer.create(question_id: 4, content: "Cost to Act", correct: false)
  Answer.create(question_id: 4, content: "Conversion Testing Action", correct: false)
  Answer.create(question_id: 4, content: "Controlled Time of Activity", correct: false)

  QuestionTag.create(
    question_id: 4,
    tag_id: 2
    )

  QuestionTag.create(
    question_id: 4,
    tag_id: 5
    )

  Question.create( # Question 5, User 3
    user_id: 3,
    content: "What are some 'best practices' for social media teams in corporations?",
    image: "http://everypost.me/blog/wp-content/uploads/2013/10/Social-networks_a.png"
    )
  Answer.create(question_id: 5, content: "Social media should be managed by marketing but outsourced to an agency who does the work", correct: false)
  Answer.create(question_id: 5, content: "Social media is a marketing responsibility, the rest of the team should focus on their jobs", correct: false)
  Answer.create(question_id: 5, content: "Best results are created with a social media service organization, servicing all customer facing groups within an organization", correct: true)
  Answer.create(question_id: 5, content: "Everybody need to be socially engaged there is no need for social media management", correct: false)
  Answer.create(question_id: 5, content: "Don't know/Not sure", correct: false)

  QuestionTag.create(
    question_id: 5,
    tag_id: 1
    )

  Question.create( # Question 6, User 3
    user_id: 3,
    content: "For Dynamic Remarketing, what will you need to set up in Analytics to collect information from the Data Layer and send it to AdWords?"
    )
  Answer.create(question_id: 6, content: "Custom Metrics", correct: false)
  Answer.create(question_id: 6, content: "Custom Dimensions", correct: true)
  Answer.create(question_id: 6, content: "Enhanced Ecommerce", correct: false)
  Answer.create(question_id: 6, content: "Event Tracking", correct: false)

  QuestionTag.create(
    question_id: 6,
    tag_id: 3
    )

  QuestionTag.create(
    question_id: 6,
    tag_id: 4
    )

  QuestionTag.create(
    question_id: 6,
    tag_id: 6
    )

  # Ratings
  Rating.create(question_id: 1, user_id: 1, value: 5)
  Rating.create(question_id: 6, user_id: 1, value: 3)
  Rating.create(question_id: 2, user_id: 2, value: 1)
  Rating.create(question_id: 5, user_id: 2, value: 4)
  Rating.create(question_id: 3, user_id: 3, value: 5)
  Rating.create(question_id: 4, user_id: 3, value: 5)
  Rating.create(question_id: 1, user_id: 3, value: 5)
  Rating.create(question_id: 6, user_id: 3, value: 3)
  Rating.create(question_id: 2, user_id: 1, value: 1)
  Rating.create(question_id: 5, user_id: 1, value: 4)
  Rating.create(question_id: 3, user_id: 2, value: 5)
  Rating.create(question_id: 4, user_id: 2, value: 5)

  # Tests
  Test.create(user_id: 1, name: "Digital Marketing Analyst - Google Chrome", logo: "http://icons.iconarchive.com/icons/google/chrome/128/Google-Chrome-icon.png")
  Test.create(user_id: 1, name: "Conversion Optimization - Alphabet", logo: "http://www.seeklogo.net/wp-content/uploads/2015/08/alphabet-inc-logo-200x200.png")

  # Tests Questions Selections
  QuestionSelection.create(test_id: 1, question_id: 1)
  QuestionSelection.create(test_id: 1, question_id: 2)
  QuestionSelection.create(test_id: 1, question_id: 3)

  # Test Answers
  TestResult.create(test_id: 1, candidate_name: "Jane Doe", candidate_email: "jane.doe@yahoo.ca", candidate_score: 0.8)
  TestResult.create(test_id: 1, candidate_name: "Aaron Carlson", candidate_email: "aaron.c@gmail.com", candidate_score: 0.9)
  TestResult.create(test_id: 1, candidate_name: "Maria Finn", candidate_email: "maria.finn@hotmail.com", candidate_score: 1.0)
