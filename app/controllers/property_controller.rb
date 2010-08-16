# :title: Property Controller Class
# == Name
# Usage Management Mechanism (UMM)
# == Synopsis
# property_controller class used to enable the administrator to login, register, add a property or an activity to the database
# == Authors
# Maria Khater 
# == Date
# August 13th, 2010
# == Copyright
class PropertyController < ApplicationController
  # add function is used to load all the properties which are present in the database and display them on the view as a table with all their attributes listed.
  def add
    if session[:auth] != true
      redirect_to :controller=>"home", :action=> "index"
    end
    if session[:auth] == true
      @properties = Property.all
    end
    
  end
  
  def insert
    # insert takes input from the textfields filled by the user and insert them into the properties database for later use.
    if session[:auth] != true
      redirect_to :controller=>"home", :action=> "index"
    end
    if session[:auth] == true
    @properties = Property.new(:name => params[:name], :entity => params[:entity], :property_type => params[:property_type])
    @properties.save
    if @properties.save
      flash[:notice] = 'Property was successfully created.'
    end
    redirect_to(:back)
    end
  end
  
  def validate
    # validate is used to check if the inputed user-name and password are correct i.e. they exist in the database. Note: the password is encrypted for security purposes. 
    @hashedpass = Digest::SHA1.hexdigest params[:password]
    
    administratordata1 = Administrator.first(:conditions => ["name = ?", params[:name]])
    
    if administratordata1[:password] ==  @hashedpass
      session[:auth] = true
      session[:username] = params[:name]
      #The user has been validated
       redirect_to :controller=>'property', :action=>'signed'  
    else
    #Login not validated!
    redirect_to :controller=>'home', :action=> 'index'
  end
  
  end
  def signed
    # signed is used to load the home page of the administrator
    if session[:auth] != true
      redirect_to :controller=>"home", :action=> "index"
    end
    if session[:auth] == true
      #Continue!
    end
  end
  def logout
    # logout is used for signing out the administrator in a secure way
    session[:auth] = false
    session[:username] = ''
    redirect_to :controller=>'home', :action=> 'index'
  end
  def create
    # If an adminstrator doesn't have an account, he can register if and only if he has the correct code for that, thus, this function validates the provided information and addes them to the administrator's database.
    puts params[:password]
    puts params[:password2]
    if  params[:password] ==  params[:password2]
        @hashedpass = Digest::SHA1.hexdigest params[:password]
        @administrators = Administrator.new(:name => params[:name],  :password => @hashedpass,  :fname => params[:fname], :lname => params[:lname], :email => params[:email])  
            if @administrators.save  
             #Registered!
             session[:auth] = false
             session[:username] = params[:name]
             redirect_to :controller=> "home", :action=> "index" 
            else  
              #The username already exists
              redirect_to(:back)
              
          end
    else 
      #The passwords did not match
      redirect_to(:back)
    end

  end
  def addactivity
    # addactivity function is used to load all the activities which are present in the database and display them on the view as a table with all thier attributes listed.
    if session[:auth] != true
      redirect_to :controller=>"home", :action=> "index"
    end
    if session[:auth] == true
      @activities = Activity.all  
    end
  end
  def insertactivity
    # insertactivity is used to insert a new activity to the database, it takes the input from the views and validates them and insert them into the activity database.
    if session[:auth] != true
      redirect_to :controller => "home", :action=> "index"
    end
    if session[:auth] == true
    @activities = Activity.new(:name => params[:name])
    @activities.save
    if @activities.save
      flash[:notice] = 'Acitivity was successfully created.'
    end
    redirect_to(:back)
  end
  end
end
