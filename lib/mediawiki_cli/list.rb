require 'mediawiki_cli/mwgateway'
require 'mediawiki_cli/filehandler'
require 'thor'

class List < Thor
include MwGateway, FileHandler
	namespace "mw:list"
	default_task :all

	desc "all", "List categories, properties, templates, and namespaces"
	def all
		create_gateway
		invoke :categories
		invoke :properties
		invoke :templates
	end

	desc "members", "List members in given categories."
	method_option :categories, :type=>:array, :aliases=>"-c"
	method_option :namespaces, :type=>:array, :aliases=>"-n"
	method_option :file, :type=>:string, :aliases=>"-f"
	def members 
		create_gateway	
		members = []
		options[:categories].each { |c| 
			members += $mw.category_members(c) 
			members << c
		} if options[:categories]
		options[:namespaces].each { |n|
			members += list_by_namespace(n)
		} if options[:namespaces]
		return output members 
	end

	desc "namespaces", "List all namespaces"
	def namespaces
		create_gateway
		return output $mw.namespaces_by_prefix.keys
	end		

## TODO metaprogramming on these methods
	desc "categories", "List all categories"
	def categories
		list_by_namespace("Category:")
	end

	desc "properties", "List all properties"
	def properties
		list_by_namespace("Property:")
	end

	desc "templates", "List all templates"
	def templates
		list_by_namespace("Template:")
	end
##

	no_tasks {
		def list_by_namespace( namespace )
			create_gateway
			return output $mw.list( namespace )
		end
	}
end
