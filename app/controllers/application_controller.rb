class ApplicationController < ActionController::Base

  private

    def friendly_token
      SecureRandom.urlsafe_base64(15).tr('lIO0', 'sxyz')
    end

    helper_method :friendly_token

end
