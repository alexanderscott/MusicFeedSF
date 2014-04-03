require 'twitter'
require 'yaml'

namespace :tweets do 
  desc "Get @artbuzzsf user timeline tweets and update db"

  task :update => :environment do 
    rails_env = ENV['RAILS_ENV'] || 'development'
    env_file = File.join('config', 'environment.yml')
    YAML.load(File.open(env_file))[rails_env].each do |key, value|
      ENV[key.to_s] = value
    end if File.exists?(env_file)


    @tw_client = Twitter::REST::Client.new do |twitter| 
      twitter.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      twitter.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      twitter.access_token = ENV['TWITTER_ACCESS_TOKEN']
      twitter.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    @tweets = @tw_client.home_timeline

    error_counter = 0
    @tweets.each do |tw_object|
      @tweet = Tweet.new_from_tw_object(tw_object)
      begin 
        @tweet.save
      rescue 
        error_counter = error_counter + 1
      end
    end

    puts "Saved #{@tweets.length} with #{error_counter} errors."
    
  end
end
