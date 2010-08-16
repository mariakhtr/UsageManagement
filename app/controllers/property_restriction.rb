require"entity.rb"
class PropertyRestriction
	attr_reader :propertyType, :function, :arguments
	attr_writer :propertyType, :function, :arguments
	
	def initialize (prop, func, args)
		@propertyType = prop
		@function = func
		@arguments = args
	end
	
	def to_s()
		puts "Property Type: " << @propertyType << "\n" 
		puts "Function Name: " << @function << "\n"
		puts "Arguments"
		arguments.each{|x| x.to_s}
	end

	def satisfies? (entity)
		property = entity.properties.find{|x| x.class.name == propertyType}
		case @arguments.size()
			when 1
				property.send(@function.to_sym, @arguments[0])
			when 2
				property.send(@function.to_sym, @arguments[0], @arguments[1])
			when 3
				property.send(@function.to_sym, @arguments[0], @arguments[1], @arguments[2])
			when 4
				property.send(@function.to_sym, @arguments[0], @arguments[1], @arguments[2], @arguments[3])
			elsel
				puts "Too many arguments"
			end
	end
	
#	def satisfies? (property)
#		case @arguments.size()
#			when 1
#				property.send(@function.to_sym, @arguments[0])
#			when 2
#				property.send(@function.to_sym, @arguments[0], @arguments[1])
#			when 3
#				property.send(@function.to_sym, @arguments[0], @arguments[1], @arguments[2])
#			when 4
#				property.send(@function.to_sym, @arguments[0], @arguments[1], @arguments[2], @arguments[3])
#			elsel
#				puts "Too many arguments"
#			end
#	end

end

#TEST CODE
#dr1 = Date.new("12:12:2010")
#dr2 = Date.new("15:12:2010")
#args  = [dr1]
#pr1 = PropertyRestriction.new("Date", "==", args )
# pr1.to_s
#d1 = Date.new("12:12:2010")
#ip1 = IPAddress.new("123.23.23.23")
#plist = [d1, ip1]
#e1 = Environment.new(plist)
#puts pr1.satisfies?(e1)