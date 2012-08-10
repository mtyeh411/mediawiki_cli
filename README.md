# mediawiki_cli

mediawiki_cli is a command line interface tool for MediaWiki. 

All mediawiki_cli commands require configuration options to be passed at run-time.  

		mw <action> <subcommand> <options> -W <wiki> 

Options:
* -W, --wiki 					=> (required) The URL to the MediaWiki API (eg, http://my.wiki/w/api.php) or the unique name of the wiki in the configuration file.
* -U, --username 			=> (optional)  
* -P, --password 			=> (optional)
* -F, --file 					=> (optional) A hashable configuration file (eg, YAML) whose top-level keys are unique names of the wiki.  Each top-level key will contain a sub-hash that contain the keys "wiki", "username", and "password"

Actions:
* list
* export
* import
* xml

## Listing 
To retrieve a list of MediaWiki resources:

		mw list [resource_subcommand] [options] -W [wiki]

Subcommands:
* categories
* properties
* templates
* all 								=> (default) List all categories, properties, and templates.
* namespaces
* members
   * -c, --categories 	=> A list of category names (eg, `mw list members -n "Category:Foo" "Category:Bar"`)
   * -n, --namespaces 	=> A list of namespace names (eg, `mw list members -n "Property:"`)
   * -f, --file  				=> A hashable file (eg, YAML) that contains keys for "categories" and "namespaces"

## Exporting 
MediaWiki export files will conform to the MediaWiki XML Schema.  The 'export' subcommand accepts input from standard input, such as from piped command output.

To export MediaWiki resources:

		mw export [subcommand] [options] -W [wiki]

Subcommands:
* export 							=> (default) 
   * -p, --pages 				=> A list of page names to export (eg, `mw export -p "Main Page" "My Other Page"`)
* batch
   * -c, --categories 	=> A list of category names whose members will be exported (eg, `mw export batch -c "Category:Foo" "Category:Bar" -W [wiki]`)
   * -n, --namespaces 	=> A list of namespace names that will be exported (eg, `mw export batch -n "Property:" "Concept:" -W [wiki]`)
   * -p, --pages 				=> A list of page names that will be exported (eg, `mw export batch -p "Main Page" "My Other Page" -W [wiki]`)
   * -f, --file 				=> A hashable file (eg, YAML) that contains keys for "categories", "namespaces", and "pages"

## Importing
Import a MediaWiki XML export file to the specified wiki.

		mw import [*files] -W [wiki]

## Xml
It may be necessary to perform XML manipulation for the MediaWiki XML files.  

		mw xml [subcommand] [options] -W [wiki]

Subcommands:
* merge[*args]				=> Merge pages elements of MediaWiki XML dumps (eg, `mw xml merge "export1.xml" "export2.xml" -W [wiki]`)

## Contributing to mediawiki_cli
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Matt Yeh. See LICENSE.txt for
further details.

