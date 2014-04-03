class Tweet < ActiveRecord::Base

  def self.new_from_tw_object(tw_object)
    self.new({
      :tw_id => tw_object.id,
      :text => tw_object.text.encode('utf-8', 'binary', invalid: :replace, undef: :replace, replace: ''),
      :created_at => tw_object.created_at,
      :user_id => tw_object.user.id,
      :user_screen_name => tw_object.user.screen_name,
      :user_name => tw_object.user.name,
      :user_url => tw_object.user.uri.to_s,
      :user_website => tw_object.user.website.to_s,
      :user_image_url => tw_object.user.profile_image_url.to_s
    })
  end

end
