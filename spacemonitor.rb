#!/usr/bin/ruby
#
# Script to get the Folder Paths of a Server
# and calculate the Disk Space that it uses
#
# Author: Angel Cantu
#
# spacemonitor.rb 
#

require 'logger'
require 'fileutils'
require 'pathname'

logger = Logger.new(STDOUT)
logger.level = Logger::INFO

logger.info("Program Started")
#start_path = Pathname.new ("/u01/app/sd/cm")
#builds_path = Pathname.new "/u01/app/sd/cm/builds"
#releases_path = Pathname.new "/u01/app/sd/cm/releases"
script_path = File.dirname(__FILE__)

unless File.exists? "#{script_path}/directory.txt" 
	logger.info "Generating directory.txt file"
	nas = Pathname.new("/Users/angelcantu/Documents/").children.select {|element| element.directory?}.collect {|e| e.to_s}
	builds = Pathname.new("/Users/angelcantu/Documents/chef-repo").children.select {|element| element.directory?}.collect {|e| e.to_s}
	releases = Pathname.new("/Users/angelcantu/Documents/Rails").children.select {|element| element.directory?}.select {|e| e.to_s}
	File.open("directory.txt", "w") do |file|
		nas.each{ |dir| file.puts "#{dir}"}
		builds.each { |dir| file.puts "#{dir}"}
		releases.each {|dir| file.puts "#{dir}"}
		logger.info "File has been created, please review it and add directories if needed"
	end
end
	

logger.info "Create Disk Usage Information File"
disk_usage_cmd = "du -sh"
Directory_file = IO.readlines("#{script_path}/directory.txt")
File.open("space.txt", "w+") do |file|
	logger.info "Getting Space Information"
	Directory_file.each do |directory|
		command = disk_usage_cmd + " #{directory}"
		file.puts(`#{command}`)
	end
end
	
	

