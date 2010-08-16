# :title: License Object Creator Class
# == Name
# Digital Rights Managemnt (DRM)
# == Synopsis
# LicenseObjectCreator class transforms the generated ReXML license file to an executable license object.
# == Authors
# Pramod Jamkhedkar, Maria Khater 
# == Date
# July 20th, 2010
# == Copyright
#
require 'rexml/document'
include REXML
require "prop.rb"
require "property_restriction.rb"
require "entity_constraint.rb"
require "act.rb"
require "restricted_activity.rb"
require "context.rb"
require "context_constraint.rb"
require "license_expression.rb"

# LicenseObjectCreator class is an abstract class, it can't be instantiated. 

class LicenseObjectCreator

end

# MyLicenseObjectCreator is a derived class from LicenseObjectCreator which is used in creating object license file for the Usage Management Mechanism Model. 
class MyLicenseObjectCreator < LicenseObjectCreator

# Creates a new instance of the class MyLicenseObjectCreator which is specific to the Usage Management Mechanism.	
	def initialize ()	
	end

	# get_license_object takes one argument, a string - the ReXML license file name, and returns the license object file.
	#
	# * It reads the ReXML file then it starts scanning the tags starting from the root till it reaches the leaf nodes. 
	# * After the root tag is read, a 'pointer' starts looping over the children tags till it reaches the leaf nodes of the XML file.
	# * It finds and extracts environment, resource and subject restrictions in order to create a <b>property restriction</b> for each constraint. It is done by creating a new instance of the property restriction class.
	# * Each created property restriction object is saved in an array in order to create a respective <b>entity constraint</b>(enviornment, resource, subject...).
	# * After creating the respective objects for each entity, a <b>context constraint</b> will be created for each activity.
	# * Each activity will has its own <b>restrictive activity constraints</b>, from the latter a license can be obtained given its restrictive activity constraints and its permissions.
	# The evaluation of restrictions starts from:
	# 1. Property Restriction
	# 2. Entity Constraint
	# 3. Context Constraint
	# 4. Activity Constraint
	# This method has three main loops are enough to go over all the tags in he ReXML file. In addition, to create the license, this method calls functions from the required files listed.
	#
	# <em>Note:</em> The ReXML license file should be generated and placed in the project directory.
	def get_license_object(lic_file)

		doc = Document.new(File.new(lic_file))
		root = doc.root
		perm = root.elements[1]
		ra_array = []
		perm.each_element{|ra_ptr|
			acv = ra_ptr.attributes["activity"]
			#puts acv
			ec_array = []
			ra_ptr.each_element{ |ec_ptr|
				#puts ec_ptr
				entity_type = ec_ptr.attributes["type"]
				#puts entity_type
				pr_array = []
				ec_ptr.each_element{|pr_ptr| 
					property = pr_ptr.attributes["property"]
					function = pr_ptr.attributes["function"]
					args = pr_ptr.text
					#puts "The restriction data are:"
					#puts property << function << args
					pr = get_property_restriction(property, function, args)
					pr_array << pr
					#pr.to_s()
				}
				ec = get_entity_constraint(entity_type, pr_array)
				ec_array << ec 
			}	
			concr = ContextConstraint.new(ec_array) 
			racv = get_restricted_activity(acv, concr)
			ra_array << racv		
		}			
		le = get_simple_lic(ra_array, ra_array)
		#puts "The following is the license structure \n"
		#le.permissions.each{|x| x.to_s()}	


	end


	private
	
	# This method takes each property,its function and arguments as string and creates an instance of PropertyRestriction using three passed parameters.
	def get_property_restriction(prop, func, args) #:doc:
		args_array = args.split(/,/)
		obj_array = args_array.collect{|x| Module.const_get(prop).new(x)}
		PropertyRestriction.new(prop, func, obj_array)
	end
	
	# An entity constraint is obtained by specifying the entity type and the property restriction(s) for that entity (eg. environment, subject or resource)
	def get_entity_constraint(entity_type, props_res)#:doc:
		SetEntityConstraint.new(entity_type,props_res)
	end
	
	# Returns the restricted activity object for the specified activity and context.
	def get_restricted_activity (activity_type, context_constraint)#:doc:
		RestrictedActivity.new(activity_type, context_constraint)
	end
	
	# Returns the license object based on the permissions and the restricted activities.
	def get_simple_lic(racv_array, permissions_array)#:doc:
		SimpleLicenseExpression.new(racv_array, permissions_array)
	end
end

# --
# Test Code
# lc = MyLicenseObjectCreator.new()
# obj = lc.get_license_object("lic.xml")
# puts obj

