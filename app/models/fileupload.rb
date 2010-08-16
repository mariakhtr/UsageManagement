# :title: Fileupload model Class
# == Name
# Usage Management Mechanism (UMM)
# == Synopsis
# property_controller class is used to upload the file once the save function is called
# == Authors
# Maria Khater 
# == Date
# August 13th, 2010
# == Copyright
class Fileupload < ActiveRecord::Base
  # saves the uploaded file in 'public/data_lic'
  def self.save(upload)
    
    name =  upload['datafile'].original_filename
    directory = "public/data_lic"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end
end
