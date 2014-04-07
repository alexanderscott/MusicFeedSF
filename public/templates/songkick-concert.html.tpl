<li id="eventbrite-event-<%= event.id %>" class="media eventbrite-event">
    <div class="media-object pull-left">
      <div class="date">
        <span class="binds"></span>
        <span class="month"><%= event.month %></span>
        <h1 class="day"><%= event.day %></h1>
      </div>
    </div>
    <div class="media-body">
      <div class="media-heading">
        <a class="event-title" href="<%= event.url %>" data-container="body" data-toggle="popover" data-trigger="manual" data-placement="right" data-html="true" data-content="<%- event.description %>">
          <%= event.title %>
        </a>
      </div>
      <div class="media-footer text-gray row">
        <span class=""> <%= event.date %></span>
        <span style="margin-left:20px;"><%= event.time %></span>
        <span style="margin-left:20px;"><%= event.venue_name %> (<%= event.distance %>)</span>
      </div>
    </div>
  </div>
</li>
