require 'mediawiki_cli/mwgateway'
require 'thor'

class Import < Thor
include MwGateway
	namespace "mw:import"
	default_task :import

	desc "import", "Import pages from file."
	def import(*file)
		create_gateway
		file.each { |f|
			$mw.import(f)
		}
	end
end

