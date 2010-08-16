require "context.rb"
require "restricted_activity.rb"

class LicenseExpression
	def initialize(acvs, permissions)
		raise 'Duh! You are trying to instantiate an abstract class!'
	end

	def is_allowed?(activity, ctx, history)
		raise 'Duh! Please read the documentation!! \n You have not defined the method is_allowed?'
		
	end
	
end

class SimpleLicenseExpression < LicenseExpression

	attr_reader :restrictedActivities, :permissions
	attr_writer :restrictedActivities, :permissions
	
	def initialize (res_acvs, permissions)	
		@restrictedActivities = res_acvs
		@permissions  = permissions
	end
	
	def is_allowed?(activity, ctx, history)
		usage = false
		access = false
		
		valid_usage_rvs = is_usage_ok?(activity, history)
		usage = true if valid_usage_rvs.length != 0
		
		
		valid_access_rvs = is_access_ok?(activity, ctx, valid_usage_rvs)
		access = true if valid_access_rvs.length != 0
		
		puts "\nThe following restricted activities are satisfied"
		valid_access_rvs.each{|rv| rv.to_s}
		puts "Is activity allowed? "
		puts (usage && access)
		usage && access
		
	end
  
	private
  
	def is_usage_ok?(activity, history)
		@permissions.select{|rv| rv.activity == activity}
	end
  
	def is_access_ok?(activity, ctx, valid_usage_rvs)
			valid_usage_rvs.select{|rv| rv.conforms?(activity, ctx)}
	end
end
	
	
#TEST CODE

#Create Environment Constraint
=begin
 #Create Property Restrictions	
 dr1 = Date.new("12:12:2010")
 dr2 = Date.new("15:12:2010")
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
 av1 = Activity.new("play")
 av2 = Activity.new("view")
 av3 = Activity.new("print")
 
 #Create Restricted activity
 racv1 = RestrictedActivity.new(av1, crc)
 racv2 = RestrictedActivity.new(av2, crc)
 racv3 = RestrictedActivity.new(av3, crc)
 
 
 #Create License Expression
 le = SimpleLicenseExpression.new([racv1, racv2, racv3], [racv1, racv2, racv3])
 
 # Create Context	
 d1 = Date.new("12:12:2010")
 ip1 = IPAddress.new("128.0.0.1")
 plist = [d1, ip1]
 e1 = Environment.new(plist)
 sid1 = SubjectID.new("PramodJamkhedkar")
 e2 = Subject.new([sid1])
 rid1 = ResourceID.new("Taxi_Driver")
 e3 = Resource.new([rid1])
 elist = [e1, e2, e3]
 c1 = Context.new(elist)
 c1.listEntities
 c1.showContextState
 
 #Create Activity
 av1 = Activity.new("view")
 
 #CODE TEST
 racv1.conforms?(av1, c1)
 
 le.is_allowed?(av1, c1, 0)
=end














=begin
av1 = Act.new("play")
    av1.to_s()
    #d1 = Mydat.new(params[:minedate])
    d1 = Mydate.new("12:12:2010")
    d1.to_s()
    #ip1 = IPA.new(params[:inipaddress])
    ip1 = IPAddress.new("128.0.0.1")
    ip1.to_s()
    plist = [d1, ip1]
    e1 = Environment.new(plist)
    e1.to_s()
    
    #sid1 = SubjectID.new(params[:insubject])
    sid1 = SubjectID.new("PramodJamkhedkar")
    e2 = Subject.new([sid1])
    e2.to_s()
    #rid1 = ResourceID.new(params[:inresource])
    rid1 = ResourceID.new("Taxi_Driver")
    e3 = Resource.new([rid1])
    
    elist = [e1, e2, e3]
    c1 = Context.new(elist) 
    c1.listEntities
    c1.showContextState
    
    ##########################################
    #lic1
    ##########################################
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
   le = SimpleLicenseExpression.new([racv], [racv])
	
   racv.conforms?(av1, c1)
 
   le.is_allowed?(av1, c1, 0)

=end
