require"context_constraint"
require"context"
require"act"

class RestrictedActivity
	attr_reader :activity, :contextConstraint
	attr_writer :activity, :contextConstraint
	
	def initialize(acv, ctx_constr)
		@activity = acv
		@contextConstraint = ctx_constr
	end
	
	def conforms?(acv, ctx)
		@activity == acv && @contextConstraint.satisfies?(ctx)
	end
	
	def to_s()
		puts "Restricted Activity is defined as follows: \n"
		@activity.to_s()
		contextConstraint.to_s()
	end
	
end


#Create Environment Constraint
=begin
 #Create Property Restrictions	
 dr1 = Mydate.new("12:12:2010")
 dr2 = Mydate.new("15:12:2010")
 args  = [dr1]
 args1 = [dr1, dr2]
 pr1 = PropertyRestriction.new("Date", "==", args )
 pr2 = PropertyRestriction.new("Date", "between?", args1)
 ipr1 = IPAddress.new("128.0.0.1")
 pr3 = PropertyRestriction.new("IPAddress", "==", [ipr1])
 
 ec = SetEntityConstraint.new("Environment", [pr1, pr2, pr3])
 
 #Create Subject Constraints
 sidr1 = SubjectID.new("PramodJamkhedkar")
 pr4 = PropertyRestriction.new("SubjectID", "==", [sidr1])
 sc = SetEntityConstraint.new("Subject", [pr4])
 
 #Create Resource Constraints
 ridr1 = ResourceID.new("Taxi_Driver")
 pr5 = PropertyRestriction.new("ResourceID", "==", [ridr1])
 rc = SetEntityConstraint.new("Resource", [pr5])
 
 #Create Context Constraints
 crc = ContextConstraint.new([rc, ec, sc])
 
 #Create Activity
 av = Act.new("play")
 
 #Create Restricted activity
 racv = RestrictedActivity.new(av, crc)
 
 
 # Create Context	
 d1 = Mydate.new("12:12:2010")
 ip1 = IPAddress.new("128.0.0.1")
 plist = [d1, ip1]
 e1 = Environment.new(plist)
 sid1 = SubjectID.new("PramodJamkhedkar")
 e2 = Subject.new([sid1])
 rid1 = ResourceID.new("Taxi_Driver")
 e3 = Resource.new([rid1])
 elist = [e1, e2, e3]
 c1 = Context.new(elist)
 #c1.listEntities
 #c1.showContextState
 
 #Create Activity
 av1 = Act.new("play")
 
 #CODE TEST
# puts racv.conforms?(av1, c1)
=end
