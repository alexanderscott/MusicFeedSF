#require 'eventbrite-client'

class ConcertsController < ApplicationController

  def index
    #eb_auth_tokens = { app_key: ENV['EVENTBRITE_API_KEY'] }
                       ##access_token: ENV['EVENTBRITE_OAUTH_TOKEN']}

    #@concert_client = EventbriteClient.new(eb_auth_tokens)    

    #@concerts = @concert_client.event_search({
      #keywords: 'art',
      #category: 'entertainment,fundraisers,other,performances,social,tradeshows,fairs',
      #city: 'San Francisco',
      #within: '5',
      #within_unit: 'M',
      #date: 'This Month',
      #max: '100'
    #})

    #p @concerts

  end

end
