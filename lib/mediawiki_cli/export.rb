require 'mediawiki_cli/mwgateway'
require 'mediawiki_cli/filehandler'
require 'thor'

class Export < Thor
include MwGateway, FileHandler
	namespace "mw:export"
	default_task :export

	desc "batch", "Export categories, pages, namespaces"
	method_option :categories, :type=>:array, :aliases=>"-c"
	method_option :pages, :type => :array, :aliases=>"-p"
	method_option :namespaces, :type=>:array, :aliases=>"-n"
	method_option :file, :type=>:string, :aliases=>"-f"
	def batch
		pages = []

		# TODO combine options
		export ||= to_hash(options.file) if options.file
		export ||= options

		export.each { |key, value|
			case key
				when "categories", "namespaces"
					pages.push invoke "mw:list:members", [],	:categories => export["categories"],
																				:namespaces => export["namespaces"],
																				:wiki => parent_options.wiki,
																				:username => parent_options.username,
																				:password => parent_options.password,
																				:file => parent_options.file
				when "pages"
					pages.push export["pages"]
			end
		}
		return output $mw.export(pages.flatten)
	end

	desc "export", "Export a list of pages"
	method_option :pages, :type=>:array, :aliases=>"-p", :required=>true
	def export
		create_gateway
#		invoke "mw:connect", [], :wiki => parent_options.wiki, 
#																:username => parent_options.username,
#																:password => parent_options.password,
#																:file => parent_options.file
		opts = (STDIN.tty?) ? options.pages : $stdin.read.split("\n")
		return output $mw.export(opts)
	end
end
