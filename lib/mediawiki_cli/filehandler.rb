
module FileHandler
	private
	# TODO when does thor create symbol keys vs string keys?
	def to_hash(file)
		case File.extname file
			when '.yaml', '.yml'
				require 'yaml'
				return YAML::load_file(file)
		end
	end

  def symbolize_keys(hash)
		return hash if not hash.is_a?(Hash)
		result = hash.inject({}){|h,(k,v)| h[k.to_sym] = symbolize_keys(v); h}
		return result 
	end
end
