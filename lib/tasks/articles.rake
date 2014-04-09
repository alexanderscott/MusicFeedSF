require 'feedjira'

namespace :articles do 
  desc "Get @musicfeedsf user timeline tweets and update db"

  task :update => :environment do 
    # fetching a single feed
    # feed = Feedzirra::Feed.fetch_and_parse("http://feeds.feedburner.com/PaulDixExplainsNothing")
    
    rails_env = ENV['RAILS_ENV'] || 'development'
    env_file = File.join('config', 'environment.yml')
    YAML.load(File.open(env_file))[rails_env].each do |key, value|
      ENV[key.to_s] = value
    end if File.exists?(env_file)

    
    feeds = [
      #{
        #:blog_name => '',
        #:blog_url => '',
        #:feed_url => '',
        #:blog_image => '',
        #:must_filter => false
      #},
      {
        :blog_name => 'The Bay Bridged',
        :blog_url => 'http://thebaybridged.com/',
        :feed_url => 'http://feeds.feedburner.com/thebaybridged/feed',
        :blog_image => 'http://thebaybridged.com/wp-content/uploads/2013/12/baybrided_logo-300x300.png',
        :must_filter => false
      },
      {
        :blog_name => 'SF Critic',
        :blog_url => 'http://www.sfcritic.com/',
        :feed_url => 'http://feeds.feedburner.com/SFCritic',
        :blog_image => 'http://www.sfcritic.com/wp-content/uploads/2013/08/SF-Critic-logo-makeshift.jpg',
        :must_filter => false
      },
      {
        :blog_name => 'SF Weekly - Music',
        :blog_url => 'http://www.sfweekly.com/music/',
        :feed_url => 'http://www.sfweekly.com/syndication/section/music/',
        :blog_image => 'http://www.sfweekly.com/img/citylogo-lg.png',
        :must_filter => false
      },
      {
        :blog_name => 'I Heart SF Bands',
        :blog_url => 'http://www.iheartsfbands.com/',
        :feed_url => 'http://www.iheartsfbands.com/feed/',
        :blog_image => 'http://www.iheartsfbands.com/blog/wp-content/themes/modularity/images/slideshow/image5.jpg',
        :must_filter => false
      },
      {
        :blog_name => 'Live Music Blog SF',
        :blog_url => 'http://livemusicblog.com/tag/san-francisco/',
        :feed_url => 'http://livemusicblog.com/feed/',
        :blog_image => 'http://livemusicblog.com/wp-content/uploads/2014/01/LiveBlog_Logo_300x105.png',
        :must_filter => false
      }
    ]

    error_counter = 0
    article_counter = 0


    feeds.each do |feed|
      feed_obj = Feedjira::Feed.fetch_and_parse(feed[:feed_url])
      feed_obj.entries.each do |entry|
        entry.sanitize!

        if feed[:must_filter]
          summary = entry.summary || ''
          music_regexp = /\b(music|concert|show)\b/i
          title_scan = entry.title.scan( music_regexp )
          #if title_scan.length > 0 or summary_scan.length > 0
          if title_scan.length > 0 
            puts "Found article title matching regex: #{entry.title}"
          else
            #summary_scan = summary.scan( art_regexp )
            #if summary_scan.length > 0
              #puts "Found article summary matching regex: #{summary}"
            #else
              #puts "Could not find match in regex"
            #end
            next
          end
        end


        content = entry.content || ''
        content_sanitized = content.encode('utf-8', 'binary', invalid: :replace, undef: :replace, replace: '') 

        summary = entry.summary || ''
        summary_sanitized = summary.encode('utf-8', 'binary', invalid: :replace, undef: :replace, replace: '') 


        @article = Article.new({
          :blog_name => feed[:blog_name],
          :blog_url => feed[:blog_url],
          :feed_url => feed[:feed_url],
          :blog_image => feed[:blog_image],
          :author => entry.author,
          :entry_id => entry.entry_id,
          :content => content_sanitized,
          :content_html => content_sanitized,
          :summary => summary_sanitized,
          :summary_html => summary_sanitized,
          :url => entry.url,
          :title => entry.title,
          :published => entry.published
        })

        article_counter = article_counter + 1

        begin
          @article.save  
        rescue
          error_counter = error_counter + 1
        end

      end
    end

    puts "Saved #{article_counter} articles with #{error_counter} errors."
    
  end
end

