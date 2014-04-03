require 'feedjira'

namespace :articles do 
  desc "Get @artbuzzsf user timeline tweets and update db"

  task :update => :environment do 
    # fetching a single feed
    # feed = Feedzirra::Feed.fetch_and_parse("http://feeds.feedburner.com/PaulDixExplainsNothing")
    
    rails_env = ENV['RAILS_ENV'] || 'development'
    env_file = File.join('config', 'environment.yml')
    YAML.load(File.open(env_file))[rails_env].each do |key, value|
      ENV[key.to_s] = value
    end if File.exists?(env_file)

    
    feeds = [
      {
        :blog_name => 'SFist',
        :blog_url => 'http://sfist.com/',
        :feed_url => 'http://feeds.gothamistllc.com/SFist',
        :blog_image => 'http://assets.gothamistllc.com/images/spacer.gif',
        :must_filter => true
      },
      {
        :blog_name => 'SF Weekly',
        :blog_url => 'http://www.sfweekly.com/',
        :feed_url => 'http://www.sfweekly.com/syndication/issue/',
        :blog_image => 'http://assets.sfweekly.com/img/citylogo-lg.png',
        :must_filter => true
      },
      {
        :blog_name => 'SF Gate',
        :blog_url => 'http://www.sfgate.com/',
        :feed_url => 'http://www.sfgate.com/rss/feed/Entertainment-530.php',
        :blog_image => 'http://www.sfgate.com/img/modules/siteheader/brand.png',
        :must_filter => true
      },
      {
        :blog_name => 'SF Gate',
        :blog_url => 'http://www.sfgate.com/',
        :feed_url => 'http://blog.sfgate.com/culture/feed/',
        :blog_image => 'http://www.sfgate.com/img/modules/siteheader/brand.png',
        :must_filter => true
      },
      {
        :blog_name => 'Fine Arts Museums of San Francisco',
        :blog_url => 'http://www.famsf.org/blog',
        :feed_url => 'http://www.famsf.org/blog/feed',
        :blog_image => 'http://cdn2.hauteliving.com/wp-content/uploads/2010/04/FAMSF.jpg',
        :must_filter => false
      },
      {
        :blog_name => 'Art Nerd: San Francisco',
        :blog_url => 'https://art-nerd.com/sanfrancisco/',
        :feed_url => 'http://art-nerd.com/sanfrancisco/feed/',
        :blog_image => 'https://pbs.twimg.com/profile_images/3560915561/198732f2a1b3c10dff2b92ba171fde53.jpeg',
        :must_filter => false
      },
      {
        :blog_name => 'SF Mural Arts',
        :blog_url => 'http://www.sfmuralarts.com/',
        :feed_url => 'http://www.sfmuralarts.com/rss',
        :blog_image => 'http://www.sfmuralarts.com/img/SiteBanner.jpg',
        :must_filter => false
      },
      {
        :blog_name => 'Asian Art Museum Blog',
        :blog_url => 'http://blog.asianart.org/blog/',
        :feed_url => 'http://blog.asianart.org/blog/?feed=rss2',
        :blog_image => 'http://ww4.hdnux.com/photos/12/00/27/2622927/9/628x471.jpg',
        :must_filter => false
      },
      {
        :blog_name => 'SF Art News',
        :blog_url => 'http://sfartnews.wordpress.com/',
        :feed_url => 'http://sfartnews.wordpress.com/feed/',
        :blog_image => 'http://sfartnews.files.wordpress.com/2013/11/copy-quinones-banner.jpg',
        :must_filter => false
      },
      {
        :blog_name => 'San Francisco Art Institute',
        :blog_url => 'http://www.sfai.edu/',
        :feed_url => 'http://www.sfai.edu/rss.xml',
        :blog_image => 'http://moodle.sfai.edu/express/design/2/1390793528/pix/logo.png',
        :must_filter => false
      },
      {
        :blog_name => 'SF Examiner',
        :blog_url => 'http://www.sfexaminer.com/',
        :feed_url => 'http://www.sfexaminer.com/sanfrancisco/Rss.xml?section=2124643',
        :blog_image => 'http://sfpark.org/wp-content/uploads/2011/02/examiner_main.jpg',
        :must_filter => false
      },
      {
        :blog_name => 'San Francisco Bay Guardian',
        :blog_url => 'http://www.sfbg.com/',
        :feed_url => 'http://www.sfbg.com/pixel_vision/rss.xml',
        :blog_image => 'http://sfbg.s3.amazonaws.com/images/logo2.gif',
        :must_filter => false
      },
      {
        :blog_name => 'Today at SFMOMA',
        :blog_url => 'http://www.sfmoma.org/',
        :feed_url => 'http://feeds.feedburner.com/SFMOMAtoday',
        :blog_image => 'http://www.sfmoma.org/assets/images/nav/sfmoma.gif',
        :must_filter => false
      },
      {
        :blog_name => 'SFMOMA: Open Space Blog',
        :blog_url => 'http://openspace.sfmoma.org/',
        :feed_url => 'http://feeds.feedburner.com/sfmoma/blog',
        :blog_image => 'http://www.sfmoma.org/assets/images/nav/sfmoma.gif',
        :must_filter => false
      }
    ]

    error_counter = 0
    article_counter = 0


    feeds.each do |feed|
      feed_obj = Feedzirra::Feed.fetch_and_parse(feed[:feed_url])
      feed_obj.entries.each do |entry|
        entry.sanitize!

        if feed[:must_filter]
          summary = entry.summary || ''
          art_regexp = /\b(art|artist|museum|gallery|exhibit)\b/i
          title_scan = entry.title.scan( art_regexp )
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

