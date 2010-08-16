# :title: Home Controller Class
# == Name
# Usage Management Mechanism (UMM)
# == Synopsis
# home_controller class used to take the uploaded file in the view and call Fileupload.save function( in the model 'home.rb') in order to save it in '/public/data_lic'
# == Authors
# Maria Khater 
# == Date
# August 13th, 2010
# == Copyright
 
class HomeController < ApplicationController
  # uploadFile calls Fileupload.save function and saves the file and it name along with the user's session's id in order to differentiate between the files uploaded by each user.
  def uploadFile
    Fileupload.save(params[:upload]) 
    upload=params[:upload]
    name =  upload['datafile'].original_filename
    puts params[:upload] 
    sessid = session[:session_id]
    @profusers = Profuser.new(:filename => name , :userid => sessid) 
    @profusers.save
    redirect_to :controller => 'userpage', :action=> 'professionaluser', :text => "File has been uploaded successfully", :layout=> true
  end
end
