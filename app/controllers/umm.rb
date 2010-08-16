require"context"
require"action"

class UsageManagementMechanism
	attr_reader :actions, :context
	attr_writer :actions, :context
	
	def initialize(actionList, ctx)
		@actions = actionList
		@context = ctx
	end
	
	def addActionByObject(new_action)
		actions << new_action
	end
	
	def addActionByName(action_name)
		new_action = Action.new(action_name)
		actions << new_action
	end
	
	def removeActionByObject(act)
		actions.delete(act)
	end
	
	def removeActionByName(action_name)
		act = actions.find{|x| x.action == action_name}
		actions.delete(act)
	end
	
	def listActions()
		puts "The current actions defined for the Usage Managmement Mechanism are: \n"
		actions.each{|x| puts x.action}
	end
	
	def isActionAllowed(action, subject, resource)
		true
	end
	
	def isLicenseInteroperable(license)
		true
	end
end


# TEST CODE FOR THE ABOVE CLASSES

# d1 = Date.new("11:12:2010")
# ip1 = IPAddress.new("123.23.23.23")
# plist = [d1, ip1]
# e1 = Environment.new(plist)
# e2 = Subject.new(plist)
# elist = [e1, e2]
# c1 = Context.new(elist)
# a1 = Action.new("write")
# a2 = Action.new("read")
# alist = [a1, a2]
# um1 = UsageManagementMechanism.new(alist, c1)
# um1.context.showContextState
# um1.listActions
# um1.addActionByName("transfer")
# um1.listActions
# um1.removeActionByName("read")
# um1.listActions
