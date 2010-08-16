class Action
	
	include Comparable
	
	def initialize(new_action)
		@action = new_action
	end
	
	attr_reader :action
	attr_writer :action

	def action=(new_action)
		@action = new_action
	end
	
	def to_s
		puts "Action: #@action"
	end
	
	def get()
		@action
	end
	
	def <=>(other_action)
		@action <=> other_action.action
	end
end
