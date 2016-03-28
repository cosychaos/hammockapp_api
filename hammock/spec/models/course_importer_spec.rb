require 'rails_helper'
require 'spec_helper'


describe 'CourseImporter', type: :model do


    coursera_courses = [[
        {"id" => "v1-228",
          "description" => "For anyone who would like to apply their technical skills to creative work ranging from video games to art installations to interactive music, and also for artists who would like to use programming in their artistic practice.",
          "slug" => "digitalmedia",
          "courseType" => "v1.session",
          "photoUrl" => "https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/24/63a093e763b307dc9420e796aeb06a/GoldComputing3.jpg",
          "name" => "Creative Programming for Digital Media & Mobile Apps"}],
        [
          {"id" => "v1-223",
            "description" => "Something else.",
            "slug" => "testmedia",
            "courseType" => "v1.session",
            "photoUrl" => "https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/24/63a093e763b307dc9420e796aeb06a/GoldComputing3.jpg",
            "name" => "test"}
        ]]

    udacity_courses = [{
              "key" => "cs101",
              "title" => "IntrotoComputerScience",
              "homepage" => "https://www.udacity.com/course/cs101",
              "subtitle" => "BuildaSearchEngine&aSocialNetwork",
              "level" => "beginner",
              "starter" => true,
              "image" => "https://lh5.ggpht.com/ITepKi-2pz4Q6lrLfv6QDNViEG…",
              "banner_image" => "https://lh4.ggpht.com/9L_ZBdT4T19FvJGW…",
              "teaser_video" => {
              "youtube_url" => "https://www.youtube.com/watch?v=Pm_WAWZNbdA"
              },
              "summary" => "Inthisintroductorycourse,you'lllearn…",
              "short_summary" => "Learnkeycomputerscienceconceptsin…",
              "required_knowledge" => "Thereisnopriorprogramming…",
              "expected_learning" => "You'lllearntheprogramminglanguage…",
              "featured" => true,
              "syllabus" => "###Lesson1:HowtoGetStarted…",
              "faq" => "###Whendoesthecoursebegin?Thisclassisself…",
              "full_course_available" => true,
              "expected_duration" => 3,
              "expected_duration_unit" => "months",
              "new_release" => false,
              "tracks" => ["DataScience","WebDevelopment","SoftwareEng"],
              "affiliates" => [],
              "image" => "https://lh6.ggpht.com/1x-8cXA7J…"
            }]

    let(:coursera_query) {double(:coursera_query, get_all_courses: coursera_courses)}
    let(:udacity_query) {double(:udacity_query, get_all_courses: udacity_courses)}

    let(:coursera_query_klass){ double(:coursera_query_klass, new: coursera_query)}
    let(:udacity_query_klass) { double(:udacity_query_klass, new: udacity_query)}

    let(:course_importer){ CourseImporter.new(coursera_query_klass, udacity_query_klass)}

    describe '#import_udacity_courses' do

      it 'populates with Udacity API data' do
        course_importer.add_udacity_courses
        expect(Courseitem.where(name: "IntrotoComputerScience")).to exist
      end

      it 'creates the as many course items as were sent in the data' do
        expect{course_importer.add_udacity_courses}.to change {Courseitem.all.count}.by 1
      end

    end

    describe '#import_coursera_courses' do

      it 'populates with Coursera API data' do
        course_importer.add_coursera_courses
        expect(Courseitem.where(name: "Creative Programming for Digital Media & Mobile Apps")).to exist
      end

      it 'creates as many course items as were sent in the data' do
        expect{course_importer.add_coursera_courses}.to change{Courseitem.all.count}.by 2
      end

      it 'creates records with a url derived from the slug' do
        course_importer.add_coursera_courses
        expect(Courseitem.where(url: "https://www.coursera.org/course/digitalmedia")).to exist
      end

    end

end
