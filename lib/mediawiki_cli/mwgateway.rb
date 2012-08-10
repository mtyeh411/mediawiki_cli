
module MwGateway
	private
	def create_gateway 
		opts = parent_options.merge options
		invoke "mw:connect", [], 	:wiki => opts.wiki, 
														:username => opts.username,
														:password => opts.password,
														:file => opts.file
	end
	def output(obj)
		puts obj
		obj
	end
end
