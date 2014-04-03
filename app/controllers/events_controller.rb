require 'eventbrite-client'

class EventsController < ApplicationController

  def index
    eb_auth_tokens = { app_key: ENV['EVENTBRITE_API_KEY'] }
                       #access_token: ENV['EVENTBRITE_OAUTH_TOKEN']}

    @eb_client = EventbriteClient.new(eb_auth_tokens)    

    @events = @eb_client.event_search({
      keywords: 'art',
      category: 'entertainment,fundraisers,other,performances,social,tradeshows,fairs',
      city: 'San Francisco',
      within: '5',
      within_unit: 'M',
      date: 'This Month',
      max: '100'
    })

    p @events

  end

end
