require"context"
require"entity_constraint"
class ContextConstraint
	attr_reader :entityConstraints
	attr_writer :entityConstraints
	
	def initialize(ent_constraints)
		@entityConstraints = ent_constraints
	end
	
	def satisfies?(ctx)
		@entityConstraints.inject(true){|result, element| result && element.satisfies?(ctx.entities.find{|x| x.class.name == element.entityType})}
	end
	
	def to_s()
		puts "Context Constraints \n"
		entityConstraints.each{|x| x.to_s()}
	end
end

#TEST CODE

 #Create Environment Constraint
 
 #Create Property Restrictions	
 #dr1 = Date.new("12:12:2010")
 #dr2 = Date.new("15:12:2010")
 #args  = [dr1]
 #args1 = [dr1, dr2]
 #pr1 = PropertyRestriction.new("Date", "==", args )
 #pr2 = PropertyRestriction.new("Date", "between?", args1)
 #ipr1 = IPAddress.new("128.0.0.1")
 #pr3 = PropertyRestriction.new("IPAddress", "==", [ipr1])
 
 #ec = SetEntityConstraint.new("Environment", [pr2, pr3])
 
 #Create Subject Constraints
 #sidr1 = SubjectID.new("PramodJamkhedkar")
 #pr4 = PropertyRestriction.new("SubjectID", "==", [sidr1])
 #sc = SetEntityConstraint.new("Subject", [pr4])
 
 #Create Resource Constraints
 #ridr1 = ResourceID.new("Taxi_Driver")
 #pr5 = PropertyRestriction.new("ResourceID", "==", [ridr1])
 #rc = SetEntityConstraint.new("Resource", [pr5])
 
 #Create Context Constraints
 #crc = ContextConstraint.new([rc, ec, sc])
 
 # Create Context	
 #d1 = Date.new("14:12:2010")
 #ip1 = IPAddress.new("128.0.0.1")
 #plist = [d1, ip1]
 #e1 = Environment.new(plist)
 #sid1 = SubjectID.new("PramodJamkhedkar")
 #e2 = Subject.new([sid1])
 #rid1 = ResourceID.new("Taxi_Driver")
 #e3 = Resource.new([rid1])
 #elist = [e1, e2, e3]
 #c1 = Context.new(elist)
 #c1.listEntities
 #c1.showContextState
 
 #CODE TEST
 #puts crc.satisfies?(c1)