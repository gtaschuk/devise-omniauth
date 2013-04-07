class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    auth = request.env["omniauth.auth"]
    #cred = request.env["omniauth.extra"]
    #puts cred
    @user = User.find_by_provider_and_uid(
      auth.provider, 
      auth.uid)

    if @user
      Rails.logger.debug "@USER FOUND?"
      Rails.logger.debug @user.provider
    end
    session[:twitter_token] = auth["credentials"]["token"]
    session[:twitter_secret] = auth["credentials"]["secret"]
    
    # can get other info from auth hash
    # https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema

    if @user.nil?
      @user = User.create(
        provider:  auth.provider,
        uid:       auth.uid,
        email:     auth.info.email,
        password:  Devise.friendly_token[0,20]
      )
      if @user.nil?
        Rails.logger.debug auth
        raise "newly created user is nil"
      end
      #puts @user
      #puts "Created USER"
      #puts @user.email
    end

    sign_in_and_redirect @user, :event => :authentication
    set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
  end
end
