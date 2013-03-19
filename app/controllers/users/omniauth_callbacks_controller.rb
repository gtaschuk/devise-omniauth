class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    auth = request.env["omniauth.auth"]
    puts auth
    #puts request.env["omniauth.extra"]
    #cred = request.env["omniauth.extra"]
    #puts cred
    @user = User.find_by_provider_and_uid(auth.provider, auth.uid)

    session[:twitter_token] = auth["credentials"]["token"]
    session[:twitter_secret] = auth["credentials"]["secret"]
    
    # can get other info from auth hash
    # https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
    unless @user
      @user = User.create(
        provider:auth.provider,
        uid:auth.uid,
        email:auth.info.email,
        password:Devise.friendly_token[0,20]
      )
    end

    sign_in_and_redirect @user, :event => :authentication
    set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
  end

end
