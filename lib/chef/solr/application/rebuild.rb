#
# Author:: AJ Christensen (<aj@opscode.com)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'chef'
require 'chef/log'
require 'chef/config'
require 'chef/application'
require 'chef/solr'
require 'chef/solr/index'

class Chef
  class Solr
    class Application
      class Rebuild < Chef::Application

        option :config_file,
          :short => "-c CONFIG",
          :long  => "--config CONFIG",
          :default => "/etc/chef/solr.rb",
          :description => "The configuration file to use"

        option :log_level,
          :short        => "-l LEVEL",
          :long         => "--log_level LEVEL",
          :description  => "Set the log level (debug, info, warn, error, fatal)",
          :proc         => lambda { |l| l.to_sym }

        option :log_location,
          :short        => "-L LOGLOCATION",
          :long         => "--logfile LOGLOCATION",
          :description  => "Set the log file location, defaults to STDOUT - recommended for daemonizing",
          :proc         => nil

        option :help,
          :short        => "-h",
          :long         => "--help",
          :description  => "Show this message",
          :on           => :tail,
          :boolean      => true,
          :show_options => true,
          :exit         => 0

        option :couchdb_database,
          :short => "-d DB",
          :long => "--couchdb-database DB",
          :description => "The CouchDB Database to re-index"

        option :couchdb_url,
          :short => "-u URL",
          :long => "--couchdb-url URL",
          :description => "The CouchDB URL"

        option :version,
          :short => "-v",
          :long => "--version",
          :description => "Show chef-solr-rebuild version",
          :boolean => true,
          :proc => lambda {|v| puts "chef-solr-rebuild: #{::Chef::Solr::VERSION}"},
          :exit => 0

        def initialize
          super

          @index = Chef::Solr::Index.new
        end

        def setup_application
          Chef::Log.level = Chef::Config[:log_level]
          Chef::Log.warn("This operation is destructive!")
          Chef::Log.warn("I'm going to count to 10, and then delete your Solr index and rebuild it.")
          Chef::Log.warn("CTRL-C will, of course, stop this disaster.")
          0.upto(10) do |num|
            Chef::Log.warn("... #{num}")
            sleep 1
          end
          Chef::Log.warn("... Bombs away!")
        end

        def run_application
          s = Chef::Solr.new(Chef::Config[:solr_url])
          Chef::Log.info("Destroying the index")
          s.rebuild_index
        end
      end
    end
  end
end
