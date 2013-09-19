require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "start scrummin with example team"
task :scrum do
  exec("scrummin", "--no-campfire", "Bob", "Jim", "Joan", "Sally", "Sue")
end