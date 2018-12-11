class Map

	def initialize
		@map = []
	end

	def set(key, value)
		a = nil
		@map.each_with_index {|(k, v), i|  a = i if k == key  }
		if a == nil
			@map << [key, value]
		else
			@map[i][1] = value
		end
	end

	def get(key)
		@map.each { |(k, v)| return v if k == key   }
		nil
	end

	def delete(key)
		@map.delete_if { |(k, v)| k == key }
	end

	def show
		puts "{"
		@map.each { |(k, v)|  print k.to_s + " => " + v.to_s; puts   }
	end

end