class Act
	
	include Comparable
	
	def initialize(new_activity)
		@activity = new_activity
	end
	
	attr_reader :activity
	attr_writer :activity

	def activity=(new)
		@activity = new
	end
	
	def to_s
		puts "Activity: #@activity"
	end
	
	def get()
		@activity
	end
	
	def <=>(other_activity)
		@activity <=> other_activity.activity
	end
end


# a1 = Activity.new("play")
# a2 = Activity.new("view")
# puts a1.activity
# puts a2.activity
# a1.activity = "view"
# puts a1.activity


# puts a1 == a2
# puts a1.activity == "transfer"
