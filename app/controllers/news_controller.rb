
require 'open-uri'
require 'mechanize'

require 'nokogiri'

class NewsController < ApplicationController
	#respond_to :json
  def index
  	agent=Mechanize.new
  	page=agent.get('https://news.google.com') 

  	google_form=page.forms.first
  	google_form.q='FAN'
  	page=agent.submit(google_form)
  	#binding.pry  	
  	#page=agent.page.link_with(:text => 'c').click
  	
  	doc = Nokogiri::HTML(page.body)
  	news_hash=Hash.new
  	news_link=Array.new
  	# Define the css selectors to be used for extractions, most
		article_css_class =".g"
		#article.css(".g").css(".r").css("a")
		article_header_css_class  =".r"

		article_summary_css_class =".st"
		articles = doc.css(article_css_class)

		#html output
		#html = ""
       
		#extract the title from the articles
		articles.each do |article|
		  title_nodes = article.css(article_header_css_class)
           
		  # since there are multiple titles for each entry on google news
		  # for this demo we only want the first (topmost)
		  #
		  # its very easy to do, since title_nodes is of type NodeSet which implements Enumerable (http://ruby-doc.org/core-2.0.0/Enumerable.html)
		  # > title_nodes.class
		  #  => Nokogiri::XML::NodeSet 
		  # > title_nodes.class.ancestors
		  #   => [Nokogiri::XML::NodeSet, Enumerable, Object, Kernel, BasicObject]

		  prime_title = title_nodes.first
      
          read_more=title_nodes.children.attribute('href').value
          start_sym="q="
          end_sym="&"
          news_url=read_more[/#{start_sym}(.*?)#{end_sym}/m, 1]
          
		  # Even when the css selector returns only one element, its type is also Nokogiri::XML::NodeSet
		  summary_node = article.css(article_summary_css_class) 
		  # > summary_node.class
		  #  => Nokogiri::XML::NodeSet 
		  # > summary_node.size
		  #  => 1 
		  #Converting to UTF-8 code 
		  a=summary_node.text.force_encoding('ASCII-8BIT').encode('UTF-8', :invalid => :replace, :undef => :replace, :replace => '?')
     binding.pry
           
      # Create an "---------" line for the title
      separator = "-" * prime_title.text.size

  
		  # Extracting the text from an Nokogiri::XML::Element is easy by calling the #text method, 
		  # notice how we can also do it on the NodeSet, 
		  # there it as a different semantic by invoking #text in all the children nodes
  	  #html += "%s\n%s\n%s\n%s\n\n\n\n" % [prime_title.text, separator, summary_node.text,read_more]
  	      news_hash[prime_title.text]="#{summary_node.text}"
  	      news_link.push(read_more)
  	      @news=News.new(headline: prime_title.text,summary: a,link: news_url)
  	       @news.save
		end
		@news_today=Hash.new
          @news_today=@news.latest_news
		render :json => @news_today
  end
end
