# :title: Userpage Controller Class
# == Name
# Usage Management Mechanism (UMM)
# == Synopsis
# userpage_controller class has controller and non-controller functions which are used to help users in getting their executable license object.  
# == Authors
# Maria Khater, Hadi Nehme 
# == Date
# August 13th, 2010
# == Copyright
#
require 'rexml/document'
include REXML
require "dummy2.rb"
# userpageController uses the input from the HTML pages and the databases, they interact with the view models and the databases to transform the user input (standard and professional) to an executable license object.   
class UserpageController < ApplicationController
  layout 'standard'
  # The "input"  function is a controller function which loads all the properties and the activities from the database before starting the page, and pass it to the view for proper display. It uses the myprinter2(lic_file) function as a start to load the license object if it exists.  
  def input
    sessid = session[:session_id]
    @msg=""
    if((File.exist? "public/data_lic/restrictions"+sessid+".xml")==true)
      @msg = myprinter2("public/data_lic/restrictions"+ sessid +".xml")
    end
    @activities = Activity.all
  end
  # The myprinter2(lic_file) takes in as input path of the ReXML file for printing. This function returns a user friendly display of the current XML file. It is used to display the license in the text area field on the input page for the users. 
def myprinter2(lic_file)
    doc = Document.new(File.new(lic_file))
    root = doc.root
    perm = root.elements[1]
    @xmldisp = ""
    @xmldisp = @xmldisp + perm.name
    ra_array = []
    perm.each_element{|ra_ptr|
      acv = ra_ptr.attributes["activity"]
      @xmldisp = @xmldisp +"\n"+"\n"+"Activity: " + acv +"\n"
      
      ec_array = []
      ra_ptr.each_element{ |ec_ptr|
      
        entity_type = ec_ptr.attributes["type"]
        @xmldisp = @xmldisp + "&nbsp;&nbsp;Entity:\n " + entity_type +"\n"
      
        pr_array = []
        ec_ptr.each_element{|pr_ptr| 
          property = pr_ptr.attributes["property"]
          function = pr_ptr.attributes["function"]
          args = pr_ptr.text
          @xmldisp = @xmldisp + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Property: " + property +"\n"
          if function.nil?
            function = ""
          end
          if args.nil?
            args =""
          end
          @xmldisp = @xmldisp + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Function:  " + function +"\n"
          @xmldisp = @xmldisp + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Arguments: " + args +"\n"
        }
      } 
    }     
    
    @xmldisp
end
# The myprinter2(lic_file) takes in as input path of the ReXML file for printing. This function returns a user friendly display of the current XML file. It is used to display the license as an HTML page. It is a non-controller function which is used in displayxml function.
def myprinter(lic_file)
    doc = Document.new(File.new(lic_file))
    root = doc.root
    perm = root.elements[1]
    @xmldisp = ""
    @xmldisp = @xmldisp + perm.name + "<br>" 
    ra_array = []
    perm.each_element{|ra_ptr|
      acv = ra_ptr.attributes["activity"]
      @xmldisp = @xmldisp + "<br>"+"Activity: " + acv + "<br>"
      
      ec_array = []
      ra_ptr.each_element{ |ec_ptr|
      
        entity_type = ec_ptr.attributes["type"]
        @xmldisp = @xmldisp + "&nbsp;&nbsp;Entity:\n " + entity_type + "<br>"
      
        pr_array = []
        ec_ptr.each_element{|pr_ptr| 
          property = pr_ptr.attributes["property"]
          function = pr_ptr.attributes["function"]
          args = pr_ptr.text
          @xmldisp = @xmldisp + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Property: " + property + "<br>"
          if function.nil?
            function = ""
          end
          if args.nil?
            args =""
          end
          @xmldisp = @xmldisp + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Function:  " + function + "<br>"
          @xmldisp = @xmldisp + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Arguments: " + args + "<br>"
        }
      } 
    }     
    
    @xmldisp
end
# displayxml is a function which uses myprinter(lic_file) function to print the license in html format.  
def displayxml
  sessid = session[:session_id]
  @xmldisp = myprinter("public/data_lic/restrictions"+sessid+".xml")
  puts @xmldisp
  render :text=> @xmldisp 
