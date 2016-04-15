require 'roo'
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
  #validates :image,
            #:presence=>true 
begin
def self.import(file)
  message="Products imported!!"
  spreadsheet = open_spreadsheet(file)
   
  header = spreadsheet.row(1)
  if header !=3
     message="Columns must be 3!!Wrong format sheet uploaded!!"
    return false,message
  end
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    product = find_by_id(row["id"]) || new
    product.attributes = row.to_hash
    product.save!
   end
   return true,message
end
def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
end
rescue
   
  end
end