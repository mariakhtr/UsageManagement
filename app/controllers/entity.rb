

require "prop"

class Entity
	attr_reader :properties
	
	def initialize (property_list)
		raise 'Doh! You are trying to instantiate an abstract class!'
	end
	
	def properties= (new_entitiy)
		@properties = new_entity
	end
	
	def to_s() 
		puts "The properties of the " << self.class.name << " are \n"
		@properties.each{|x| puts x.class}
	end
	
	def addProperty(property)
		@properties << property
	end
	
	def removePropertyByObject(property)
		@properties.delete(property)
	end
	
	def removePropertyByName(property_name)
		property = @properties.find{|x| x.class.name == property_name}
		@properties.delete(property)
	end
	
	def listProperties()
		puts "The properties of the " << self.class.name << " are \n"
		@properties.each{|x| puts x.class }
	end
	
	def getProperties()
		@properties
	end
	
	def showEntityState()
		puts "The state of the properties of the " << self.class.name << " is \n"
		@properties.each{|x| puts x.class.name << " ---- " << x.get}
	end	
end


class Environment < Entity
	def initialize(property_list)
		@properties = property_list
	end
end


class Subject < Entity
	def initialize(property_list)
		@properties = property_list
	end
end

class Resource < Entity
	def initialize(property_list)
		@properties = property_list
	end
end	



# TEST CODE FOR THE ABOVE CLASSES

# d1 = Date.new("11:12:2010")
# ip1 = IPAddress.new("123.23.23.23")
# plist = [d1, ip1]
# e1 = Environment.new(plist)
# e1.listProperties()
# e1.removePropertyByName("Date")
# e1.listProperties()	
# e1.to_s()
# e1.showEntityState()
