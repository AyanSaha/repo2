class News < ActiveRecord::Base
	validates :headline ,:presence => true
	validates :summary, :presence => true,:uniqueness=>true
	validates :link ,:presence =>true







	def self.latest_news
		@news=News.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
    end
end
