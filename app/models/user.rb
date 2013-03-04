class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:twitter]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, 
    :password, 
    :password_confirmation, 
    :remember_me, :provider, 
    :uid
  # attr_accessible :title, :body
  

  def twitter(token,secret)
    unless @twitter_user
      @twitter_user = Twitter::Client.new(
        oauth_token: token, 
        oauth_token_secret: secret) rescue nil
    end
    puts @twitter_user
    puts token
    puts secret 
    @twitter_user
  end
end
