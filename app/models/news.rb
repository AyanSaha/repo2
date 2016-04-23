class News < ActiveRecord::Base
	validates :headline ,:presence => true
	validates :summary, :presence => true,:uniqueness=>true
	validates :link ,:presence =>true







	def latest_news
		#@latest=News.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
		@latest=News.find_by_sql("select id,headline,summary,link from news order by updated_at desc")
        return @latest
    end
end
