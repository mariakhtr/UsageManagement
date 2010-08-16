class Prop
	def set()
	end
	
	def get()
	end
end

class ComparableProperty < Prop
	include Comparable
end

class Mydate < ComparableProperty
	
	attr_reader :date
	
	def initialize(new_date)
		@date = new_date
	end

	def date= (new_date)
		@date = new_date
	end
	
	def to_s
		puts "Date: #@date"
	end
	
	def get()
		@date
	end
	
	def set(new_date)
		@date = new_date
	end
	
	def <=>(other_date)
		curr = @date.split(/[:]+/)
		other = other_date.date.split(/[:]+/)
		if curr[2] < other[2] then
			return -1
		elsif curr[2] > other[2]
			return 1
			
		else
			if curr[1] < other[1] then
				return -1
			elsif curr[1] > other[1] 
				return 1
			else
				if curr[0] < other[0] then
					return -1
				elsif curr[0] > other[0] 
					return 1
				else
					return 0
				end
			end
		end
	end
end

class IPAddress < ComparableProperty
	
	attr_reader :ipAddress
	
	
	def initialize(new_ip)
		@ipAddress = new_ip
	end

	def ipAddress= (new_ip)
		@ipAddress = new_date
	end
	
	def to_s
		puts "IP Address: #@ipAddress"
	end
	
	def get()
		@ipAddress
	end
	
	def set(new_ip)
		@ipAddress = new_ip
	end
	
	def <=>(new_ip)
		@ipAddress <=> new_ip.ipAddress
	end
end


class SubjectID < ComparableProperty
	
	attr_reader :subjectID
	
	
	def initialize(new_id)
		@subjectID = new_id
	end

	def subjectID= (new_id)
		@subjectID = new_id
	end
	
	def to_s
		puts "SUBJECT ID: #@subjectID"
	end
	
	def get()
		@subjectID
	end
	
	def set(new_id)
		@subjectID= new_id
	end
	
	def <=>(new_id)
		@subjectID <=> new_id.subjectID
	end
end

class ResourceID < ComparableProperty
	
	attr_reader :resourceID
	attr_writer :resourceID
	
	
	def initialize(new_id)
		@resourceID = new_id
	end

	def resourceID= (new_id)
		@resourceID = new_id
	end
	
	def to_s
		puts "RESOURCE ID: #@resourceID"
	end
	
	def get()
		@resourceID
	end
	
	def set(new_id)
		@resourceID= new_id
	end
	
	def <=>(new_id)
		@resourceID <=> new_id.resourceID
	end
end




# d1 = IPAddress.new("12:12:2010")
# d2 = IPAddress.new("10:12:2010")
# puts d1 < d2
