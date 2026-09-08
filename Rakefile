require "bundler/gem_tasks"
require "minitest/test_task"
require "standard/rake"

Minitest::TestTask.create do |t|
  t.test_prelude = 'require "swarf/probe"'
end

task default: %i[test standard]
