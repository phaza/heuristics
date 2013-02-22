#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'lib/heuristics'
  t.test_files = FileList['test/lib/heuristics/*_test.rb']
  t.verbose = false
end
task :default => :test