end

  def addanotheractivityrestriction
    
    # Get the selected activities and properties.
    puts params[:sthg]
    selected_activity = params[:activity][:name]
    puts selected_activity
    selected_property = params[:property][:name]
    puts selected_property
    puts params[:mydropdown]
    
    redirect_to :action=> "input"
    session[:user_id] = @current_user.id 
    @newrestric = Restriction.new(:resname => params[:property][:name], :userid => session[:user_id], :rescondition => params[:sthg], :function => params[:mydropdown])
    if @newrestric.save
      @restrictions = Restriction.find_by_userid(session[:user_id])
    end
    
  end
  
  def typeupdate
    
      @prop = Property.find_by_name(params[:name])
      
      
      
      if @prop.property_type == "Comparable"
        
        puts "Property Comparable"
        @hellomsg = '<a href="javascript:showDiv();">Show Functions</a>'
        #return true
        #render(:update) { |page| page['hideShow'].show}
        redirect_to :action=> "comp"
        #render :json => @hellomsg
 

         

        
      elsif @prop.property_type == "Equatable"
        puts "Property equatable"
        #return false
      end
       
       #redirect_to :action=> "input" 
  end
  
  def addactivityrestriction
    # Get the selected activities and properties
    sessid = session[:session_id]
    puts sessid
    puts params[:sthg]
    selected_activity = params[:activity][:name]
    puts selected_activity
    selected_property = params[:property][:name]
    puts selected_property
    puts params[:mydropdown]
   
    #if file doesn't exist, create it
    #if((File.exist? "//home/Maria/Desktop/restrictions"+sessid+".xml")==false)
    if((File.exist? "public/data_lic/restrictions"+sessid+".xml")==false)
      basicDoc = Document.new
      basicDoc << XMLDecl.new( "1.0", "UTF-8" )
     
      license = Element.new "license"
      license.attributes["id"]  = sessid
      permissions = Element.new "permissions"
      context = Element.new "context"
      license.add_element permissions
      license.add_element context
      basicDoc.add_element license
      #File.open("//home/Maria/Desktop/restrictions"+sessid+".xml", 'w') {|f| f.write(basicDoc) }
      #File.open("//home/Maria/Desktop/restrictions"+sessid+".xml", 'a') {|f| f.write(XMLDecl.new( "1.0", "UTF-8" )) }
      File.open("public/data_lic/restrictions"+sessid+".xml", 'w') {|f| f.write(basicDoc) }
      File.open("public/data_lic/restrictions"+sessid+".xml", 'a') {|f| f.write(XMLDecl.new( "1.0", "UTF-8" )) }
    end
   
    #Add to the xml document the selected restriction
    document = Document.new
    #Create the context xml information to add, depending on the restriction selected
    contDocument = Document.new
    
    @counter = 1
    #fetch the activity chosen from the database by the action ID obtained
    @act = Activity.find_by_id(selected_activity)
    #get the entity-restriction type depending on the property
    @property = Property.find_by_name(selected_property)
   
    activityExists = false
    er_typeExists = false
    
    
    contElmntExists = false
    contPropertyExists = false
    #read XML file to find out how many restrictions there already is
    #doc = Document.new(File.new("//home/Maria/Desktop/restrictions"+sessid+".xml"))
    doc = Document.new(File.new("public/data_lic/restrictions"+sessid+".xml"))
    root = doc.root
    perm = root.elements[1]
    cont = root.elements[2]
   
    #if(perm.element[1] == nil)
      #docEmpty = true
     

     perm.each_element{|ra_ptr|
             acv = ra_ptr.attributes["activity"]
             #puts acv
             if(acv != @act.name)
               @counter = @counter + 1            
             else
               break
             end                                
     }
    
     #determine if the activity chosen already exists
     perm.each_element{|ra_ptr|
             acv = ra_ptr.attributes["activity"]
             if(acv == @act.name)
               activityExists = true
              
                ra_ptr.each_element{ |entity_restriction|
                typ= entity_restriction.attributes["type"]
                if(typ == @property.entity)
                  er_typeExists = true
                end
                }
             end                                
     }
   
    if(activityExists == true)
        if(er_typeExists == true)
       
          restriction = Element.new("restriction")
          restriction.attributes["property"]      = selected_property
         @operator = "=="
          if(params[:mydropdown] == "greater")
            @operator = ">"
          elsif(params[:mydropdown] == "less")
            @operator = "<"
          elsif(params[:mydropdown] == "equals")
            @operator = "=="
          elsif(params[:mydropdown] == "lesseq")
            @operator = "<="
          elsif(params[:mydropdown] == "greatereq")
            @operator = ">="
          elsif(params[:mydropdown] == "between?")
          end
           
          #
          restriction.attributes["function"]      = @operator
          restriction.text = params[:sthg]
         
          document.add_element restriction
       
        else
       
          entity_restrictions1 = Element.new("entity-restrictions")  
          entity_restrictions1.attributes["type"]  = @property.entity
         
          entity_restrictions1.add_element "restriction"
          entity_restrictions1.elements[1].attributes["property"]      = selected_property
          @operator = "=="
          if(params[:mydropdown] == "greater")
            @operator = ">"
          elsif(params[:mydropdown] == "less")
            @operator = "<"
          elsif(params[:mydropdown] == "equals")
            @operator = "=="
          elsif(params[:mydropdown] == "lesseq")
            @operator = "<="
          elsif(params[:mydropdown] == "greatereq")
            @operator = ">="
          elsif(params[:mydropdown] == "between?")
          end
           
          #
          entity_restrictions1.elements[1].attributes["function"]      = @operator
          entity_restrictions1.elements[1].text = params[:sthg]
         
          document.add_element entity_restrictions1
       
        end
     
    else
         
        restrictedAct1 = Element.new "restricted-activity"
        restrictedAct1.attributes["num"]      = @counter
        restrictedAct1.attributes["activity"]   = @act.name
       
        entity_restrictions1 = Element.new("entity-restrictions")  
        entity_restrictions1.attributes["type"]  = @property.entity
       
        entity_restrictions1.add_element "restriction"
        entity_restrictions1.elements[1].attributes["property"]      = selected_property
       
        #if @operator is not filled with a value, it does not get added as a "function" attribute later!
        if(params[:mydropdown] == "greater")
          @operator = ">"
        elsif(params[:mydropdown] == "less")
          @operator = "<"
        elsif(params[:mydropdown] == "equals")
          @operator = "=="
        elsif(params[:mydropdown] == "lesseq")
          @operator = "<="
        elsif(params[:mydropdown] == "greatereq")
          @operator = ">="
        elsif(params[:mydropdown] == "between?")
        end
         
        #
        entity_restrictions1.elements[1].attributes["function"]      = @operator
        entity_restrictions1.elements[1].text = params[:sthg]
       
        restrictedAct1.add_element entity_restrictions1
       
        document.add_element restrictedAct1
    end
    
    cont.each_element{|cont_type|
             @context_element = cont_type.name
            
             if(@context_element == @property.entity)
               contElmntExists = true
                #if activity exists, determine if it already contains an element with the entity restriction type
                cont_type.each_element{ |cont_type_property|
                
                if(cont_type_property.text == selected_property)
                  contPropertyExists = true
                end
                }
             end                      
     }
    
    if(contElmntExists == true)
        if(contPropertyExists == true)
          #Do nothing     
        else       
          property = Element.new("property")            
          property.text = selected_property
         
          contDocument.add_element property       
        end
     
    else        
        contextElement1 = Element.new @property.entity
       
        property = Element.new("property")            
        property.text = selected_property
              
        contextElement1.add_element property
       
        contDocument.add_element contextElement1
    end
   
    #    er_typeExists = false   
    finalDoc = Document.new
    finalDoc << XMLDecl.new( "1.0", "UTF-8" )
    #add permissions and context elements to license
    permissions = Element.new "permissions"
    context = Element.new "context"
    
    #determin if the activity chosen already exists
     perm.each_element{|ra_ptr|
             acv = ra_ptr.attributes["activity"]
             if(acv == @act.name)
              
                ra_ptr.each_element{ |entity_restriction|
                typ= entity_restriction.attributes["type"]
                if(typ == @property.entity)
                  entity_restriction.add_element document.elements[1]
                end
                }
                if(er_typeExists == true)#The case where the activity and the entity restriction both exist
                  permissions.add_element ra_ptr
                else #The case where the activity exists, but the entity restriction type is new
                  ra_ptr.add_element document.elements[1]
                  permissions.add_element ra_ptr
                end
             else #The case where the activity doesn't already exist
               permissions.add_element ra_ptr
               
             end                                
     }
    
     if(activityExists == false)
      permissions.add_element document.elements[1]
    end
    cont.each_element{|cont_type|
             
             if(cont_type.name == @property.entity)                            
                if(contPropertyExists == true)#The case where the activity and the entity restriction both exist
                  context.add_element cont_type
                else #The case where the activity exists, but the entity restriction type is new
                  cont_type.add_element contDocument.elements[1]
                  context.add_element cont_type
                end
             else #The case where the activity doesn't already exist
               context.add_element cont_type
               
             end                                
     }

     if(contElmntExists == false)
      context.add_element contDocument.elements[1]
    end

   
    license = Element.new "license"
    license.attributes["id"]  = sessid
    license.add_element permissions
    license.add_element context
    finalDoc.add_element license
    
    
   
    #append the document data to the file restrictions.xml
    #File.open("//home/Maria/Desktop/restrictions"+ sessid +".xml", 'w') {|f| f.write(finalDoc) }
    #File.open("//home/Maria/Desktop/restrictions"+ sessid +".xml", 'a') {|f| f.write(XMLDecl.new( "1.0", "UTF-8" )) }
    File.open("public/data_lic/restrictions"+ sessid +".xml", 'w') {|f| f.write(finalDoc) }
    File.open("public/data_lic/restrictions"+ sessid +".xml", 'a') {|f| f.write(XMLDecl.new( "1.0", "UTF-8" )) }
    @msg = myprinter("public/data_lic/restrictions"+ sessid +".xml")
    redirect_to :action=> "input", :partial=>@msg
    #session[:user_id] = @current_user.id
    #@newrestric = Restriction.new(:resname => params[:property][:name], :userid => session[:user_id], :rescondition => params[:sthg], :function => params[:mydropdown])
    #if @newrestric.save
     # @restrictions = Restriction.find_by_userid(session[:user_id])
    #end
  end
  # createlicense is a function which uses the created ReXML file from the function addanotherproperty and calls upon the classes of the in dummy2.rb in order to transform the ReXML file to an executable object. 
  def createlicense
    sessid = session[:session_id]
    lc = MyLicenseObjectCreator.new()
    #obj=lc.get_license_object("//home/Maria/Desktop/restrictions"+sessid+".xml")
    obj=lc.get_license_object("public/data_lic/restrictions"+sessid+".xml")
    data = Marshal.dump(obj)
    File.open("public/data/filename" +sessid, 'w') {|f| f.write(data)}
    send_file "public/data/filename"+ sessid, :type=> "application/terminal"
  end
  # comp is a non-controller function it is used to hide and show a combo box one the HTML files 
  def comp
    
  end
  # This function is for professional users who are able to write thier own licenses in XML and upload it to the server where it is tested and the executable license object is obtained. It makes use of the function of the Profusers database and it also marshals the object into a textfile for sending it to the user.  
  def downloadlic
    lc = MyLicenseObjectCreator.new()
    sessid = session[:session_id]
    @profusers = Profuser.find_by_userid(sessid)
    name = @profusers.filename
    puts name
    obj=lc.get_license_object("public/data_lic/"+name)
    data = Marshal.dump(obj)
    File.open("public/data/filename", 'w') {|f| f.write(data)}
    send_file 'public/data/filename', :type=> "application/gedit"
  end
  # This function deleteprof is used to normalize and keep track of the number of entries in the Profusers database where it deletes the downloaded files.
  def deleteprof
    sessid = session[:session_id]
    @profusers = Profuser.find_by_userid(sessid)
    @profusers.delete()
    redirect_to(:controller => 'home')
  end
end
