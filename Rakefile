require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require 'watirspec/rake_tasks'
WatirSpec::RakeTasks.new

task default: %i[spec watirspec:run]
