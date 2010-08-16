require "entity"

class Context 
	attr_reader :entities
	attr_writer :entities
	
	def initialize(entity_list)
		@entities = entity_list
	end
	
	def addEntity(entity)
		@entities << entity
	end
	
	def removeEntityByObject(entity)
		@entities.delete(entity)
	end
	
	def removeEntityByName(entity_name)
		entity = @entities.find{|x| x.class.name == entity_name}
		@entities.delete(entity)
	end
	
	def getEntities()
		@entities
	end
	
	def listEntities()
		puts "The Context has the following entities \n"
		@entities.each{|x| x.listProperties}
	end
	
	def showContextState()
		puts "The Context has the following state \n"
		@entities.each{|x| x.showEntityState}
	end
	
end

# TEST CODE FOR THE ABOVE CLASSES

# d1 = Date.new("11:12:2010")
# ip1 = IPAddress.new("123.23.23.23")
# plist = [d1, ip1]
# e1 = Environment.new(plist)
# sid1 = SubjectID.new("PramodJamkhedkar")
# e2 = Subject.new([sid1])
# rid1 = ResourceID.new("Taxi_Driver")
# e3 = Resource.new([rid1])
# elist = [e1, e2, e3]
# c1 = Context.new(elist)
# c1.listEntities
# c1.showContextState