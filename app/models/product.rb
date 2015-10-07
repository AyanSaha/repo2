class Product < ActiveRecord::Base
	
  #has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  #validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  mount_uploader :image, ImageUploader
  validates :name,
            :presence => {:message => "Enter name of the product!!" }
  validates :description, 
            :presence => {:message => "Enter description of the product"},:length => {minimum: 5 ,:message => "Desciption should be 5 characters long"}
  validates :price , 
            :presence => {:message =>"Price can't be blank!"}  
  validates :image,
            :presence=>true 

end
