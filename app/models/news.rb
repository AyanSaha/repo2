class News < ActiveRecord::Base
	validates :headline ,:presence => true
	validates :summary, :presence => true,:uniqueness=>true
	validates :link ,:presence =>true

scope :latest,-> {order ('created_at')}
    
    def find_latest
    	return News.latest
    end
end
