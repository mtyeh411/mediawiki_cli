#!/usr/bin/env ruby

require 'media_wiki'
require 'mediawiki_cli/list'
require 'mediawiki_cli/export'
#require 'mediawiki_cli/import'
require 'mediawiki_cli/xml'
require 'thor'

module Mw
	class Cli < Thor
	include FileHandler
		namespace :mw

		class_option :wiki, :type=>:string, :aliases=>"-W", :required=>true
		class_option :username, :type=>:string, :aliases=>"-U"
		class_option :password, :type=>:string, :aliases=>"-P"
		class_option :file, :type=>:string, :aliases=>"-F"

		desc "connect", "connect"
		def connect 
			config = symbolize_keys(to_hash(options.file)).fetch(options.wiki.to_sym) if options.file

			config ||= options
			$mw ||= MediaWiki::Gateway.new(config[:wiki])
			if config[:username] and config[:password]
				$mw.login(config[:username], config[:password]) 
			end
		end

		desc "import", "Import pages from file."
		def import(*file)
			connect
			file.each { |f|
				$mw.import(f)
			}
		end

		desc "list", "list"
		subcommand "list", List 

		desc "export", "export"
		subcommand "export", Export

#		desc "import", "import"
#		subcommand "import", Import

		desc "xml", "xml"
		subcommand "xml", Xml
	end
end

