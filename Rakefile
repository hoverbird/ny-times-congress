require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "ny-times-congress"
    s.executables = "congresh" 
    s.summary = "Ruby wrapper and command shell for the New York Times Congress API"
    s.authors = ["Patrick Ewing"]
    s.files =  FileList["[A-Z]*", "{bin,lib,spec}/**/*"] 
    s.add_dependency("json", [">= 1.1.3"])
    s.email = "patrick.henry.ewing@gmail.com"
    s.homepage = "http://github.com/hoverbird/ny-times-congress"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'ny-times-congress'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'spec/rake/spectask'
  desc "Run all examples"
  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
  end
rescue LoadError
  puts "RSpec is not available.  You'll need it to test ny-times-congress."
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.libs << 'test'
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end
rescue LoadError
  puts "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  puts "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
end

task :default => :spec
