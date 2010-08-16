require"property_restriction"

class EntityConstraint
	attr_reader :entityType
	attr_writer :entityType

	def initialize (property_list)
		raise 'Doh! You are trying to instantiate an abstract class!'
	end
	
	def satisfies?(entity)
	end
	
end

class SetEntityConstraint < EntityConstraint
	attr_reader :entityType, :propertyRestrictions
	attr_writer :entityType, :propertyRestrictions
	
	def initialize (en_type, pro_res)
		@entityType = en_type
		@propertyRestrictions = pro_res
	end
	
	def satisfies?(entity)
		propertyRestrictions.inject(true){|result, element| result && element.satisfies?(entity)}
	end
	
	def to_s()
		puts "Entitiy Type" << @entityType << "\n"
		puts "Properties restrictions \n" 
		propertyRestrictions.each{|x| x.to_s}
		puts "\n"
	end
	 
	
end

#TEST CODE
 #Create Property Restrictions	
 #dr1 = Date.new("12:12:2010")
 #dr2 = Date.new("15:12:2010")
 #args  = [dr1]
 #args1 = [dr1, dr2]
 #pr1 = PropertyRestriction.new("Date", "==", args )
 #pr2 = PropertyRestriction.new("Date", "between?", args1)
 #ipr1 = IPAddress.new("128.0.0.1")
 #pr3 = PropertyRestriction.new("IPAddress", "==", [ipr1])
 
 #Create SetEntityConstraint
 #ec = SetEntityConstraint.new("Environment", [pr1, pr2, pr3])
 
 #Create Environment
 #d1 = Date.new("12:12:2010")
 #ip1 = IPAddress.new("128.0.0.1")
 #plist = [d1, ip1]
 #e1 = Environment.new(plist)
 
 #CODE TEST
 #puts ec.satisfies?(e1)
 #puts d1.between?(dr1, dr2)