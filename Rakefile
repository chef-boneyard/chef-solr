require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "chef-solr"
    gem.summary = %Q{Search indexing for Chef}
    gem.email = "adam@opscode.com"
    gem.homepage = "http://wiki.opscode.com/display/chef"
    gem.authors = ["Adam Jacob"]
    gem.add_dependency "libxml-ruby", ">=1.1.3"
    gem.add_dependency "uuidtools", ">=2.0.0"
    gem.add_dependency "chef", IO.read("VERSION").strip
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.executables = [ 'chef-solr', 'chef-solr-indexer', 'chef-solr-rebuild' ]
    gem.files = [
      "README.rdoc",
      "Rakefile",
      "VERSION"
    ]
    gem.files.include %w{ README.rdoc Rakefile VERSION bin/* lib/**/* solr/* spec/**/* }
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it from gemcutter with: sudo gem install gemcutter jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = %w{-fs --color}
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "chef-solr #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

