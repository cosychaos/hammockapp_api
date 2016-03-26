# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  response = { "courses": [
          {
            "key": "cs101",
            "title": "IntrotoComputerScience",
            "homepage": "https://www.udacity.com/course/cs101",
            "subtitle": "BuildaSearchEngine&aSocialNetwork",
            "level": "beginner",
            "starter": true,
            "image": "https://lh5.ggpht.com/ITepKi-2pz4Q6lrLfv6QDNViEG…",
            "banner_image": "https://lh4.ggpht.com/9L_ZBdT4T19FvJGW…",
            "teaser_video": {
            "youtube_url": "https://www.youtube.com/watch?v=Pm_WAWZNbdA"
            },
            "summary": "Inthisintroductorycourse,you'lllearn…",
            "short_summary": "Learnkeycomputerscienceconceptsin…",
            "required_knowledge": "Thereisnopriorprogramming…",
            "expected_learning": "You'lllearntheprogramminglanguage…",
            "featured": true,
            "syllabus": "###Lesson1:HowtoGetStarted…",
            "faq": "###Whendoesthecoursebegin?Thisclassisself…",
            "full_course_available": true,
            "expected_duration": 3,
            "expected_duration_unit": "months",
            "new_release": false,
            "tracks":["DataScience","WebDevelopment","SoftwareEng"],
            "affiliates": [],
            "image": "https://lh6.ggpht.com/1x-8cXA7J…"
          }]}.to_json

  coursera = {"elements": [
    {"id": "v1-228",
      "description": "For anyone who would like to apply their technical skills to creative work ranging from video games to art installations to interactive music, and also for artists who would like to use programming in their artistic practice.",
      "slug": "digitalmedia",
      "courseType": "v1.session",
      "photoUrl": "https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/24/63a093e763b307dc9420e796aeb06a/GoldComputing3.jpg",
      "name": "Creative Programming for Digital Media & Mobile Apps"}]}.to_json

  config.before(:each) do
    stub_request(:get, "https://www.udacity.com/public-api/v0/courses").
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => response, :headers => {})

    stub_request(:get, /.*api.coursera.*/ ).
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => coursera, :headers => {})
  end
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explictly tag your specs with their type, e.g.:
  #
  #     describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/v/3-0/docs
  config.infer_spec_type_from_file_location!
end
