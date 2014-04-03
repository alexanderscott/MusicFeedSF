
every 2.minutes do 
  rake "tweets:update"
end

every 2.hours do 
  rake "articles:update"
end

