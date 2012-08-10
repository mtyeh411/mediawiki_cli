require 'nokogiri'
require 'thor'

class Xml < Thor
	namespace "mw:xml"

	desc "merge", "Merge MediaWiki XML dumps"
	def merge(*xml)

		mwns = "http://www.mediawiki.org/xml/export-0.5/"

		first = xml.shift
		f = File.open(first) if File.exists? first
		master = Nokogiri::XML f

		others = xml.each { |x|
			x = File.open(x) if File.exists? x
			doc = Nokogiri::XML x
			doc.xpath("//mediawiki:page", "mediawiki"=>mwns).each {|n|
				master.root.add_child n	
			}
		}
	
		puts master.root.to_xml
	end
end
